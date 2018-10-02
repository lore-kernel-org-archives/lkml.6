Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6482C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE03206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE03206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeJBUNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbeJBUNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:06 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F69BBF0;
        Tue,  2 Oct 2018 13:29:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 124/228] ath10k: fix memory leak of tpc_stats
Date:   Tue,  2 Oct 2018 06:23:41 -0700
Message-Id: <20181002132507.814212681@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 260e629bbf441585860e21d5e10d2e88437f47c8 ]

Currently tpc_stats is allocated and is leaked on the return
path if num_tx_chain is greater than WMI_TPC_TX_N_CHAIN. Avoid
this leak by performing the check on num_tx_chain before the
allocation of tpc_stats.

Detected by CoverityScan, CID#1469422 ("Resource Leak")
Fixes: 4b190675ad06 ("ath10k: fix kernel panic while reading tpc_stats")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4602,10 +4602,6 @@ void ath10k_wmi_event_pdev_tpc_config(st
 
 	ev = (struct wmi_pdev_tpc_config_event *)skb->data;
 
-	tpc_stats = kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
-	if (!tpc_stats)
-		return;
-
 	num_tx_chain = __le32_to_cpu(ev->num_tx_chain);
 
 	if (num_tx_chain > WMI_TPC_TX_N_CHAIN) {
@@ -4614,6 +4610,10 @@ void ath10k_wmi_event_pdev_tpc_config(st
 		return;
 	}
 
+	tpc_stats = kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
+	if (!tpc_stats)
+		return;
+
 	ath10k_wmi_tpc_config_get_rate_code(rate_code, pream_table,
 					    num_tx_chain);
 


