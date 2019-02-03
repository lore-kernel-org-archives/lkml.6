Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC39C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DF92177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfBCOVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55950 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbfBCOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeX-0006Tl-Vw; Sun, 03 Feb 2019 14:21:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006uS-P5; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Luca Coelho" <luciano.coelho@intel.com>,
        "Kalle Valo" <kvalo@codeaurora.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.433087326@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 079/305] iwlwifi: mvm: check return value of
 rs_rate_from_ucode_rate()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16:
 - Fix up one additional caller
 - Adjust filename, context
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/iwlwifi/mvm/rs.c
@@ -1057,7 +1057,10 @@ static void rs_tx_status(void *mvm_r, st
 	 */
 	table = &lq_sta->lq;
 	ucode_rate = le32_to_cpu(table->rs_table[0]);
-	rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+	if (rs_rate_from_ucode_rate(ucode_rate, info->band, &rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 	if (info->band == IEEE80211_BAND_5GHZ)
 		rate.index -= IWL_FIRST_OFDM_RATE;
 	mac_flags = info->status.rates[0].flags;
@@ -1161,7 +1164,10 @@ static void rs_tx_status(void *mvm_r, st
 	 */
 	if (info->flags & IEEE80211_TX_STAT_AMPDU) {
 		ucode_rate = le32_to_cpu(table->rs_table[0]);
-		rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+		if (rs_rate_from_ucode_rate(ucode_rate, info->band, &rate)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
 		rs_collect_tx_data(lq_sta, curr_tbl, rate.index,
 				   info->status.ampdu_len,
 				   info->status.ampdu_ack_len,
@@ -1186,7 +1192,12 @@ static void rs_tx_status(void *mvm_r, st
 		/* Collect data for each rate used during failed TX attempts */
 		for (i = 0; i <= retries; ++i) {
 			ucode_rate = le32_to_cpu(table->rs_table[i]);
-			rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+			if (rs_rate_from_ucode_rate(ucode_rate, info->band,
+						    &rate)) {
+				WARN_ON_ONCE(1);
+				return;
+			}
+
 			/*
 			 * Only collect stats if retried rate is in the same RS
 			 * table as active/search.
@@ -2677,7 +2688,10 @@ static void rs_build_rates_table_from_fi
 	for (i = 0; i < num_rates; i++)
 		lq_cmd->rs_table[i] = ucode_rate_le32;
 
-	rs_rate_from_ucode_rate(ucode_rate, band, &rate);
+	if (rs_rate_from_ucode_rate(ucode_rate, band, &rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 	if (is_mimo(&rate))
 		lq_cmd->mimo_delim = num_rates - 1;
@@ -2928,8 +2942,11 @@ static void rs_program_fix_rate(struct i
 
 	if (lq_sta->dbg_fixed_rate) {
 		struct rs_rate rate;
-		rs_rate_from_ucode_rate(lq_sta->dbg_fixed_rate,
-					lq_sta->band, &rate);
+		if (rs_rate_from_ucode_rate(lq_sta->dbg_fixed_rate,
+					    lq_sta->band, &rate)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
 		rs_fill_lq_cmd(mvm, NULL, lq_sta, &rate);
 		iwl_mvm_send_lq_cmd(lq_sta->drv, &lq_sta->lq, false);
 	}

