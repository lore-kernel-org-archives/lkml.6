Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165955AbeE1OpZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161069AbeE1KaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guanglei Li <guanglei.li@oracle.com>,
        Honglei Wang <honglei.wang@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>, Yanjun Zhu <yanjun.zhu@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 088/329] RDS: IB: Fix null pointer issue
Date: Mon, 28 May 2018 12:00:17 +0200
Message-Id: <20180528100250.103146864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guanglei Li <guanglei.li@oracle.com>

[ Upstream commit 2c0aa08631b86a4678dbc93b9caa5248014b4458 ]

Scenario:
1. Port down and do fail over
2. Ap do rds_bind syscall

PID: 47039  TASK: ffff89887e2fe640  CPU: 47  COMMAND: "kworker/u:6"
 #0 [ffff898e35f159f0] machine_kexec at ffffffff8103abf9
 #1 [ffff898e35f15a60] crash_kexec at ffffffff810b96e3
 #2 [ffff898e35f15b30] oops_end at ffffffff8150f518
 #3 [ffff898e35f15b60] no_context at ffffffff8104854c
 #4 [ffff898e35f15ba0] __bad_area_nosemaphore at ffffffff81048675
 #5 [ffff898e35f15bf0] bad_area_nosemaphore at ffffffff810487d3
 #6 [ffff898e35f15c00] do_page_fault at ffffffff815120b8
 #7 [ffff898e35f15d10] page_fault at ffffffff8150ea95
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffff898e35f15dc8  RFLAGS: 00010282
    RAX: 00000000fffffffe  RBX: ffff889b77f6fc00  RCX:ffffffff81c99d88
    RDX: 0000000000000000  RSI: ffff896019ee08e8  RDI:ffff889b77f6fc00
    RBP: ffff898e35f15df0   R8: ffff896019ee08c8  R9:0000000000000000
    R10: 0000000000000400  R11: 0000000000000000  R12:ffff896019ee08c0
    R13: ffff889b77f6fe68  R14: ffffffff81c99d80  R15: ffffffffa022a1e0
    ORIG_RAX: ffffffffffffffff  CS: 0010 SS: 0018
 #8 [ffff898e35f15dc8] cma_ndev_work_handler at ffffffffa022a228 [rdma_cm]
 #9 [ffff898e35f15df8] process_one_work at ffffffff8108a7c6
 #10 [ffff898e35f15e58] worker_thread at ffffffff8108bda0
 #11 [ffff898e35f15ee8] kthread at ffffffff81090fe6

PID: 45659  TASK: ffff880d313d2500  CPU: 31  COMMAND: "oracle_45659_ap"
 #0 [ffff881024ccfc98] __schedule at ffffffff8150bac4
 #1 [ffff881024ccfd40] schedule at ffffffff8150c2cf
 #2 [ffff881024ccfd50] __mutex_lock_slowpath at ffffffff8150cee7
 #3 [ffff881024ccfdc0] mutex_lock at ffffffff8150cdeb
 #4 [ffff881024ccfde0] rdma_destroy_id at ffffffffa022a027 [rdma_cm]
 #5 [ffff881024ccfe10] rds_ib_laddr_check at ffffffffa0357857 [rds_rdma]
 #6 [ffff881024ccfe50] rds_trans_get_preferred at ffffffffa0324c2a [rds]
 #7 [ffff881024ccfe80] rds_bind at ffffffffa031d690 [rds]
 #8 [ffff881024ccfeb0] sys_bind at ffffffff8142a670

PID: 45659                          PID: 47039
rds_ib_laddr_check
  /* create id_priv with a null event_handler */
  rdma_create_id
  rdma_bind_addr
    cma_acquire_dev
      /* add id_priv to cma_dev->id_list */
      cma_attach_to_dev
                                    cma_ndev_work_handler
                                      /* event_hanlder is null */
                                      id_priv->id.event_handler

Signed-off-by: Guanglei Li <guanglei.li@oracle.com>
Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yanjun Zhu <yanjun.zhu@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/ib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -336,7 +336,8 @@ static int rds_ib_laddr_check(struct net
 	/* Create a CMA ID and try to bind it. This catches both
 	 * IB and iWARP capable NICs.
 	 */
-	cm_id = rdma_create_id(&init_net, NULL, NULL, RDMA_PS_TCP, IB_QPT_RC);
+	cm_id = rdma_create_id(&init_net, rds_rdma_cm_event_handler,
+			       NULL, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id))
 		return PTR_ERR(cm_id);
 
