Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2254aJZT8S8pvII08J4o5qiGBboXliKd+uAocaHVfD3AI+MFC+Y+VyynH/bwwZ9Vg0rJdGq5
ARC-Seal: i=1; a=rsa-sha256; t=1519217886; cv=none;
        d=google.com; s=arc-20160816;
        b=dx3xxE0dqoZbDqdpxo2Xr5pxgq0aA7NH/imQR+mPdPJ/l/wppLNjweqoaebRSWp60/
         KbJD6AcP2mlWVqO3qZWtVwCWXmSbFz3ORSJhlqKmWtwSJbxQSeWVUjFnasB8ndrmKgDL
         /I4JU8M2kuYov2uLvSXY7v6UG7/gxzZD2+U0wjMc5gi2CrVHAU9o0ZfyUXdia1GCbn+4
         E03I2l60ataV0jnItC/wSic91BqQtlQIdy7vAu70w3BpJj5cBRpCmZUY7T1W0+swx/OQ
         3dDUsgwyhGi2P9qQKqzqrawb0bq4lZc8XdHLl2R33sWMWXRG0n5ZW93g32imPhPDwnFM
         +cdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1a/YzPlmPW+3A1aTNYiTSXWz2aMC+2ofXgZZnvWxAyI=;
        b=Yn5obeueoZOkkLesaPENeKxMGMz+zxzYEN9Bs5MqaGi4qKl8+Y3yUILXnIIE4AH8KZ
         0utey8abZgY6vJqaF95q/E1hMfuhE6rN2lDPdpvOi0BAbAK49prrkp4OzO6PVvorqqYn
         8t4nJKhymeHLg/OIpfzrOe1uZsmt7PkDDN7J0Thq1/mF/v9QpxNFlMumMrUnUK1XUOkY
         EySnrcs6K/+1rcsP/fMdAiGI+fknBgNKa5P5iAeVCQ/CQexshwQ66ST7eeDni5ZNGRgQ
         d3KHQsT1Tc5wzstLGNk05YMjxxPz/ZxpDIeK3FJRmVnFTV6yDmngHlh6dQ4lQ8g1kVbz
         LZ3Q==
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
Subject: [PATCH 4.14 013/167] RDMA/rxe: Fix rxe_qp_cleanup()
Date: Wed, 21 Feb 2018 13:47:04 +0100
Message-Id: <20180221124525.320821638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015414667373323?=
X-GMAIL-MSGID: =?utf-8?q?1593015414667373323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
