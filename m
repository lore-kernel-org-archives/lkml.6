Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C670C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1948520658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeICVsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:48:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeICVsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:30 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40A66D0B;
        Mon,  3 Sep 2018 17:27:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 150/165] MIPS: Always use -march=<arch>, not -<arch> shortcuts
Date:   Mon,  3 Sep 2018 18:57:16 +0200
Message-Id: <20180903165704.600404684@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 344ebf09949c31bcb8818d8458b65add29f1d67b upstream.

The VDSO Makefile filters CFLAGS to select a subset which it uses whilst
building the VDSO ELF. One of the flags it allows through is the -march=
flag that selects the architecture/ISA to target.

Unfortunately in cases where CONFIG_CPU_MIPS32_R{1,2}=y and the
toolchain defaults to building for MIPS64, the main MIPS Makefile ends
up using the short-form -<arch> flags in cflags-y. This is because the
calls to cc-option always fail to use the long-form -march=<arch> flag
due to the lack of an -mabi=<abi> flag in KBUILD_CFLAGS at the point
where the cc-option function is executed. The resulting GCC invocation
is something like:

  $ mips64-linux-gcc -Werror -march=mips32r2 -c -x c /dev/null -o tmp
  cc1: error: '-march=mips32r2' is not compatible with the selected ABI

These short-form -<arch> flags are dropped by the VDSO Makefile's
filtering, and so we attempt to build the VDSO without specifying any
architecture. This results in an attempt to build the VDSO using
whatever the compiler's default architecture is, regardless of whether
that is suitable for the kernel configuration.

One encountered build failure resulting from this mismatch is a
rejection of the sync instruction if the kernel is configured for a
MIPS32 or MIPS64 r1 or r2 target but the toolchain defaults to an older
architecture revision such as MIPS1 which did not include the sync
instruction:

    CC      arch/mips/vdso/gettimeofday.o
  /tmp/ccGQKoOj.s: Assembler messages:
  /tmp/ccGQKoOj.s:273: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:329: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:520: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:714: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1009: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1066: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1114: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1279: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1334: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1374: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1459: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1514: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1814: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:2002: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:2066: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  make[2]: *** [scripts/Makefile.build:318: arch/mips/vdso/gettimeofday.o] Error 1
  make[1]: *** [scripts/Makefile.build:558: arch/mips/vdso] Error 2
  make[1]: *** Waiting for unfinished jobs....

This can be reproduced for example by attempting to build
pistachio_defconfig using Arnd's GCC 8.1.0 mips64 toolchain from
kernel.org:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-mips64-linux.tar.xz

Resolve this problem by using the long-form -march=<arch> in all cases,
which makes it through the arch/mips/vdso/Makefile's filtering & is thus
consistently used to build both the kernel proper & the VDSO.

The use of cc-option to prefer the long-form & fall back to the
short-form flags makes no sense since the short-form is just an
abbreviation for the also-supported long-form in all GCC versions that
we support building with. This means there is no case in which we have
to use the short-form -<arch> flags, so we can simply remove them.

The manual redefinition of _MIPS_ISA is removed naturally along with the
use of the short-form flags that it accompanied, and whilst here we
remove the separate assembler ISA selection. I suspect that both of
these were only required due to the mips32 vs mips2 mismatch that was
introduced by commit 59b3e8e9aac6 ("[MIPS] Makefile crapectomy.") and
fixed but not cleaned up by commit 9200c0b2a07c ("[MIPS] Fix Makefile
bugs for MIPS32/MIPS64 R1 and R2.").

I've marked this for backport as far as v4.4 where the MIPS VDSO was
introduced. In earlier kernels there should be no ill effect to using
the short-form flags.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
Reviewed-by: James Hogan <jhogan@kernel.org>
Patchwork: https://patchwork.linux-mips.org/patch/19579/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Makefile |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -155,15 +155,11 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r43
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
-			-Wa,-mips32 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
-			-Wa,-mips32r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R1)	+= -march=mips32 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R2)	+= -march=mips32r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap -modd-spreg
-cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call cc-option,-march=mips64,-mips64 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-			-Wa,-mips64 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-			-Wa,-mips64r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS64_R1)	+= -march=mips64 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS64_R2)	+= -march=mips64r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
 cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \


