Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeCUWC2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:02:28 -0400
Received: from hall.aurel32.net ([163.172.24.10]:33246 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753534AbeCUWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:02:27 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-riscv@lists.infradead.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] RISC-V: build vdso-dummy.o with -no-pie
Date: Wed, 21 Mar 2018 22:26:31 +0100
Message-Id: <20180321212631.20449-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debian toolcahin defaults to PIE, and I guess that will also be the case
of most distributions. This causes the following build failure:

  AS      arch/riscv/kernel/vdso/getcpu.o
  AS      arch/riscv/kernel/vdso/flush_icache.o
  VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
  OBJCOPY arch/riscv/kernel/vdso/vdso.so
  AS      arch/riscv/kernel/vdso/vdso.o
  VDSOLD  arch/riscv/kernel/vdso/vdso-dummy.o
  LD      arch/riscv/kernel/vdso/vdso-syms.o
riscv64-linux-gnu-ld: attempted static link of dynamic object `arch/riscv/kernel/vdso/vdso-dummy.o'
make[2]: *** [arch/riscv/kernel/vdso/Makefile:43: arch/riscv/kernel/vdso/vdso-syms.o] Error 1
make[1]: *** [scripts/Makefile.build:575: arch/riscv/kernel/vdso] Error 2
make: *** [Makefile:1018: arch/riscv/kernel] Error 2

While the root Makefile correctly passes "-fno-PIE" to build individual
object files, the RISC-V kernel also builds vdso-dummy.o as an
executable, which is therefore linked as PIE. Fix that by updating this
specific link rule to also include "-no-pie".

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 324568d33921..f6561b783b61 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -52,7 +52,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(CC) $(KCFLAGS) -nostdlib $(SYSCFLAGS_$(@F)) \
+      cmd_vdsold = $(CC) $(KCFLAGS) $(call cc-option, -no-pie) -nostdlib $(SYSCFLAGS_$(@F)) \
                            -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp -lgcc && \
                    $(CROSS_COMPILE)objcopy \
                            $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@
-- 
2.16.1
