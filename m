Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8E2C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472FD21991
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FD21991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeHEWms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:42:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:42:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75KaopA591449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:36:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75KaoGg591446;
        Sun, 5 Aug 2018 13:36:50 -0700
Date:   Sun, 5 Aug 2018 13:36:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alistair Strachan <tipbot@zytor.com>
Message-ID: <tip-379d98ddf41344273d9718556f761420f4dc80b3@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, astrachan@google.com,
        tglx@linutronix.de, andi.kleen@intel.com, luto@kernel.org
Reply-To: luto@kernel.org, andi.kleen@intel.com, tglx@linutronix.de,
          astrachan@google.com, gregkh@linuxfoundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180803173931.117515-1-astrachan@google.com>
References: <20180803173931.117515-1-astrachan@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86: vdso: Use $LD instead of $CC to link
Git-Commit-ID: 379d98ddf41344273d9718556f761420f4dc80b3
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

Commit-ID:  379d98ddf41344273d9718556f761420f4dc80b3
Gitweb:     https://git.kernel.org/tip/379d98ddf41344273d9718556f761420f4dc80b3
Author:     Alistair Strachan <astrachan@google.com>
AuthorDate: Fri, 3 Aug 2018 10:39:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 22:33:50 +0200

x86: vdso: Use $LD instead of $CC to link

The vdso{32,64}.so can fail to link with CC=clang when clang tries to find
a suitable GCC toolchain to link these libraries with.

/usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
  access beyond end of merged section (782)

This happens because the host environment leaked into the cross compiler
environment due to the way clang searches for suitable GCC toolchains.

Clang is a retargetable compiler, and each invocation of it must provide
--target=<something> --gcc-toolchain=<something> to allow it to find the
correct binutils for cross compilation. These flags had been added to
KBUILD_CFLAGS, but the vdso code uses CC and not KBUILD_CFLAGS (for various
reasons) which breaks clang's ability to find the correct linker when cross
compiling.

Most of the time this goes unnoticed because the host linker is new enough
to work anyway, or is incompatible and skipped, but this cannot be reliably
assumed.

This change alters the vdso makefile to just use LD directly, which
bypasses clang and thus the searching problem. The makefile will just use
${CROSS_COMPILE}ld instead, which is always what we want. This matches the
method used to link vmlinux.

This drops references to DISABLE_LTO; this option doesn't seem to be set
anywhere, and not knowing what its possible values are, it's not clear how
to convert it from CC to LD flag.

Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-team@android.com
Cc: joel@joelfernandes.org
Cc: Andi Kleen <andi.kleen@intel.com>
Link: https://lkml.kernel.org/r/20180803173931.117515-1-astrachan@google.com

---
 arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 261802b1cc50..42c6c1bea4f4 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -46,10 +46,8 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-			-Wl,--no-undefined \
-			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
-			$(DISABLE_LTO)
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+			-z max-page-size=4096 -z common-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -95,10 +93,8 @@ CFLAGS_REMOVE_vvar.o = -pg
 #
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
-			   -Wl,-soname=linux-vdso.so.1 \
-			   -Wl,-z,max-page-size=4096 \
-			   -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
+			   -z max-page-size=4096 -z common-page-size=4096
 
 # x32-rebranded versions
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
@@ -123,7 +119,7 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
+VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 targets += vdso32/vdso32.lds
 targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -157,13 +153,13 @@ $(obj)/vdso32.so.dbg: FORCE \
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(CC) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
+		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
-	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
+VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
+	$(call ld-option, --build-id) -Bsymbolic
 GCOV_PROFILE := n
 
 #
