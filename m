Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeEaHDT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:03:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49781 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753825AbeEaHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:03:16 -0400
X-ME-Proxy: <xmx:M54PWxWHtQ1Tn_189QNDPe36frM5GhijU7uVItQ633SKnOIRbVSeAQ>
X-ME-Proxy: <xmx:M54PW4QzPy2Zym5huIQ-qkp9u-midijIUxMvKs-E97Z8TNi14Yuc7g>
X-ME-Proxy: <xmx:M54PWx3cj-NcxryAIwOR5swzl8BIg5zLY0jqO8sIUkVr79IqaGEA5Q>
X-ME-Proxy: <xmx:M54PWygV_2fLTI6HhWNCLwYzbc4Hyk76u2rYhsd0HdZP2r-qkkXi0Q>
X-ME-Proxy: <xmx:M54PWyUgp8YORl46pzadMUm2ibi4NZ0kgMvMCmr9PMYqR0T_V-frvQ>
X-ME-Proxy: <xmx:M54PWw3Y5Za4TGVyvx_8yepYEJKYXNrXR1Rzj0JRxjLmNKHNOVRyEQ>
X-ME-Sender: <xms:M54PWzUU6HYAIAgBRbKfNTnAPfGJnmmV59zEnAaz1X3sfrN9e63Wyw>
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: netdev@vger.kernel.org
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH net-next] net/ncsi: Avoid GFP_KERNEL in response handler
Date: Thu, 31 May 2018 17:02:54 +1000
Message-Id: <20180531070254.28878-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ncsi_rsp_handler_gc() allocates the filter arrays using GFP_KERNEL in
softirq context, causing the below backtrace. This allocation is only a
few dozen bytes during probing so allocate with GFP_ATOMIC instead.

[   42.813372] BUG: sleeping function called from invalid context at mm/slab.h:416
[   42.820900] in_atomic(): 1, irqs_disabled(): 0, pid: 213, name: kworker/0:1
[   42.827893] INFO: lockdep is turned off.
[   42.832023] CPU: 0 PID: 213 Comm: kworker/0:1 Tainted: G        W       4.13.16-01441-gad99b38 #65
[   42.841007] Hardware name: Generic DT based system
[   42.845966] Workqueue: events ncsi_dev_work
[   42.850251] [<8010a494>] (unwind_backtrace) from [<80107510>] (show_stack+0x20/0x24)
[   42.858046] [<80107510>] (show_stack) from [<80612770>] (dump_stack+0x20/0x28)
[   42.865309] [<80612770>] (dump_stack) from [<80148248>] (___might_sleep+0x230/0x2b0)
[   42.873241] [<80148248>] (___might_sleep) from [<80148334>] (__might_sleep+0x6c/0xac)
[   42.881129] [<80148334>] (__might_sleep) from [<80240d6c>] (__kmalloc+0x210/0x2fc)
[   42.888737] [<80240d6c>] (__kmalloc) from [<8060ad54>] (ncsi_rsp_handler_gc+0xd0/0x170)
[   42.896770] [<8060ad54>] (ncsi_rsp_handler_gc) from [<8060b454>] (ncsi_rcv_rsp+0x16c/0x1d4)
[   42.905314] [<8060b454>] (ncsi_rcv_rsp) from [<804d86c8>] (__netif_receive_skb_core+0x3c8/0xb50)
[   42.914158] [<804d86c8>] (__netif_receive_skb_core) from [<804d96cc>] (__netif_receive_skb+0x20/0x7c)
[   42.923420] [<804d96cc>] (__netif_receive_skb) from [<804de4b0>] (netif_receive_skb_internal+0x78/0x6a4)
[   42.932931] [<804de4b0>] (netif_receive_skb_internal) from [<804df980>] (netif_receive_skb+0x78/0x158)
[   42.942292] [<804df980>] (netif_receive_skb) from [<8042f204>] (ftgmac100_poll+0x43c/0x4e8)
[   42.950855] [<8042f204>] (ftgmac100_poll) from [<804e094c>] (net_rx_action+0x278/0x4c4)
[   42.958918] [<804e094c>] (net_rx_action) from [<801016a8>] (__do_softirq+0xe0/0x4c4)
[   42.966716] [<801016a8>] (__do_softirq) from [<8011cd9c>] (do_softirq.part.4+0x50/0x78)
[   42.974756] [<8011cd9c>] (do_softirq.part.4) from [<8011cebc>] (__local_bh_enable_ip+0xf8/0x11c)
[   42.983579] [<8011cebc>] (__local_bh_enable_ip) from [<804dde08>] (__dev_queue_xmit+0x260/0x890)
[   42.992392] [<804dde08>] (__dev_queue_xmit) from [<804df1f0>] (dev_queue_xmit+0x1c/0x20)
[   43.000689] [<804df1f0>] (dev_queue_xmit) from [<806099c0>] (ncsi_xmit_cmd+0x1c0/0x244)
[   43.008763] [<806099c0>] (ncsi_xmit_cmd) from [<8060dc14>] (ncsi_dev_work+0x2e0/0x4c8)
[   43.016725] [<8060dc14>] (ncsi_dev_work) from [<80133dfc>] (process_one_work+0x214/0x6f8)
[   43.024940] [<80133dfc>] (process_one_work) from [<80134328>] (worker_thread+0x48/0x558)
[   43.033070] [<80134328>] (worker_thread) from [<8013ba80>] (kthread+0x130/0x174)
[   43.040506] [<8013ba80>] (kthread) from [<80102950>] (ret_from_fork+0x14/0x24)

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-rsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index a6b7c7d5c829..930c1d3796f0 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -652,7 +652,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 				      NCSI_CAP_VLAN_MASK;
 
 	size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;
-	nc->mac_filter.addrs = kzalloc(size, GFP_KERNEL);
+	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
 	if (!nc->mac_filter.addrs)
 		return -ENOMEM;
 	nc->mac_filter.n_uc = rsp->uc_cnt;
@@ -661,7 +661,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 
 	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
 				       sizeof(*nc->vlan_filter.vids),
-				       GFP_KERNEL);
+				       GFP_ATOMIC);
 	if (!nc->vlan_filter.vids)
 		return -ENOMEM;
 	/* Set VLAN filters active so they are cleared in the first
-- 
2.17.0
