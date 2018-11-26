Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3903C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665412089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXEOJZ0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665412089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeKZVsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeKZVsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17D421104;
        Mon, 26 Nov 2018 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229697;
        bh=E3N85T6NtOYCM12ne9YIQTsCteZZrFqGAkvmgjG/YWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXEOJZ0NNBr84E+li/MukqSTIc8WPK35xgUiuGMpHNXiMSxd4Nxtv2MAF6WbM0oWW
         n9WmhdHTWUS8dFiCm0dWycaLVa0IDRLjqeyboDBuee/NVWypuVU5ZUXg1IJwWKx5Dn
         C1ussct5cT4taRkJ5VZwhpHCMsJJ0nGNvC12S2ws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bernhard.Rosenkranzer@linaro.org,
        Greg Hackmann <ghackmann@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Davidson <md@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Hines <srhines@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dianders@chromium.org,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 36/70] x86/build: Fix stack alignment for CLang
Date:   Mon, 26 Nov 2018 11:50:51 +0100
Message-Id: <20181126105050.235366120@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 8f91869766c00622b2eaa8ee567db4f333b78c1a upstream.

Commit:

  d77698df39a5 ("x86/build: Specify stack alignment for clang")

intended to use the same stack alignment for clang as with gcc.

The two compilers use different options to configure the stack alignment
(gcc: -mpreferred-stack-boundary=n, clang: -mstack-alignment=n).

The above commit assumes that the clang option uses the same parameter
type as gcc, i.e. that the alignment is specified as 2^n. However clang
interprets the value of this option literally to use an alignment of n,
in consequence the stack remains misaligned.

Change the values used with -mstack-alignment to be the actual alignment
instead of a power of two.

cc-option isn't used here with the typical pattern of KBUILD_CFLAGS +=
$(call cc-option ...). The reason is that older gcc versions don't
support the -mpreferred-stack-boundary option, since cc-option doesn't
verify whether the alternative option is valid it would incorrectly
select the clang option -mstack-alignment..

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bernhard.Rosenkranzer@linaro.org
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Davidson <md@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Hines <srhines@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dianders@chromium.org
Link: http://lkml.kernel.org/r/20170817004740.170588-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,9 +14,11 @@ endif
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-        cc_stack_align_opt := -mpreferred-stack-boundary
-else ifneq ($(call cc-option, -mstack-alignment=4),)
-        cc_stack_align_opt := -mstack-alignment
+      cc_stack_align4 := -mpreferred-stack-boundary=2
+      cc_stack_align8 := -mpreferred-stack-boundary=3
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+      cc_stack_align4 := -mstack-alignment=4
+      cc_stack_align8 := -mstack-alignment=8
 endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
@@ -36,7 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align_opt)=2)
+REALMODE_CFLAGS += $(cc_stack_align4)
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
@@ -76,7 +78,7 @@ ifeq ($(CONFIG_X86_32),y)
         # Align the stack to the register width instead of using the default
         # alignment of 16 bytes. This reduces stack usage and the number of
         # alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align_opt)=2)
+        KBUILD_CFLAGS += $(cc_stack_align4)
 
         # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
         # a lot more stack due to the lack of sharing of stacklots:
@@ -115,7 +117,7 @@ else
         # default alignment which keep the stack *mis*aligned.
         # Furthermore an alignment to the register width reduces stack usage
         # and the number of alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align_opt)=3)
+        KBUILD_CFLAGS += $(cc_stack_align8)
 
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)


