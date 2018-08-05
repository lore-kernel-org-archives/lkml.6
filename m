Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65BC28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF851208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuHpYe8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF851208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHEF07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:26:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46180 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeHEF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:26:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14-v6so4121012pgv.13;
        Sat, 04 Aug 2018 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssAAIsvCmi0/GZVaortLAXi2PA0a/5tL3SgT/2w8XsI=;
        b=tuHpYe8rM9FT1Z30Qsg5PUMjrcIS9G9Qx50yIs+XY9yogHl29F+zDiXsgT8CwXZQ1m
         UkjHcMxe/bde8Fmb2+Da7BulbymnIj5L/LEkqKivjmSrEKm2HRExvmecC9lp5RYsXWKZ
         cu2B1GtDdNJM69bRLlQLcCRjsr/gNzy5gHqHU/xl00KnsjKRqYFOAIhlWD7REkaQBSZ7
         AeB9ilrSturiE/E+10AgLqHMSF+DkAT+7t28pGRIyRtGrQLOvxdzbohLt8TlWetrTEL5
         aOj+2lfg+Bnf1dBSkhrYjKSqLfgZEejAWmT5afltEPlBwKZ2FsobROom7gJNcdlLcNpg
         oV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssAAIsvCmi0/GZVaortLAXi2PA0a/5tL3SgT/2w8XsI=;
        b=mSZ+2T7BmYmJBCtE5SYxEhGAnm6nSWURa8QToUJ49A7t+fCu6hfzh4Ht2LlMBWgjVi
         aB48tVVtfbswjEt0SWr3/rSRFX8JhlQskRYHr//G3mIrij7/3l4OtIMzQYP5aoSmYCMu
         BfalLAbWZXh+bJaGpowNQxg+b2e6Mi1KtIJKk1V/LRyGUkA2wVLCu0RMVEdJ65oNZ0es
         arE8XqR+vWi23fzRJhIdX/fE//wo0zmQPuvNU5HYdU1L6OyxPGBTP0Gh5Ftl1FD1s5iW
         +6nxXUgWkz6tM/S3/OFYiX07ys52sOY+YiE71war5aA07fGEhAT7SUMGvpUMieHtZ+We
         J54w==
X-Gm-Message-State: AOUpUlHdFeOoeZXE7yVFn0p1vhZWjBwGAYQLtPXqPBib25mXNtb7gIcX
        q7UtIvUEt690rJ6jcBa/fslusZ8l
X-Google-Smtp-Source: AAOMgpfKYyB0P3Q+pIvuUt345DWq5RvQx/lHRFKZmcYg+W+MxINjtcoLi0gc4baqp/2CUTKsJJ6inw==
X-Received: by 2002:a62:4b48:: with SMTP id y69-v6mr11320003pfa.93.1533439438665;
        Sat, 04 Aug 2018 20:23:58 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x87-v6sm15971922pfa.143.2018.08.04.20.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 20:23:58 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 6/6] key: enforce the secure boot checking when loading efi root key
Date:   Sun,  5 Aug 2018 11:21:19 +0800
Message-Id: <20180805032119.20485-7-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180805032119.20485-1-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI root key is not completely secure insecure when the
secure boot is disabled because it can be changed by unsigned EFI
binary before system be handed over to kernel. But in some use
case user does not want the EFI secure key functions be blocked
when secure boot is disabled.

Like the kernel module verification, this patch adds a enforce
kernel configuration option that it can be used to enforce kernel
to checking the secure boot before loading efi root key. And user
can also use kernel parameter to enable it. When this option be
enabled, the EFI root key will not be loaded by kernel when secure
boot is diabled.

Without this option, kernel will be tainted but the EFI root key
can still be loaded.

Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++++
 drivers/firmware/efi/Kconfig                    |  8 ++++++
 drivers/firmware/efi/efi-secure-key.c           | 33 ++++++++++++++++++++++---
 include/linux/kernel.h                          |  3 ++-
 kernel/panic.c                                  |  1 +
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c68970..7a9ac358793f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1122,6 +1122,12 @@
 			vendor GUIDs, all of them will be loaded. See
 			Documentation/acpi/ssdt-overlays.txt for details.
 
+	efi-secure-key.sb_enforce [EFI; X86]
+			When EFI_SECURE_KEY is set, this means that
+			EFI root key will not be loaded when secure boot is
+			not enabled. Note that if EFI_SECURE_KEY_SB_ENFORCE
+			is set, that is always true, so this option does
+			nothing.
 
 	eisa_irq_edge=	[PARISC,HW]
 			See header of drivers/parisc/eisa.c.
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 048cf91ae8e8..fba894a4e7b0 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -187,6 +187,14 @@ config EFI_SECURE_KEY
 
 	  If unsure, say N.
 
+config EFI_SECURE_KEY_SB_ENFORCE
+	bool "Force checking secure boot when loading EFI root key"
+	default y
+	depends on EFI_SECURE_KEY
+	help
+	  Skip EFI root key when secure boot is not enabled. Without this,
+	  EFI root key will simply taint the kernel when no secure boot.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/efi-secure-key.c b/drivers/firmware/efi/efi-secure-key.c
index aa422ee87f70..417d73768887 100644
--- a/drivers/firmware/efi/efi-secure-key.c
+++ b/drivers/firmware/efi/efi-secure-key.c
@@ -15,6 +15,7 @@
 #include <linux/parser.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
+#include <linux/moduleparam.h>
 #include <keys/efi-type.h>
 #include <keys/user-type.h>
 #include <crypto/algapi.h>
@@ -27,6 +28,9 @@ static unsigned long rkey_size;
 static bool is_loaded;
 static bool is_secure;
 
+static bool sb_enforce = IS_ENABLED(CONFIG_EFI_SECURE_KEY_SB_ENFORCE);
+module_param(sb_enforce, bool_enable_only, 0644);
+
 static void __init
 print_efi_rkey_setup_data(struct efi_rkey_setup_data *rkey_setup)
 {
@@ -59,11 +63,13 @@ void __init parse_efi_root_key_setup(u64 phys_addr, u32 data_len)
 
 	/* keep efi root key */
 	if (rkey_setup->final_status == EFI_SUCCESS) {
-		memcpy(root_key, rkey_setup->root_key, rkey_setup->key_size);
-		rkey_size = rkey_setup->key_size;
-		is_loaded = true;
 		is_secure = rkey_setup->is_secure;
-		pr_info("EFI root key is loaded.\n");
+		if (is_secure || !sb_enforce) {
+			memcpy(root_key, rkey_setup->root_key, rkey_setup->key_size);
+			rkey_size = rkey_setup->key_size;
+			is_loaded = true;
+			pr_info("EFI root key is loaded.\n");
+		}
 		if (!is_secure) {
 			pr_warn("EFI root key is insecure when no secure boot.\n");
 		}
@@ -75,6 +81,14 @@ void __init parse_efi_root_key_setup(u64 phys_addr, u32 data_len)
 	early_iounmap(setup_data, data_len);
 }
 
+static void __init clean_efi_root_key(void)
+{
+	memzero_explicit(root_key, ROOT_KEY_SIZE);
+	rkey_size = 0;
+	is_loaded = false;
+	is_secure = false;
+}
+
 #define ERK_HASH_SIZE SHA256_DIGEST_SIZE
 #define HMAC_HASH_SIZE SHA256_DIGEST_SIZE
 #define DKEY_SIZE SHA256_DIGEST_SIZE
@@ -705,6 +719,17 @@ static int __init init_efi_secure_key(void)
 	if (!is_loaded)
 		return 0;
 
+	if (!is_secure) {
+		if (sb_enforce) {
+			clean_efi_root_key();
+			pr_info("EFI root key is unloaded because insecure.\n");
+			return 0;
+		} else {
+			add_taint(TAINT_INSECURE_KEY, LOCKDEP_STILL_OK);
+			pr_warn("Tainted kernel because EFI root key is insecure.\n");
+		}
+	}
+
 	hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(hash_tfm)) {
 		pr_err("can't allocate %s transform: %ld\n",
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..b45716e54a97 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -565,7 +565,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_INSECURE_KEY		18
+#define TAINT_FLAGS_COUNT		19
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..d641098a814d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -327,6 +327,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[TAINT_INSECURE_KEY]		= { 'Y', ' ', false },
 };
 
 /**
-- 
2.13.6

