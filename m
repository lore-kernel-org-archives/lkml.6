Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C332BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F9220819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F9220819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeKEX5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:57:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEX5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:57:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5Earep368360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 06:36:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5EarhN368357;
        Mon, 5 Nov 2018 06:36:53 -0800
Date:   Mon, 5 Nov 2018 06:36:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-f87419e1c9b5d38ea8a81b31e90aefa1be3fde5d@git.kernel.org>
Cc:     natechancellor@gmail.com, yamada.masahiro@socionext.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        ndesaulniers@google.com, keescook@chromium.org, namit@vmware.com,
        linux-kernel@vger.kernel.org
Reply-To: yamada.masahiro@socionext.com, natechancellor@gmail.com,
          hpa@zytor.com, tglx@linutronix.de, bp@alien8.de,
          mingo@kernel.org, ndesaulniers@google.com, keescook@chromium.org,
          namit@vmware.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181023231125.27976-1-natechancellor@gmail.com>
References: <20181023231125.27976-1-natechancellor@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/build: Remove -pipe from KBUILD_CFLAGS
Git-Commit-ID: f87419e1c9b5d38ea8a81b31e90aefa1be3fde5d
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

Commit-ID:  f87419e1c9b5d38ea8a81b31e90aefa1be3fde5d
Gitweb:     https://git.kernel.org/tip/f87419e1c9b5d38ea8a81b31e90aefa1be3fde5d
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Tue, 23 Oct 2018 16:11:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 15:32:40 +0100

x86/build: Remove -pipe from KBUILD_CFLAGS

Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
inline assembly code to work around asm() related GCC inlining bugs")
added -Wa,- to KBUILD_CFLAGS, which breaks compiling with Clang (hangs
indefinitely at compiling init/main.o). This happens because while Clang
accepts -pipe (and has it documented in its list of supported flags), it
silently ignores it after this 2010 commit (thanks to Nick Desaulniers
for tracking this down), meaning that gas just infinitely waits for
stdin and never receives it.

https://github.com/llvm-mirror/clang/commit/c19a12dc3d441bec62eed55e312b76c12d6d9022

Initially, I had suggested just add -Wa,- to KBUILD_CFLAGS when GCC was
being used but that was before realizing it is because Clang doesn't do
anything with -pipe. H. Peter Anvin suggested checking to see if -pipe
gives us any gains out of GCC. Turns out it might actually be hurting:

With -pipe:

real    3m40.813s
real    3m44.449s
real    3m39.648s

Without -pipe:

real    3m38.492s
real    3m38.335s
real    3m38.975s

The issue of -Wa,- being passed along to gas without -pipe being
supported should still probably be fixed on the LLVM side (open issue:
https://bugs.llvm.org/show_bug.cgi?id=39410) but this is not as much of
a workaround anymore since it helps both GCC and Clang.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/213
Link: https://lkml.kernel.org/r/20181023231125.27976-1-natechancellor@gmail.com
---
 arch/x86/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b562e464009..88398fdf8129 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
-# Speed up the build
-KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -239,7 +237,7 @@ archheaders:
 archmacros:
 	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
 
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
 
