Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbeCMVIb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:08:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbeCMVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:08:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: David Laight <David.Laight@aculab.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] xen: remove pre-xen3 fallback handlers
Date: Tue, 13 Mar 2018 22:06:09 +0100
Message-Id: <20180313210652.3484599-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:FiJkuPTAGqIqRCoUm3OPBePsJWAssIxxC3r1Qw3jjuJY9eHoiz/
 pSsbIMkYUwgqFafIkMHsXXiIuDRre25DpbRIt1lti6DgM+7lD7jPVU7brQcbrQ2PlCdMdtw
 Rpam6sEPnoghRtLjQPQQv20p6QUM0Pway0Oq3tmumTIxY9ruep5lOjvJPL/M6mUU2pPIee+
 oWlo+d/16MCJtFHG2iaLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UamoApXJnyc=:nXxSxhJWr9V35P/FcOez4A
 OOkKNOUW72iso+h4YPrtVgRzbFoXV/TM2plOLCCjHMRsJD06i64RmLfZ1qOOR+h1YavfrnemN
 aZ0GDr3Utnyws/MFf9Y9S6hOJNysrBjXaKDMwtrvvBg5IrdpqnAp8ZVHP0ihQpcjnSlfDSFGp
 /95H0KsUobv4AEPBGlI0pePpKzR05YEaNQbXCOAzajNu/PXLf+01zBzjDLobnewC15lbyh7fG
 C+CzdVGRVn/91mjkuKxizkbW6NAiWXWqFzsUwBgrMprtlFBO8/qkgATbiiOY4UtBRwuxLA0rH
 87MVLK7hS/W1/m/Zg0M4Ll1AY1YqxFKVrxItwvZZEq6um436eHy81r+8WUeVO/4+OEpNE9yC/
 8mAG1y0DO/o7Aa4GcK+vnwOhRc64h1r+DnTDp13S+G+QyJqI1ML1LLF8z5Wzxb67/MN0fF6x6
 UJux2Yve8XeOKNukf0v8tB1MfRBkk3ucFkRfGR0IuzYhzfG9aJDGv59DZX9IrQvsvZvC+HmOI
 yMSuUxWcVhCy3J3o74mXS2YF019bVPU9aeolQrAjg9GFsKKhWp9aefbREV2CB5D4A19sswrzf
 PmDR4A6Y1I/iS+e6sL3VHlV6qF1G+xVWvQzww4/fxrqdJZ4GcFbbl9ymnLc2W+07WrrmPBxUa
 lKSDub0vdpMNe4RIFOzr3toaUXp2p6Qnw/7Bm3pfz93fD9AcOpAy6dsEzbMhYVmEbYu3U2Cqw
 sWJi3LRJPK1P+I84pnNHrByXfVr2fUahJh6tNQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy hypercall handlers were originally added with
a comment explaining that "copying the argument structures in
HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
variable is sufficiently safe" and only made sure to not write
past the end of the argument structure, the checks in linux/string.h
disagree with that, when link-time optimizations are used:

In function 'memcpy',
    inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
    inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
    inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
    inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
   __read_overflow2();
   ^

Further research turned out that only Xen 3.0.2 or earlier required the
fallback at all, while all versions in use today don't need it.
As far as I can tell, it is not even possible to run a mainline kernel
on those old Xen releases, at the time when they were in use, only
a patched kernel was supported anyway.

Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v2] use a table lookup instead of a switch/case statement, after
multiple suggestions.
[v3] remove that file completely
---
 arch/x86/include/asm/xen/hypercall.h | 13 +-----
 drivers/xen/Makefile                 |  1 -
 drivers/xen/fallback.c               | 81 ------------------------------------
 3 files changed, 2 insertions(+), 93 deletions(-)
 delete mode 100644 drivers/xen/fallback.c

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index bfd882617613..dcf9353a662a 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -365,15 +365,11 @@ HYPERVISOR_update_va_mapping(unsigned long va, pte_t new_val,
 		return _hypercall4(int, update_va_mapping, va,
 				   new_val.pte, new_val.pte >> 32, flags);
 }
-extern int __must_check xen_event_channel_op_compat(int, void *);
 
 static inline int
 HYPERVISOR_event_channel_op(int cmd, void *arg)
 {
-	int rc = _hypercall2(int, event_channel_op, cmd, arg);
-	if (unlikely(rc == -ENOSYS))
-		rc = xen_event_channel_op_compat(cmd, arg);
-	return rc;
+	return _hypercall2(int, event_channel_op, cmd, arg);
 }
 
 static inline int
@@ -388,15 +384,10 @@ HYPERVISOR_console_io(int cmd, int count, char *str)
 	return _hypercall3(int, console_io, cmd, count, str);
 }
 
-extern int __must_check xen_physdev_op_compat(int, void *);
-
 static inline int
 HYPERVISOR_physdev_op(int cmd, void *arg)
 {
-	int rc = _hypercall2(int, physdev_op, cmd, arg);
-	if (unlikely(rc == -ENOSYS))
-		rc = xen_physdev_op_compat(cmd, arg);
-	return rc;
+	return _hypercall2(int, physdev_op, cmd, arg);
 }
 
 static inline int
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 451e833f5931..ea2485069e19 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
-obj-$(CONFIG_X86)			+= fallback.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= events/
 obj-y	+= xenbus/
diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
deleted file mode 100644
index b04fb64c5a91..000000000000
--- a/drivers/xen/fallback.c
+++ /dev/null
@@ -1,81 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/bug.h>
-#include <linux/export.h>
-#include <asm/hypervisor.h>
-#include <asm/xen/hypercall.h>
-
-int xen_event_channel_op_compat(int cmd, void *arg)
-{
-	struct evtchn_op op;
-	int rc;
-
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, event_channel_op_compat, &op);
-
-	switch (cmd) {
-	case EVTCHNOP_close:
-	case EVTCHNOP_send:
-	case EVTCHNOP_bind_vcpu:
-	case EVTCHNOP_unmask:
-		/* no output */
-		break;
-
-#define COPY_BACK(eop) \
-	case EVTCHNOP_##eop: \
-		memcpy(arg, &op.u.eop, sizeof(op.u.eop)); \
-		break
-
-	COPY_BACK(bind_interdomain);
-	COPY_BACK(bind_virq);
-	COPY_BACK(bind_pirq);
-	COPY_BACK(status);
-	COPY_BACK(alloc_unbound);
-	COPY_BACK(bind_ipi);
-#undef COPY_BACK
-
-	default:
-		WARN_ON(rc != -ENOSYS);
-		break;
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
-
-int xen_physdev_op_compat(int cmd, void *arg)
-{
-	struct physdev_op op;
-	int rc;
-
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, physdev_op_compat, &op);
-
-	switch (cmd) {
-	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
-	case PHYSDEVOP_set_iopl:
-	case PHYSDEVOP_set_iobitmap:
-	case PHYSDEVOP_apic_write:
-		/* no output */
-		break;
-
-#define COPY_BACK(pop, fld) \
-	case PHYSDEVOP_##pop: \
-		memcpy(arg, &op.u.fld, sizeof(op.u.fld)); \
-		break
-
-	COPY_BACK(irq_status_query, irq_status_query);
-	COPY_BACK(apic_read, apic_op);
-	COPY_BACK(ASSIGN_VECTOR, irq_op);
-#undef COPY_BACK
-
-	default:
-		WARN_ON(rc != -ENOSYS);
-		break;
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(xen_physdev_op_compat);
-- 
2.9.0
