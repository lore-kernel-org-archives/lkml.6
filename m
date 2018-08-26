Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD112086A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI974cTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD112086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeH0A6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35792 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0A6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so2441726edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXMZHC4drIynOYLCSCC5+Ozc3UpZJDDn9U6acW84FvM=;
        b=VI974cTJioiLwc0CwesGY3QKksWtGSM24R3VmozJi4KEU3eJO6rMkk0iYTDDdeLhX6
         NuaGd5qO53x0eSwvO75HhEjM4urIxLtztjzF2e7B0zi189QVUp1EbSjwQX/AKCsT1QxK
         RPZ1Bq39JUEjuD189J1CjA6z4q8SuMnnCdXl36ejvu4cey6AL3b41hHnLE176EW0lP8s
         ny/XATRPM4KQanrmYZh902CuPeWVbJ2+Ua6ca4TGFllOxYgOTPssmTMnYeU01Cze9xxd
         AZMymlXXH+5oj9ujEkuCjisl4UJBgWf1JrU8DSixe7ipiYT4mAQmTZm/YXpTc3SKZ0+o
         MSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXMZHC4drIynOYLCSCC5+Ozc3UpZJDDn9U6acW84FvM=;
        b=pP2L/sRxVYQ5TLn9t0OSzZXFxAXfWvzn3VS0dDhIpUVK1jS7XoXo6v5eEaJbOzzFRu
         +09z39fnaJNqr5bWu9vSzIAnRLOxpnW62zHHP0D1Ap4CZB9Jp+QcUgdpBfw6w4qIz4MW
         6sbCOd/WZSi8hk92QdHQ6m7R5TDOOTvxx+FliMQYVSuy/Sm9oeqdkyrBT/yHbfGYwGyc
         klkfyt8NAaVTdox9z2Hab2ZE6wJtDJDyxxnFeGOEl2oHY9scdvA3Tiz9TWMfrEe/259p
         n93C2Ag1oSbgDkbfWtiAabV7A6flPXnY9E2N8gHSNY2LblIPIqSfp02BostdJZHknWRK
         C50g==
X-Gm-Message-State: APzg51B/vH+EzsCW0mJLrRMq6fHWmCHohC1aLkwuRCqrlhAGGxNlXqIh
        e4RbXthbhpUx5wpjxMiNEbAEpWnZ
X-Google-Smtp-Source: ANB0VdYaghT4PRnZEfHdmzjeKkn//yUGjjR58CN2QKQcZE9ggk9JENR7EHuyGt6aRigpGyHGjDgUIA==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr13331763edq.250.1535318096801;
        Sun, 26 Aug 2018 14:14:56 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:14:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/21] staging:rtl8192u: Refactor enum VERSION_819xU - Style
Date:   Sun, 26 Aug 2018 22:14:19 +0100
Message-Id: <20180826211439.14326-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enumerated type VERSION_819xU to version_819xu to clear
checkpatch issue with CamelCase naming. Additionally the constants
defined by the type are renamed for the same reason.

Remove the 'typedef' directive to clear the checkpatch issue with
defining new types.

The enumerated type has been moved to the file where the type is
actually used, r8192U.h

Additionally the memeber variable, which uses the type
(card_8192_version), has been changed to use the type to enable
compiler typechecking.

These are coding style changes which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 6 +++---
 drivers/staging/rtl8192u/r8192U.h        | 8 +++++++-
 drivers/staging/rtl8192u/r8192U_core.c   | 8 ++++----
 drivers/staging/rtl8192u/r8192U_hw.h     | 5 -----
 drivers/staging/rtl8192u/r819xU_phy.c    | 4 ++--
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 9b7f822e9762..e60da2358343 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -37,9 +37,9 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 
 		switch (Bandwidth) {
 		case HT_CHANNEL_WIDTH_20:
-				if (priv->card_8192_version == VERSION_819xU_A
+				if (priv->card_8192_version == VERSION_819XU_A
 					|| priv->card_8192_version
-					== VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
+					== VERSION_819XU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev,
 						(enum rf90_radio_path_e)eRFPath,
 						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
@@ -57,7 +57,7 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 					}
 				break;
 		case HT_CHANNEL_WIDTH_20_40:
-				if (priv->card_8192_version == VERSION_819xU_A || priv->card_8192_version == VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
+				if (priv->card_8192_version == VERSION_819XU_A || priv->card_8192_version == VERSION_819XU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x0b, bMask12Bits, 0x300); /* phy para:3ba */
 					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x2c, bMask12Bits, 0x3df);
 					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x0e, bMask12Bits, 0x0a1);
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 94a148994069..ce287e2f79e1 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -798,6 +798,12 @@ typedef enum _tag_TxCmd_Config_Index {
 	TXCMD_XXXX_CTRL,
 } DCMD_TXCMD_OP;
 
+enum version_819xu {
+	VERSION_819XU_A, // A-cut
+	VERSION_819XU_B, // B-cut
+	VERSION_819XU_C,// C-cut
+};
+
 typedef struct r8192_priv {
 	struct usb_device *udev;
 	/* For maintain info from eeprom */
@@ -815,7 +821,7 @@ typedef struct r8192_priv {
 	/* O: rtl8192, 1: rtl8185 V B/C, 2: rtl8185 V D */
 	short card_8192;
 	/* If TCR reports card V B/C, this discriminates */
-	u8 card_8192_version;
+	enum version_819xu card_8192_version;
 	short enable_gpio0;
 	enum card_type {
 		PCI, MINIPCI, CARDBUS, USB
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index e218b5c20642..3b89f2669754 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2395,7 +2395,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 	} else {
 		priv->eeprom_vid = 0;
 		priv->eeprom_pid = 0;
-		priv->card_8192_version = VERSION_819xU_B;
+		priv->card_8192_version = VERSION_819XU_B;
 		priv->eeprom_ChannelPlan = 0;
 		priv->eeprom_CustomerID = 0;
 	}
@@ -2422,7 +2422,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 	priv->rf_type = RTL819X_DEFAULT_RF_TYPE; /* default 1T2R */
 	priv->rf_chip = RF_8256;
 
-	if (priv->card_8192_version == (u8)VERSION_819xU_A) {
+	if (priv->card_8192_version == VERSION_819XU_A) {
 		/* read Tx power gain offset of legacy OFDM to HT rate */
 		if (bLoad_From_EEPOM) {
 			ret = eprom_read(dev, (EEPROM_TxPowerDiff >> 1));
@@ -2567,7 +2567,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		 * 92U does not enable TX power tracking.
 		 */
 		priv->ThermalMeter[0] = priv->EEPROMThermalMeter;
-	} /* end if VersionID == VERSION_819xU_A */
+	} /* end if VersionID == VERSION_819XU_A */
 
 	/* for dlink led */
 	switch (priv->eeprom_CustomerID) {
@@ -2872,7 +2872,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 
 	rtl8192_phy_configmac(dev);
 
-	if (priv->card_8192_version == (u8)VERSION_819xU_A) {
+	if (priv->card_8192_version == VERSION_819XU_A) {
 		rtl8192_phy_getTxPower(dev);
 		rtl8192_phy_setTxPower(dev, priv->chan);
 	}
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 00a123d44207..15e56003d97c 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -20,11 +20,6 @@
 #ifndef R8192_HW
 #define R8192_HW
 
-typedef enum _VERSION_819xU {
-	VERSION_819xU_A, // A-cut
-	VERSION_819xU_B, // B-cut
-	VERSION_819xU_C,// C-cut
-} VERSION_819xU, *PVERSION_819xU;
 //added for different RF type
 typedef enum _RT_RF_TYPE_DEF {
 	RF_1T2R = 0,
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 7ee10d49894b..8e6ed20848d8 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -814,7 +814,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 
 	/* ----Enable XSTAL ---- */
 	write_nic_byte_E(dev, 0x5e, 0x00);
-	if (priv->card_8192_version == (u8)VERSION_819xU_A) {
+	if (priv->card_8192_version == VERSION_819XU_A) {
 		/* Antenna gain offset from B/C/D to A */
 		reg_u32 = priv->AntennaTxPwDiff[1]<<4 |
 			   priv->AntennaTxPwDiff[0];
@@ -1367,7 +1367,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 
 		switch (CurrentCmd->cmd_id) {
 		case CMD_ID_SET_TX_PWR_LEVEL:
-			if (priv->card_8192_version == (u8)VERSION_819xU_A)
+			if (priv->card_8192_version == VERSION_819XU_A)
 				/* consider it later! */
 				rtl8192_SetTxPowerLevel(dev, channel);
 			break;
-- 
2.18.0

