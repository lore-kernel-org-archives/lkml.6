Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10067C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5A2673A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2SuMHmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5A2673A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeFZS2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:28:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35862 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbeFZS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:28:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so18228090wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Pl3hl9dlr/wJP2mnaTAtaT54uoquJiV2t4p4cdOAyg=;
        b=Q2SuMHmpWc0SFvLy6xXOjfHRMrRsAwFPYNhXwbVsiRG/mDtWiE26DFzdPw657vIUoe
         CI/gMks+q6ug0i6zfBiWFiiMjsSnnDHmWEh2IFpjvpHAMiLbAOPKwUpMP6oy5HYP6ohH
         NLRjX3Btm+gWIrQ3cUm9F7iD7Form2lxGBOCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Pl3hl9dlr/wJP2mnaTAtaT54uoquJiV2t4p4cdOAyg=;
        b=g89OJer3EUj+zJ9F/kFw5OaQGilZ/vib8QsWpf//gX2efOOca+kLUYLFyxXj5RpJE0
         aWjbr0JBDAhWO4J+KF6ShJrWyBh9MpbZCdFTAlJ6JQ1w1pkzuJcBJ8wsNvh6iHoufQVw
         gyV10aWCq3c4i+sWWEMJgcCubYcQ+9wJvi/e2DxJSw03vLdy2DMVVILEeJBY3RVZnKb4
         VNEMFBQ++jxG9dekaFKMJ7PNf9EZ7JDxR4OpfEnmcGl6Uz3+9l321z4qTAjKhGtinzRx
         egxfho93qHy0pQ5FvkrJ9H9Xmaab0lqN4U35e6HES3z+ciaq5TmcgBBod0xcXapGHa4V
         CQwQ==
X-Gm-Message-State: APt69E2CKPIH4eMxB7M7ba+oQwQEJsxDVaAjqx2A/IfWkFGOYM5Wvs5i
        lRThnNzMqJo9O0PCnZUn7tXUCjJcYag=
X-Google-Smtp-Source: AAOMgpdp8md12H8lKmG+/g2bfIeTGUEZ5vKZNFc6DOZe0mNzs6xXc9uD89wKFdEr5cBtUmZ7zsgecA==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr2601535wrd.176.1530037722557;
        Tue, 26 Jun 2018 11:28:42 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:d037:e907:f0a2:a5ea])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1707664wmc.34.2018.06.26.11.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:28:41 -0700 (PDT)
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
Subject: [PATCH v9 1/6] arch: enable relative relocations for arm64, power and x86
Date:   Tue, 26 Jun 2018 20:27:56 +0200
Message-Id: <20180626182802.19932-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
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
2.11.0

