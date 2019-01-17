Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zpys7xVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfAQGfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:35:06 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:50766 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfAQGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:35:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0H6XnvT003810;
        Thu, 17 Jan 2019 15:33:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0H6XnvT003810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547706830;
        bh=SeoPdt1N8+bmi3v04SWn5jMYqHWODkut+4jQbo2fVpA=;
        h=From:To:Cc:Subject:Date:From;
        b=Zpys7xVpYrUZXaUpa+rtTlf3o9bTAmLQShZaKnitZzhH3SQf7Zk+bRP0cm3cppS0D
         xBjzv3VZGtr0bN3b9N3Nx+jaoFoKyFobugJuJmvi5Ja5mJRbMVvhQpqSAX9PmmdLpR
         gj4hQr16hzFZ1tNwiiJtDan8dSt3epSl8Z8zh61dYDxAFpp9gUhOJxypwagtGEBRZm
         pxhPiPnIC5/08GwCFP7BdrPCamzDsF8ng9qxo6h0i5ccFwMIHhMKY8a1ZxKL7LRvGu
         RpWTeap+iqkxvg+WoDANtTHplwNnAUN8f6S4E5Be1oSUmEJ5wxbx2W+a58JwJt/j2u
         8dQWne2vC5gRA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jordan Rupprecht <rupprecht@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kbuild: support llvm-ar
Date:   Thu, 17 Jan 2019 15:33:46 +0900
Message-Id: <1547706826-16833-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to avoid applying this patch because this patch is ugly, and
people are trying to fix llvm-ar. I tried the latest llvm-ar, and I
saw some improvement, but still cannot build the kernel with it.

The main reason of this post is for the record, and suggest how llvm-ar
should work.

As you may have noticed, there are two issues:

 [1] llvm-ar does not recognize the 'P' option
 [2] llvm-ar does not flatten thin archives (not fixed yet)

Let me explain each of them.

[1] Why is 'P' option needed for GNU ar?

It may not be so clear the reason of commit 9a6cfca4f413 ("kbuild:
thin archives use P option to ar").

If two objects from different directories have the same file name,
GNU ar may drop the one when flattening thin archives.

Here is a simple test case:

  $ gcc -c -x c /dev/null -o foo.o
  $ mkdir a
  $ gcc -c -x c /dev/null -o a/foo.o
  $ ar rcST a/built-in.a a/foo.o
  $ ar rcST built-in.a a/built-in.a foo.o
  $ cat built-in.a
  !<thin>
  //                                              8         `
  foo.o/

  /0              0           0     0     644     944       `

We expect built-in.a contains both a/foo.o and foo.o, but the former
is lost. The 'P' option solves this.

  $ rm -f built-in.a
  $ ar rcSTP built-in.a a/built-in.a foo.o
  $ cat built-in.a
  !<thin>
  //                                              16        `
  a/foo.o/
  foo.o/
  /0              0           0     0     644     944       `
  /9              0           0     0     644     944       `

Interestingly, GNU ar works as expected without 'P' when the order of
a/built-in.a and foo.o are opposite:

  $ rm built-in.a
  $ ar rcST built-in.a foo.o a/built-in.a
  $ cat built-in.a
  !<thin>
  //                                              16        `
  foo.o/
  a/foo.o/
  /0              0           0     0     644     944       `
  /7              0           0     0     644     944       `

Anyway, even the latest GNU toolchain works like that, so
Kbuild does need the 'P' option.

The real world example is sh.

  arch/sh/kernel/cpu/fpu.c
  arch/sh/kernel/cpu/sh2a/fpu.c
  arch/sh/kernel/cpu/sh4/fpu.c
  arch/sh/kernel/cpu/sh5/fpu.c

[2] flattening thin archives

llvm-ar cannot flatten archives.

This issue was filed in the following:
  https://bugs.llvm.org/show_bug.cgi?id=37530

Its status was marked as "RESOLVED FIXED", but actually not fixed
as of writing (Jan 17, 2019).

The older version of llvm-ar worked like this:

  $ rm -f built-in.a a/built-in.a
  $ llvm-ar rcST a/built-in.a a/foo.o
  $ llvm-ar rcST built-in.a a/built-in.a
  $ cat built-in.a !<thin>
  //                                              14        `
  a/built-in.a/
  /0              0           0     0     644     136       `

Recently, two commits were pushed to the trunk.
  [llvm-ar] Flatten thin archives.
  [llvm-ar] Resubmit recursive thin archive test with fix for full path names and better error messages

As far as I tested, the latest llvm-ar works as follows:

  $ llvm-ar rcST a/built-in.a a/foo.o
  $ llvm-ar rcST built-in.a a/built-in.a
  $ cat built-in.a
  !<thin>
  //                                              8         `
  foo.o/

  /0              0           0     0     644     800       `

OK, it flattens the thin archive, but the problem is it rips off
the directory path.

GNU ar works as follows:

  $ ar rcST   a/built-in.a   a/foo.o
  $ ar rcST    built-in.a a/built-in.a
  $ cat built-in.a
  !<thin>
  //                                              10        `
  a/foo.o/

  /0              0           0     0     644     800       `

If you use the latest llvm-ar for building the kernel, you will see
a mysterious 'llvm-ar: error: No such file or directory.' error.
(I think the error message could be improved because it is unclear
what is missing.)

[Workaround in this patch]

Currently, llvm-ar cannot flatten thin archives correctly. So, Kbuild
uses '$(AR) t' to expand thin archives from subdirectories, then repack
all objects into the current directory built-in.a.

The 'P' for cmd_link_l_target is unneeded because Kbuild does not
support subdir objects for lib-y in the first place.

[How to use]

Pass AR=llvm-ar in the configuration and build command:

 $ make AR=llvm-ar defconfig
 $ make AR=llvm-ar

Or, simply in one line:

 $ make AR=llvm-ar defconfig all

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch can be cleanly applied to Linux 5.0-rc2 + the following:
https://patchwork.kernel.org/patch/10761625/
https://patchwork.kernel.org/patch/10767193/
https://patchwork.kernel.org/patch/10767195/
https://patchwork.kernel.org/patch/10767503/
https://patchwork.kernel.org/patch/10767509/


 init/Kconfig           | 3 +++
 scripts/Makefile.build | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 513fa54..185274ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -23,6 +23,9 @@ config CLANG_VERSION
 	int
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
 
+config AR_IS_LLVM
+	def_bool $(success,$(AR) --version | head -n 1 | grep -q LLVM)
+
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f8e2794..b866bb5 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -399,7 +399,13 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 ifdef builtin-target
 
 quiet_cmd_ar_builtin = AR      $@
+ifdef CONFIG_AR_IS_LLVM
+      cmd_ar_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS) $@ \
+		       $(foreach f, $(real-prereqs), \
+		       $(if $(filter $(subdir-obj-y), $(f)), $(shell $(AR) t $(f)), $(f)))
+else
       cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+endif
 
 $(builtin-target): $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
@@ -427,7 +433,7 @@ ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
 
 # lib target archives do get a symbol table and index
-cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+cmd_link_l_target = rm -f $@; $(AR) rcsT$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
-- 
2.7.4

