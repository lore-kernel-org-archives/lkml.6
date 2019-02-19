Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E75CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C73121904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tcmWlt0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfBSJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:46 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53209 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBSJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:44 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1J9XBkM002572;
        Tue, 19 Feb 2019 18:33:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1J9XBkM002572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550568792;
        bh=LpVzcmMvxAwWbg6InvMN4itJqp0PH2zyJ5T3ksV7i4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcmWlt0YrbAbfQcvzqsVEym5Ev6XG7pQYx+bxUitf2wUusx3Koem9zJVWSybCa68k
         5qRJhxnDq9KJd4k17ANUWC64q1kNPGE/+rRSEah+jVPexeFlO9Zd+j16z/botu1L++
         xAYI2s7vJZLg87W3eJywNrLvJstlRn2RXgwiltTtbBXsXUhr20vRUUDGuD+XYqEHPP
         r+S4xsWLb1cxdzEX0UeTOZR8PzWCN5HP8X5viBZt3A125IvuQH+8wsF9o0iw03qi5B
         8vuSgfw4QM3NOj2uzcexOl2Cl2Lge6kvDC1ebFZmiyjfHRM3wnWq+cWrkp2rF22lv0
         XDoJkg1HaHoQg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/5] scripts/gdb: do not descend into scripts/gdb from scripts
Date:   Tue, 19 Feb 2019 18:33:04 +0900
Message-Id: <1550568787-18710-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Kbuild descends from scripts/Makefile to scripts/gdb/Makefile
just for creating symbolic links, but it does not need to do it so early.

Merge the two descending paths to simplify the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                   | 2 +-
 scripts/Makefile           | 3 +--
 scripts/gdb/linux/Makefile | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 26dbcb7..a5762c6 100644
--- a/Makefile
+++ b/Makefile
@@ -1518,7 +1518,7 @@ $(DOC_TARGETS): scripts_basic FORCE
 
 PHONY += scripts_gdb
 scripts_gdb: prepare
-	$(Q)$(MAKE) $(build)=scripts/gdb/linux build_constants_py
+	$(Q)$(MAKE) $(build)=scripts/gdb
 
 ifdef CONFIG_GDB_SCRIPTS
 all: scripts_gdb
diff --git a/scripts/Makefile b/scripts/Makefile
index feb1f71..9d442ee 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
-subdir-$(CONFIG_GDB_SCRIPTS) += gdb
 
 # Let clean descend into subdirs
-subdir-	+= basic dtc kconfig mod package
+subdir-	+= basic dtc gdb kconfig mod package
diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index aba23be..7545806 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -14,11 +14,8 @@ quiet_cmd_gen_constants_py = GEN     $@
 	$(CPP) -E -x c -P $(c_flags) $< > $@ ;\
 	sed -i '1,/<!-- end-c-headers -->/d;' $@
 
-targets += constants.py
-$(obj)/constants.py: $(SRCTREE)/$(obj)/constants.py.in FORCE
+extra-y += constants.py
+$(obj)/constants.py: $(src)/constants.py.in FORCE
 	$(call if_changed_dep,gen_constants_py)
 
-build_constants_py: $(obj)/constants.py
-	@:
-
-clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py) $(obj)/constants.py
+clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py)
-- 
2.7.4

