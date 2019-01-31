Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F175EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB740218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bummAweV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfAaT3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:29:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36849 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfAaT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:29:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so1934675plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFJ2wRRAA6IcXGO+/YjG1KwDtDZI3ZJyGSkT8C93+ng=;
        b=bummAweVarfI8k6oygDBubQOq0LmgOcN0J+QZblexpy8/IhsmXIWhZQep1j4JxBHCi
         9M3wp41b1RA0JpXrPwzKUXMe2wlknzlm38/yVJxZ2VisEsShjKcd37T3/XgmFxqWOxEH
         mrkHCwpMgxQiKPgnIa990XbwbI1+A6HThvwIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFJ2wRRAA6IcXGO+/YjG1KwDtDZI3ZJyGSkT8C93+ng=;
        b=VxWq2igk83wLFAUEAQeU/2is+mvARjQ5TFTdS7aIznI3pH5SZSBDh3Eg3lE8q/8Im1
         GR3TSQeWYjz0NegNql4t/dOn+GLs0uHOTglrvUK0Pj5cPjctxZp69mumXJAyuCDhioz8
         ROoxPTBTa+4EKtRMkc2krBNGiMEAHgCJeOKtbZMfN1B1X4sMC0BL4I6Bx5/2DpiU7rF5
         RE70w6fvBvuRRTZ0iLYJAqIQnAyyH51dcPOgjOcKqj2EmaQt+9WHXBjJUj53wEmJ2b12
         WbajC4HQLD2pcIeXFGvCpDYYTPWBH+FX/DeP8pjAEftpC9vgYihGK/0Mga9lFbb58oN5
         nwBg==
X-Gm-Message-State: AJcUukeenH9/G+yMnEnT9uuuMPSbiuaxxJ1AVS6Bz5R+aZ46M/Iuq51P
        t+5L3pQbDBgu5zQjW63vgRW7hg==
X-Google-Smtp-Source: ALg8bN620UGZSWSXLJlom6YH/iGy7rMQgOcXdIpYO/yDV0hBkdq6i4rBx/QaIGQWhCFld0FOFHOD0w==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr36294891plt.157.1548962959435;
        Thu, 31 Jan 2019 11:29:19 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:29:18 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Joerg Roedel <jroedel@suse.de>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 22/27] x86/modules: Add option to start module section after kernel
Date:   Thu, 31 Jan 2019 11:24:29 -0800
Message-Id: <20190131192533.34130-23-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option so the module section is just after the mapped kernel. It
will ensure position independent modules are always at the right
distance from the kernel and do not require mcmodule=large. It also
optimize the available size for modules by getting rid of the empty
space on kernel randomization range.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 Documentation/x86/x86_64/mm.txt         | 3 +++
 arch/x86/Kconfig                        | 4 ++++
 arch/x86/include/asm/pgtable_64_types.h | 6 ++++++
 arch/x86/kernel/head64.c                | 5 ++++-
 arch/x86/mm/dump_pagetables.c           | 3 ++-
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 804f9426ed17..35b845d695d5 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -151,3 +151,6 @@ correct as KASAN disables KASLR.
 
 For both 4- and 5-level layouts, the STACKLEAK_POISON value in the last 2MB
 hole: ffffffffffff4111
+
+If CONFIG_DYNAMIC_MODULE_BASE is enabled, the module section follows the end of
+the mapped kernel.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 263d81c570b2..c3ad1b0ae1a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2221,6 +2221,10 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 
 	   If unsure, leave at the default value.
 
+# Module section starts just after the end of the kernel module
+config DYNAMIC_MODULE_BASE
+	bool
+
 config X86_GLOBAL_STACKPROTECTOR
 	bool "Stack cookie using a global variable"
 	depends on CC_STACKPROTECTOR_AUTO
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 88bca456da99..d1bb676ec376 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <asm/kaslr.h>
+#include <asm/sections.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -141,7 +142,12 @@ extern unsigned int ptrs_per_p4d;
 
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
 
+#ifdef CONFIG_DYNAMIC_MODULE_BASE
+#define MODULES_VADDR		ALIGN(((unsigned long)_end + PAGE_SIZE), PMD_SIZE)
+#else
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
+#endif
+
 /* The module sections ends with the start of the fixmap */
 #define MODULES_END		_AC(0xffffffffff000000, UL)
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 22e81275495b..ca2f6ff431af 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -411,12 +411,15 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	 * Build-time sanity checks on the kernel image and module
 	 * area mappings. (these are purely build-time and produce no code)
 	 */
+#ifndef CONFIG_DYNAMIC_MODULE_BASE
 	BUILD_BUG_ON(MODULES_VADDR < __START_KERNEL_map);
 	BUILD_BUG_ON(MODULES_VADDR - __START_KERNEL_map < KERNEL_IMAGE_SIZE);
-	BUILD_BUG_ON(MODULES_LEN + KERNEL_IMAGE_SIZE > 2*PUD_SIZE);
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_RANDOMIZE_BASE_LARGE) &&
+		     MODULES_LEN + KERNEL_IMAGE_SIZE > 2*PUD_SIZE);
 	BUILD_BUG_ON((__START_KERNEL_map & ~PMD_MASK) != 0);
 	BUILD_BUG_ON((MODULES_VADDR & ~PMD_MASK) != 0);
 	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
+#endif
 	MAYBE_BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..3172bd968215 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -104,7 +104,7 @@ static struct addr_marker address_markers[] = {
 	[EFI_END_NR]		= { EFI_VA_END,		"EFI Runtime Services" },
 #endif
 	[HIGH_KERNEL_NR]	= { __START_KERNEL_map,	"High Kernel Mapping" },
-	[MODULES_VADDR_NR]	= { MODULES_VADDR,	"Modules" },
+	[MODULES_VADDR_NR]	= { 0/*MODULES_VADDR*/,	"Modules" },
 	[MODULES_END_NR]	= { MODULES_END,	"End Modules" },
 	[FIXADDR_START_NR]	= { FIXADDR_START,	"Fixmap Area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
@@ -623,6 +623,7 @@ static int __init pt_dump_init(void)
 	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
 	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
 #endif
+	address_markers[MODULES_VADDR_NR].start_address = MODULES_VADDR;
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
-- 
2.20.1.495.gaa96b0ce6b-goog

