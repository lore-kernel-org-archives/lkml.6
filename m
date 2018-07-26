Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F420883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk0s/iSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8F420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbeGZUnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33129 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeGZUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so2262567edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhS47ATwJEekxmA1KbkxybCUcBBavjTOdhE2mUWZWfg=;
        b=sk0s/iSPhd+7IehC+b8BHSzm0l9pqTsL1f/8IdE1gHunAhoOWapWMScvRrgYtUwtUW
         NMXInEN4fl3VoNXW8b2SiF1nIphL8cG2fzWQ2sg2weoBiYGh6LM4tT7z/y+gNTxn/Zbn
         wQdxEA2870IvykpQMVn2M2gomvuYltIs59JQ546mJuTOkHqCyafao8tcsP+7SGMHOOwr
         RDYNdwVDYvBlCGxosG9aXK+ZnvxNz2jJQFuIcKRYXq3Sqoev+hhhJGrGtAebo1SWGnbh
         sKLNrxRzTI1pFsbyMov3bpLZ//xkPdTvyr9rvGOhlztl3bGdnw2CpinYf+ayR+XUtsHe
         O6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhS47ATwJEekxmA1KbkxybCUcBBavjTOdhE2mUWZWfg=;
        b=r0atkAhdbZKdKO46LykjDgW8GwylfVtCqJAgfqXSwB/We5XuPEjFp9mIGYdM9HrFxE
         XqudXLdtj0SdXGzEx/GC5QwTLQP8JNCy6SqggQwoe80sjdgC5KNX/peciSzDfkxoVqYN
         xomuUWMlw/HpZsahytrGOVzftoOV85qAUIOFE0yt6MKTJZcnxZ+xptfroeeg981rmxXB
         6omQ//55hCpmcd51Uqjga2Wpk3bezN90HBYc0MRawHAotOxR8J8T+zkLqjRdipUMqocU
         Lc0dpXaYGrutdfoME1dNGZLSI1YB305Leuz3qHbw4ndqTHSxbKpk73yl2HPHlOHUTfei
         s/aw==
X-Gm-Message-State: AOUpUlE8I9cKcLHQpvzzC2+7Ts1DFz6lmOi0ZOzo/qXksqLTDU8x5vGX
        AsYNZQ7Kf229B4Gvrc0sA7lR8XBW
X-Google-Smtp-Source: AAOMgpeYsnAlR6PTyZom1qkaQJ/xAiB9R5Oui/d16gtt6gYR9eJqkyaIiwSOtNNzbOLqL7wyzNQcyQ==
X-Received: by 2002:a50:ba3b:: with SMTP id g56-v6mr4113809edc.85.1532633104227;
        Thu, 26 Jul 2018 12:25:04 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/16] staging:rtl8192u: Remove proxy rtl819XRadioC_Array - Style
Date:   Thu, 26 Jul 2018 20:24:21 +0100
Message-Id: <20180726192426.31913-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the array rtl819XRadioC_Array which is only serving as a proxy for
the real array Rtl8192UsbRadioC_Array. This is a coding style change and
should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 7 +++----
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 1cbb48c5c110..3ed48d6095d7 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -29,7 +29,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 };
 
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
-#define rtl819XRadioC_Array Rtl8192UsbRadioC_Array
 #define rtl819XRadioD_Array Rtl8192UsbRadioD_Array
 
 /******************************************************************************
@@ -1009,14 +1008,14 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 	case RF90_PATH_C:
 		for (i = 0; i < RadioC_ArrayLength; i = i+2) {
 
-			if (rtl819XRadioC_Array[i] == 0xfe) {
+			if (Rtl8192UsbRadioC_Array[i] == 0xfe) {
 				mdelay(100);
 				continue;
 			}
 			rtl8192_phy_SetRFReg(dev, eRFPath,
-					     rtl819XRadioC_Array[i],
+					     Rtl8192UsbRadioC_Array[i],
 					     bMask12Bits,
-					     rtl819XRadioC_Array[i+1]);
+					     Rtl8192UsbRadioC_Array[i+1]);
 			mdelay(1);
 
 		}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d708796d7cec..44af37f19f45 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XRadioC_Array[];
 extern u32 rtl819XRadioD_Array[];
 
 enum HW90_BLOCK_E {
-- 
2.18.0

