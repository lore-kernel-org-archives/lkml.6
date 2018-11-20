Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B0C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6193C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MC10FD+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6193C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeKUDnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:43:52 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:35503 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeKUDnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:43:52 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAKHDTcN010172;
        Wed, 21 Nov 2018 02:13:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAKHDTcN010172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542734010;
        bh=HiyW/Q0RXc4dHdrRRySoaw5wSTNJQhz5gwAPhJMcFrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MC10FD+jy6SePztbztH2z8Z4fpujWIY5oQLAnSNPchOvkH3duDNsbEEQulC6EZIpO
         H40lkbgkGILdELA5jf63s8G2mzOfQoxq9m1OkZXfB3qEYqXViCtcDcaxL8fuMzTg0S
         Tt2meeZVcKg9WENu/BX8XNYAvM9frHo4MISGCiMitDVEadEI6G6Bp+FNyYofzXFfqU
         c/vi+2mbxHCqCC40T78NKF4MN9nkwJivy6lVqAOWjZyf2vgiTBXVy73becNQD+LG6x
         EH3rnSYYFzb5Wk+rqcTv81yjMCFN6OSSF4cqJhOmiu9WOPz/jNXUu3xPyf2mjKlUNO
         e1bdyis2YQ+SA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: move modpost out of 'scripts' target
Date:   Wed, 21 Nov 2018 02:13:24 +0900
Message-Id: <1542734004-2673-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am eagar to build under the scripts/ directory only with $(HOSTCC),
but scripts/mod/ highly depends on the $(CC) and target arch headers.
That it why the 'scripts' target must depend on 'asm-generic',
'gcc-plugins', and $(autoksyms_h).

Move it to the 'prepare0' stage. I know this is a cheesy workaround,
but better than the current situation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile             | 3 ++-
 scripts/Makefile     | 3 +--
 scripts/mod/Makefile | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index b78cc97..21a7729 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,7 +1073,7 @@ include/config/kernel.release: $(srctree)/Makefile FORCE
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
 PHONY += scripts
-scripts: scripts_basic scripts_dtc asm-generic gcc-plugins $(autoksyms_h)
+scripts: scripts_basic scripts_dtc
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
@@ -1111,6 +1111,7 @@ macroprepare: prepare1 archmacros
 archprepare: archheaders archscripts macroprepare scripts_basic
 
 prepare0: archprepare gcc-plugins
+	$(Q)$(MAKE) $(build)=scripts/mod
 	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
diff --git a/scripts/Makefile b/scripts/Makefile
index ece52ff..b48259d 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -37,9 +37,8 @@ build_unifdef: $(obj)/unifdef
 	@:
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
-subdir-y                     += mod
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_GDB_SCRIPTS) += gdb
 
 # Let clean descend into subdirs
-subdir-	+= basic dtc kconfig package gcc-plugins
+subdir-	+= basic dtc kconfig mod package gcc-plugins
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index a5b4af4..42c5d50 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,8 +4,6 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
 
-CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
-
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
-- 
2.7.4

