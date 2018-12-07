Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9429C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7208920868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fsuanyn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLGAN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:13:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40049 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLGAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:13:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so873794pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnxtaTSUT4ZjS4fAMsNPM8zLcRZ7oBhSPNZwlUEuE60=;
        b=Fsuanyn7StOHvNQ7bqa87XghNNfi7t8tRG6DPQ29wYdcadcjjhK1WvOw5TwZMm9kT8
         UusRXE/8NPcsdRAOJshMLKoSLK9+1f1x4FBuxlvZ7j1tisljcSuWkLq5bCUPBWvbDBjL
         EWgLp5s6t+38kbidPAGui5DECeNodxSAOpE6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnxtaTSUT4ZjS4fAMsNPM8zLcRZ7oBhSPNZwlUEuE60=;
        b=AL2VNjREdB+WztYm/0fL536BycyY00Hs/xwvF1waD70I7wCIQAL5UQe70iS5kDf/qh
         sN+7eyOAz6cdjE/ZZ2OulgK+KconydxgwvF9LPLPyWA6xw3+eFCNtl+FvakeOvNx75fX
         ebqZBMQAsCCVRkjo2j0Ogv2N40TE71GYh5hqR0dwVMAX28aPp8YNtYCalFxHZGAoQU5N
         YLV8o0fT1QvmkQS14fBnZ+2E5JZwJThL0Y7BbFJF/3d++pZ0OyGUcXIhUrRlEWH8q23t
         75VwlFJszxaDa8HtpLFJMQtv9UJEVPgy9vHLliwEpFGNT6zd4Rx4ZbWXnyMTUfgnQJ8E
         8bXw==
X-Gm-Message-State: AA+aEWZkIXss/d1MMvqC5mby/M/fAzIK54IspwBybb5wAHOn6BFDbWXI
        PSDwCHZC+QyvYjqqZatQuwJunQ==
X-Google-Smtp-Source: AFSGD/VZWz2VDi/kkquokqHoMzDBp+UIdhBOg/qryEpK0PnNYu7HA04acuttCJzs4Q9R7hXz1IMidA==
X-Received: by 2002:a63:1258:: with SMTP id 24mr56312pgs.114.1544141606581;
        Thu, 06 Dec 2018 16:13:26 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id o66sm1654437pgo.75.2018.12.06.16.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 16:13:17 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH v2 1/2] mwifiex: refactor mwifiex_parse_htinfo() for reuse
Date:   Thu,  6 Dec 2018 16:12:48 -0800
Message-Id: <20181207001249.165477-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function converts some firmware-specific parameters into cfg80211
'rate_info' structures. It currently assumes it's dealing only with TX
bitrate, but the RX bitrate looks to be the same, so refactor this
function to be reusable.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * no change - just split unrelated (debugfs) patch to its own series
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index adc88433faa8..02b80ea232a7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1275,27 +1275,27 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 }
 
 static void
-mwifiex_parse_htinfo(struct mwifiex_private *priv, u8 tx_htinfo,
+mwifiex_parse_htinfo(struct mwifiex_private *priv, u8 rateinfo, u8 htinfo,
 		     struct rate_info *rate)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 
 	if (adapter->is_hw_11ac_capable) {
 		/* bit[1-0]: 00=LG 01=HT 10=VHT */
-		if (tx_htinfo & BIT(0)) {
+		if (htinfo & BIT(0)) {
 			/* HT */
-			rate->mcs = priv->tx_rate;
+			rate->mcs = rateinfo;
 			rate->flags |= RATE_INFO_FLAGS_MCS;
 		}
-		if (tx_htinfo & BIT(1)) {
+		if (htinfo & BIT(1)) {
 			/* VHT */
-			rate->mcs = priv->tx_rate & 0x0F;
+			rate->mcs = rateinfo & 0x0F;
 			rate->flags |= RATE_INFO_FLAGS_VHT_MCS;
 		}
 
-		if (tx_htinfo & (BIT(1) | BIT(0))) {
+		if (htinfo & (BIT(1) | BIT(0))) {
 			/* HT or VHT */
-			switch (tx_htinfo & (BIT(3) | BIT(2))) {
+			switch (htinfo & (BIT(3) | BIT(2))) {
 			case 0:
 				rate->bw = RATE_INFO_BW_20;
 				break;
@@ -1310,26 +1310,26 @@ mwifiex_parse_htinfo(struct mwifiex_private *priv, u8 tx_htinfo,
 				break;
 			}
 
-			if (tx_htinfo & BIT(4))
+			if (htinfo & BIT(4))
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 
-			if ((priv->tx_rate >> 4) == 1)
+			if ((rateinfo >> 4) == 1)
 				rate->nss = 2;
 			else
 				rate->nss = 1;
 		}
 	} else {
 		/*
-		 * Bit 0 in tx_htinfo indicates that current Tx rate
-		 * is 11n rate. Valid MCS index values for us are 0 to 15.
+		 * Bit 0 in htinfo indicates that current rate is 11n. Valid
+		 * MCS index values for us are 0 to 15.
 		 */
-		if ((tx_htinfo & BIT(0)) && (priv->tx_rate < 16)) {
-			rate->mcs = priv->tx_rate;
+		if ((htinfo & BIT(0)) && (rateinfo < 16)) {
+			rate->mcs = rateinfo;
 			rate->flags |= RATE_INFO_FLAGS_MCS;
 			rate->bw = RATE_INFO_BW_20;
-			if (tx_htinfo & BIT(1))
+			if (htinfo & BIT(1))
 				rate->bw = RATE_INFO_BW_40;
-			if (tx_htinfo & BIT(2))
+			if (htinfo & BIT(2))
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		}
 	}
@@ -1375,7 +1375,8 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
 		sinfo->tx_packets = node->stats.tx_packets;
 		sinfo->tx_failed = node->stats.tx_failed;
 
-		mwifiex_parse_htinfo(priv, node->stats.last_tx_htinfo,
+		mwifiex_parse_htinfo(priv, priv->tx_rate,
+				     node->stats.last_tx_htinfo,
 				     &sinfo->txrate);
 		sinfo->txrate.legacy = node->stats.last_tx_rate * 5;
 
@@ -1401,7 +1402,8 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
 			 HostCmd_ACT_GEN_GET, DTIM_PERIOD_I,
 			 &priv->dtim_period, true);
 
-	mwifiex_parse_htinfo(priv, priv->tx_htinfo, &sinfo->txrate);
+	mwifiex_parse_htinfo(priv, priv->tx_rate, priv->tx_htinfo,
+			     &sinfo->txrate);
 
 	sinfo->signal_avg = priv->bcn_rssi_avg;
 	sinfo->rx_bytes = priv->stats.rx_bytes;
-- 
2.20.0.rc2.403.gdbc3b29805-goog

