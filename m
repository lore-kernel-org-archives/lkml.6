Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeFCM26 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeFCM2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 29/29] x86/xen: Add unwind hint annotations to xen_setup_gdt
Date: Sun,  3 Jun 2018 14:26:52 +0200
Message-Id: <20180603122652.17453-30-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed in mainline as this function got rewritten in 4.12

This enables objtool to grok the iret in the middle of a C function.

This matches commit 76846bf3cb09 ("x86/asm: Add unwind hint annotations
to sync_core()")

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/enlighten.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 081437b5f381..e3a3f5a64884 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -75,6 +75,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/unwind_hints.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1452,10 +1453,12 @@ static void __ref xen_setup_gdt(int cpu)
 		 * GDT. The new GDT has  __KERNEL_CS with CS.L = 1
 		 * and we are jumping to reload it.
 		 */
-		asm volatile ("pushq %0\n"
+		asm volatile (UNWIND_HINT_SAVE
+			      "pushq %0\n"
 			      "leaq 1f(%%rip),%0\n"
 			      "pushq %0\n"
 			      "lretq\n"
+			      UNWIND_HINT_RESTORE
 			      "1:\n"
 			      : "=&r" (dummy) : "0" (__KERNEL_CS));
 
-- 
2.17.1
