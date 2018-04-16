Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDPOtD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:03 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62199 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeDPOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:48:57 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtq017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
Date: Mon, 16 Apr 2018 23:47:42 +0900
Message-Id: <1523890067-13641-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(CPP) is used here to perform macro replacement in ITS.  Do not
pass $(cpp_flags) because it pulls in more options for dependency
file generation etc. but none of which is necessary here.  ITS files
do not include any header file, so $(call if_change,...) is enough.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1bd5c4f..981bcf8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -125,7 +125,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 	$(call if_changed,its_cat)
 
 quiet_cmd_cpp_its_S = ITS     $@
-      cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+      cmd_cpp_its_S = $(CPP) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
@@ -135,19 +135,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_CELLS=$(itb_addr_cells)
 
 $(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
+	$(call if_changed,cpp_its_S,none,vmlinux.bin)
 
 $(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,gzip,vmlinux.bin.gz)
+	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
 $(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
-	$(call if_changed_dep,cpp_its_S,bzip2,vmlinux.bin.bz2)
+	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
 $(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,lzma,vmlinux.bin.lzma)
+	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
 
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,lzo,vmlinux.bin.lzo)
+	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
       cmd_itb-image = \
-- 
2.7.4
