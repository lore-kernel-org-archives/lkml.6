Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFFAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D952820833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1MGepT/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfACBRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:17:17 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:41567 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfACBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:17:17 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x031GwhQ001151;
        Thu, 3 Jan 2019 10:16:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x031GwhQ001151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546478219;
        bh=xVvKr37H6GF6qKmnraYMODxr3+soLJC30kP+XSvBu4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=1MGepT/8KHk3KqffyGYPE2najb5nDsMpBt7isiihHrq+xnl+c/xVPMhPSAR4yX4Bn
         FkFoJ7PZUqTEWINgptEMTZKLnaJ/wpw7PqsvzvhQcBbO0Fn6qfHznDdkeRmYuDMdWm
         xxz64L0WsdM8/Ltc4agi1Ks+v/ZHQolGOHAEhv0thmzqpP8v+A9c31Wg1dX75Y5d09
         bpX+P5RFGqWTgpzzhS2Nurhy2F05YPozHNWnZdrZLIqUghW6kJ5WP4ovFJQjFBtK+M
         5QMeCIoRdefUWcjLKfE2FoEMcUO0H0qn03PlgI7mJQXIQWX40UmD1cmZNvKd1XymRA
         QZeoHtVRgwlDg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] kbuild: use assignment instead of define ... endef for filechk_* rules
Date:   Thu,  3 Jan 2019 10:16:54 +0900
Message-Id: <1546478214-20394-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not have to use define ... endef for filechk_* rules.

For simple cases, the use of assignment looks cleaner, IMHO.

I updated the usage for scripts/Kbuild.include in case somebody
misunderstands the 'define ... endif' is the requirement.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild                             |  4 +---
 Makefile                           |  3 +--
 arch/s390/kernel/syscalls/Makefile | 12 +++---------
 arch/s390/tools/Makefile           |  7 ++-----
 scripts/Kbuild.include             |  8 ++++----
 scripts/kconfig/Makefile           |  4 +---
 6 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/Kbuild b/Kbuild
index 06b801e..65db5be 100644
--- a/Kbuild
+++ b/Kbuild
@@ -26,9 +26,7 @@ timeconst-file := include/generated/timeconst.h
 
 targets += $(timeconst-file)
 
-define filechk_gentimeconst
-	echo $(CONFIG_HZ) | bc -q $<
-endef
+filechk_gentimeconst = echo $(CONFIG_HZ) | bc -q $<
 
 $(timeconst-file): kernel/time/timeconst.bc FORCE
 	$(call filechk,gentimeconst)
diff --git a/Makefile b/Makefile
index 62c9890..39355d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1041,9 +1041,8 @@ PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ need-builtin=1
 
-define filechk_kernel.release
+filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
-endef
 
 # Store (new) KERNELRELEASE string in include/config/kernel.release
 include/config/kernel.release: $(srctree)/Makefile FORCE
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index 4d929ed..b98f250 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -24,17 +24,11 @@ uapi:	$(uapi-hdrs-y)
 _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
-define filechk_syshdr
-	$(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2" < $<
-endef
+filechk_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2" < $<
 
-define filechk_sysnr
-	$(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $<
-endef
+filechk_sysnr = $(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $<
 
-define filechk_syscalls
-	$(CONFIG_SHELL) '$(systbl)' -S < $<
-endef
+filechk_syscalls = $(CONFIG_SHELL) '$(systbl)' -S < $<
 
 syshdr_abi_unistd_32 := common,32
 $(uapi)/unistd_32.h: $(syscall) FORCE
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index cf4846a..2342b84 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -20,13 +20,10 @@ HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
 # Ensure output directory exists
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
-define filechk_facility-defs.h
-	$(obj)/gen_facilities
-endef
+filechk_facility-defs.h = $(obj)/gen_facilities
 
-define filechk_dis-defs.h
+filechk_dis-defs.h = \
 	$(obj)/gen_opcode_table < $(srctree)/arch/$(ARCH)/tools/opcodes.txt
-endef
 
 $(kapi)/facility-defs.h: $(obj)/gen_facilities FORCE
 	$(call filechk,facility-defs.h)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 74a3fe7..525bff6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -41,11 +41,11 @@ kecho := $($(quiet)kecho)
 ###
 # filechk is used to check if the content of a generated file is updated.
 # Sample usage:
-# define filechk_sample
-#	echo $KERNELRELEASE
-# endef
-# version.h : Makefile
+#
+# filechk_sample = echo $(KERNELRELEASE)
+# version.h: FORCE
 #	$(call filechk,sample)
+#
 # The rule defined shall write to stdout the content of the new file.
 # The existing file will be compared with the new one.
 # - If no file exist it is created
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ec204fa..679e62e 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -201,9 +201,7 @@ HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
 $(obj)/gconf.o: $(obj)/.gconf-cfg
 
 # check if necessary packages are available, and configure build flags
-define filechk_conf_cfg
-	$(CONFIG_SHELL) $<
-endef
+filechk_conf_cfg = $(CONFIG_SHELL) $<
 
 $(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
 	$(call filechk,conf_cfg)
-- 
2.7.4

