Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeC2DuM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:50:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38656 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeC2DuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:50:10 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, paul.durrant@citrix.com, wei.liu2@citrix.com
Subject: [PATCH v2 1/1] xen-netback: process malformed sk_buff correctly to avoid BUG_ON()
Date: Thu, 29 Mar 2018 11:51:03 +0800
Message-Id: <1522295463-469-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "BUG_ON(!frag_iter)" in function xenvif_rx_next_chunk() is triggered if
the received sk_buff is malformed, that is, when the sk_buff has pattern
(skb->data_len && !skb_shinfo(skb)->nr_frags). Below is a sample call
stack:

[  438.652658] ------------[ cut here ]------------
[  438.652660] kernel BUG at drivers/net/xen-netback/rx.c:325!
[  438.652714] invalid opcode: 0000 [#1] SMP NOPTI
[  438.652813] CPU: 0 PID: 2492 Comm: vif1.0-q0-guest Tainted: G           O     4.16.0-rc6+ #1
[  438.652896] RIP: e030:xenvif_rx_skb+0x3c2/0x5e0 [xen_netback]
[  438.652926] RSP: e02b:ffffc90040877dc8 EFLAGS: 00010246
[  438.652956] RAX: 0000000000000160 RBX: 0000000000000022 RCX: 0000000000000001
[  438.652993] RDX: ffffc900402890d0 RSI: 0000000000000000 RDI: ffffc90040889000
[  438.653029] RBP: ffff88002b460040 R08: ffffc90040877de0 R09: 0100000000000000
[  438.653065] R10: 0000000000007ff0 R11: 0000000000000002 R12: ffffc90040889000
[  438.653100] R13: ffffffff80000000 R14: 0000000000000022 R15: 0000000080000000
[  438.653149] FS:  00007f15603778c0(0000) GS:ffff880030400000(0000) knlGS:0000000000000000
[  438.653188] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.653219] CR2: 0000000001832a08 CR3: 0000000029c12000 CR4: 0000000000042660
[  438.653262] Call Trace:
[  438.653284]  ? xen_hypercall_event_channel_op+0xa/0x20
[  438.653313]  xenvif_rx_action+0x41/0x80 [xen_netback]
[  438.653341]  xenvif_kthread_guest_rx+0xb2/0x2a8 [xen_netback]
[  438.653374]  ? __schedule+0x352/0x700
[  438.653398]  ? wait_woken+0x80/0x80
[  438.653421]  kthread+0xf3/0x130
[  438.653442]  ? xenvif_rx_action+0x80/0x80 [xen_netback]
[  438.653470]  ? kthread_destroy_worker+0x40/0x40
[  438.653497]  ret_from_fork+0x35/0x40

The issue is hit by xen-netback when there is bug with other networking
interface (e.g., dom0 physical NIC), who has generated and forwarded
malformed sk_buff to dom0 vifX.Y. It is possible to reproduce the issue on
purpose with below sample code in a kernel module:

skb->dev = dev; // dev of vifX.Y
skb->len = 386;
skb->data_len = 352;
skb->tail = 98;
skb->end = 384;
skb_shinfo(skb)->nr_frags = 0;
dev->netdev_ops->ndo_start_xmit(skb, dev);

This patch stops processing sk_buff immediately if it is detected as
malformed, that is, pkt->frag_iter is NULL but there is still remaining
pkt->remaining_len.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

---
Changed since v1:
  * return XEN_NETIF_RSP_ERROR in response to netfront

 drivers/net/xen-netback/rx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index b1cf7c6..a3d8ee9 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -358,6 +358,7 @@ static void xenvif_rx_data_slot(struct xenvif_queue *queue,
 {
 	unsigned int offset = 0;
 	unsigned int flags;
+	bool err = false;
 
 	do {
 		size_t len;
@@ -369,6 +370,15 @@ static void xenvif_rx_data_slot(struct xenvif_queue *queue,
 		offset += len;
 		pkt->remaining_len -= len;
 
+		if (unlikely(!pkt->frag_iter && pkt->remaining_len)) {
+			pkt->remaining_len = 0;
+			pkt->extra_count = 0;
+			err = true;
+			pr_err_ratelimited("malformed sk_buff at %s\n",
+					   queue->name);
+			break;
+		}
+
 	} while (offset < XEN_PAGE_SIZE && pkt->remaining_len > 0);
 
 	if (pkt->remaining_len > 0)
@@ -392,7 +402,7 @@ static void xenvif_rx_data_slot(struct xenvif_queue *queue,
 	rsp->offset = 0;
 	rsp->flags = flags;
 	rsp->id = req->id;
-	rsp->status = (s16)offset;
+	rsp->status = likely(!err) ? (s16)offset : XEN_NETIF_RSP_ERROR;
 }
 
 static void xenvif_rx_extra_slot(struct xenvif_queue *queue,
-- 
2.7.4
