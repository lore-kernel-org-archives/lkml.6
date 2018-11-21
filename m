Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11C2214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnDp5Co+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11C2214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbeKVFrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731945AbeKVFr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:47:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FE32151B;
        Wed, 21 Nov 2018 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827516;
        bh=OAsH4TLXG4YTQxXyh2BTGrjiFxzBy59FJ5dM8TAbV3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnDp5Co+HX5Or4jnSrZPLpgDGO2QOLTlZDh8Oz2NoRMB2awKQ/Sv6J88mUEoUROUk
         KlcTVuKJ5Vrda9sw3pGyts4U7f/30Dx0BwxezL73tbdrH7K031gO4SdvWELdQ1p+oo
         QV6dmPamWQPF11MUKQ+p5Bp6wo7QiKDGz5g5h8wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
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
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 33/59] x86/build: Use cc-option to validate stack alignment parameter
Date:   Wed, 21 Nov 2018 20:06:48 +0100
Message-Id: <20181121183509.545564885@linuxfoundation.org>
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

commit 9e8730b178a2472fca3123e909d6e69cc8127778 upstream.

With the following commit:

  8f91869766c0 ("x86/build: Fix stack alignment for CLang")

cc-option is only used to determine the name of the stack alignment option
supported by the compiler, but not to verify that the actual parameter
<option>=N is valid in combination with the other CFLAGS.

This causes problems (as reported by the kbuild robot) with older GCC versions
which only support stack alignment on a boundary of 16 bytes or higher.

Also use (__)cc_option to add the stack alignment option to CFLAGS to
make sure only valid options are added.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
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
Fixes: 8f91869766c0 ("x86/build: Fix stack alignment for CLang")
Link: http://lkml.kernel.org/r/20170817182047.176752-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -38,7 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
-REALMODE_CFLAGS += $(cc_stack_align4)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
@@ -78,7 +78,7 @@ ifeq ($(CONFIG_X86_32),y)
         # Align the stack to the register width instead of using the default
         # alignment of 16 bytes. This reduces stack usage and the number of
         # alignment instructions.
-        KBUILD_CFLAGS += $(cc_stack_align4)
+        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
 
         # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
         # a lot more stack due to the lack of sharing of stacklots:
@@ -117,7 +117,7 @@ else
         # default alignment which keep the stack *mis*aligned.
         # Furthermore an alignment to the register width reduces stack usage
         # and the number of alignment instructions.
-        KBUILD_CFLAGS += $(cc_stack_align8)
+        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))
 
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)


