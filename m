Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Vv/f7vLl/34lRyQZhTgMsZf71uiUWV0j6xuoPQW0dsX2/qDdLyVgA6v4vtm9sos8RPFlj
ARC-Seal: i=1; a=rsa-sha256; t=1519218360; cv=none;
        d=google.com; s=arc-20160816;
        b=Hoc5eaq9M9oWAKx/KW6IFrh9w0fcX1kWC1/J4VBN9DxgOdal6+vQrraRSy+1+fOcdB
         YbR1zI2kyFRGhlGti64zsEl5dORj97UwqpWCMdZrCVjgoKDIUpq69IFCX3Ne06mUh673
         vpMjQ5x1XCyxeY1JM1Lcj25XHvou5qzVacZIbyg83yG5vdYfIHcZIvs9eGnn6stLZneN
         EtpEjMBnoRX0ZmiTxylNmwpFJzlgRDfv93xKUysEbyENlcc4r5IPlb/daWlPwCJwC6Mu
         QD/CIRcl1ddeY8Gn5LKfDuQ7dtO6dIMokkgXuIvJhEOuCXGhM7O/Gzeq4m1UJj2wcFxd
         kzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UE1yJcAZyIh0qf04OFskT53N90bMAJNuprhLwilFTRk=;
        b=Hng2nr97cGY/XhJsXRus/0YFuh9HSlvZ2vm2xoCpK6RZoDaq49B/xJ37sJM85DJ8gI
         1kjdXh7h+wgqtONyRS0XRdwB1AhRBrZbrAp6byIGaxwasQG7ZGsG+GqjSRHpHAF1IQd/
         bOvMQb6uOmK5fqhAFmy4FVGYNqSAxp9KdhjnUFBHfI/mpM30tm1t12yGms8kSsI3PV0k
         g1U9RshuXsHxBvYmFvuol61z6FFuzqcU2Mvm3fLmy/nt33miOeJtT3ehEOndAKgfRy6p
         lRj2IuWMrutBg88hicJKJG/PhgQqtR+oYARGBTnYOKr4clcKhGEczIPSovIJRmaEXRaV
         16KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Moni Shoua <monis@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 012/163] RDMA/rxe: Fix rxe_qp_cleanup()
Date: Wed, 21 Feb 2018 13:47:21 +0100
Message-Id: <20180221124530.703836813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015414667373323?=
X-GMAIL-MSGID: =?utf-8?q?1593015911601586759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit bb3ffb7ad48a21e98a5c64eb21103a74fd9f03f6 upstream.

rxe_qp_cleanup() can sleep so it must be run in thread context and
not in atomic context. This patch avoids that the following bug is
triggered:

Kernel BUG at 00000000560033f3 [verbose debug info unavailable]
BUG: sleeping function called from invalid context at net/core/sock.c:2761
in_atomic(): 1, irqs_disabled(): 0, pid: 7, name: ksoftirqd/0
INFO: lockdep is turned off.
Preemption disabled at:
[<00000000b6e69628>] __do_softirq+0x4e/0x540
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.15.0-rc7-dbg+ #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0x85/0xbf
 ___might_sleep+0x177/0x260
 lock_sock_nested+0x1d/0x90
 inet_shutdown+0x2e/0xd0
 rxe_qp_cleanup+0x107/0x140 [rdma_rxe]
 rxe_elem_release+0x18/0x80 [rdma_rxe]
 rxe_requester+0x1cf/0x11b0 [rdma_rxe]
 rxe_do_task+0x78/0xf0 [rdma_rxe]
 tasklet_action+0x99/0x270
 __do_softirq+0xc0/0x540
 run_ksoftirqd+0x1c/0x70
 smpboot_thread_fn+0x1be/0x270
 kthread+0x117/0x130
 ret_from_fork+0x24/0x30

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Moni Shoua <monis@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_qp.c    |   12 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |    3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -824,9 +824,9 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 }
 
 /* called when the last reference to the qp is dropped */
-void rxe_qp_cleanup(struct rxe_pool_entry *arg)
+static void rxe_qp_do_cleanup(struct work_struct *work)
 {
-	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
+	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
 	rxe_drop_all_mcast_groups(qp);
 
@@ -859,3 +859,11 @@ void rxe_qp_cleanup(struct rxe_pool_entr
 	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
 	sock_release(qp->sk);
 }
+
+/* called when the last reference to the qp is dropped */
+void rxe_qp_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
+
+	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
+}
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -35,6 +35,7 @@
 #define RXE_VERBS_H
 
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <rdma/rdma_user_rxe.h>
 #include "rxe_pool.h"
 #include "rxe_task.h"
@@ -281,6 +282,8 @@ struct rxe_qp {
 	struct timer_list rnr_nak_timer;
 
 	spinlock_t		state_lock; /* guard requester and completer */
+
+	struct execute_work	cleanup_work;
 };
 
 enum rxe_mem_state {
