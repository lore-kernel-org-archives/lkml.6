Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC55621783
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfAGCQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:16:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbfAGCQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:16:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D52F63FF79FE450F0BE;
        Mon,  7 Jan 2019 10:16:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Jan 2019 10:15:38 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <yaohongbo@huawei.com>, <wangxiongfeng2@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <thunder.leizhen@huawei.com>, <tanxiaojun@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <cj.chengjian@huawei.com>, <wxf.wang@hisilicon.com>,
        <keith.busch@intel.com>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
Date:   Mon, 7 Jan 2019 10:22:07 +0800
Message-ID: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an out of bounds array access in nvme_cqe_peding().

When enable irq_thread for nvme interrupt, there is racing between the
nvmeq->cq_head updating and reading.

nvmeq->cq_head is updated in nvme_update_cq_head(), if nvmeq->cq_head
equals nvmeq->q_depth and before its value set to zero, nvme_cqe_pending()
uses its value as an array index, the index will be out of bounds.

(When enabled nvme.using_thread_interrupts=1 in cmdline, i found this
abnormal address access).

[  100.299140] Unable to handle kernel paging request at virtual address
ffff00002416500e
[  100.307046] Mem abort info:
[  100.309826]   ESR = 0x96000007
[  100.312867]   Exception class = DABT (current EL), IL = 32 bits
[  100.318771]   SET = 0, FnV = 0
[  100.321811]   EA = 0, S1PTW = 0
[  100.324938] Data abort info:
[  100.327805]   ISV = 0, ISS = 0x00000007
[  100.331626]   CM = 0, WnR = 0
[  100.334581] swapper pgtable: 4k pages, 48-bit VAs, pgdp =
00000000a9f05748
[  100.341441] [ffff00002416500e] pgd=00000a5fffffe803,
pud=00000a5fffffd803, pmd=0000003f780ac003, pte=0000000000000000
[  100.352038] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[  100.357597] Modules linked in: hns_roce_hw_v2(O) hns_roce(O) hns3(O)
hclge(O) hnae3(O)
[  100.365505] CPU: 28 PID: 2888 Comm: irq/162-nvme0q7 Tainted: G
O      4.19.0-g45910de #1
[  100.374449] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
RC0 - B080 (V8.01) 11/30/2018
[  100.383218] pstate: 00400089 (nzcv daIf +PAN -UAO)
[  100.387999] pc : nvme_irq_check+0x10/0x28
[  100.391995] lr : __handle_irq_event_percpu+0x70/0x2c8
[  100.397032] sp : ffff000009ac3e60
[  100.400333] x29: ffff000009ac3e60 x28: ffff803f73690d80
[  100.405631] x27: ffff805f78494400 x26: ffff0000097d1000
[  100.410930] x25: ffff000009ac3f04 x24: ffff0000097a2018
[  100.416228] x23: ffff0000097d1b40 x22: 00000000000000a2
[  100.421526] x21: 0000000000000000 x20: ffff805f78494438
[  100.426825] x19: ffff803f70384480 x18: 0000000000000400
[  100.432123] x17: 0000000000000000 x16: 0000000000000000
[  100.437421] x15: 0000000000000400 x14: 0000000000000400
[  100.442719] x13: 0000000000000000 x12: 0000000000000000
[  100.448018] x11: 0000000000000000 x10: 0000000000000040
[  100.453317] x9 : ffff0000097effe0 x8 : ffff803f775db908
[  100.458615] x7 : ffff803f775dba40 x6 : 0000000000000110
[  100.463913] x5 : ffff803f775db908 x4 : 0000805f7626a000
[  100.469212] x3 : 0000000000000000 x2 : ffff000024161000
[  100.474510] x1 : 0000000000000001 x0 : ffff000024165000
[  100.479809] Process irq/162-nvme0q7 (pid: 2888, stack limit =
0x000000007f43f8e5)
[  100.487276] Call trace:
[  100.489710]  nvme_irq_check+0x10/0x28
[  100.493358]  handle_irq_event_percpu+0x34/0x88
[  100.497787]  handle_irq_event+0x48/0x78
[  100.501610]  handle_fasteoi_irq+0xa8/0x180
[  100.505692]  generic_handle_irq+0x24/0x38
[  100.509688]  __handle_domain_irq+0x5c/0xb0
[  100.513770]  gic_handle_irq+0x7c/0x180
[  100.517504]  el1_irq+0xb0/0x128
[  100.520631]  nvme_irq+0x108/0x150
[  100.523933]  irq_thread_fn+0x28/0x68
[  100.527494]  irq_thread+0x124/0x1d0
[  100.530969]  kthread+0x12c/0x130
[  100.534183]  ret_from_fork+0x10/0x18
[  100.537745] Code: 7940ec20 f9402422 3941f021 8b001040 (79401c00)
[  100.543895] ---[ end trace 119829d132a82da5 ]---
[  100.548499] Kernel panic - not syncing: Fatal exception in interrupt
[  100.554881] SMP: stopping secondary CPUs
[  100.575347] Kernel Offset: disabled
[  100.578822] CPU features: 0x0,22800a38
[  100.582556] Memory Limit: none
[  100.585633] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682..68375d4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (++nvmeq->cq_head == nvmeq->q_depth) {
+	if (nvmeq->cq_head == (nvmeq->q_depth - 1)) {
 		nvmeq->cq_head = 0;
 		nvmeq->cq_phase = !nvmeq->cq_phase;
+	} else {
+		++nvmeq->cq_head;
 	}
 }
 
-- 
1.8.3.1

