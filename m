Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeFEG5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:57:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60569 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeFEG5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:57:44 -0400
Message-Id: <fa51770430e00ac2db1c621365473a0c893d105e.1528179842.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: fix build failure by disabling attribute-alias
 warning in pci_32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  5 Jun 2018 06:57:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2479bfc9bc600 ("powerpc: Fix build by disabling attribute-alias
warning for SYSCALL_DEFINEx") forgot arch/powerpc/kernel/pci_32.c

Latest GCC version emit the following warnings

As arch/powerpc code is built with -Werror, this breaks build with
GCC 8.1

This patch inhibits this warning

In file included from arch/powerpc/kernel/pci_32.c:14:
./include/linux/syscalls.h:233:18: error: 'sys_pciconfig_iobase' alias between functions of incompatible types 'long int(long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/pci_32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d63b488d34d7..4f861055a852 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -285,6 +285,9 @@ pci_bus_to_hose(int bus)
  * Note that the returned IO or memory base is a physical address
  */
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpragmas"
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(pciconfig_iobase, long, which,
 		unsigned long, bus, unsigned long, devfn)
 {
@@ -310,3 +313,4 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which,
 
 	return result;
 }
+#pragma GCC diagnostic pop
-- 
2.13.3
