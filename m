Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82208C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521B820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfBHPKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:10:09 -0500
Received: from verein.lst.de ([213.95.11.211]:42848 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfBHPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:10:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 276E968DD2; Fri,  8 Feb 2019 16:10:07 +0100 (CET)
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v8 1/5] arm64: replace -pg with CC_FLAGS_FTRACE in arm64 Makefiles
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151007.276E968DD2@newverein.lst.de>
Date:   Fri,  8 Feb 2019 16:10:07 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  In preparation for arm64 supporting ftrace built on other compiler
  options, let's have the arm64 makefiles remove the $(CC_FLAGS_FTRACE)
  flags, whatever these may be, rather than assuming '-pg'.

  There should be no functional change as a result of this patch.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/kernel/Makefile |    6 +++---
 arch/arm64/lib/Makefile    |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_insn.o = -pg
-CFLAGS_REMOVE_return_address.o = -pg
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -24,7 +24,7 @@ CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffi
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
 		   -fcall-saved-x18 -fomit-frame-pointer
-CFLAGS_REMOVE_atomic_ll_sc.o := -pg
+CFLAGS_REMOVE_atomic_ll_sc.o := $(CC_FLAGS_FTRACE)
 GCOV_PROFILE_atomic_ll_sc.o	:= n
 KASAN_SANITIZE_atomic_ll_sc.o	:= n
 KCOV_INSTRUMENT_atomic_ll_sc.o	:= n
