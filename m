Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeEOCi2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:38:28 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:62016 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOCi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:38:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4F2bxAF001564
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH RESEND] um: vdso: remove unused vdso-syms.lds
Date: Tue, 15 May 2018 11:37:58 +0900
Message-Id: <1526351878-24961-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---

The previous post has gone to the moderator
due to too many recipients.
I am resending this.
I hope this is reaching UML maintainers.

 arch/x86/um/vdso/.gitignore |  1 -
 arch/x86/um/vdso/Makefile   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
index 9cac6d0..f8b69d8 100644
--- a/arch/x86/um/vdso/.gitignore
+++ b/arch/x86/um/vdso/.gitignore
@@ -1,2 +1 @@
-vdso-syms.lds
 vdso.lds
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 1000335..426681e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
-targets += vdso-syms.lds
-extra-$(VDSO64-y)			+= vdso-syms.lds
-
-#
-# Match symbols in the DSO that look like VDSO*; produce a file of constants.
-#
-sed-vdsosym := -e 's/^00*/0/' \
-	-e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
-quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
-endef
-
-$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
 #
 # The DSO images are built using a special linker script.
 #
-- 
2.7.4
