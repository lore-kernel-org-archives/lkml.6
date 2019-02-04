Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A83C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C720820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBDIqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:46:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfBDIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:46:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148kCNc356553
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:46:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148kBMc356550;
        Mon, 4 Feb 2019 00:46:11 -0800
Date:   Mon, 4 Feb 2019 00:46:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-ce9084ba0d1d8030adee7038ace32f8d9d423d0f@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, lee.jones@linaro.org,
        hpa@zytor.com, peterz@infradead.org, ard.biesheuvel@linaro.org,
        xypron.glpk@gmx.de, jhugo@codeaurora.org,
        takahiro.akashi@linaro.org, agraf@suse.de,
        matt@codeblueprint.co.uk, bjorn.andersson@linaro.org,
        tglx@linutronix.de, leif.lindholm@linaro.org,
        sai.praneeth.prakhya@intel.com, pjones@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com, lee.jones@linaro.org, bp@alien8.de,
          matt@codeblueprint.co.uk, bjorn.andersson@linaro.org,
          takahiro.akashi@linaro.org, agraf@suse.de, xypron.glpk@gmx.de,
          ard.biesheuvel@linaro.org, jhugo@codeaurora.org,
          leif.lindholm@linaro.org, sai.praneeth.prakhya@intel.com,
          pjones@redhat.com, tglx@linutronix.de
In-Reply-To: <20190202094119.13230-9-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-9-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig
 symbol
Git-Commit-ID: ce9084ba0d1d8030adee7038ace32f8d9d423d0f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ce9084ba0d1d8030adee7038ace32f8d9d423d0f
Gitweb:     https://git.kernel.org/tip/ce9084ba0d1d8030adee7038ace32f8d9d423d0f
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sat, 2 Feb 2019 10:41:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:27:29 +0100

x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol

Turn ARCH_USE_MEMREMAP_PROT into a generic Kconfig symbol, and fix the
dependency expression to reflect that AMD_MEM_ENCRYPT depends on it,
instead of the other way around. This will permit ARCH_USE_MEMREMAP_PROT
to be selected by other architectures.

Note that the encryption related early memremap routines in
arch/x86/mm/ioremap.c cannot be built for 32-bit x86 without triggering
the following warning:

     arch/x86//mm/ioremap.c: In function 'early_memremap_encrypted':
  >> arch/x86/include/asm/pgtable_types.h:193:27: warning: conversion from
                     'long long unsigned int' to 'long unsigned int' changes
                     value from '9223372036854776163' to '355' [-Woverflow]
      #define __PAGE_KERNEL_ENC (__PAGE_KERNEL | _PAGE_ENC)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     arch/x86//mm/ioremap.c:713:46: note: in expansion of macro '__PAGE_KERNEL_ENC'
       return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_ENC);

which essentially means they are 64-bit only anyway. However, we cannot
make them dependent on CONFIG_ARCH_HAS_MEM_ENCRYPT, since that is always
defined, even for i386 (and changing that results in a slew of build errors)

So instead, build those routines only if CONFIG_AMD_MEM_ENCRYPT is
defined.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-9-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig          | 3 +++
 arch/x86/Kconfig      | 5 +----
 arch/x86/mm/ioremap.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..9f0213213da8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -885,6 +885,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config ARCH_USE_MEMREMAP_PROT
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..a7e7a60602fb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1510,6 +1510,7 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	select DYNAMIC_PHYSICAL_MASK
+	select ARCH_USE_MEMREMAP_PROT
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
@@ -1529,10 +1530,6 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	  If set to N, then the encryption of system memory can be
 	  activated with the mem_encrypt=on command line option.
 
-config ARCH_USE_MEMREMAP_PROT
-	def_bool y
-	depends on AMD_MEM_ENCRYPT
-
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5378d10f1d31..0029604af8a4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -705,7 +705,7 @@ bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
 
-#ifdef CONFIG_ARCH_USE_MEMREMAP_PROT
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /* Remap memory with encryption */
 void __init *early_memremap_encrypted(resource_size_t phys_addr,
 				      unsigned long size)
@@ -747,7 +747,7 @@ void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_NOENC_WP);
 }
-#endif	/* CONFIG_ARCH_USE_MEMREMAP_PROT */
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 static pte_t bm_pte[PAGE_SIZE/sizeof(pte_t)] __page_aligned_bss;
 
