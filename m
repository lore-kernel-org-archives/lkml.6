Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeBXDcl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 22:32:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752217AbeBXDci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 22:32:38 -0500
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, sergei.shtylyov@cogentembedded.com,
        christoffer.dall@linaro.org, brouer@redhat.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 net 2/3] tuntap: disable preemption during XDP processing
Date: Sat, 24 Feb 2018 11:32:25 +0800
Message-Id: <1519443146-9089-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except for tuntap, all other drivers' XDP was implemented at NAPI
poll() routine in a bh. This guarantees all XDP operation were done at
the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But
for tuntap, we do it in process context and we try to protect XDP
processing by RCU reader lock. This is insufficient since
CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
breaks the assumption that all XDP were processed in the same CPU.

Fixing this by simply disabling preemption during XDP processing.

Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 2823a4a..63d39fe6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1642,6 +1642,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	else
 		*skb_xdp = 0;
 
+	preempt_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog && !*skb_xdp) {
@@ -1665,6 +1666,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
+			preempt_enable();
 			return NULL;
 		case XDP_TX:
 			xdp_xmit = true;
@@ -1686,6 +1688,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		rcu_read_unlock();
+		preempt_enable();
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1698,10 +1701,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		skb->dev = tun->dev;
 		generic_xdp_tx(skb, xdp_prog);
 		rcu_read_unlock();
+		preempt_enable();
 		return NULL;
 	}
 
 	rcu_read_unlock();
+	preempt_enable();
 
 	return skb;
 
@@ -1709,6 +1714,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	put_page(alloc_frag->page);
 err_xdp:
 	rcu_read_unlock();
+	preempt_enable();
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 	return NULL;
 }
-- 
2.7.4
