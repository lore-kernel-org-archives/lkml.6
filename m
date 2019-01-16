Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96933C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D9B20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfAPF0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:26:18 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50608 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAPF0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:26:18 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 31FAC2A119; Wed, 16 Jan 2019 00:26:15 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     stable@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <3ba14e34f666486b5e77253a82dfde882a505e23.1547616204.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Add -ffreestanding to CFLAGS
Date:   Wed, 16 Jan 2019 16:23:24 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a build failure when using GCC 8.1:

/usr/bin/ld: block/partitions/ldm.o: in function `ldm_parse_tocblock':
block/partitions/ldm.c:153: undefined reference to `strcmp'

This is caused by a new optimization which effectively replaces a
strncmp() call with a strcmp() call. This affects a number of strncmp()
call sites in the kernel.

The entire class of optimizations is avoided with -fno-builtin, which
gets enabled by -ffreestanding. This may avoid possible future build
failures in case new optimizations appear in future compilers.

I haven't done any performance measurements with this patch but I did
count the function calls in a defconfig build. For example, there are now
23 more sprintf() calls and 39 fewer strcpy() calls. The effect on the
other libc functions is smaller.

If this harms performance we can tackle that regression by optimizing
the call sites, ideally using semantic patches. That way, clang and ICC
builds might benfit too.

Cc: stable@vger.kernel.org
Reference: https://marc.info/?l=linux-m68k&m=154514816222244&w=2
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 997c9f20ea0f..0a99c276d9a4 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -58,7 +58,8 @@ cpuflags-$(CONFIG_M5206e)	:= $(call cc-option,-mcpu=5206e,-m5200)
 cpuflags-$(CONFIG_M5206)	:= $(call cc-option,-mcpu=5206,-m5200)
 
 KBUILD_AFLAGS += $(cpuflags-y)
-KBUILD_CFLAGS += $(cpuflags-y) -pipe
+KBUILD_CFLAGS += $(cpuflags-y)
+
 ifdef CONFIG_MMU
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
 KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2
@@ -69,6 +70,8 @@ KBUILD_CFLAGS += -D__uClinux__
 KBUILD_AFLAGS += -D__uClinux__
 endif
 
+KBUILD_CFLAGS += -pipe -ffreestanding
+
 KBUILD_LDFLAGS := -m m68kelf
 KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
 
-- 
2.19.2

