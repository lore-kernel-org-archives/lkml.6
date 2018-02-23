Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeBWU4E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:56:04 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36643 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeBWU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:56:02 -0500
X-Google-Smtp-Source: AH8x224HsU5vxBUzM3itNdzRFJVueQj0AyMOa7bH+jX+5/vfO/KRiIfAFDk95814rsTWXYgck/Vylw==
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] powerpc/boot: Fix random build errors
Date: Fri, 23 Feb 2018 12:55:59 -0800
Message-Id: <1519419359-19163-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once in a while I see build errors similar to the following
when building images from a clean tree.

Building powerpc:virtex-ml507:44x/virtex5_defconfig ... failed
------------
Error log:
arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
	libfdt.h: No such file or directory

Building powerpc:bamboo:smpdev:44x/bamboo_defconfig ... failed
------------
Error log:
arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
	libfdt.h: No such file or directory

arch/powerpc/boot/treeboot-currituck.c:35:20: fatal error:
     libfdt.h: No such file or directory

Rebuilds will succeed.

Turns out that several source files in arch/powerpc/boot/ include
libfdt.h, but Makefile dependencies are incomplete. Let's fix that.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/boot/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ef6549e57157..26d5d2a5b8e9 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -101,7 +101,8 @@ $(addprefix $(obj)/,$(zlib-y)): \
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
 
-$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
+$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o \
+	treeboot-akebono.o treeboot-currituck.o treeboot-iss4xx.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
 src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
-- 
2.7.4
