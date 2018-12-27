Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54952C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2475B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeL0C5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:57:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17063 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeL0C5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:57:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06DE3E68A1BBB;
        Thu, 27 Dec 2018 10:57:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 27 Dec 2018 10:57:16 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <mingo@redhat.com>, <vincent.guittot@linaro.org>,
        <peterz@infradead.org>, <xiezhipeng1@huawei.com>
CC:     <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: fix infinity loop in update_blocked_averages
Date:   Thu, 27 Dec 2018 11:04:26 +0800
Message-ID: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhepeng Xie report a bug, there is a infinity loop in
update_blocked_averages().

PID: 14233  TASK: ffff800b2de08fc0  CPU: 1   COMMAND: "docker"
 #0 [ffff00002213b9d0] update_blocked_averages at ffff00000811e4a8
 #1 [ffff00002213ba60] pick_next_task_fair at ffff00000812a3b4
 #2 [ffff00002213baf0] __schedule at ffff000008deaa88
 #3 [ffff00002213bb70] schedule at ffff000008deb1b8
 #4 [ffff00002213bb80] futex_wait_queue_me at ffff000008180754
 #5 [ffff00002213bbd0] futex_wait at ffff00000818192c
 #6 [ffff00002213bd00] do_futex at ffff000008183ee4
 #7 [ffff00002213bde0] __arm64_sys_futex at ffff000008184398
 #8 [ffff00002213be60] el0_svc_common at ffff0000080979ac
 #9 [ffff00002213bea0] el0_svc_handler at ffff000008097a6c
 #10 [ffff00002213bff0] el0_svc at ffff000008084044

rq->tmp_alone_branch introduced in 4.10, used to point to
the new beg of the list. If this cfs_rq is deleted somewhere
else, then the tmp_alone_branch will be illegal and cause
a list_add corruption.

(When enabled DEBUG_LIST, we fould this list_add corruption)

[ 2546.741103] list_add corruption. next->prev should be prev
(ffff800b4d61ad40), but was ffff800ba434fa38. (next=ffff800b6a95e740).
[ 2546.741130] ------------[ cut here ]------------
[ 2546.741132] kernel BUG at lib/list_debug.c:25!
[ 2546.741136] Internal error: Oops - BUG: 0 [#1] SMP
[ 2546.742870] CPU: 1 PID: 29428 Comm: docker-runc Kdump: loaded Tainted: G E  4.19.5-1.aarch64 #1
[ 2546.745415] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 2546.747402] pstate: 40000085 (nZcv daIf -PAN -UAO)
[ 2546.749015] pc : __list_add_valid+0x50/0x90
[ 2546.750485] lr : __list_add_valid+0x50/0x90
[ 2546.751975] sp : ffff00001b5eb910
[ 2546.753286] x29: ffff00001b5eb910 x28: ffff800abacf0000
[ 2546.754976] x27: ffff00001b5ebbb0 x26: ffff000009570000
[ 2546.756665] x25: ffff00000960d000 x24: 00000250f41ca8f8
[ 2546.758366] x23: ffff800b6a95e740 x22: ffff800b4d61ad40
[ 2546.760066] x21: ffff800b4d61ad40 x20: ffff800ba434f080
[ 2546.761742] x19: ffff800b4d61ac00 x18: ffffffffffffffff
[ 2546.763425] x17: 0000000000000000 x16: 0000000000000000
[ 2546.765089] x15: ffff000009570748 x14: 6666662073617720
[ 2546.766755] x13: 747562202c293034 x12: 6461313664346230
[ 2546.768429] x11: 3038666666662820 x10: 0000000000000000
[ 2546.770124] x9 : 0000000000000001 x8 : ffff000009f34a0f
[ 2546.771831] x7 : 0000000000000000 x6 : 000000000000250d
[ 2546.773525] x5 : 0000000000000000 x4 : 0000000000000000
[ 2546.775227] x3 : 0000000000000000 x2 : 70ef7f624013ca00
[ 2546.776929] x1 : 0000000000000000 x0 : 0000000000000075
[ 2546.778623] Process docker-runc (pid: 29428, stack limit = 0x00000000293494a2)
[ 2546.780742] Call trace:
[ 2546.781955]  __list_add_valid+0x50/0x90
[ 2546.783469]  enqueue_entity+0x4a0/0x6e8
[ 2546.784957]  enqueue_task_fair+0xac/0x610
[ 2546.786502]  sched_move_task+0x134/0x178
[ 2546.787993]  cpu_cgroup_attach+0x40/0x78
[ 2546.789540]  cgroup_migrate_execute+0x378/0x3a8
[ 2546.791169]  cgroup_migrate+0x6c/0x90
[ 2546.792663]  cgroup_attach_task+0x148/0x238
[ 2546.794211]  __cgroup1_procs_write.isra.2+0xf8/0x160
[ 2546.795935]  cgroup1_procs_write+0x38/0x48
[ 2546.797492]  cgroup_file_write+0xa0/0x170
[ 2546.799010]  kernfs_fop_write+0x114/0x1e0
[ 2546.800558]  __vfs_write+0x60/0x190
[ 2546.801977]  vfs_write+0xac/0x1c0
[ 2546.803341]  ksys_write+0x6c/0xd8
[ 2546.804674]  __arm64_sys_write+0x24/0x30
[ 2546.806146]  el0_svc_common+0x78/0x100
[ 2546.807584]  el0_svc_handler+0x38/0x88
[ 2546.809017]  el0_svc+0x8/0xc

In this patch, we move rq->tmp_alone_branch point to its prev before delete it
from list.

Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Cc: Bin Li <huawei.libin@huawei.com>
Cc: <stable@vger.kernel.org>        [4.10+]
Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac855b2..7a72702 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->on_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
+		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
+			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
+
 		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
 		cfs_rq->on_list = 0;
 	}
-- 
1.8.3.1

