Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeDPOtJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:09 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62390 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeDPOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:49:05 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtr017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] MIPS: boot: fix build rule of vmlinux.its.S
Date: Mon, 16 Apr 2018 23:47:43 +0900
Message-Id: <1523890067-13641-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Documentation/kbuild/makefile.txt says, it is a typical mistake
to forget the FORCE prerequisite for the rule invoked by if_changed.

Add the FORCE to the prerequisite, but it must be filtered-out from
the files passed to the 'cat' command.  Because this rule generates
.vmlinux.its.S.cmd, vmlinux.its.S must be specified as targets so
that the .cmd file is included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 981bcf8..6c7054e 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,10 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells = 2
 endif
 
+targets += vmlinux.its.S
+
 quiet_cmd_its_cat = CAT     $@
-      cmd_its_cat = cat $^ >$@
+      cmd_its_cat = cat $(filter-out $(PHONY), $^) >$@
 
-$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS))
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
 
 quiet_cmd_cpp_its_S = ITS     $@
-- 
2.7.4
