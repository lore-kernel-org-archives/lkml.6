Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29236C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594920671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIuGY4Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D594920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeGZUnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35602 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeGZUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so2252282edr.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ni33WUqV0laomTGHotpL1dR5f4S+giFrtxWfydcDkE0=;
        b=SIuGY4UftALEP0qOcFOYCYq0NYEZ89NouOAMDWYbb6JcYHOZdiLupQ6pWboa1es/Ol
         6MM4hmKu/L6eNcWWZCdVsg5jy8RLLTlpoQZl6mGZDcByMntc5aDHqqMvih4dHUqNYxs5
         SHWLS0QDFLYVurGSsEnmwcFH+n7gNMQ310Anoe5R1grGzl+sNi0Hu0nA4zjYmCHk92jq
         unaEVpopgeRwBy35Klcd0mychi8gIW/rNSukxPl5+WeE8CXPyFSOtu4R+mmaHaFpA4Hi
         KiXDYURda6dOSY6aNlzdtDZSyZuQbjObw834kEtNyXKxYUGNQagI/W9HuVQUk1DdPnah
         sESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ni33WUqV0laomTGHotpL1dR5f4S+giFrtxWfydcDkE0=;
        b=e/zfrePy2us+ak2WDrHCpjHJVeYP10tbSU3J9A5NlIuLYRXX9vZ+lXLxKt65wRY6fM
         g1n2WPeAHqJYKjh88ruttN0FDSjyqsFAdBydmf1MM2pxAO3dHR45UBgTWz1iJeLuLQ/A
         2hAa/YKFQ5NabnG2Uqy5T04tIEPMfFKD/WsqAoJPSveKDy1hGKlJ7Sq3iw4JwbiWpXfB
         3+hrTaAxrdJlECS5J7bi5rXlkucS1rTEFs8pHUjcrHYIZYsVgb4X4YmysDWJ6xSES9jT
         FzfsHLx5DzVnf+PD+1juKkV8LJWnZxtBohSzQnavFw1FRdDvwJad9rXvJGWeu6EyRO1Q
         Cs3w==
X-Gm-Message-State: AOUpUlFdiU6iIrSlGaoZnNJ63JGFBsA6rab1DwxS+P2Hld9n37/zCNzB
        8m66BTEd+NexqE8YycuAyUM37fSf
X-Google-Smtp-Source: AAOMgpezZq/pCc8zaFOLasySEmWBIJStDohCQLA0HZDepe7GGS+EzSy9JNd7b8Sw1WpRar/gAx81tw==
X-Received: by 2002:aa7:d1cb:: with SMTP id g11-v6mr4071337edp.163.1532633106894;
        Thu, 26 Jul 2018 12:25:06 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/16] staging:rtl8192u: Rename HW90_BLOCK_E - Style
Date:   Thu, 26 Jul 2018 20:24:23 +0100
Message-Id: <20180726192426.31913-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the enumerated type HW90_BLOCK_E to hw90_block_e. Whilst this is
not flagged by checkpatch types are meant to be in lowercase.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 8 ++++----
 drivers/staging/rtl8192u/r819xU_phy.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 983520b3aa25..c8c54484eab5 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -687,14 +687,14 @@ static void rtl8192_InitBBRFRegDef(struct net_device *dev)
  * function:  This function is to write register and then readback to make
  *            sure whether BB and RF is OK
  * input:     net_device        *dev
- *            HW90_BLOCK_E      CheckBlock
+ *            hw90_block_e      CheckBlock
  *            RF90_RADIO_PATH_E eRFPath  //only used when checkblock is
  *                                       //HW90_BLOCK_RF
  * output:    none
  * return:    return whether BB and RF is ok (0:OK, 1:Fail)
  * notice:    This function may be removed in the ASIC
  ******************************************************************************/
-u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum HW90_BLOCK_E CheckBlock,
+u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum hw90_block_e CheckBlock,
 			    enum RF90_RADIO_PATH_E eRFPath)
 {
 	u8 ret = 0;
@@ -786,10 +786,10 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 
 	/* ----Ckeck FPGAPHY0 and PHY1 board is OK---- */
 	/* TODO: this function should be removed on ASIC */
-	for (eCheckItem = (enum HW90_BLOCK_E)HW90_BLOCK_PHY0;
+	for (eCheckItem = (enum hw90_block_e)HW90_BLOCK_PHY0;
 	     eCheckItem <= HW90_BLOCK_PHY1; eCheckItem++) {
 		/* don't care RF path */
-		status = rtl8192_phy_checkBBAndRF(dev, (enum HW90_BLOCK_E)eCheckItem,
+		status = rtl8192_phy_checkBBAndRF(dev, (enum hw90_block_e)eCheckItem,
 						  (enum RF90_RADIO_PATH_E)0);
 		if (status != 0) {
 			RT_TRACE((COMP_ERR | COMP_PHY),
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 2cd1c25164a2..d9503996457d 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,7 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-enum HW90_BLOCK_E {
+enum hw90_block_e {
 	HW90_BLOCK_MAC = 0,
 	HW90_BLOCK_PHY0 = 1,
 	HW90_BLOCK_PHY1 = 2,
@@ -62,7 +62,7 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
 void rtl8192_phy_configmac(struct net_device *dev);
 void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
-			    enum HW90_BLOCK_E CheckBlock,
+			    enum hw90_block_e CheckBlock,
 			    enum RF90_RADIO_PATH_E eRFPath);
 void rtl8192_BBConfig(struct net_device *dev);
 void rtl8192_phy_getTxPower(struct net_device *dev);
-- 
2.18.0

