Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC866C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B092F20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B092F20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeFQFcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:32:13 -0400
Received: from mout.perfora.net ([74.208.4.194]:57281 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbeFQFbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:11 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lo05O-1gA4gY1T4q-00fyYI;
 Sun, 17 Jun 2018 07:31:02 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 07/11] staging: rtl8723bs: Move bandwidth index lookup to new function.
Date:   Sat, 16 Jun 2018 22:30:36 -0700
Message-Id: <20180617053040.5903-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:Fx3zyiiAd735fpJKDKYT1lsHbcjTeJVherxSiOtD2WoyOk2USx9
 KQyo6LJyONM5QzAVNMTxaoWzU3U6JzR7d07+S+dGIPJv4IgsaI+s273dE7JiPV7xLIAUWbg
 9E4x0O+u905H72FWoN06LnDTv90f34wl0gmXXDwXUFxU/6EM0nuzXLM9FhTorqFY8QMIsBJ
 VSDUylo9R8qQid0KIORdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cXwJJwSRe4A=:bfqSOGpklnFVb5kIfAVEzX
 Kz+5q/ROkNX+5bkbThGyB1siIDCbdBPKl92gu3Di/IqFn3mTW1V0V5g3RnmtwR3tG7s4ny5gT
 d5I+YZ4gEyJhX6ezVUJaflo+FW78Z90xCtBwegt89KHA/SrcUGjlR3+UuJ0bU0uE84lf1iqmj
 KTJZpudc8J9Sc7TZCiiimT54Q+yBFbdAfeWYdtxymGc4WSwe0aTPId8xmRblYvUP1KsQ+OBSq
 BQ3wiR2id9otD05LiYV4XjVWoJdwNUv8mo7+EY10QSYVWxKOf2uZkQN+sHgtsxH5ush0SmTWp
 OD5zTDNWmm77RnrCap6MDUs54eHsxqML1T3bHncK1YqwYAljgYvd3IrxOvMvznoKw0BYtSYdL
 cTl83/bPgd+JT9a4nmUK4wp53wcuSdE1gN5HXL301rd492RkLFaM0t29AbrJnzfptats1d1e1
 2B2ihfC3+bwuC7Tfd3M1QB6u7KB8pCHDJuKsoGO27Z/mZzA/hz0mmvFlRoFB+ecvn76GV+mJ8
 GWJk9rXFguHt5nXaxBFXMY8O9ufJRCXJhYCh6D/9GUbBvCLPpitALq+Y5lB9CiAe7cU6x/tBE
 H3ntH3iDmcUPDxsv9R2TFsxuq8HGKJ5CMT7yAzqIsfnqyvanclrUUY5ThGWinB7TII3/BBi/P
 gijOaCzesnBTRQgwv4t9REeDtFim8F75haqedVk4kIPif1x2PGzLP7i/cssknCoXae0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factoring out the conditional lookup of bandwidth index into the power
limit table into it's own function simplifies the logic of
'phy_get_tx_pwr_lmt()'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 4b5219481b33..6d8a07ac7bb3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1612,6 +1612,22 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 	return channelIndex;
 }
 
+static s16 get_bandwidth_idx(const enum CHANNEL_WIDTH bandwidth)
+{
+	switch (bandwidth) {
+	case CHANNEL_WIDTH_20:
+		return 0;
+	case CHANNEL_WIDTH_40:
+		return 1;
+	case CHANNEL_WIDTH_80:
+		return 2;
+	case CHANNEL_WIDTH_160:
+		return 3;
+	default:
+		return -1;
+	}
+}
+
 static s16 get_rate_sctn_idx(const u8 rate)
 {
 	switch (rate) {
@@ -1703,15 +1719,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	else if (band_type == BAND_ON_5G)
 		idx_band = 1;
 
-	if (bandwidth == CHANNEL_WIDTH_20)
-		idx_bandwidth = 0;
-	else if (bandwidth == CHANNEL_WIDTH_40)
-		idx_bandwidth = 1;
-	else if (bandwidth == CHANNEL_WIDTH_80)
-		idx_bandwidth = 2;
-	else if (bandwidth == CHANNEL_WIDTH_160)
-		idx_bandwidth = 3;
-
+	idx_bandwidth = get_bandwidth_idx(bandwidth);
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-- 
2.17.1

