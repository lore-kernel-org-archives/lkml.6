Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161785AbeE1Kdl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161320AbeE1Kde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 165/329] powerpc/boot: Fix random libfdt related build errors
Date: Mon, 28 May 2018 12:01:34 +0200
Message-Id: <20180528100256.161938680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 64c3f648c25d108f346fdc96c15180c6b7d250e9 ]

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -92,7 +92,8 @@ $(addprefix $(obj)/,$(zlib-y)): \
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
 
-$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
+$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o \
+	treeboot-akebono.o treeboot-currituck.o treeboot-iss4xx.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
 src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
