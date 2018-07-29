Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99889C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419C420892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA1wxk+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeG2Wk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbeG2WkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so10590083wrs.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nC037p4FtoVIrMCNzU8I7gaT/iXgNmtqDq3KbXQXHm4=;
        b=uA1wxk+AgNNQjBqrEphpnjlvegN3sAM9+cpYFB8lD3ixZ5YMOP7dL7sVqaKOaDNNog
         hzfHBSx1HJtNn0PEB+0hU3GkW6mi/UGJ7GW9gDo1ONs0AwdlHwfVDkFPqyNoM1TDPxYx
         fW2rV+G4j07OmMYqHrm5UIpDrejzdj4vayOwXgemmAtBZFkf8N20tmRwVLwS5Q8EosoM
         UCvu6pfzTYB/Kh3RM2WYIETAW3kdQsCOeEi9xL0/479+Gcdzgd5fjWpljHIqweG3je62
         hS16p+F8UhASu4kdGmwTcHajsbMJaaDEobciuwVT03DJM15+KSXfooWNfOLic2y17h5G
         2/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nC037p4FtoVIrMCNzU8I7gaT/iXgNmtqDq3KbXQXHm4=;
        b=Sjv2O8whUpq0+mF6kHak7R5Qoa2mWpjtasVC82qR2ZVG2rhvE1RQShw5jbFhw1ef7Y
         WPrJr9SuOnKAwvc9IFJZHWNbzurXbUH/maTURAQpBO4eirZJqthYz5gLhZgkt3VsvNrr
         3JLsceRgZZwGEWeJB7v5eV0y7n9SPyorNgurLu44Mm+NPa0rSIdx+4PCl2jOAWnQDhlb
         bJtFl2pok5Et228G4SHjDsH9AfZRXk4zlfUzYO6KC5BVLdrdnWqD+xEgyvZ1jIVcL7I8
         frLMHBthedugxRlRy6PpBbQD81ETNX69trm8HhHyQk0IWLxblgCfN/XZRnbPcRz8Bpu5
         iKiA==
X-Gm-Message-State: AOUpUlG+HwwHA0cKpGXpF30melzlLIVsni+oNZjr3ln7dybIMRHdmW9c
        BCOKP7vwLTihDf+8kVHGeS3xnjcBrE4=
X-Google-Smtp-Source: AAOMgpdA//a4oTkCVdzLGLhQcniWCSCZScevG9l4QtbBPyfXw1Um2lhEyk9sN6rqijGDkMFsqkZkTA==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr14373102wrp.140.1532898512927;
        Sun, 29 Jul 2018 14:08:32 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 08/15] staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
Date:   Sun, 29 Jul 2018 22:07:40 +0100
Message-Id: <20180729210747.10803-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_ratr_sta_e was defined in the file
drivers/staging/rtl8192u/r8192U_dm.h but never actually used in that
file. The only variable which uses this enumerated type is 'ratr_state',
a member variable of the _rate_adaptive structure defined in the file
drivers/staging/rtl8192u/r8192U.h.

To clarify and place the enumerated type close to where it is used the
type was moved to the drivers/staging/rtl8192u/r8192U.h file.

In addition the member variable 'ratr_state' which uses the enumerated
constants was declared as being of type 'u8'. This negates any advantage
of the enumerated type, compiler type-checking, so that member variable's
type has been changed to being of the enumerated type.

The typedef from the enumerated type has been removed to clear the
checkpatch issue with defining new types. Additionally the name of the
type has been left as enum dynamic_ratr_state

This is a coding style change and should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    | 10 +++++++++-
 drivers/staging/rtl8192u/r8192U_dm.h |  8 --------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e615d9b3f6b1..94a148994069 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -662,9 +662,17 @@ typedef enum _RT_RF_TYPE_819xU {
 	RF_PSEUDO_11N = 4,
 } RT_RF_TYPE_819xU, *PRT_RF_TYPE_819xU;
 
+/* 2007/10/08 MH Define RATR state. */
+enum dynamic_ratr_state {
+	DM_RATR_STA_HIGH = 0,
+	DM_RATR_STA_MIDDLE = 1,
+	DM_RATR_STA_LOW = 2,
+	DM_RATR_STA_MAX
+};
+
 typedef struct _rate_adaptive {
 	u8				rate_adaptive_disabled;
-	u8				ratr_state;
+	enum dynamic_ratr_state		ratr_state;
 	u16				reserve;
 
 	u32				high_rssi_thresh_for_ra;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 078770a8c7bf..d7bd257a7e93 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -105,14 +105,6 @@ struct dig {
 	long		rssi_val;
 };
 
-/* 2007/10/08 MH Define RATR state. */
-typedef enum tag_dynamic_ratr_state_definition {
-	DM_RATR_STA_HIGH = 0,
-	DM_RATR_STA_MIDDLE = 1,
-	DM_RATR_STA_LOW = 2,
-	DM_RATR_STA_MAX
-} dm_ratr_sta_e;
-
 /* 2007/10/11 MH Define DIG operation type. */
 typedef enum tag_dynamic_init_gain_operation_type_definition {
 	DIG_TYPE_THRESH_HIGH	= 0,
-- 
2.18.0

