Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55A88C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723E204EE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1723E204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933165AbeFLGxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:53:42 -0400
Received: from ozlabs.org ([203.11.71.1]:55645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753885AbeFLGxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:53:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414gZn1fcMz9ryk;
        Tue, 12 Jun 2018 16:53:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCHv4 0/3] Salted build ids via linker sections
In-Reply-To: <20180612003224.3658-1-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com>
Date:   Tue, 12 Jun 2018 16:53:35 +1000
Message-ID: <87zi00ts0g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laura Abbott <labbott@redhat.com> writes:
> Hi,
>
> This is v4 of the series to allow unique build ids in the kernel. As a
> reminder of the context:
>
> ""
> In Fedora, the debug information is packaged separately (foo-debuginfo) and
> can be installed separately. There's been a long standing issue where only one
> version of a debuginfo info package can be installed at a time. Mark Wielaard
> made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> more details)
>
> Part of the requirement to allow this to work is that build ids are
> unique between builds. The existing upstream rpm implementation ensures
> this by re-calculating the build-id using the version and release as a
> seed. This doesn't work 100% for the kernel because of the vDSO which is
> its own binary and doesn't get updated. After poking holes in a few of my
> ideas, there was a discussion with some people from the binutils team about
> adding --build-id-salt to let ld do the calculation debugedit is doing. There
> was a counter proposal made to add in the salt while building. The
> easiest proposal was to add an item in the linker script vs. linking in
> an object since we need the salt to go in every module as well as the
> kernel and vmlinux.
> ""
>
> v4 takes Linus' suggestion of using linker fill to insert the build id.
> This removes the need to use a generated header which makes things much
> easier. One change is that because this section isn't .comment it won't
> get stripped automatically. This is pretty small but I also know people
> can be picky so I'm open to opinions or suggestions here.
>
> Laura Abbott (3):
>   scripts: Preprocess module-common.lds
>   kbuild: Introduce build-salt linker section and config option
>   x86: Add build salt to the vDSO and kernel linker scripts

Hi Laura,

Here's a patch to get it working on powerpc. Seems to work as expected.

cheers


From fc5e22e4873956f9328e401ee5dd2835f4884db9 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 12 Jun 2018 14:52:34 +1000
Subject: [PATCH] powerpc: Add support for BUILD_SALT in kernel, modules & VDSO

This patch adds support for BUILD_SALT in the kernel, modules and
VDSO. See the commit that adds BUILD_SALT for more info.

Kernel:
  0:mon> d c000000001340840
  c000000001340840 0055aaff12345678 1234567812345678  |.U...4Vx.4Vx.4Vx|
  c000000001340850 1234567812345678 1234567812345678  |.4Vx.4Vx.4Vx.4Vx|

Module:

  $ cat/sys/module/kvm/sections/.salt
  0xd0000000064385e8
  ...
  0:mon> d d0000000064385e8
  d0000000064385e8 0055aaff12345678 1234567812345678  |.U...4Vx.4Vx.4Vx|
  d0000000064385f8 1234567812345678 1234567812345678  |.4Vx.4Vx.4Vx.4Vx|

vdso:
  (gdb) x/4xw (0x7ffff7f80000 + 0x4a0)
  0x7ffff7f804a0:	0xffaa5500	0x78563412	0x78563412	0x78563412

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso32/vdso32.lds.S | 2 ++
 arch/powerpc/kernel/vdso64/vdso64.lds.S | 2 ++
 arch/powerpc/kernel/vmlinux.lds.S       | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 099a6db14e67..c06a12607777 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -4,6 +4,7 @@
  * library
  */
 #include <asm/vdso.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
@@ -25,6 +26,7 @@ SECTIONS
 	.gnu.version_d 	: { *(.gnu.version_d) }
 	.gnu.version_r 	: { *(.gnu.version_r) }
 
+	BUILD_SALT
 	.note		: { *(.note.*) }		:text	:note
 
 	. = ALIGN(16);
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 256fb9720298..ace69258446a 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -4,6 +4,7 @@
  * library
  */
 #include <asm/vdso.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
@@ -25,6 +26,7 @@ SECTIONS
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
 
+	BUILD_SALT
 	.note		: { *(.note.*) }		:text	:note
 
 	. = ALIGN(16);
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 5baac79df97e..59635369ceea 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -348,6 +348,7 @@ SECTIONS
 	}
 
 	BUG_TABLE
+	BUILD_SALT
 
 	. = ALIGN(PAGE_SIZE);
 	_edata  =  .;
-- 
2.14.1


