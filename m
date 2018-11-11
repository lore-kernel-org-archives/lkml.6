Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4F02084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA/QUZfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4F02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeKLIUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbeKLIUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4C4223CB;
        Sun, 11 Nov 2018 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975446;
        bh=jMeAZfGf3TgqpUQoCcTu0GJIc2VbP1wylRRJxcOfnwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mA/QUZfe9bBkCmSH/jM23MADFweMF6cA1t2d5Wa30yNpvZddbiQe5QINqMInoTX67
         gwB+0byQOYHjzc2sWq1PklgYpvR3huQ0KXzmO0mUWO0S0dGTg246MAwEQAAATL8ab3
         D0BZBb7nxicb7c8dRDVJlq4zCZLeJghPPNEV2L6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.18 208/350] iwlwifi: mvm: check return value of rs_rate_from_ucode_rate()
Date:   Sun, 11 Nov 2018 14:21:12 -0800
Message-Id: <20181111221716.730166861@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>

commit 3d71c3f1f50cf309bd20659422af549bc784bfff upstream.

The rs_rate_from_ucode_rate() function may return -EINVAL if the rate
is invalid, but none of the callsites check for the error, potentially
making us access arrays with index IWL_RATE_INVALID, which is larger
than the arrays, causing an out-of-bounds access.  This will trigger
KASAN warnings, such as the one reported in the bugzilla issue
mentioned below.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=200659

Cc: stable@vger.kernel.org
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1218,7 +1218,11 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	rs_rate_from_ucode_rate(tx_resp_hwrate, info->band, &tx_resp_rate);
+	if (rs_rate_from_ucode_rate(tx_resp_hwrate, info->band,
+				    &tx_resp_rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	/* Disable last tx check if we are debugging with fixed rate but
@@ -1269,7 +1273,10 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm
 	 */
 	table = &lq_sta->lq;
 	lq_hwrate = le32_to_cpu(table->rs_table[0]);
-	rs_rate_from_ucode_rate(lq_hwrate, info->band, &lq_rate);
+	if (rs_rate_from_ucode_rate(lq_hwrate, info->band, &lq_rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 	/* Here we actually compare this rate to the latest LQ command */
 	if (lq_color != LQ_FLAG_COLOR_GET(table->flags)) {
@@ -1371,8 +1378,12 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm
 		/* Collect data for each rate used during failed TX attempts */
 		for (i = 0; i <= retries; ++i) {
 			lq_hwrate = le32_to_cpu(table->rs_table[i]);
-			rs_rate_from_ucode_rate(lq_hwrate, info->band,
-						&lq_rate);
+			if (rs_rate_from_ucode_rate(lq_hwrate, info->band,
+						    &lq_rate)) {
+				WARN_ON_ONCE(1);
+				return;
+			}
+
 			/*
 			 * Only collect stats if retried rate is in the same RS
 			 * table as active/search.
@@ -3241,7 +3252,10 @@ static void rs_build_rates_table_from_fi
 	for (i = 0; i < num_rates; i++)
 		lq_cmd->rs_table[i] = ucode_rate_le32;
 
-	rs_rate_from_ucode_rate(ucode_rate, band, &rate);
+	if (rs_rate_from_ucode_rate(ucode_rate, band, &rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 	if (is_mimo(&rate))
 		lq_cmd->mimo_delim = num_rates - 1;


