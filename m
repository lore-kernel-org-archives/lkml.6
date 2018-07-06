Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6787823F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6787823F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGFK3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932310AbeGFK33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B0C4A868C1AC;
        Fri,  6 Jul 2018 18:29:15 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:29:07 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 07/10] net: hns3: Fix warning bug when doing lp selftest
Date:   Fri, 6 Jul 2018 11:28:01 +0100
Message-ID: <20180706102804.196-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The napi_alloc_skb is excepted to be called under the
non-preemptible code path when it is called by hns3_clean_rx_ring
during loopback selftest, otherwise the below warning will be
logged:

[   92.420780] BUG: using smp_processor_id() in preemptible
[00000000] code: ethtool/1873
<SNIP>
[   92.463202]  check_preemption_disabled+0xf8/0x100
[   92.467893]  debug_smp_processor_id+0x1c/0x28
[   92.472239]  __napi_alloc_skb+0x30/0x130
[   92.476158]  hns3_clean_rx_ring+0x118/0x5f0 [hns3]
[   92.480941]  hns3_self_test+0x32c/0x4d0 [hns3]
[   92.485375]  ethtool_self_test+0xdc/0x1e8
[   92.489372]  dev_ethtool+0x1020/0x1da8
[   92.493109]  dev_ioctl+0x188/0x3a0
[   92.496499]  sock_do_ioctl+0xf4/0x208
[   92.500148]  sock_ioctl+0x228/0x3e8
[   92.503626]  do_vfs_ioctl+0xc4/0x880
[   92.507189]  SyS_ioctl+0x94/0xa8
[   92.510404]  el0_svc_naked+0x30/0x34

This patch fix it by disabling preemption when calling
hns3_clean_rx_ring during loopback selftest.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 40c0425..11620e0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -201,7 +201,9 @@ static u32 hns3_lb_check_rx_ring(struct hns3_nic_priv *priv, u32 budget)
 		rx_group = &ring->tqp_vector->rx_group;
 		pre_rx_pkt = rx_group->total_packets;
 
+		preempt_disable();
 		hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);
+		preempt_enable();
 
 		rcv_good_pkt_total += (rx_group->total_packets - pre_rx_pkt);
 		rx_group->total_packets = pre_rx_pkt;
-- 
2.7.4


