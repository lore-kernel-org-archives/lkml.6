Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD129C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E57218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAZJPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:15:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbfAZJPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:15:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D1B3D42E93C57A1078C;
        Sat, 26 Jan 2019 17:15:03 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 17:14:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <cminyard@mvista.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <yangyingliang@huawei.com>, <qiaonuohan@huawei.com>
Subject: [PATCH v2] ipmi_si: fix use-after-free of resource->name
Date:   Sat, 26 Jan 2019 17:14:54 +0800
Message-ID: <1548494094-14356-1-git-send-email-yangyingliang@huawei.com>
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
rmmod ipmi_si
cat /proc/ioports

[ 1623.482380] Unable to handle kernel paging request at virtual address ffff00000901d478
[ 1623.482382] Mem abort info:
[ 1623.482383]   ESR = 0x96000007
[ 1623.482385]   Exception class = DABT (current EL), IL = 32 bits
[ 1623.482386]   SET = 0, FnV = 0
[ 1623.482387]   EA = 0, S1PTW = 0
[ 1623.482388] Data abort info:
[ 1623.482389]   ISV = 0, ISS = 0x00000007
[ 1623.482390]   CM = 0, WnR = 0
[ 1623.482393] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000d7d94a66
[ 1623.482395] [ffff00000901d478] pgd=000000dffbfff003, pud=000000dffbffe003, pmd=0000003f5d06e003, pte=0000000000000000
[ 1623.482399] Internal error: Oops: 96000007 [#1] SMP
[ 1623.487407] Modules linked in: ipmi_si(E) nls_utf8 isofs rpcrdma ib_iser ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad rdma_cm ib_cm dm_mirror dm_region_hash dm_log iw_cm dm_mod aes_ce_blk crypto_simd cryptd aes_ce_cipher ses ghash_ce sha2_ce enclosure sha256_arm64 sg sha1_ce hisi_sas_v2_hw hibmc_drm sbsa_gwdt hisi_sas_main ip_tables mlx5_ib ib_uverbs marvell ib_core mlx5_core ixgbe mdio hns_dsaf ipmi_devintf hns_enet_drv ipmi_msghandler hns_mdio [last unloaded: ipmi_si]
[ 1623.532410] CPU: 30 PID: 11438 Comm: cat Kdump: loaded Tainted: G            E     5.0.0-rc3+ #168
[ 1623.541498] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.37 11/21/2017
[ 1623.548822] pstate: a0000005 (NzCv daif -PAN -UAO)
[ 1623.553684] pc : string+0x28/0x98
[ 1623.557040] lr : vsnprintf+0x368/0x5e8
[ 1623.560837] sp : ffff000013213a80
[ 1623.564191] x29: ffff000013213a80 x28: ffff00001138abb5
[ 1623.569577] x27: ffff000013213c18 x26: ffff805f67d06049
[ 1623.574963] x25: 0000000000000000 x24: ffff00001138abb5
[ 1623.580349] x23: 0000000000000fb7 x22: ffff0000117ed000
[ 1623.585734] x21: ffff000011188fd8 x20: ffff805f67d07000
[ 1623.591119] x19: ffff805f67d06061 x18: ffffffffffffffff
[ 1623.596505] x17: 0000000000000200 x16: 0000000000000000
[ 1623.601890] x15: ffff0000117ed748 x14: ffff805f67d07000
[ 1623.607276] x13: ffff805f67d0605e x12: 0000000000000000
[ 1623.612661] x11: 0000000000000000 x10: 0000000000000000
[ 1623.618046] x9 : 0000000000000000 x8 : 000000000000000f
[ 1623.623432] x7 : ffff805f67d06061 x6 : fffffffffffffffe
[ 1623.628817] x5 : 0000000000000012 x4 : ffff00000901d478
[ 1623.634203] x3 : ffff0a00ffffff04 x2 : ffff805f67d07000
[ 1623.639588] x1 : ffff805f67d07000 x0 : ffffffffffffffff
[ 1623.644974] Process cat (pid: 11438, stack limit = 0x000000008d4cbc10)
[ 1623.651592] Call trace:
[ 1623.654068]  string+0x28/0x98
[ 1623.657071]  vsnprintf+0x368/0x5e8
[ 1623.660517]  seq_vprintf+0x70/0x98
[ 1623.668009]  seq_printf+0x7c/0xa0
[ 1623.675530]  r_show+0xc8/0xf8
[ 1623.682558]  seq_read+0x330/0x440
[ 1623.689877]  proc_reg_read+0x78/0xd0
[ 1623.697346]  __vfs_read+0x60/0x1a0
[ 1623.704564]  vfs_read+0x94/0x150
[ 1623.711339]  ksys_read+0x6c/0xd8
[ 1623.717939]  __arm64_sys_read+0x24/0x30
[ 1623.725077]  el0_svc_common+0x120/0x148
[ 1623.732035]  el0_svc_handler+0x30/0x40
[ 1623.738757]  el0_svc+0x8/0xc
[ 1623.744520] Code: d1000406 aa0103e2 54000149 b4000080 (39400085)
[ 1623.753441] ---[ end trace f91b6a4937de9835 ]---
[ 1623.760871] Kernel panic - not syncing: Fatal exception
[ 1623.768935] SMP: stopping secondary CPUs
[ 1623.775718] Kernel Offset: disabled
[ 1623.781998] CPU features: 0x002,21006008
[ 1623.788777] Memory Limit: none
[ 1623.798329] Starting crashdump kernel...
[ 1623.805202] Bye!

If io_setup is called successful in try_smi_init() but try_smi_init()
goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
will not be called while removing module. It leads to the resource that
allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
resource is freed while removing the module. It causes use-after-free
when cat /proc/ioports.

Fix this by calling io_cleanup() while try_smi_init() goes to out_err
and don't call release_region() if request_region() is not called to
avoid error prints.

Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
Cc: stable@vger.kernel.org
Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
Suggested-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/char/ipmi/ipmi_si_intf.c    | 5 +++++
 drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index dc8603d..f1b9fda 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2085,6 +2085,11 @@ static int try_smi_init(struct smi_info *new_smi)
 	WARN_ON(new_smi->io.dev->init_name != NULL);
 
  out_err:
+	if (rv && new_smi->io.io_cleanup) {
+		new_smi->io.io_cleanup(&new_smi->io);
+		new_smi->io.io_cleanup = NULL;
+	}
+
 	kfree(init_name);
 	return rv;
 }
diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
index ef6dffc..0c46a3f 100644
--- a/drivers/char/ipmi/ipmi_si_port_io.c
+++ b/drivers/char/ipmi/ipmi_si_port_io.c
@@ -53,6 +53,9 @@ static void port_cleanup(struct si_sm_io *io)
 	unsigned int addr = io->addr_data;
 	int          idx;
 
+	if (io->regsize != 1 && io->regsize != 2 && io->regsize != 4)
+		return;
+
 	if (addr) {
 		for (idx = 0; idx < io->io_size; idx++)
 			release_region(addr + idx * io->regspacing,
-- 
1.8.3


