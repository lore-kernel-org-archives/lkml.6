Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F2BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3602087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfADFut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:50:49 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:54178 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfADFus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:50:48 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8EEC01AE9C81FCC8A455;
        Fri,  4 Jan 2019 13:50:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x045ocKg048261;
        Fri, 4 Jan 2019 13:50:38 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019010413511579-20414885 ;
          Fri, 4 Jan 2019 13:51:15 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     madalin.bucur@nxp.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, huang.junhua@zte.com.cn,
        Junhua Huang <huangjunhua@zte.com.cn>
Subject: [PATCH] fsl/fman: avoid sleeping in atomic context while adding an address
Date:   Fri, 4 Jan 2019 13:50:01 +0800
Message-Id: <1546581001-38798-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-04 13:51:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-04 13:50:23,
        Serialize complete at 2019-01-04 13:50:23
X-MAIL: mse01.zte.com.cn x045ocKg048261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhua Huang <huang.junhua@zte.com.cn>

dev_set_rx_mode will call function pointer mac_dev->add_hash_mac_addr
while holding spin_lock_bh. The function pointer points to 
memac_add_hash_mac_address when ethernet type is fman-memac,
which will kmalloc use GFP_KERNEL flag.

/ # ifconfig eth2 192.168.1.168
[  576.604544] BUG: sleeping function called from invalid context at mm/slab.h:393
[  576.610587] in_atomic(): 1, irqs_disabled(): 0, pid: 2751, name: ifconfig
[  576.616105] 2 locks held by ifconfig/2751:
[  576.618916] #0:(rtnl_mutex)at: [<c00000000080ba60>] .rtnl_lock+0x1c/0x30
[  576.625523] #1:(_xmit_ETHER)at: [<c0000000007f9430>] .dev_set_rx_mode+0x24/0x54
[  576.632745] CPU: 5 PID: 2751 Comm: ifconfig Tainted: G   W 4.9.115-rt93-EMBSYS-@332 #3
[  576.642942] Call Trace:
[  576.644085] [c00000007499b440] [c000000000a09eb4] .dump_stack+0xe0/0x14c (unreliable)
[  576.650642] [c00000007499b4d0] [c000000000076f3c] .___might_sleep+0x1ac/0x278
[  576.656493] [c00000007499b560] [c0000000001aad6c] .kmem_cache_alloc+0x144/0x28c
[  576.662518] [c00000007499b620] [c000000000634c18] .memac_add_hash_mac_address+0x100/0x194
[  576.669416] [c00000007499b6b0] [c000000000630b54] .set_multi+0x1bc/0x20c
[  576.674829] [c00000007499b760] [c00000000063718c] .dpaa_set_rx_mode+0x84/0x104
[  576.680765] [c00000007499b7e0] [c0000000007f9394] .__dev_set_rx_mode+0x64/0xdc
[  576.686701] [c00000007499b870] [c0000000007f943c] .dev_set_rx_mode+0x30/0x54
[  576.692464] [c00000007499b8f0] [c0000000007f98f4] .__dev_change_flags+0x98/0x1c4
[  576.698573] [c00000007499b980] [c0000000007f9a4c] .dev_change_flags+0x2c/0x80
[  576.704429] [c00000007499ba10] [c0000000008cde28] .devinet_ioctl+0x624/0x8e0
[  576.710191] [c00000007499bb00] [c0000000008d1678] .inet_ioctl+0x1f4/0x250
[  576.715697] [c00000007499bb70] [c0000000007c89d8] .sock_do_ioctl+0x50/0xa8
[  576.721284] [c00000007499bc00] [c0000000007c94e8] .sock_ioctl+0x2b8/0x39c
[  576.726786] [c00000007499bca0] [c0000000001e2500] .do_vfs_ioctl+0xc8/0x8b4
[  576.732373] [c00000007499bd90] [c0000000001e2d44] .SyS_ioctl+0x58/0xa4
[  576.737612] [c00000007499be30] [c0000000000007a4] system_call+0x38/0x108

Signed-off-by: Junhua Huang <huangjunhua@zte.com.cn>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 71a5ded..21dd557 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -923,7 +923,7 @@ int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 	hash = get_mac_addr_hash_code(addr) & HASH_CTRL_ADDR_MASK;
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
-- 
2.15.2

