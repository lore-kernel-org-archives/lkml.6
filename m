Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09401C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeH2Vss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:48:48 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.39]:49192 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbeH2Vsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:48:47 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 029D96377AC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 12:50:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id v4bjfFLc5bXuJv4bzfaeNe; Wed, 29 Aug 2018 12:50:46 -0500
X-Authority-Reason: nr=8
Received: from [189.250.89.86] (port=33556 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fv4bj-002Qf2-4D; Wed, 29 Aug 2018 12:50:19 -0500
Date:   Wed, 29 Aug 2018 12:50:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] wil6210: fix unsigned cid comparison with >= 0
Message-ID: <20180829175018.GA3776@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.89.86
X-Source-L: No
X-Exim-ID: 1fv4bj-002Qf2-4D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.89.86]:33556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comparison of cid >= 0 is always true because cid is of type u8
(8 bits, unsigned).

Fix this by removing such comparison and updating the type of
variable cid to u8 in the caller function.

Addresses-Coverity-ID: 1473079 ("Unsigned compared against 0")
Fixes: b9010f105f21 ("wil6210: add FT roam support for AP and station")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/ath/wil6210/wil6210.h | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index cf6a691..abb8201 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -455,7 +455,7 @@ static inline void parse_cidxtid(u8 cidxtid, u8 *cid, u8 *tid)
  */
 static inline bool wil_cid_valid(u8 cid)
 {
-	return (cid >= 0 && cid < WIL6210_MAX_CID);
+	return cid < WIL6210_MAX_CID;
 }
 
 struct wil6210_mbox_ring {
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index c3ad8e4..4859f0e 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1177,7 +1177,7 @@ static void wmi_evt_ring_en(struct wil6210_vif *vif, int id, void *d, int len)
 	u8 vri = evt->ring_index;
 	struct wireless_dev *wdev = vif_to_wdev(vif);
 	struct wil_sta_info *sta;
-	int cid;
+	u8 cid;
 	struct key_params params;
 
 	wil_dbg_wmi(wil, "Enable vring %d MID %d\n", vri, vif->mid);
-- 
2.7.4

