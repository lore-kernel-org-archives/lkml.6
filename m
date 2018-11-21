Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB96C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B96206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ows8ndOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B96206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbeKVFp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbeKVFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA26206BB;
        Wed, 21 Nov 2018 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827423;
        bh=8JOTH2aLHViBIXw5/0s2i86YQ/3Iz238JPxDc0AfPzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ows8ndOMZCjkSprYjM1zgdwpv28GLeiHQKOdQPmBqDLjgOhdD0/W4VSKs6e5KuJCL
         GLwXt6cXGOJ3YssjMvZSNk3fs/Xj2hWyt4ti05v1416Go46XTRIlSiXPtpLOopE+dH
         3CVbDGAtWelIlmapj4ZJQe5rFSC8OgGmrfYpNfCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 24/59] x86/build: Specify stack alignment for clang
Date:   Wed, 21 Nov 2018 20:06:39 +0100
Message-Id: <20181121183509.210549454@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit d77698df39a512911586834d303275ea5fda74d0 upstream.

For gcc stack alignment is configured with -mpreferred-stack-boundary=N,
clang has the option -mstack-alignment=N for that purpose. Use the same
alignment as with gcc.

If the alignment is not specified clang assumes an alignment of
16 bytes, as required by the standard ABI. However as mentioned in
d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if
supported") the standard kernel entry on x86-64 leaves the stack
on an 8-byte boundary, as a consequence clang will keep the stack
misaligned.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -11,6 +11,14 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
+# For gcc stack alignment is specified with -mpreferred-stack-boundary,
+# clang has the option -mstack-alignment for that purpose.
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+        cc_stack_align_opt := -mpreferred-stack-boundary
+else ifneq ($(call cc-option, -mstack-alignment=4),)
+        cc_stack_align_opt := -mstack-alignment
+endif
+
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
 #
@@ -28,7 +36,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -mpreferred-stack-boundary=2)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align_opt)=2)
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
@@ -65,8 +73,10 @@ ifeq ($(CONFIG_X86_32),y)
         # with nonstandard options
         KBUILD_CFLAGS += -fno-pic
 
-        # prevent gcc from keeping the stack 16 byte aligned
-        KBUILD_CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
+        # Align the stack to the register width instead of using the default
+        # alignment of 16 bytes. This reduces stack usage and the number of
+        # alignment instructions.
+        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align_opt)=2)
 
         # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
         # a lot more stack due to the lack of sharing of stacklots:
@@ -98,8 +108,14 @@ else
         KBUILD_CFLAGS += $(call cc-option,-mno-80387)
         KBUILD_CFLAGS += $(call cc-option,-mno-fp-ret-in-387)
 
-	# Use -mpreferred-stack-boundary=3 if supported.
-	KBUILD_CFLAGS += $(call cc-option,-mpreferred-stack-boundary=3)
+        # By default gcc and clang use a stack alignment of 16 bytes for x86.
+        # However the standard kernel entry on x86-64 leaves the stack on an
+        # 8-byte boundary. If the compiler isn't informed about the actual
+        # alignment it will generate extra alignment instructions for the
+        # default alignment which keep the stack *mis*aligned.
+        # Furthermore an alignment to the register width reduces stack usage
+        # and the number of alignment instructions.
+        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align_opt)=3)
 
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)


