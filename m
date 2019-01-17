Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01972077B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cowC4sas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAQALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:11:11 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:16423 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfAQALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:11:10 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0H0A7dI030467;
        Thu, 17 Jan 2019 09:10:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0H0A7dI030467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547683808;
        bh=SxYJYsVS6RJFLIMLIgeTo6HceNxuJCOtpPTp/5SyoXI=;
        h=From:To:Cc:Subject:Date:From;
        b=cowC4sasdge8VQIXAb6Dl6frth/JC1zE0tSjTNzWPyK2LEgr1zrfE/OGjJw4T4fVO
         YD0ct0gcIlCVLAWfeUdiWHQSTOeXr+F+OsZZTd9VNJsD6FHMALl0oyIGMZJdW3vLSY
         KhbYlgZgNMPiokP76FIMOoUPZ1xgu3FsSQIQqGkgEtRNkDRiqS5/Qoh5gachuCNL7y
         Ek4iR066V3ozGrsQ9i5Xri165VcTMOsCFpWFz6kyRNFa6w0+X4sogsEr9WAlOpIXp3
         7NCZTpRD/JJl/wrGdjkf64Essbfty5enpWUd8KMyD4pn1w9v49ABFrSZvasV54nI/8
         y7h2hmUlccuJw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v3 1/2] kbuild: remove top-level built-in.a
Date:   Thu, 17 Jan 2019 09:10:03 +0900
Message-Id: <1547683804-17956-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol table in the final archive is unneeded; the linker does not
require the symbol table after the --whole-archive option. Every object
file in the archive is included in the link anyway.

Pass thin archives from subdirectories directly to the linker, and
remove the final archiving step.

Fix up the document and comments as well.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---

Changes in v3: None
Changes in v2:
 - Update the document and comments
 - Add Nicholas' Ack

 Documentation/kbuild/makefiles.txt |  9 ++-------
 scripts/Makefile.build             |  8 ++------
 scripts/link-vmlinux.sh            | 30 ++++++------------------------
 3 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index bf28c47..48eab0b 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -154,13 +154,8 @@ more details, with real examples.
 
 	Kbuild compiles all the $(obj-y) files.  It then calls
 	"$(AR) rcSTP" to merge these files into one built-in.a file.
-	This is a thin archive without a symbol table, which makes it
-	unsuitable as a linker input.
-
-	The scripts/link-vmlinux.sh script later makes an aggregate
-	built-in.a with "${AR} rcsTP", which creates the thin archive
-	with a symbol table and an index, making it a valid input for
-	the final vmlinux link passes.
+	This is a thin archive without a symbol table. It will be later
+	linked into vmlinux by scripts/link-vmlinux.sh
 
 	The order of files in $(obj-y) is significant.  Duplicates in
 	the lists are allowed: the first instance will be linked into
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60..681ab58 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -394,14 +394,10 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 $(sort $(subdir-obj-y)): $(subdir-ym) ;
 
 #
-# Rule to compile a set of .o files into one .o file
+# Rule to compile a set of .o files into one .a file (without symbol table)
 #
 ifdef builtin-target
 
-# built-in.a archives are made with no symbol table or index which
-# makes them small and fast, but unable to be used by the linker.
-# scripts/link-vmlinux.sh builds an aggregate built-in.a with a symbol
-# table and index.
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; \
                      $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(filter $(real-obj-y), $^)
@@ -426,7 +422,7 @@ $(modorder-target): $(subdir-ym) FORCE
 	$(Q)(cat /dev/null; $(modorder-cmds)) > $@
 
 #
-# Rule to compile a set of .o files into one .a file
+# Rule to compile a set of .o files into one .a file (with symbol table)
 #
 ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c8cf453..4788def 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -44,24 +44,6 @@ info()
 	fi
 }
 
-# Thin archive build here makes a final archive with symbol table and indexes
-# from vmlinux objects INIT and MAIN, which can be used as input to linker.
-# KBUILD_VMLINUX_LIBS archives should already have symbol table and indexes
-# added.
-#
-# Traditional incremental style of link does not require this step
-#
-# built-in.a output file
-#
-archive_builtin()
-{
-	info AR built-in.a
-	rm -f built-in.a;
-	${AR} rcsTP${KBUILD_ARFLAGS} built-in.a			\
-				${KBUILD_VMLINUX_INIT}		\
-				${KBUILD_VMLINUX_MAIN}
-}
-
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -69,7 +51,8 @@ modpost_link()
 	local objects
 
 	objects="--whole-archive				\
-		built-in.a					\
+		${KBUILD_VMLINUX_INIT}				\
+		${KBUILD_VMLINUX_MAIN}				\
 		--no-whole-archive				\
 		--start-group					\
 		${KBUILD_VMLINUX_LIBS}				\
@@ -88,7 +71,8 @@ vmlinux_link()
 
 	if [ "${SRCARCH}" != "um" ]; then
 		objects="--whole-archive			\
-			built-in.a				\
+			${KBUILD_VMLINUX_INIT}			\
+			${KBUILD_VMLINUX_MAIN}			\
 			--no-whole-archive			\
 			--start-group				\
 			${KBUILD_VMLINUX_LIBS}			\
@@ -99,7 +83,8 @@ vmlinux_link()
 			-T ${lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
-			built-in.a				\
+			${KBUILD_VMLINUX_INIT}			\
+			${KBUILD_VMLINUX_MAIN}			\
 			-Wl,--no-whole-archive			\
 			-Wl,--start-group			\
 			${KBUILD_VMLINUX_LIBS}			\
@@ -160,7 +145,6 @@ cleanup()
 	rm -f .tmp_System.map
 	rm -f .tmp_kallsyms*
 	rm -f .tmp_vmlinux*
-	rm -f built-in.a
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.o
@@ -217,8 +201,6 @@ fi;
 # final build of init/
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
 
-archive_builtin
-
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
-- 
2.7.4

