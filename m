Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CD8208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD8208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeFQFcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:32:14 -0400
Received: from mout.perfora.net ([74.208.4.197]:32867 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932096AbeFQFbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:10 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgFn8-1fxw8n2JUq-00ne38;
 Sun, 17 Jun 2018 07:31:01 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 06/11] staging: rtl8723bs: Move rate section index lookup to new function.
Date:   Sat, 16 Jun 2018 22:30:35 -0700
Message-Id: <20180617053040.5903-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:zcZIzGywR3HOy/lB/uceY/zUeXvFOTBsfcuE8n3hR2seDExUW22
 /Jw0Y6cjh8g1ITbUBLFquStDaK6szEEYUC/xSuUHaBQutVM+VoC4XBCttZJsfsiLgsKVQK6
 0OKB9aoKO7wZqB0RbZIM9PW3Zu9ZGRFbFRFj6yxqtizy9zhf30jg/iNxRL8xofLPBMsdGi0
 pOm0piz+5Md1bouu2c+Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xj6t0oXcC3M=:fMG+lydlHUqiINp6vgqipG
 02vTXLTCiOqK8JiVk/nZX+Uj3OLXt1UnU0n8JJh6MoOXz93wxLHQbYf54jmXPR8GiwxfR2WzA
 nid1bGaegnmvp8uX/D3Nr0yKcw1lmEBoVCTFQzmvQc0sC1JY/37JUxJW6iumNLBcmaZcOR6jU
 X6HZNQ+fEQYAzZFvumDK7P0Lug8fvxF/vgXQ51L44iObNOnRABv5NuSVXuSQQRRG7ZBv4MFHJ
 bYtIG6cqaDPhSpv9z/l6h40z8pfaJgsSry8OjP13OSNelD4pN38qLbR+0oaQ/tujZsQx01ttv
 7UV/y7rM26OGL733OGdIU5QvclVqLiiklhK/XFPOLiNPDgNwEXuix+cOr430XgXIl0Ipn0gB0
 2/kMZ7mhR7oTELkDWBOsTbnOXWHKh8v35P4cHK6xy4wJTX+K2PXg+snBoBzDiZkmS3k2WqCuE
 CFVhOtS5rlFBZiR0AQ8iL3S+Rd69pBBrNeg5vPN18NDjXmNoPlNcfw3fIOr6bnGjSpTeutk3K
 IXds75WUxUt6e5xt53R1DzXjgZoRZCXrXkBexavOEimxUkqvvDXHkzxVPeH/fWg63r9A74lej
 kp7EvWvZJTbbbo0QmRDAg9cCuGwxd1O26w0AJ4iRhaJIjSa5YnUcuFauNLo0mcOsBD2nKmaIZ
 4wguC9GRXOlMoWcpEgVDCWcqcgFKVcyxg4HeHtvgg2NkCBByX00YZMLvCkzMfO/VtFVM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rate section lookup is a large switch statement in the middle of
'phy_get_tx_pwr_lmt()'; refactor this statement into it's own function
for increased readability.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 109 ++++++++----------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 6ae646ec3d06..4b5219481b33 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1612,6 +1612,52 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 	return channelIndex;
 }
 
+static s16 get_rate_sctn_idx(const u8 rate)
+{
+	switch (rate) {
+	case MGN_1M: case MGN_2M: case MGN_5_5M: case MGN_11M:
+		return 0;
+	case MGN_6M: case MGN_9M: case MGN_12M: case MGN_18M:
+	case MGN_24M: case MGN_36M: case MGN_48M: case MGN_54M:
+		return 1;
+	case MGN_MCS0: case MGN_MCS1: case MGN_MCS2: case MGN_MCS3:
+	case MGN_MCS4: case MGN_MCS5: case MGN_MCS6: case MGN_MCS7:
+		return 2;
+	case MGN_MCS8: case MGN_MCS9: case MGN_MCS10: case MGN_MCS11:
+	case MGN_MCS12: case MGN_MCS13: case MGN_MCS14: case MGN_MCS15:
+		return 3;
+	case MGN_MCS16: case MGN_MCS17: case MGN_MCS18: case MGN_MCS19:
+	case MGN_MCS20: case MGN_MCS21: case MGN_MCS22: case MGN_MCS23:
+		return 4;
+	case MGN_MCS24: case MGN_MCS25: case MGN_MCS26: case MGN_MCS27:
+	case MGN_MCS28: case MGN_MCS29: case MGN_MCS30: case MGN_MCS31:
+		return 5;
+	case MGN_VHT1SS_MCS0: case MGN_VHT1SS_MCS1: case MGN_VHT1SS_MCS2:
+	case MGN_VHT1SS_MCS3: case MGN_VHT1SS_MCS4: case MGN_VHT1SS_MCS5:
+	case MGN_VHT1SS_MCS6: case MGN_VHT1SS_MCS7: case MGN_VHT1SS_MCS8:
+	case MGN_VHT1SS_MCS9:
+		return 6;
+	case MGN_VHT2SS_MCS0: case MGN_VHT2SS_MCS1: case MGN_VHT2SS_MCS2:
+	case MGN_VHT2SS_MCS3: case MGN_VHT2SS_MCS4: case MGN_VHT2SS_MCS5:
+	case MGN_VHT2SS_MCS6: case MGN_VHT2SS_MCS7: case MGN_VHT2SS_MCS8:
+	case MGN_VHT2SS_MCS9:
+		return 7;
+	case MGN_VHT3SS_MCS0: case MGN_VHT3SS_MCS1: case MGN_VHT3SS_MCS2:
+	case MGN_VHT3SS_MCS3: case MGN_VHT3SS_MCS4: case MGN_VHT3SS_MCS5:
+	case MGN_VHT3SS_MCS6: case MGN_VHT3SS_MCS7: case MGN_VHT3SS_MCS8:
+	case MGN_VHT3SS_MCS9:
+		return 8;
+	case MGN_VHT4SS_MCS0: case MGN_VHT4SS_MCS1: case MGN_VHT4SS_MCS2:
+	case MGN_VHT4SS_MCS3: case MGN_VHT4SS_MCS4: case MGN_VHT4SS_MCS5:
+	case MGN_VHT4SS_MCS6: case MGN_VHT4SS_MCS7: case MGN_VHT4SS_MCS8:
+	case MGN_VHT4SS_MCS9:
+		return 9;
+	default:
+		DBG_871X("Wrong rate 0x%x\n", rate);
+		return -1;
+	}
+}
+
 s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		      enum BAND_TYPE band_type, enum CHANNEL_WIDTH bandwidth,
 		      u8 rf_path, u8 data_rate, u8 channel)
@@ -1666,68 +1712,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	else if (bandwidth == CHANNEL_WIDTH_160)
 		idx_bandwidth = 3;
 
-	switch (data_rate) {
-	case MGN_1M: case MGN_2M: case MGN_5_5M: case MGN_11M:
-		idx_rate_sctn = 0;
-		break;
-
-	case MGN_6M: case MGN_9M: case MGN_12M: case MGN_18M:
-	case MGN_24M: case MGN_36M: case MGN_48M: case MGN_54M:
-		idx_rate_sctn = 1;
-		break;
-
-	case MGN_MCS0: case MGN_MCS1: case MGN_MCS2: case MGN_MCS3:
-	case MGN_MCS4: case MGN_MCS5: case MGN_MCS6: case MGN_MCS7:
-		idx_rate_sctn = 2;
-		break;
-
-	case MGN_MCS8: case MGN_MCS9: case MGN_MCS10: case MGN_MCS11:
-	case MGN_MCS12: case MGN_MCS13: case MGN_MCS14: case MGN_MCS15:
-		idx_rate_sctn = 3;
-		break;
-
-	case MGN_MCS16: case MGN_MCS17: case MGN_MCS18: case MGN_MCS19:
-	case MGN_MCS20: case MGN_MCS21: case MGN_MCS22: case MGN_MCS23:
-		idx_rate_sctn = 4;
-		break;
-
-	case MGN_MCS24: case MGN_MCS25: case MGN_MCS26: case MGN_MCS27:
-	case MGN_MCS28: case MGN_MCS29: case MGN_MCS30: case MGN_MCS31:
-		idx_rate_sctn = 5;
-		break;
-
-	case MGN_VHT1SS_MCS0: case MGN_VHT1SS_MCS1: case MGN_VHT1SS_MCS2:
-	case MGN_VHT1SS_MCS3: case MGN_VHT1SS_MCS4: case MGN_VHT1SS_MCS5:
-	case MGN_VHT1SS_MCS6: case MGN_VHT1SS_MCS7: case MGN_VHT1SS_MCS8:
-	case MGN_VHT1SS_MCS9:
-		idx_rate_sctn = 6;
-		break;
-
-	case MGN_VHT2SS_MCS0: case MGN_VHT2SS_MCS1: case MGN_VHT2SS_MCS2:
-	case MGN_VHT2SS_MCS3: case MGN_VHT2SS_MCS4: case MGN_VHT2SS_MCS5:
-	case MGN_VHT2SS_MCS6: case MGN_VHT2SS_MCS7: case MGN_VHT2SS_MCS8:
-	case MGN_VHT2SS_MCS9:
-		idx_rate_sctn = 7;
-		break;
-
-	case MGN_VHT3SS_MCS0: case MGN_VHT3SS_MCS1: case MGN_VHT3SS_MCS2:
-	case MGN_VHT3SS_MCS3: case MGN_VHT3SS_MCS4: case MGN_VHT3SS_MCS5:
-	case MGN_VHT3SS_MCS6: case MGN_VHT3SS_MCS7: case MGN_VHT3SS_MCS8:
-	case MGN_VHT3SS_MCS9:
-		idx_rate_sctn = 8;
-		break;
-
-	case MGN_VHT4SS_MCS0: case MGN_VHT4SS_MCS1: case MGN_VHT4SS_MCS2:
-	case MGN_VHT4SS_MCS3: case MGN_VHT4SS_MCS4: case MGN_VHT4SS_MCS5:
-	case MGN_VHT4SS_MCS6: case MGN_VHT4SS_MCS7: case MGN_VHT4SS_MCS8:
-	case MGN_VHT4SS_MCS9:
-		idx_rate_sctn = 9;
-		break;
-
-	default:
-		DBG_871X("Wrong rate 0x%x\n", data_rate);
-		break;
-	}
+	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
                 DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
-- 
2.17.1

