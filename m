Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDPOtI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62379 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeDPOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:49:05 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtp017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
Date: Mon, 16 Apr 2018 23:47:41 +0900
Message-Id: <1523890067-13641-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0f9da844d87796ac31b04e81ee95e155e9043132.

It is true that commit 0f9da844d877 ("MIPS: boot: Define __ASSEMBLY__
for its.S build") fixed the build error, but it should not have
defined __ASSEMBLY__ just for textual substitution in arbitrary data.
The file is image tree source in this case, but the purpose of using
CPP is to replace some macros.

I merged a better solution, commit a95b37e20db9 ("kbuild: get
<linux/compiler_types.h> out of <linux/kconfig.h>").  The original
fix-up is no longer needed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index c22da16..1bd5c4f 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,7 +126,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
-			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
-- 
2.7.4
