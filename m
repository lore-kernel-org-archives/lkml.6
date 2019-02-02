Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF59C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0233520870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3vgkLIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfBBJlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34305 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfBBJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so7516301ede.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iULYkK79KzQBLjCzo7CPIeChw9PmIPBpwpuo29dYAvY=;
        b=T3vgkLIZXa0V+j0poP/GqVK5uMWVYHB5KT1wpcxU8+sWPsMPj3VSoA1cLPuqgiTIvK
         DFPkzouQE0soyhlw+bXv8OqICmb76KmSNL4cxWJBi0UeaOV1fjBHdcbQWQZImYVfwwlv
         4WniOgtSiPG/V0nai9ug659D5v2uzCMlRc0A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iULYkK79KzQBLjCzo7CPIeChw9PmIPBpwpuo29dYAvY=;
        b=IJ8vtVmo3iMuAE5Y/jQPKrI6NycQ/NT+kb+p0Dc1vYseoH72vvMUinb/bPu0auEKJo
         VLGNDsvf/s6Ld8U7U7Eu1Waecbo8u0fDBAON6n2NUjJlPVeE15HH/h+rN6T2IHVWhFc/
         sFSfEYHQXO2GVPi4QnaSvvZHDntir4GIvlr0fVMB2roJw6uIOnMGo3VvhHVRXZD2Wy+F
         egPTAg89yj8UpBAhVclAYAAk/FrYt6qUB8q7MZbTA39RTRXqBBlch4/vJrTpQbDl55Gr
         ZaEqlx08qsAKMe+wLIlK6xLhg9eR+YC15gzQ+pV5XePPnVcfHmEdC49Y++FUxQOY+d+N
         HH4w==
X-Gm-Message-State: AJcUukcumAvlsxJbAGhZm46swnUVNhGyGb8UowcdPNmMP6LSZZooiN17
        5QjVVZzQzCZ6hEcXNyFUudjG9A==
X-Google-Smtp-Source: ALg8bN4m1urgzG2Bkr7v90ADfFhZpdQHQs9wD97wg5DTIStUgQOl2Ci/ZOBpPf3NdlCG1PCvRfTO8g==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr40373314edi.246.1549100498944;
        Sat, 02 Feb 2019 01:41:38 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:38 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 08/10] x86: make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
Date:   Sat,  2 Feb 2019 10:41:17 +0100
Message-Id: <20190202094119.13230-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 15af091611e2..09c2c5600579 100644
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
 
-- 
2.17.1

