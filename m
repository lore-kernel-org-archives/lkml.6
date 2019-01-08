Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B6C20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978051;
	bh=rsDCwvIRQnDj199RRZZ5AepXFLCpVXgTUggP/uguKl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ul9qUHZa7apY23beEX6yYYcVJvQocGl5MXj+ABriUupO2zXuNSavZJNA5ojIiYYbu
	 agSxdEbgt+sYpxdJJupgYY8dLZoHlDIL+CJ7652K7x8dcMg+QNskt5+wrrQWP4O3my
	 B+t+fsvL4jLYWWZTfPQ/g5HcEJ+g3r9l1s8aB+H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfAHUHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbfAHT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30E62087F;
        Tue,  8 Jan 2019 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975671;
        bh=rsDCwvIRQnDj199RRZZ5AepXFLCpVXgTUggP/uguKl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agO+G1OM2DWcP3f+Ur80wlJiFzNZRO5VVwO9dco5PFulQEUfhXfSlpjPidMfl75nY
         nMTsp0bXXPPMWeeZcsyI7eXb62toEVY03RRZNi8zsoWmbmYr1dC0BjHM1RRWmcsP0R
         4am1zFJhS/bI5VecMnLZGFS/yz9wUcPrvuuN6QaA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 043/117] kbuild: let fixdep directly write to .*.cmd files
Date:   Tue,  8 Jan 2019 14:25:11 -0500
Message-Id: <20190108192628.121270-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 392885ee82d35d515ba2af7b72c5e357c3002113 ]

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

In fact, [1] is no longer a problem since commit 9c2af1c7377a ("kbuild:
add .DELETE_ON_ERROR special target"). Make deletes a target file on
any failure in its recipe. Because fixdep is a part of the recipe of
*.o target, if it fails, the *.o is deleted anyway. However, I am a
bit worried about the slight possibility of [2].

So, here is a solution. Let fixdep directly write to a .*.cmd file,
but allow makefiles to include it only when its corresponding target
exists.

This effectively reverts commit 2982c953570b ("kbuild: remove redundant
$(wildcard ...) for cmd_files calculation"), and commit 00d78ab2ba75
("kbuild: remove dead code in cmd_files calculation in top Makefile")
because now we must check the presence of targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile               | 13 +++++++------
 scripts/Kbuild.include | 10 ++++------
 scripts/Makefile.build | 12 +++++-------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 7a2a9a175756..28b87f551470 100644
--- a/Makefile
+++ b/Makefile
@@ -1034,6 +1034,8 @@ ifdef CONFIG_GDB_SCRIPTS
 endif
 	+$(call if_changed,link-vmlinux)
 
+targets := vmlinux
+
 # Build samples along the rest of the kernel. This needs headers_install.
 ifdef CONFIG_SAMPLES
 vmlinux-dirs += samples
@@ -1758,13 +1760,12 @@ quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
 cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
                   $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
 
-# read all saved command lines
-cmd_files := $(wildcard .*.cmd)
+# read saved command lines for existing targets
+existing-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  $(cmd_files): ;	# Do not try to update included dependency files
-  include $(cmd_files)
-endif
+cmd_files := $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+$(cmd_files): ;	# Do not try to update included dependency files
+-include $(cmd_files)
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3d09844405c9..b8c866193ae6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -262,9 +262,8 @@ ifndef CONFIG_TRIM_UNUSED_KSYMS
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
-	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	rm -f $(depfile);
 
 else
 
@@ -287,9 +286,8 @@ cmd_and_fixdep =                                                             \
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
index 6a6be9f440cf..1d56f181b917 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -527,18 +527,16 @@ FORCE:
 # optimization, we don't need to read them if the target does not
 # exist, we will rebuild anyway in that case.
 
-cmd_files := $(wildcard $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
+existing-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  include $(cmd_files)
-endif
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
 ifneq ($(KBUILD_SRC),)
 # Create directories for object files if they do not exist
 obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
-# If cmd_files exist, their directories apparently exist.  Skip mkdir.
-exist-dirs := $(sort $(patsubst %/,%, $(dir $(cmd_files))))
-obj-dirs := $(strip $(filter-out $(exist-dirs), $(obj-dirs)))
+# If targets exist, their directories apparently exist. Skip mkdir.
+existing-dirs := $(sort $(patsubst %/,%, $(dir $(existing-targets))))
+obj-dirs := $(strip $(filter-out $(existing-dirs), $(obj-dirs)))
 ifneq ($(obj-dirs),)
 $(shell mkdir -p $(obj-dirs))
 endif
-- 
2.19.1

