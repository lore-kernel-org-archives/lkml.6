Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5552ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2222084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnLFsnyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2222084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGTCdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46104 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so5353360pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3c4yJISsZ8njlrY27mOkZhrtgEwHQwsD2YRlK07pNU=;
        b=HnLFsnyvmq5bavtChtfoZG4xE36AR7SILCwwrOp2cvK4w0jROFyuOqe47PW4V2B3xm
         ZaMskY0oT0cuHVoypgl6eOgJR+IsXocd1P5gsd+Burz1y2JH6t/natdGZmS/wXNO5Tp5
         g2PLVKhSPpAM1jbdgdtDQy4Jj9Ryl/r2VLUN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3c4yJISsZ8njlrY27mOkZhrtgEwHQwsD2YRlK07pNU=;
        b=UCWTKGSCaPbv5Ai4gA8whYEq00m3WZt+VjcIHlZlXjOXrR9D1tRV05GqM+h3ZBOzKV
         bwHf2RcGL69G3nUOCG4uelNmP+XdFLK26jrmbdKFLVEJKMY+E5RvyB8QsLhAVz8Knvc1
         kHgjVmgt1CqSytCQiKNipvzT8NOKsfs78VcafZxAwpSRCdotqXKUNOclOHFzdE5uHuIe
         XQxk2cELWpX4hQYE3NKn5CxP8fCDTVPfy7vFzdI6nuDpvvAYB7tye/T9lXQ62zyf1KzQ
         +nWrfcQw+FDQ7oUne3JiYps/HX7RpsMz/8xA5xjs3A+4sL3fpomn83S8fyTF3O28jhj8
         l8ag==
X-Gm-Message-State: AOUpUlFt5MXPtVH54y57DIx4H/tKbu5bD/66mvZblHDGhCA84+Cv+Mho
        ouyiyak1Ywtc45jBVQImW09myg==
X-Google-Smtp-Source: AAOMgpdagwFi5+UEDQ5mG6IPH4WyU8HVrYo/k0Sgko87n843seHV+2UI2jsd7m3bAl0YEkBaqoBCnA==
X-Received: by 2002:a63:1c5f:: with SMTP id c31-v6mr73888pgm.321.1532051274708;
        Thu, 19 Jul 2018 18:47:54 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:54 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 3/9] efi/x86: align efi_uga_draw_protocol typedef names to convention
Date:   Fri, 20 Jul 2018 10:47:20 +0900
Message-Id: <20180720014726.24031-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-efi subsystem uses typedefs with the _t suffix to declare
data structures that originate in the UEFI spec. Our type mangling
for mixed mode depends on this convention, so rename the UGA drawing
protocols to allow efi_call_proto() to be used with them in a
subsequent patch.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c |  4 ++--
 arch/x86/boot/compressed/eboot.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index c72550783c16..011d5c289449 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -321,7 +321,7 @@ static void setup_quirks(struct boot_params *boot_params)
 static efi_status_t
 setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 {
-	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
+	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
 	u32 *handles = (u32 *)uga_handle;
@@ -366,7 +366,7 @@ setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 static efi_status_t
 setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 {
-	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
+	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
 	u64 *handles = (u64 *)uga_handle;
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index e799dc5c6448..8297387c4676 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -12,22 +12,22 @@
 
 #define DESC_TYPE_CODE_DATA	(1 << 0)
 
-struct efi_uga_draw_protocol_32 {
+typedef struct {
 	u32 get_mode;
 	u32 set_mode;
 	u32 blt;
-};
+} efi_uga_draw_protocol_32_t;
 
-struct efi_uga_draw_protocol_64 {
+typedef struct {
 	u64 get_mode;
 	u64 set_mode;
 	u64 blt;
-};
+} efi_uga_draw_protocol_64_t;
 
-struct efi_uga_draw_protocol {
+typedef struct {
 	void *get_mode;
 	void *set_mode;
 	void *blt;
-};
+} efi_uga_draw_protocol_t;
 
 #endif /* BOOT_COMPRESSED_EBOOT_H */
-- 
2.17.1

