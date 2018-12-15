Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A41CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184FD206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeLODRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:17:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729812AbeLODRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:17:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00E96B0FFFE00;
        Sat, 15 Dec 2018 11:17:30 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 11:17:23 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [Patch net 04/10] net: hns: Fixed bug that netdev was opened twice
Date:   Sat, 15 Dec 2018 11:53:23 +0800
Message-ID: <1544846009-50276-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
References: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

After resetting dsaf to try to repair chip error such as ecc error,
the net device will be open if net interface is up. But at this time
if there is the users set the net device up with the command ifconfig,
the net device will be opened twice consecutively.

Function napi_enable was called when open device. And Kernel panic will
be occurred if it was called twice consecutively. Such as follow:
static inline void napi_enable(struct napi_struct *n)
{
         BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
         smp_mb__before_clear_bit();
         clear_bit(NAPI_STATE_SCHED, &n->state);
}

[37255.571996] Kernel panic - not syncing: BUG!
[37255.595234] Call trace:
[37255.597694] [<ffff80000008ab48>] dump_backtrace+0x0/0x1a0
[37255.603114] [<ffff80000008ad08>] show_stack+0x20/0x28
[37255.608187] [<ffff8000009c4944>] dump_stack+0x98/0xb8
[37255.613258] [<ffff8000009c149c>] panic+0x10c/0x26c
[37255.618070] [<ffff80000070f134>] hns_nic_net_up+0x30c/0x4e0
[37255.623664] [<ffff80000070f39c>] hns_nic_net_open+0x94/0x12c
[37255.629346] [<ffff80000084be78>] __dev_open+0xf4/0x168
[37255.634504] [<ffff80000084c1ac>] __dev_change_flags+0x98/0x15c
[37255.640359] [<ffff80000084c29c>] dev_change_flags+0x2c/0x68
[37255.769580] [<ffff8000008dc400>] devinet_ioctl+0x650/0x704
[37255.775086] [<ffff8000008ddc38>] inet_ioctl+0x98/0xb4
[37255.780159] [<ffff800000827b7c>] sock_do_ioctl+0x44/0x84
[37255.785490] [<ffff800000828e04>] sock_ioctl+0x248/0x30c
[37255.790737] [<ffff80000026dc6c>] do_vfs_ioctl+0x480/0x618
[37255.796156] [<ffff80000026de94>] SyS_ioctl+0x90/0xa4
[37255.801139] SMP: stopping secondary CPUs
[37255.805079] kbox: catch panic event.
[37255.809586] collected_len = 128928, LOG_BUF_LEN_LOCAL = 131072
[37255.816103] flush cache 0xffff80003f000000  size 0x800000
[37255.822192] flush cache 0xffff80003f000000  size 0x800000
[37255.828289] flush cache 0xffff80003f000000  size 0x800000
[37255.834378] kbox: no notify die func register. no need to notify
[37255.840413] ---[ end Kernel panic - not syncing: BUG!

This patchset fix this bug according to the flag NIC_STATE_DOWN.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index c205a0e..c9454c4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1333,6 +1333,9 @@ static int hns_nic_net_up(struct net_device *ndev)
 	int i, j;
 	int ret;
 
+	if (!test_bit(NIC_STATE_DOWN, &priv->state))
+		return 0;
+
 	ret = hns_nic_init_irq(priv);
 	if (ret != 0) {
 		netdev_err(ndev, "hns init irq failed! ret=%d\n", ret);
-- 
1.9.1

