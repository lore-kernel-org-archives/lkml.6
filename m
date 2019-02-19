Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B21C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="woJkBY3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfBSJd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:29 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52743 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfBSJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:28 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1J9XBkK002572;
        Tue, 19 Feb 2019 18:33:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1J9XBkK002572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550568791;
        bh=HvvF60VcQISFTj9szcbmZ1V43ms0dB+V6d8yWP+KhJc=;
        h=From:To:Cc:Subject:Date:From;
        b=woJkBY3gNgTmTZVBCNIZlOa4za9glgTvi90k465n5OoQRqtYYZMH7V4hk+lKWOwbz
         /ilk9kK4N5n9hfEaPxfagugnF0eDtDEHpgdxGwUBD7HPedVNbrbZRAsV9hhAyUN+FR
         MFAznGGAtIc5TxDPkQ2xGgcGTP1yethh1lkLqo+lU4EjYymavxQb78KcHzA6Q92+aZ
         qzynSDziCPKAS27c+U0egQR6aibPiloCaBNVuOtIkT5VflqbGw4ZZgAh+jAWA8+aux
         IOkl3nNNaqx5GY8pgEtQum3EC/TPCdVr/eJnCrVYWP5mY8Yqu0zFiyT6/BwVdlR9R8
         Ts0S4iXkICFtg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] scripts/gdb: delay generation of gdb constants.py
Date:   Tue, 19 Feb 2019 18:33:02 +0900
Message-Id: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/gdb/linux/constants.py is never used in the kernel build
process. There is no good reason to create it so early.

Get it out of the 'prepare' stage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild   | 10 ----------
 Makefile | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Kbuild b/Kbuild
index 65db5be..4cebcc7 100644
--- a/Kbuild
+++ b/Kbuild
@@ -6,7 +6,6 @@
 # 2) Generate timeconst.h
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
-# 5) Generate constants.py (may need bounds.h)
 
 #####
 # 1) Generate bounds.h
@@ -58,14 +57,5 @@ quiet_cmd_syscalls = CALL    $<
 missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
 
-#####
-# 5) Generate constants for Python GDB integration
-#
-
-extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
-
-build_constants_py: $(timeconst-file) $(bounds-file)
-	@$(MAKE) $(build)=scripts/gdb/linux $@
-
 # Keep these three files during make clean
 no-clean-files := $(bounds-file) $(offsets-file) $(timeconst-file)
diff --git a/Makefile b/Makefile
index 88db36b..26dbcb7 100644
--- a/Makefile
+++ b/Makefile
@@ -1513,6 +1513,17 @@ PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS): scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=Documentation $@
 
+# Misc
+# ---------------------------------------------------------------------------
+
+PHONY += scripts_gdb
+scripts_gdb: prepare
+	$(Q)$(MAKE) $(build)=scripts/gdb/linux build_constants_py
+
+ifdef CONFIG_GDB_SCRIPTS
+all: scripts_gdb
+endif
+
 else # KBUILD_EXTMOD
 
 ###
-- 
2.7.4

