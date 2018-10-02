Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB302089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB302089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeJBUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJBUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:29 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 014E7C20;
        Tue,  2 Oct 2018 13:27:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 009/228] net: hns3: Fix warning bug when doing lp selftest
Date:   Tue,  2 Oct 2018 06:21:46 -0700
Message-Id: <20181002132459.667646314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit d7099d15478e89edb9bc6c6e3ab4cd341884a367 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -201,7 +201,9 @@ static u32 hns3_lb_check_rx_ring(struct
 		rx_group = &ring->tqp_vector->rx_group;
 		pre_rx_pkt = rx_group->total_packets;
 
+		preempt_disable();
 		hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);
+		preempt_enable();
 
 		rcv_good_pkt_total += (rx_group->total_packets - pre_rx_pkt);
 		rx_group->total_packets = pre_rx_pkt;


