Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeFDG7w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeFDG7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.9 29/29] x86/xen: Add unwind hint annotations to xen_setup_gdt
Date: Mon,  4 Jun 2018 08:58:25 +0200
Message-Id: <20180604065803.335464289@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Not needed in mainline as this function got rewritten in 4.12

This enables objtool to grok the iret in the middle of a C function.

This matches commit 76846bf3cb09 ("x86/asm: Add unwind hint annotations
to sync_core()")

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
 
