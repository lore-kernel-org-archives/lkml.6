Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965415AbeCABCz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:02:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34114 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965280AbeCABCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:02:53 -0500
X-Google-Smtp-Source: AG47ELvPHdrsDyAhgsug3xeCBPJfKrGzl29rJrA6iRzuhVXhg/KDtydeQFGmMbAxLxyT3KiZVT4Vag==
Date: Wed, 28 Feb 2018 17:02:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] powerpc: Keep const vars out of writable .sdata
Message-ID: <20180301010249.GA18370@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>

Newer gcc will support "-mno-readonly-in-sdata"[1], which makes sure that
the optimization on PPC32 for variables getting moved into the .sdata
section will not apply to const variables (which must be in .rodata).

This was originally noticed in mm/rodata_test.c when rodata_test_data
was not static:

c0695034 g     O .data	00000004 rodata_test_data

After this patch with an updated compiler, this is correctly in .rodata.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82411

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ccd2556bdb53..c7628e973084 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -141,7 +141,9 @@ AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
+
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
+CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
