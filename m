Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34672C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B12208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B12208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHWLZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:25:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeHWLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:25:25 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 079ABACC;
        Thu, 23 Aug 2018 07:57:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 01/79] ARC: Explicitly add -mmedium-calls to CFLAGS
Date:   Thu, 23 Aug 2018 09:52:37 +0200
Message-Id: <20180823074918.728499037@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <abrodkin@synopsys.com>

[ Upstream commit 74c11e300c103af47db5b658fdcf28002421e250 ]

GCC built for arc*-*-linux has "-mmedium-calls" implicitly enabled by default
thus we don't see any problems during Linux kernel compilation.
----------------------------->8------------------------
arc-linux-gcc -mcpu=arc700 -Q --help=target | grep calls
  -mlong-calls                          [disabled]
  -mmedium-calls                        [enabled]
----------------------------->8------------------------

But if we try to use so-called Elf32 toolchain with GCC configured for
arc*-*-elf* then we'd see the following failure:
----------------------------->8------------------------
init/do_mounts.o: In function 'init_rootfs':
do_mounts.c:(.init.text+0x108): relocation truncated to fit: R_ARC_S21W_PCREL
against symbol 'unregister_filesystem' defined in .text section in fs/filesystems.o

arc-elf32-ld: final link failed: Symbol needs debug section which does not exist
make: *** [vmlinux] Error 1
----------------------------->8------------------------

That happens because neither "-mmedium-calls" nor "-mlong-calls" are enabled in
Elf32 GCC:
----------------------------->8------------------------
arc-elf32-gcc -mcpu=arc700 -Q --help=target | grep calls
  -mlong-calls                          [disabled]
  -mmedium-calls                        [disabled]
----------------------------->8------------------------

Now to make it possible to use Elf32 toolchain for building Linux kernel
we're explicitly add "-mmedium-calls" to CFLAGS.

And since we add "-mmedium-calls" to the global CFLAGS there's no point in
having per-file copies thus removing them.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/Makefile |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -14,7 +14,7 @@ endif
 
 KBUILD_DEFCONFIG := nsim_700_defconfig
 
-cflags-y	+= -fno-common -pipe -fno-builtin -D__linux__
+cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=archs
 
@@ -137,16 +137,3 @@ dtbs: scripts
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-
-# Hacks to enable final link due to absence of link-time branch relexation
-# and gcc choosing optimal(shorter) branches at -O3
-#
-# vineetg Feb 2010: -mlong-calls switched off for overall kernel build
-# However lib/decompress_inflate.o (.init.text) calls
-# zlib_inflate_workspacesize (.text) causing relocation errors.
-# Thus forcing all exten calls in this file to be long calls
-export CFLAGS_decompress_inflate.o = -mmedium-calls
-export CFLAGS_initramfs.o = -mmedium-calls
-ifdef CONFIG_SMP
-export CFLAGS_core.o = -mmedium-calls
-endif


