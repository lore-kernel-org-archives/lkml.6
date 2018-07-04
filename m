Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC82C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EE92083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRshl8rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EE92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbeGDIlW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:41:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeGDIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:38:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so3477385edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvlJovxgJJ+QheLrbv7UTmXIJsBE8E1kyVYaaE1/yZw=;
        b=SRshl8rhluInJKzqhBxvquTse209GvHLTUrF9aCGlZ6nEHaH1VTiPTbYPXUcbCb+a+
         CanuIV+YSPI9fQGaPxCA6y/sZ6A2bNAuuBf8kf+E/rTCjsu7IFInTnKFhmb5fWDdU8AV
         CMe2EYDfFpFvPQAAN1eCohJQFn7LthzXTVMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvlJovxgJJ+QheLrbv7UTmXIJsBE8E1kyVYaaE1/yZw=;
        b=QbnYNddRhGNcOCBe86PbY6V6UOc7L0U4bO5wSkqyIpICOrOMtGu+9ycZK7ELeeyzhl
         xqSrrmcfXNUYdaeAK2hG2j0DyPQqO72BTQ/wax931RqGeMBPupdsUHUoAU2V4JUE+QJc
         atqno9bcH+rlBIB6M5QGOgagOVorX58WCWUC24gvhrtmsfAI5fVsHIM80FdLXvljBeX0
         gQJjmOPvVKeoWEcr1M9trk7sXL2If+KX80bQTEuHbD2OJDwUyyKudNlJErlbK5ujO1Rv
         Iv20jsSb0cZtwM/jF/k3+bQHAoK0qpEDQ26tZbsTm7wWJKaB1NbbVeMa3ETMxrgVBsGA
         eq8A==
X-Gm-Message-State: APt69E3dpU/+v3JNa7OTbelsI0XfWYoFa9L9FJ5D701OfZB+XhTTAIOK
        BiIbM+fHWNRA/W4yhPlNRkXd0lJ6QZ4=
X-Google-Smtp-Source: AAOMgpefmYphpRfS1iyARbegXECgWnzgz/vzo3BVRM73RgbJqNT8saXU2kyDa0nxqB36ShjrFYp07g==
X-Received: by 2002:a50:d9c7:: with SMTP id x7-v6mr1722213edj.95.1530693527904;
        Wed, 04 Jul 2018 01:38:47 -0700 (PDT)
Received: from ards-mac-mini.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1821740edj.55.2018.07.04.01.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:38:47 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v10 1/6] arch: enable relative relocations for arm64, power and x86
Date:   Wed,  4 Jul 2018 10:36:46 +0200
Message-Id: <20180704083651.24360-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before updating certain subsystems to use place relative 32-bit
relocations in special sections, to save space and reduce the
number of absolute relocations that need to be processed at runtime
by relocatable kernels, introduce the Kconfig symbol and define it
for some architectures that should be able to support and benefit
from it.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig         | 10 ++++++++++
 arch/arm64/Kconfig   |  1 +
 arch/powerpc/Kconfig |  1 +
 arch/x86/Kconfig     |  1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1aa59063f1fd..2b8b70820002 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -971,4 +971,14 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_ARCH_PREL32_RELOCATIONS
+	bool
+	help
+	  May be selected by an architecture if it supports place-relative
+	  32-bit relocations, both in the toolchain and in the module loader,
+	  in which case relative references can be used in special sections
+	  for PCI fixup, initcalls etc which are only half the size on 64 bit
+	  architectures, and don't require runtime relocation on relocatable
+	  kernels.
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..1940c6405d04 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,7 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..e4fe19789b8b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,6 +177,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..e10a3542db7e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,6 +123,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
-- 
2.17.1

