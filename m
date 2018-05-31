Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeEaMIE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:08:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54492 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754330AbeEaMH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:07:58 -0400
From: Xie XiuQi <xiexiuqi@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <bhelgaas@google.com>, <gregkh@linuxfoundation.org>,
        <rafael.j.wysocki@intel.com>, <jarkko.sakkinen@linux.intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wanghuiqiang@huawei.com>,
        <tnowicki@caviumnetworks.com>
Subject: [PATCH 0/2] arm64/drivers: avoid alloc memory on offline node
Date: Thu, 31 May 2018 20:14:37 +0800
Message-ID: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A numa system may return node which is not online.
For example, a numa node:
1) without memory
2) NR_CPUS is very small, and the cpus on the node are not brought up

In this situation, we use NUMA_NO_NODE to avoid oops.

[   25.732905] Unable to handle kernel NULL pointer dereference at virtual address 00001988
[   25.740982] Mem abort info:
[   25.743762]   ESR = 0x96000005
[   25.746803]   Exception class = DABT (current EL), IL = 32 bits
[   25.752711]   SET = 0, FnV = 0
[   25.755751]   EA = 0, S1PTW = 0
[   25.758878] Data abort info:
[   25.761745]   ISV = 0, ISS = 0x00000005
[   25.765568]   CM = 0, WnR = 0
[   25.768521] [0000000000001988] user address but active_mm is swapper
[   25.774861] Internal error: Oops: 96000005 [#1] SMP
[   25.779724] Modules linked in:
[   25.782768] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc6-mpam+ #115
[   25.789714] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B305 05/28/2018
[   25.798831] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[   25.803612] pc : __alloc_pages_nodemask+0xf0/0xe70
[   25.808389] lr : __alloc_pages_nodemask+0x184/0xe70
[   25.813252] sp : ffff00000996f660
[   25.816553] x29: ffff00000996f660 x28: 0000000000000000
[   25.821852] x27: 00000000014012c0 x26: 0000000000000000
[   25.827150] x25: 0000000000000003 x24: ffff000008099eac
[   25.832449] x23: 0000000000400000 x22: 0000000000000000
[   25.837747] x21: 0000000000000001 x20: 0000000000000000
[   25.843045] x19: 0000000000400000 x18: 0000000000010e00
[   25.848343] x17: 000000000437f790 x16: 0000000000000020
[   25.853641] x15: 0000000000000000 x14: 6549435020524541
[   25.858939] x13: 20454d502067756c x12: 0000000000000000
[   25.864237] x11: ffff00000996f6f0 x10: 0000000000000006
[   25.869536] x9 : 00000000000012a4 x8 : ffff8023c000ff90
[   25.874834] x7 : 0000000000000000 x6 : ffff000008d73c08
[   25.880132] x5 : 0000000000000000 x4 : 0000000000000081
[   25.885430] x3 : 0000000000000000 x2 : 0000000000000000
[   25.890728] x1 : 0000000000000001 x0 : 0000000000001980
[   25.896027] Process swapper/0 (pid: 1, stack limit = 0x        (ptrval))
[   25.902712] Call trace:
[   25.905146]  __alloc_pages_nodemask+0xf0/0xe70
[   25.909577]  allocate_slab+0x94/0x590
[   25.913225]  new_slab+0x68/0xc8
[   25.916353]  ___slab_alloc+0x444/0x4f8
[   25.920088]  __slab_alloc+0x50/0x68
[   25.923562]  kmem_cache_alloc_node_trace+0xe8/0x230
[   25.928426]  pci_acpi_scan_root+0x94/0x278
[   25.932510]  acpi_pci_root_add+0x228/0x4b0
[   25.936593]  acpi_bus_attach+0x10c/0x218
[   25.940501]  acpi_bus_attach+0xac/0x218
[   25.944323]  acpi_bus_attach+0xac/0x218
[   25.948144]  acpi_bus_scan+0x5c/0xc0
[   25.951708]  acpi_scan_init+0xf8/0x254
[   25.955443]  acpi_init+0x310/0x37c
[   25.958831]  do_one_initcall+0x54/0x208
[   25.962653]  kernel_init_freeable+0x244/0x340
[   25.966999]  kernel_init+0x18/0x118
[   25.970474]  ret_from_fork+0x10/0x1c
[   25.974036] Code: 7100047f 321902a4 1a950095 b5000602 (b9400803)
[   25.980162] ---[ end trace 64f0893eb21ec283 ]---
[   25.984765] Kernel panic - not syncing: Fatal exception

Xie XiuQi (2):
  arm64: avoid alloc memory on offline node
  drivers: check numa node's online status in dev_to_node

 arch/arm64/kernel/pci.c | 3 +++
 include/linux/device.h  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
1.8.3.1
