Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754863AbeEaMIJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:08:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54508 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754197AbeEaMH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:07:58 -0400
From: Xie XiuQi <xiexiuqi@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <bhelgaas@google.com>, <gregkh@linuxfoundation.org>,
        <rafael.j.wysocki@intel.com>, <jarkko.sakkinen@linux.intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wanghuiqiang@huawei.com>,
        <tnowicki@caviumnetworks.com>
Subject: [PATCH 2/2] drivers: check numa node's online status in dev_to_node
Date: Thu, 31 May 2018 20:14:39 +0800
Message-ID: <1527768879-88161-3-git-send-email-xiexiuqi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
References: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dev->numa_node is not available (or offline), we should
return NUMA_NO_NODE to prevent alloc memory on offline
nodes, which could cause oops.

For example, a numa node:
1) without memory
2) NR_CPUS is very small, and the cpus on the node are not brought up

[   27.851041] Unable to handle kernel NULL pointer dereference at virtual address 00001988
[   27.859128] Mem abort info:
[   27.861908]   ESR = 0x96000005
[   27.864949]   Exception class = DABT (current EL), IL = 32 bits
[   27.870860]   SET = 0, FnV = 0
[   27.873900]   EA = 0, S1PTW = 0
[   27.877029] Data abort info:
[   27.879895]   ISV = 0, ISS = 0x00000005
[   27.883716]   CM = 0, WnR = 0
[   27.886673] [0000000000001988] user address but active_mm is swapper
[   27.893012] Internal error: Oops: 96000005 [#1] SMP
[   27.897876] Modules linked in:
[   27.900919] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc6-mpam+ #116
[   27.907865] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B306 05/28/2018
[   27.916983] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[   27.921763] pc : __alloc_pages_nodemask+0xf0/0xe70
[   27.926540] lr : __alloc_pages_nodemask+0x184/0xe70
[   27.931403] sp : ffff00000996f7e0
[   27.934704] x29: ffff00000996f7e0 x28: ffff000008cb10a0
[   27.940003] x27: 00000000014012c0 x26: 0000000000000000
[   27.945301] x25: 0000000000000003 x24: ffff0000085bbc14
[   27.950600] x23: 0000000000400000 x22: 0000000000000000
[   27.955898] x21: 0000000000000001 x20: 0000000000000000
[   27.961196] x19: 0000000000400000 x18: 0000000000000f00
[   27.966494] x17: 00000000003bff88 x16: 0000000000000020
[   27.971792] x15: 000000000000003b x14: ffffffffffffffff
[   27.977090] x13: ffffffffffff0000 x12: 0000000000000030
[   27.982388] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[   27.987686] x9 : 2e64716e622e7364 x8 : 7f7f7f7f7f7f7f7f
[   27.992984] x7 : 0000000000000000 x6 : ffff000008d73c08
[   27.998282] x5 : 0000000000000000 x4 : 0000000000000081
[   28.003580] x3 : 0000000000000000 x2 : 0000000000000000
[   28.008878] x1 : 0000000000000001 x0 : 0000000000001980
[   28.014177] Process swapper/0 (pid: 1, stack limit = 0x        (ptrval))
[   28.020863] Call trace:
[   28.023296]  __alloc_pages_nodemask+0xf0/0xe70
[   28.027727]  allocate_slab+0x94/0x590
[   28.031374]  new_slab+0x68/0xc8
[   28.034502]  ___slab_alloc+0x444/0x4f8
[   28.038237]  __slab_alloc+0x50/0x68
[   28.041713]  __kmalloc_node_track_caller+0x100/0x320
[   28.046664]  devm_kmalloc+0x3c/0x90
[   28.050139]  pinctrl_bind_pins+0x4c/0x298
[   28.054135]  driver_probe_device+0xb4/0x4a0
[   28.058305]  __driver_attach+0x124/0x128
[   28.062213]  bus_for_each_dev+0x78/0xe0
[   28.066035]  driver_attach+0x30/0x40
[   28.069597]  bus_add_driver+0x248/0x2b8
[   28.073419]  driver_register+0x68/0x100
[   28.077242]  __pci_register_driver+0x64/0x78
[   28.081500]  pcie_portdrv_init+0x44/0x4c
[   28.085410]  do_one_initcall+0x54/0x208
[   28.089232]  kernel_init_freeable+0x244/0x340
[   28.093577]  kernel_init+0x18/0x118
[   28.097052]  ret_from_fork+0x10/0x1c
[   28.100614] Code: 7100047f 321902a4 1a950095 b5000602 (b9400803)
[   28.106740] ---[ end trace e32df44e6e1c3a4b ]---

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Huiqiang Wang <wanghuiqiang@huawei.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <Tomasz.Nowicki@caviumnetworks.com>
Cc: Xishi Qiu <qiuxishi@huawei.com>
---
 include/linux/device.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4779569..2a4fb08 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1017,7 +1017,12 @@ extern __printf(2, 3)
 #ifdef CONFIG_NUMA
 static inline int dev_to_node(struct device *dev)
 {
-	return dev->numa_node;
+	int node = dev->numa_node;
+
+	if (unlikely(node != NUMA_NO_NODE && !node_online(node)))
+		return NUMA_NO_NODE;
+
+	return node;
 }
 static inline void set_dev_node(struct device *dev, int node)
 {
-- 
1.8.3.1
