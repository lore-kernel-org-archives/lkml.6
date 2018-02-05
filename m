Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeBEPEt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:04:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:55818 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeBEPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:04:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: David Laight <David.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
Date: Mon,  5 Feb 2018 16:03:30 +0100
Message-Id: <20180205150340.328921-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:MPdXWqQ5Ay+CnEcN1IlE1yMEwYTdv9/AOSYFs/GDi0NUeCW+yg4
 2tcrbh3iDSDxTVsyT2O7LJyFCw4wwINWCXl2FaroUEg8yPiSp1U0JpoonrONBT3uX6jW17Y
 Y78/yiQWbiuu5HvVrLM29bXLSfbtNXvBLXTsi7BJRq+v+oAbMj49/EKYH4LP8EkKtzfx3nz
 A5J7fi3rTu7kAyNhwhGvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RW1NEdh18dE=:4VNLF5oIaOQ6+bbWm5CkxB
 CwvL7XNzCZlftV7XyPFrQEVEhtHVaUkL7QqLKY8Uy/z6UIGnr5/1HJ9865vCRabykXCYF55NA
 qQyXdAqGK/GKPRzzxqzOm7DUr1nHSgxlS7Vw723iUZ+2SQPvzZYeqOzTL7UE37VOLmAeIbSOm
 +LJd+fFEDP2+rSB6Zi63kK9fMz8P1GpVJBp3G37neVMqgRgZVMtyyW6GZ18aHvz6ghASt7gXb
 7FJfFDkhcfpzRfAZ9kmTfC86q8xV8fazIJMwXp6h7ZjU19rBjpfGH/WSHdFv5Hvg5iwkBg5iO
 ot80wnw/hhO7UMFn0lTivjmv2ClLRwGyb9jPVABRB3Xd29fySeyKU1LGaH/S79qexqgZ7rcEl
 L64usP5mSPJ9rBYImpCZWOcqHDvW3owQb5SOcryJEYD2XHGlkuFKXmRSiQ9Pkrzkv1m04O7N9
 A/o4BEKXjR92QLwZF3CipQRD7fSs2AcPJd2VBCLQsUVoXSACvcbTV3jCMpVhYnLY4A2dTUW0I
 mcSfzC/CQXfNMWyhMn/XIR+aPmcZVn37uGOPpbww8h/X8rSV++kWXGXDW7z54uVvdXmXVQ2oY
 CXnd9Zk/2o4VyN4nNNgLyJJ22lVb0acw8o/ID3z1UalxQ42PynHsR31alMaQH2nRjJgl3oxlm
 E7prLs2hH1eH+VvJosw8/B/xIiv+wfj2ZO77E5R4XhEhyd8Wtf/K2eBv82kVs6O4iz5tt07EV
 nB83VAKiior8jKyUY3BYk29z6wChcmCyiTSYLg==
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
[v2] use a table lookup instead of a switch/case statement, after
multiple suggestions.
---
 drivers/xen/fallback.c | 94 +++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
index b04fb64c5a91..091d45fa4fe6 100644
--- a/drivers/xen/fallback.c
+++ b/drivers/xen/fallback.c
@@ -5,76 +5,60 @@
 #include <asm/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
+static const size_t evtchnop_len[] = {
+	[EVTCHNOP_bind_interdomain] = sizeof(struct evtchn_bind_interdomain),
+	[EVTCHNOP_bind_virq]	    = sizeof(struct evtchn_bind_virq),
+	[EVTCHNOP_bind_pirq]	    = sizeof(struct evtchn_bind_pirq),
+	[EVTCHNOP_close]	    = sizeof(struct evtchn_close),
+	[EVTCHNOP_send]		    = sizeof(struct evtchn_send),
+	[EVTCHNOP_alloc_unbound]    = sizeof(struct evtchn_alloc_unbound),
+	[EVTCHNOP_bind_ipi]	    = sizeof(struct evtchn_bind_ipi),
+	[EVTCHNOP_status]	    = sizeof(struct evtchn_status),
+	[EVTCHNOP_bind_vcpu]	    = sizeof(struct evtchn_bind_vcpu),
+	[EVTCHNOP_unmask]	    = sizeof(struct evtchn_unmask),
+};
+
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
-	switch (cmd) {
-	case EVTCHNOP_close:
-	case EVTCHNOP_send:
-	case EVTCHNOP_bind_vcpu:
-	case EVTCHNOP_unmask:
-		/* no output */
-		break;
+	if (cmd > ARRAY_SIZE(evtchnop_len))
+		return -ENOSYS;
 
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
+	len = evtchnop_len[cmd];
+	memcpy(&op.u, arg, len);
+	rc = _hypercall1(int, event_channel_op_compat, &op);
+	memcpy(arg, &op.u, len);
 
 	return rc;
 }
 EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
 
+static const size_t physdevop_len[] = {
+	[PHYSDEVOP_IRQ_UNMASK_NOTIFY] = 0,
+	[PHYSDEVOP_irq_status_query]  = sizeof(struct physdev_irq_status_query),
+	[PHYSDEVOP_set_iopl]	      = sizeof(struct physdev_set_iopl),
+	[PHYSDEVOP_set_iobitmap]      = sizeof(struct physdev_set_iobitmap),
+	[PHYSDEVOP_apic_read]	      = sizeof(struct physdev_apic),
+	[PHYSDEVOP_apic_write]	      = sizeof(struct physdev_apic),
+	[PHYSDEVOP_ASSIGN_VECTOR]     = sizeof(struct physdev_irq),
+};
+
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
-	switch (cmd) {
-	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
-	case PHYSDEVOP_set_iopl:
-	case PHYSDEVOP_set_iobitmap:
-	case PHYSDEVOP_apic_write:
-		/* no output */
-		break;
+	if (cmd > ARRAY_SIZE(physdevop_len))
+		return -ENOSYS;
 
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
+	len = physdevop_len[cmd];
+	memcpy(&op.u, arg, len);
+	rc = _hypercall1(int, physdev_op_compat, &op);
+	memcpy(arg, &op.u, len);
 
 	return rc;
 }
-- 
2.9.0
