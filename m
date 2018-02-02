Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBBPdS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:33:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:64790 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:33:10 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Date: Fri,  2 Feb 2018 16:32:31 +0100
Message-Id: <20180202153240.1190361-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:XPC/aBNTJ6HoMhdxlkHQWX43Zp9Rk9lzA+Jp2LMeYW+JRKf6MmD
 fAYYoWi17colqZjaUtEaHtgZcerT0JGLkcVcPRAbXwcQcvGjyeEU46PTPali23tMAw7c4PX
 Z9fvKHIPjJPaIeBJLnfNraTyXh/z8A84RAsaYm9TeFoJgs3xeRhMdrR1HbTSrB2zyXlupke
 DMFyWvWwKJIQ3f18FLlhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FivGfNiSDGg=:8zZE5M376lioGU98EZRiH8
 rx0G4FGCSpae26RX4DoT+6GiZoMYf0b5qrscYKrrTri+radqR4V9u1ra5nhHhhBcwdwddkydf
 Xm0WIc0wAAD3aUGpMt/EBSJjP32g6iXz3eUYYhz96RnsTTFUZTbXgGUagK9Icf+/7yT1kXCh3
 YKds26rfCfQXYm3SucosOMB7dCny1cEJNX5kvpOnGxEeFzxz+OOancqfRQACtm63lCVY1rZdX
 9sKcg4q2d0qWBC5934pII9uh7WrugpE6Cmvr1uFKPUANxo+4xmerRDSpvmGAMFOMJk0cRob+w
 LSlgi/iJvAwmJ4PP63eIcvrFLpfG9AtWjWZKnW9WLW+KdKYccCk9vTUJnyzwBV0e65l7mId3A
 J+LBPkkgLdLq88HYXKvEjsGixlFETBMJeGbwSKO3LzzkB+DOHxmgbaB4rZugjJzvl+FvVhQzQ
 mk79HgxYV6l90KqwKQKiNytznRvu4Dn9tHPbZ+/Smea8vE9egcnhOdYP5KBj5woFqy/r2UpfS
 8B0z0W2wn8THNPNbkt2cKvRFen2gwyPnB8hmtRXXna30E9wTeic7EWQwx/6Xnl/DixC3JKwEI
 8SwDmRaagHbESLuOyuggWd9FKwPqMpTqLciYRXcsAcWfchX4z7H2ctFATiifWWgP3+v8uerDE
 eU1imj42+jfgjQRsWiJ4aZWd0BkvEGG/ruDW/toFMtrFebY9GBIaXpzDqmaWAvXhES7HZxkqe
 Sdlz2HqxH8PgAUI9g30K1ASVQIwPl2uhw14XsA==
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
make[3]: *** [ccLujFNx.ltrans15.ltrans.o] Error 1
make[3]: Target 'all' not remade because of errors.
lto-wrapper: fatal error: make returned 2 exit status
compilation terminated.
ld: error: lto-wrapper failed

This changes the functions so that each argument is accessed with
exactly the correct length based on the command code.

Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/fallback.c | 94 ++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
index b04fb64c5a91..eded8dd821ad 100644
--- a/drivers/xen/fallback.c
+++ b/drivers/xen/fallback.c
@@ -7,75 +7,87 @@
 
 int xen_event_channel_op_compat(int cmd, void *arg)
 {
-	struct evtchn_op op;
+	struct evtchn_op op = { .cmd = cmd, };
+	size_t len;
 	int rc;
 
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, event_channel_op_compat, &op);
-
 	switch (cmd) {
+	case EVTCHNOP_bind_interdomain:
+		len = sizeof(struct evtchn_bind_interdomain);
+		break;
+	case EVTCHNOP_bind_virq:
+		len = sizeof(struct evtchn_bind_virq);
+		break;
+	case EVTCHNOP_bind_pirq:
+		len = sizeof(struct evtchn_bind_pirq);
+		break;
 	case EVTCHNOP_close:
+		len = sizeof(struct evtchn_close);
+		break;
 	case EVTCHNOP_send:
+		len = sizeof(struct evtchn_send);
+		break;
+	case EVTCHNOP_alloc_unbound:
+		len = sizeof(struct evtchn_alloc_unbound);
+		break;
+	case EVTCHNOP_bind_ipi:
+		len = sizeof(struct evtchn_bind_ipi);
+		break;
+	case EVTCHNOP_status:
+		len = sizeof(struct evtchn_status);
+		break;
 	case EVTCHNOP_bind_vcpu:
+		len = sizeof(struct evtchn_bind_vcpu);
+		break;
 	case EVTCHNOP_unmask:
-		/* no output */
+		len = sizeof(struct evtchn_unmask);
 		break;
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
 	default:
-		WARN_ON(rc != -ENOSYS);
-		break;
+		return -ENOSYS;
 	}
 
+	memcpy(&op.u, arg, len);
+	rc = _hypercall1(int, event_channel_op_compat, &op);
+	memcpy(arg, &op.u, len);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
 
 int xen_physdev_op_compat(int cmd, void *arg)
 {
-	struct physdev_op op;
+	struct physdev_op op = { .cmd = cmd, };
+	size_t len;
 	int rc;
 
-	op.cmd = cmd;
-	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, physdev_op_compat, &op);
-
 	switch (cmd) {
 	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
+		len = 0;
+		break;
+	case PHYSDEVOP_irq_status_query:
+		len = sizeof(struct physdev_irq_status_query);
+		break;
 	case PHYSDEVOP_set_iopl:
+		len = sizeof(struct physdev_set_iopl);
+		break;
 	case PHYSDEVOP_set_iobitmap:
+		len = sizeof(struct physdev_set_iobitmap);
+		break;
+	case PHYSDEVOP_apic_read:
 	case PHYSDEVOP_apic_write:
-		/* no output */
+		len = sizeof(struct physdev_apic);
 		break;
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
+	case PHYSDEVOP_ASSIGN_VECTOR:
+		len = sizeof(struct physdev_irq);
 		break;
+	default:
+		return -ENOSYS;
 	}
 
+	memcpy(&op.u, arg, len);
+	rc = _hypercall1(int, physdev_op_compat, &op);
+	memcpy(arg, &op.u, len);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(xen_physdev_op_compat);
-- 
2.9.0
