Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B438C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19906206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hW55NC/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfAND2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:28:50 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:34177 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfAND2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:28:50 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0E3S96R029303;
        Mon, 14 Jan 2019 12:28:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0E3S96R029303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547436490;
        bh=qBY8DqCSiZ8zeu0VY5+SCHZidy9aU5aOT28YOxmXrxw=;
        h=From:To:Cc:Subject:Date:From;
        b=hW55NC/jn52zyUAcez9Kaii1G0wf2M8i5T2xOpd107MON3JM7b463JmcuAPnLpABC
         QnDYTCvdfBdwdzK1fF96rFZGW/doZMLQ1a+s8N7hrSb/H03NWe9cWSgj+g4IqBhlX6
         /LwBf4bbf28ED0M+6D2/sYIo+irOSBOIxvmke0ndaP28/Yzj/0ky5Kb2x1x6QOpInj
         OTcv/RzYynYfx9G2zKaQlqgupNgv/fqloXAjvJT6TB8QI8EJi8PgxL3dJNih3sQpKp
         x41or7wgstjG1Niufnowxy7854Tc3aIokxmrc9t0zsHlA/nunZ4rJHFPp652g8hi2F
         2Rnjx5vWe/wYg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: remove top-level built-in.a
Date:   Mon, 14 Jan 2019 12:27:58 +0900
Message-Id: <1547436479-10491-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol table in the final archive is unneeded because it is passed
to the linker after the --whole-archive option. Every object file in
the archive is included in the link anyway.

Pass thin archives from subdirectories directly to the linker, and
remove the final archiving step.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/link-vmlinux.sh | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

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

