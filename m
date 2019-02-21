Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C762084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfBUGfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:35:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUGfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:35:53 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E9879284D0FAC64FB44;
        Thu, 21 Feb 2019 14:35:51 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 14:35:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <cminyard@mvista.com>
CC:     <yangyingliang@huawei.com>, <arnd@arndb.de>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <honglei5@huawei.com>
Subject: [PATCH] ipmi_si: fix oops when loading ipmi_si driver
Date:   Thu, 21 Feb 2019 14:35:41 +0800
Message-ID: <1550730941-29208-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we excute the following commands, we got oops
modprobe ipmi_si ports=0xffc0e3 type=bt

[  503.305487] ipmi_si: IPMI System Interface driver
[  503.305489] ipmi_hardcode: probing via hardcoded address
[  503.305491] ipmi_si: Adding hardcoded-specified bt state machine
[  503.305494] ipmi_si: Trying hardcoded-specified bt state machine at i/o address 0xffc0e3, slave address 0x0, irq 0
[  503.337865] ipmi_si ipmi_si.0: bt cap response too short: 3
[  503.337867] ipmi_si ipmi_si.0: using default values
[  503.337869] ipmi_si ipmi_si.0: req2rsp=5 secs retries=2
[  503.421948] ipmi_si ipmi_si.0: IPMI message handler: Found new BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
[  503.665959] ipmi_si ipmi_si.0: IPMI bt interface initialized
[  512.188061] ipmi_si: module verification failed: signature and/or required key missing - tainting kernel
[  512.190063] ipmi_si: IPMI System Interface driver
[  512.190065] ipmi_hardcode: probing via hardcoded address
[  512.190067] ipmi_si: Adding hardcoded-specified bt state machine
[  512.190070] ipmi_si: Trying hardcoded-specified bt state machine at i/o address 0xffc0e3, slave address 0x0, irq 0
[  512.201867] ipmi_si ipmi_si.0: bt cap response too short: 3
[  512.201869] ipmi_si ipmi_si.0: using default values
[  512.201870] ipmi_si ipmi_si.0: req2rsp=5 secs retries=2
[  512.269898] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
[  512.269899] Mem abort info:
[  512.269900]   ESR = 0x96000006
[  512.269902]   Exception class = DABT (current EL), IL = 32 bits
[  512.269903]   SET = 0, FnV = 0
[  512.269904]   EA = 0, S1PTW = 0
[  512.269905] Data abort info:
[  512.269906]   ISV = 0, ISS = 0x00000006
[  512.269908]   CM = 0, WnR = 0
[  512.269910] user pgtable: 4k pages, 48-bit VAs, pgdp = 000000003f829971
[  512.269912] [0000000000000030] pgd=0000005f1e7de003, pud=0000005f69728003, pmd=0000000000000000
[  512.269916] Internal error: Oops: 96000006 [#1] SMP
[  512.274923] Modules linked in: ipmi_si(E+) nls_utf8 isofs dm_mirror dm_region_hash dm_log dm_mod aes_ce_blk crypto_simd cryptd aes_ce_cipher ghash_ce sha2_ce sha256_arm64 sha1_ce ses hibmc_drm enclosure hisi_sas_v2_hw hisi_sas_main sg sbsa_gwdt ip_tables marvell ixgbe hns_dsaf hns_enet_drv ipmi_devintf mpt3sas ipmi_msghandler hns_mdio hnae mdio [last unloaded: ipmi_si]
[  512.308100] CPU: 27 PID: 13691 Comm: modprobe Kdump: loaded Tainted: G            E     5.0.0-rc7+ #273
[  512.317456] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.37 11/21/2017
[  512.324781] pstate: a0000005 (NzCv daif -PAN -UAO)
[  512.329643] pc : sysfs_do_create_link_sd.isra.0+0x5c/0x110
[  512.335204] lr : sysfs_do_create_link_sd.isra.0+0x50/0x110
[  512.340763] sp : ffff000012a8b8b0
[  512.344118] x29: ffff000012a8b8b0 x28: ffff805f69bf8818
[  512.349505] x27: 0000000000000000 x26: 0000000000000000
[  512.354891] x25: ffff000011840000 x24: ffff805f69248ee0
[  512.360277] x23: 0000000000000001 x22: ffff000011b0d000
[  512.365662] x21: ffff00001116e3e0 x20: ffff805f76db7cb0
[  512.371047] x19: 0000000000000030 x18: ffffffffffffffff
[  512.376433] x17: 0000000000000000 x16: 0000000000000000
[  512.381818] x15: ffff00001176d708 x14: 5244006d726f6674
[  512.387204] x13: 0000000000000040 x12: 0000000000000008
[  512.392589] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[  512.397974] x9 : 716e6573606aff2f x8 : 7f7f7f7f7f7f7f7f
[  512.403360] x7 : 2d68725e686c6f68 x6 : 0080000000000000
[  512.408745] x5 : 0000000000000000 x4 : ffff805f08e2d440
[  512.414131] x3 : ffff000011b0df60 x2 : 0000000000000001
[  512.419516] x1 : 0000000000000000 x0 : 0000000000000000
[  512.424902] Process insmod (pid: 13691, stack limit = 0x0000000007e6d9d7)
[  512.431784] Call trace:
[  512.434260]  sysfs_do_create_link_sd.isra.0+0x5c/0x110
[  512.439468]  sysfs_create_link+0x40/0x68
[  512.443446]  driver_sysfs_add+0x88/0xb8
[  512.447332]  device_bind_driver+0x20/0x70
[  512.451392]  __device_attach+0xa0/0x170
[  512.459409]  device_initial_probe+0x24/0x30
[  512.467809]  bus_probe_device+0xa0/0xa8
[  512.475844]  device_add+0x494/0x620
[  512.483441]  platform_device_add+0x118/0x2a0
[  512.491638]  try_smi_init+0x6c0/0x11c8 [ipmi_si]
[  512.500161]  init_ipmi_si+0x13c/0x1f0 [ipmi_si]
[  512.508342]  do_one_initcall+0x54/0x1f0
[  512.515668]  do_init_module+0x64/0x1e4
[  512.522810]  load_module+0x13fc/0x14f8
[  512.529816]  __se_sys_finit_module+0xa0/0x100
[  512.537398]  __arm64_sys_finit_module+0x24/0x30
[  512.545045]  el0_svc_common+0x120/0x148
[  512.552029]  el0_svc_handler+0x38/0x78
[  512.558918]  el0_svc+0x8/0xc
[  512.564960] Code: 942513e5 d503201f d503201f 35000400 (f9400273)
[  512.574273] ---[ end trace 2a5abdfb7a1edf93 ]---
[  512.582123] Kernel panic - not syncing: Fatal exception
[  512.590600] SMP: stopping secondary CPUs
[  512.597934] Kernel Offset: disabled
[  512.604635] CPU features: 0x002,21006008
[  512.611889] Memory Limit: none
[  512.621495] Starting crashdump kernel...
[  512.628775] Bye!

Because the target_kobj pointer is null in sysfs_do_create_link_sd().
The pointer is assigned by new_smi->io.dev->driver->p.

If ipmi_si driver is not registered, new_smi->io.dev->driver->p is null
and it will be used when try_smi_init() calling platform_device_add().
Fix this oops by registering the driver before calling platform_device_add().

Fixes: 9d70029edbbf ("ipmi_si: Move platform device handling to another file")

Reported-by: Hong Lei <honglei5@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/char/ipmi/ipmi_si_hardcode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index 4876428..2aa1ea9 100644
--- a/drivers/char/ipmi/ipmi_si_hardcode.c
+++ b/drivers/char/ipmi/ipmi_si_hardcode.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "ipmi_hardcode: " fmt
 
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
 #include "ipmi_si.h"
 
 /*
@@ -144,5 +145,11 @@ int ipmi_si_hardcode_find_bmc(void)
 
 		ret = ipmi_si_add_smi(&io);
 	}
+
+	if (!ret) {
+		ipmi_platform_driver.driver.bus = &platform_bus_type;
+		ret = driver_register(&ipmi_platform_driver.driver);
+	}
+
 	return ret;
 }
-- 
1.8.3.1


