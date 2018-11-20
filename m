Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F3C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F88C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iiUdRthQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F88C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeKTLdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:33:15 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34066 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbeKTLdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:33:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEY029284;
        Tue, 20 Nov 2018 10:05:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEY029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675937;
        bh=f2BtdiU0GitGOassCnUVM6KJqG2sSFpHgHMxZ5FKCpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiUdRthQrzwUu1zD6p5unciaLi1lLIwuUno+PlMUownsdL9HTS6G/09ttOmOOe7Hq
         2Qt3NvTog6REbo1S6Qr/fWZuhbVCUMEGpqSCVwIzGwsrOuwHIBDvz3h9mYRISPUsRb
         gTH6HgKb3mkrDkVbE/gGIqVmrGk220HPxDir1bowtzOOsN4bPs4JcxgcVcjd6BWTm5
         I/DSWsdqi2FR0z3+Onb+YoA99iNkhHnfhiEHFNj0ioez0DQiUczgorSwM1UGFnt3w4
         zHS7dC5/WZ3K00mAFZ91rc5LWo/t4pbRybqIQAMUZCsdpS9VCekuCU2NIsLbciQyfE
         Ux1OIj+FFAaJA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] kbuild: let fixdep directly write to .*.cmd files
Date:   Tue, 20 Nov 2018 10:05:22 +0900
Message-Id: <1542675930-21114-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, fixdep writes dependencies to .*.tmp, which is renamed to
.*.cmd after everything succeeds. This is a very safe way to avoid
corrupted .*.cmd files. The if_changed_dep has carried this safety
mechanism since it was added in 2002.

If fixdep fails for some reasons or a user terminates the build while
fixdep is running, the incomplete output from the fixdep could be
troublesome.

This is my insight about some bad scenarios:

[1] If the compiler succeeds to generate *.o file, but fixdep fails
    to write necessary dependencies to .*.cmd file, Make will miss
    to rebuild the object when headers or CONFIG options are changed.
    In this case, fixdep should not generate .*.cmd file at all so
    that 'arg-check' will surely trigger the rebuild of the object.

[2] A partially constructed .*.cmd file may not be a syntactically
    correct makefile. The next time Make runs, it would include it,
    then fail to parse it. Once this happens, 'make clean' is be the
    only way to fix it.

In fact, [1] is no longer a problem since 9c2af1c7377a ("kbuild: add
.DELETE_ON_ERROR special target"). Make deletes a target file on any
failure in its recipe. Because fixdep is a part of the recipe of *.o
target, if it fails, the *.o is deleted anyway. However, I am a bit
worried about the slight possibility of [2].

So, here is a solution. Let fixdep directly write to a .*.cmd file,
but allow makefiles to include it only when its corresponding target
exists.

This effectively reverts commit 2982c953570b ("kbuild: remove redundant
$(wildcard ...) for cmd_files calculation"), and commit 00d78ab2ba75
("kbuild: remove dead code in cmd_files calculation in top Makefile")
because now we must check the presence of targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 Makefile               | 13 +++++++------
 scripts/Kbuild.include | 10 ++++------
 scripts/Makefile.build | 10 ++++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index ddbf627..b78cc97 100644
--- a/Makefile
+++ b/Makefile
@@ -1039,6 +1039,8 @@ ifdef CONFIG_GDB_SCRIPTS
 endif
 	+$(call if_changed,link-vmlinux)
 
+targets := vmlinux
+
 # Build samples along the rest of the kernel. This needs headers_install.
 ifdef CONFIG_SAMPLES
 vmlinux-dirs += samples
@@ -1760,13 +1762,12 @@ quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
 cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
                   $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
 
-# read all saved command lines
-cmd_files := $(wildcard .*.cmd)
+# read saved command lines for existing targets
+exist-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  $(cmd_files): ;	# Do not try to update included dependency files
-  include $(cmd_files)
-endif
+cmd_files := $(foreach f,$(exist-targets),$(dir $(f)).$(notdir $(f)).cmd)
+$(cmd_files): ;	# Do not try to update included dependency files
+-include $(cmd_files)
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index bb01555..6cf6a8b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -264,9 +264,8 @@ ifndef CONFIG_TRIM_UNUSED_KSYMS
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
-	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	rm -f $(depfile);
 
 else
 
@@ -289,9 +288,8 @@ cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
 	$(ksym_dep_filter) |                                                 \
 		scripts/basic/fixdep -e $(depfile) $@ '$(make-cmd)'          \
-			> $(dot-target).tmp;	                             \
-	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+			> $(dot-target).cmd;	                             \
+	rm -f $(depfile);
 
 endif
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a8e7ba9..c909588 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -529,17 +529,15 @@ FORCE:
 # optimization, we don't need to read them if the target does not
 # exist, we will rebuild anyway in that case.
 
-cmd_files := $(wildcard $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
+exist-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  include $(cmd_files)
-endif
+-include $(foreach f,$(exist-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
 ifneq ($(KBUILD_SRC),)
 # Create directories for object files if they do not exist
 obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
-# If cmd_files exist, their directories apparently exist.  Skip mkdir.
-exist-dirs := $(sort $(patsubst %/,%, $(dir $(cmd_files))))
+# If targets exist, their directories apparently exist. Skip mkdir.
+exist-dirs := $(sort $(patsubst %/,%, $(dir $(exist-targets))))
 obj-dirs := $(strip $(filter-out $(exist-dirs), $(obj-dirs)))
 ifneq ($(obj-dirs),)
 $(shell mkdir -p $(obj-dirs))
-- 
2.7.4

