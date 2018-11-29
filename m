Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2BAC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63962081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UQ15fJ2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63962081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeK2OFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:05:14 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:38852 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2OFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:05:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAT2x3qD006619;
        Thu, 29 Nov 2018 11:59:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAT2x3qD006619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543460344;
        bh=Zijhk3B0tO6PDmGT/Ead+AaJZcHca8AmeJMyJrYLKkM=;
        h=From:To:Cc:Subject:Date:From;
        b=UQ15fJ2a/SlBGXehlxqmZZZzb8AAhbJUuEzwaKq2NUUNdKPKrJygwPKElUpz4sSqm
         4JHTiLFq6hl0CKH90ad4a3aEjeHeVYUdgS41ble5b6w6s260mNmB1rbNf2vdnEr+u7
         ORCnNpT1iAtxZt4o71BNbwn2RzFTnd+n6e/P8TZV02v5JtTKEQ3765UkPWn84mZgCd
         m28oy3cVVqqq1jyUTifjPRCN1bTlS5acJMUf2vifnkb8AZrMA5fCyU3//iW7DvGx1Y
         aJVJ07/TLTTXmfl4KMdBylImy2XVJm0AAsy9MC9pYpJ9StOhi82E//WmCqwkSCR+69
         C6lSA8ChPOgjw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH] kbuild: fix UML build error with CONFIG_GCC_PLUGINS
Date:   Thu, 29 Nov 2018 11:58:50 +0900
Message-Id: <1543460330-2219-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML fails to build with CONFIG_GCC_PLUGINS=y.

$ make -s ARCH=um mrproper
$ make -s ARCH=um allmodconfig
$ make ARCH=um
  UPD     include/generated/uapi/linux/version.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/export.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  scripts/unifdef
  CC      arch/x86/um/user-offsets.s
cc1: error: cannot load plugin ./scripts/gcc-plugins/cyc_complexity_plugin.so
./scripts/gcc-plugins/cyc_complexity_plugin.so: cannot open shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
./scripts/gcc-plugins/structleak_plugin.so: cannot open shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open shared object file: No such file or directory
make[1]: *** [scripts/Makefile.build;119: arch/x86/um/user-offsets.s] Error 1
make: *** [arch/um/Makefile;152: arch/x86/um/user-offsets.s] Error 2

Change the order of the preparation stage (with cleanups) to make sure
gcc-plugins is built before descending to arch/x86/um/.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 6b90bd4ba40b ("GCC plugin infrastructure")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will pick up this to kbuild tree to avoid conflicts.
Ack from UML people is appreciated, though.


 Makefile             |  4 ++--
 arch/um/Makefile     | 24 ++----------------------
 arch/x86/um/Makefile |  4 +++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/Makefile b/Makefile
index 0ce4e29..a066dab 100644
--- a/Makefile
+++ b/Makefile
@@ -1106,9 +1106,9 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 
 macroprepare: prepare1 archmacros
 
-archprepare: archheaders archscripts macroprepare scripts_basic
+archprepare: archheaders archscripts macroprepare scripts_basic gcc-plugins
 
-prepare0: archprepare gcc-plugins
+prepare0: archprepare
 	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
diff --git a/arch/um/Makefile b/arch/um/Makefile
index ab1066c..c080359 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -116,7 +116,8 @@ endef
 archheaders:
 	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) asm-generic archheaders
 
-archprepare: include/generated/user_constants.h
+archprepare:
+	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
@@ -146,25 +147,4 @@ archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
-# Generated files
-
-$(HOST_DIR)/um/user-offsets.s: __headers FORCE
-	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
-
-define filechk_gen-asm-offsets
-        (set -e; \
-         echo "/*"; \
-         echo " * DO NOT MODIFY."; \
-         echo " *"; \
-         echo " * This file was generated by arch/$(ARCH)/Makefile"; \
-         echo " *"; \
-         echo " */"; \
-         echo ""; \
-         sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}" < $<; \
-         echo ""; )
-endef
-
-include/generated/user_constants.h: $(HOST_DIR)/um/user-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index c2d3d7c..1792464 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -36,10 +36,12 @@ subarch-$(CONFIG_MODULES) += ../kernel/module.o
 
 USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
-extra-y += user-offsets.s
 $(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	-Iarch/x86/include/generated
 
+include/generated/user_constants.h: $(obj)/user-offsets.s
+	$(call filechk,offsets,__USER_CONSTANT_H__)
+
 UNPROFILE_OBJS := stub_segv.o
 CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
 
-- 
2.7.4

