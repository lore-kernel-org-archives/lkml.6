Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ECEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD53420671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU5m4eSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD53420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeGZUnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44459 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so2239143edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBIS6lpy8GcWKbEtD1zd2prebwV9XYTKjnN2u4Nb4eI=;
        b=sU5m4eSRSrC1VW5ZjwJ/wSYvzhjrXWbwp0KnCfEJXUF974TBucrtFFpCAw/A8IMM69
         rHjW3ZuicEsrY6s0SQaRwR6VWsOeqyzGAQAzPuBO5VZha/+w7EcGlpiGYMzzY2PMba1t
         Fwhqrvm+wyo66a+qChstNLn4frnCeOKVOhrGk0X6MBdqJkPoEFvmRYgmFiWVu7Ar23RD
         sw1wR57VGRNymV8vGQ7JwXaIryiB6WP2sq4EFRyKo5vDyyiK5Xd1GtHEAyClIS0IOLQl
         wA7epwmEs7Wt4Q+4SOFKfto0XHhv3Ub04torQeD72LQKoFhyA89oGKPTsK9xjUXSOXxY
         mn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gBIS6lpy8GcWKbEtD1zd2prebwV9XYTKjnN2u4Nb4eI=;
        b=TTtrsBsKzjv2bZmUEttSa1USrSlO/pqpozdlnLIbnrsCMLXHKh2xtiY/sl4Qzao4wY
         xxMXU2a9HeNfGu+2ORDT5fLCewVsRnLSDtf1uxT/n0t8Mr0cJAHbFsNZq6t9NElqmrMx
         vw00mg3iojk3t4n5ZzAv0Lrnus+64cTMpAolquJq7Y9t3GVLgXMuW3l9uakWeYMPy1uU
         9PHqbxMdylrvZfKaw45m0+FiHRxhIUEOyq5ssOWDiHrl7/gpAV7HNj819ucccxXBUuqv
         ahs02M/jFzOdSqW2XY5L2q/eKh2OoQlC+DR/gX9p48Y3/09RYKyeNtNc6oU1SDpxx3E6
         fyiA==
X-Gm-Message-State: AOUpUlFkMFHclP89/fIrMsf66JJfVLm44RWAdnaiPll5+567sgEwxXTY
        qKdKYsXYp6hzNBi38NQ0+ZWYN5Ss
X-Google-Smtp-Source: AAOMgpcIrt1eU8fxTrdGok0YoQhEFmYNiBAk+x+az0cOfzK287fRHQtETb9I6AW4nWQVdUGGZLZQMA==
X-Received: by 2002:a50:b4b0:: with SMTP id w45-v6mr4084751edd.254.1532633100234;
        Thu, 26 Jul 2018 12:25:00 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/16] staging:rtl8192u: Remove proxy array rtl819XAGCTAB_Array - Style
Date:   Thu, 26 Jul 2018 20:24:18 +0100
Message-Id: <20180726192426.31913-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the array rtl819XAGCTAB_Array which is only a proxy to the
array Rtl8192UsbAGCTAB_Array. There appears to be no purpose
served by this implementation, other then to obscure the
Rtl8192UsbAGCTAB_Array structure, which is actually written to and
read from.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 11 +++++------
 drivers/staging/rtl8192u/r819xU_phy.h |  1 -
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 8d44bbe90221..cf7b09f9818a 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -33,7 +33,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 #define rtl819XRadioB_Array Rtl8192UsbRadioB_Array
 #define rtl819XRadioC_Array Rtl8192UsbRadioC_Array
 #define rtl819XRadioD_Array Rtl8192UsbRadioD_Array
-#define rtl819XAGCTAB_Array Rtl8192UsbAGCTAB_Array
 
 /******************************************************************************
  * function:  This function checks different RF type to execute legal judgement.
@@ -542,12 +541,12 @@ void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
 		}
 	} else if (ConfigType == BaseBand_Config_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLength; i += 2) {
-			rtl8192_setBBreg(dev, rtl819XAGCTAB_Array[i],
-					 bMaskDWord, rtl819XAGCTAB_Array[i+1]);
+			rtl8192_setBBreg(dev, Rtl8192UsbAGCTAB_Array[i],
+					 bMaskDWord, Rtl8192UsbAGCTAB_Array[i+1]);
 			RT_TRACE(COMP_DBG,
-				 "i: %x, rtl819XAGCTAB_Array[0]=%x rtl819XAGCTAB_Array[1]=%x\n",
-				 i, rtl819XAGCTAB_Array[i],
-				 rtl819XAGCTAB_Array[i+1]);
+				 "i: %x, Rtl8192UsbAGCTAB_Array[0]=%x Rtl8192UsbAGCTAB_Array[1]=%x\n",
+				 i, Rtl8192UsbAGCTAB_Array[i],
+				 Rtl8192UsbAGCTAB_Array[i+1]);
 		}
 	}
 }
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 842837bd6631..808a11c475a4 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XAGCTAB_Array[];
 extern u32 rtl819XRadioA_Array[];
 extern u32 rtl819XRadioB_Array[];
 extern u32 rtl819XRadioC_Array[];
-- 
2.18.0

