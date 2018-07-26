Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC31C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C162083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqzhOAi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C162083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeGZUnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46227 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so2238326edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j1dgjhlU8oFNM9wP4mJurEVqSnb1T3bd7hiKA3FCGrA=;
        b=gqzhOAi8UrXmMRtW/w0IkBGfgd6t/sl7QM45A/hgOTS2xLJze11fZcX0kr78WJ91z6
         YRvuxAGed+QEWEjOxtKfGFuyI/xtLIUAeLJCc3q6FQpES1eMnsXUzmL4+T7BjjrPBxYu
         /eEwSscudAHWx/agomfT5tmwWx2Ec1OV4wKjw3iaZtrLiNW2dDAKOBDKQ651tNwOneWZ
         n0/q8v6ncT52pEG6hYuEZa8A5dRbKxsxyhoV+T+KxO3tZ9G2OSfcTxhTzkFamDELVmIR
         jjRiGuV/HwjJQP2OTjd9JbLx3hM9tO/RSpk9WHFOEcgYQAByNpJ6ytYs/qFhFSNp3vnT
         DIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j1dgjhlU8oFNM9wP4mJurEVqSnb1T3bd7hiKA3FCGrA=;
        b=kDpexj7/o+Eup5sL7ps5HEbv/12vYa1eOcGZObn0tYOQiaaxqrCbepQqGcRQbRcJIr
         5VH0Zrmv24AXRu/RzQiCiQufctlc7eUd5Th8AT240JyVGI9UGWB75ps3QWJIU4FBRnPT
         ftK159Xk+wz+eTr2xh/v3fPJ/Be8v7mXeolwfVLhANH1L49SxYMGlt4VmJnQkyGiJX9J
         12yHcYLcEUImJh9Kaf+xxjGcyV2+9eP2fWmWitDnyH4xkluecKclfATYNYGovrQv16an
         eOvOJubhnn/Mhr7I0Y8Uts0NzsmwT599Z8cmysb7SkeGFDP0mGG48cbRvDRQ09AtV6PI
         WXgQ==
X-Gm-Message-State: AOUpUlGCnF4oswzuOz277mf0uQFEB876CUUPqQl5xUv2hd134xDddeB1
        lHIq1KQaYeB6hHtC6DKSwmGvfU95
X-Google-Smtp-Source: AAOMgpf/UuOLcoIgd+DmPEimvgGYoOX9m3acGh0ogcaH5K5HfWDH/QW3tEx0PeoZSj9l8HdmFApDPA==
X-Received: by 2002:aa7:c803:: with SMTP id a3-v6mr4090954edt.124.1532633105546;
        Thu, 26 Jul 2018 12:25:05 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/16] staging:rtl8192u: Remove proxy rtl819XRadioD_Array - Style
Date:   Thu, 26 Jul 2018 20:24:22 +0100
Message-Id: <20180726192426.31913-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the array rtl819XRadioD_Array which is only acting as a proxy to
the real array Rtl8192UsbRadioD_Array.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 7 +++----
 drivers/staging/rtl8192u/r819xU_phy.h | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 3ed48d6095d7..983520b3aa25 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -29,7 +29,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 };
 
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
-#define rtl819XRadioD_Array Rtl8192UsbRadioD_Array
 
 /******************************************************************************
  * function:  This function checks different RF type to execute legal judgement.
@@ -1023,14 +1022,14 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 	case RF90_PATH_D:
 		for (i = 0; i < RadioD_ArrayLength; i = i+2) {
 
-			if (rtl819XRadioD_Array[i] == 0xfe) {
+			if (Rtl8192UsbRadioD_Array[i] == 0xfe) {
 				mdelay(100);
 				continue;
 			}
 			rtl8192_phy_SetRFReg(dev, eRFPath,
-					     rtl819XRadioD_Array[i],
+					     Rtl8192UsbRadioD_Array[i],
 					     bMask12Bits,
-					     rtl819XRadioD_Array[i+1]);
+					     Rtl8192UsbRadioD_Array[i+1]);
 			mdelay(1);
 
 		}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 44af37f19f45..2cd1c25164a2 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,8 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XRadioD_Array[];
-
 enum HW90_BLOCK_E {
 	HW90_BLOCK_MAC = 0,
 	HW90_BLOCK_PHY0 = 1,
-- 
2.18.0

