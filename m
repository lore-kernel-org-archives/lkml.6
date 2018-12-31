Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F54E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G4xPYXuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeLaIYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:24:38 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:31627 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeLaIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:24:36 -0500
X-Greylist: delayed 61643 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2018 03:24:35 EST
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBV8OIjq008355;
        Mon, 31 Dec 2018 17:24:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBV8OIjq008355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546244661;
        bh=b0bvC1IOQoBGfuT9L9fXYPVekMltcdROb1UDZETb0XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4xPYXuAetS1KkHIwKYez39Iv7mbycx1GS+Nu23ZMgaVgRvLiFl8qmnuCLbLcYbgB
         AaoE4N/33T+h5XJNsi7n0s6ut99+yQmsC7O1NnyQdizUP8XrJ5q7xuZKamM6Uct7ka
         k9ZJRim0uh2heBdhGQARul9q3NZJ3xakmZSUrnYzKcJcoXIHH3KD8GZsFHpTT5n/Wz
         VDYa4+U4OlVnCOM+Lrkfw4aecjaoW36YB6b8J4mzu2b2+vif9557QLfgMpHQ0D3KZv
         xrwsfo9OLpqptq1RIMmet3kEwwKh4Z0+cakNEL+aTBvC+BR18NjnJtN80eOmV7PCxs
         GtEwcnKjyeayg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/4] kbuild: change filechk to surround the given command with { }
Date:   Mon, 31 Dec 2018 17:24:09 +0900
Message-Id: <1546244651-10447-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filechk_* rules often consist of multiple 'echo' lines. They must be
surrounded with { } or ( ) to work correctly. Otherwise, only the
string from the last 'echo' would be written into the target.

Let's take care of that in the 'filechk' in scripts/Kbuild.include
to clean up filechk_* rules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild                   | 2 +-
 Makefile                 | 6 +++---
 arch/s390/tools/Makefile | 2 +-
 firmware/Makefile        | 5 ++---
 kernel/Makefile          | 6 +++++-
 scripts/Kbuild.include   | 2 +-
 scripts/Makefile.lib     | 3 +--
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Kbuild b/Kbuild
index 414ae6d..06b801e 100644
--- a/Kbuild
+++ b/Kbuild
@@ -27,7 +27,7 @@ timeconst-file := include/generated/timeconst.h
 targets += $(timeconst-file)
 
 define filechk_gentimeconst
-	(echo $(CONFIG_HZ) | bc -q $< )
+	echo $(CONFIG_HZ) | bc -q $<
 endef
 
 $(timeconst-file): kernel/time/timeconst.bc FORCE
diff --git a/Makefile b/Makefile
index 04a8578..437d603 100644
--- a/Makefile
+++ b/Makefile
@@ -1127,13 +1127,13 @@ define filechk_utsrelease.h
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2;    \
 	  exit 1;                                                         \
 	fi;                                                               \
-	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
+	echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"
 endef
 
 define filechk_version.h
-	(echo \#define LINUX_VERSION_CODE $(shell                         \
+	echo \#define LINUX_VERSION_CODE $(shell                         \
 	expr $(VERSION) \* 65536 + 0$(PATCHLEVEL) \* 256 + 0$(SUBLEVEL)); \
-	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
+	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'
 endef
 
 $(version_h): FORCE
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 48cdac1..cf4846a 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -25,7 +25,7 @@ define filechk_facility-defs.h
 endef
 
 define filechk_dis-defs.h
-	( $(obj)/gen_opcode_table < $(srctree)/arch/$(ARCH)/tools/opcodes.txt )
+	$(obj)/gen_opcode_table < $(srctree)/arch/$(ARCH)/tools/opcodes.txt
 endef
 
 $(kapi)/facility-defs.h: $(obj)/gen_facilities FORCE
diff --git a/firmware/Makefile b/firmware/Makefile
index e2f7dd2..37e5ae3 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -13,7 +13,7 @@ ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
 ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
 PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
 
-filechk_fwbin = { \
+filechk_fwbin = \
 	echo "/* Generated by $(src)/Makefile */"		;\
 	echo "    .section .rodata"				;\
 	echo "    .p2align $(ASM_ALIGN)"			;\
@@ -28,8 +28,7 @@ filechk_fwbin = { \
 	echo "    .p2align $(ASM_ALIGN)"			;\
 	echo "    $(ASM_WORD) _fw_$(FWSTR)_name"		;\
 	echo "    $(ASM_WORD) _fw_$(FWSTR)_bin"			;\
-	echo "    $(ASM_WORD) _fw_end - _fw_$(FWSTR)_bin"	;\
-}
+	echo "    $(ASM_WORD) _fw_end - _fw_$(FWSTR)_bin"
 
 $(obj)/%.gen.S: FORCE
 	$(call filechk,fwbin)
diff --git a/kernel/Makefile b/kernel/Makefile
index cde93d5..6aa7543 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -122,7 +122,11 @@ targets += config_data.gz
 $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
 	$(call if_changed,gzip)
 
-      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;")
+filechk_ikconfiggz = \
+	echo "static const char kernel_config_data[] __used = MAGIC_START"; \
+	cat $< | scripts/bin2c; \
+	echo "MAGIC_END;"
+
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call filechk,ikconfiggz)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 46bf1a0..74a3fe7 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -56,7 +56,7 @@ kecho := $($(quiet)kecho)
 define filechk
 	$(Q)set -e;				\
 	mkdir -p $(dir $@);			\
-	$(filechk_$(1)) > $@.tmp;		\
+	{ $(filechk_$(1)); } > $@.tmp;		\
 	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
 		rm -f $@.tmp;			\
 	else					\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 390957f..12b88d0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -417,7 +417,6 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
@@ -428,5 +427,5 @@ define filechk_offsets
 	 echo ""; \
 	 sed -ne $(sed-offsets) < $<; \
 	 echo ""; \
-	 echo "#endif" )
+	 echo "#endif"
 endef
-- 
2.7.4

