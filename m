Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeEHQVz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:21:55 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:55160 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755527AbeEHQVy (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:54 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/6] net: Update [e/in]gress_needed static key to modern api
Date: Tue,  8 May 2018 09:07:00 -0700
Message-Id: <20180508160703.8125-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to both ingress_needed and egress_needed,
for better self documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/core/dev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 019cb1fc1dde..64483afb7b90 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1755,33 +1755,33 @@ int call_netdevice_notifiers(unsigned long val, struct net_device *dev)
 EXPORT_SYMBOL(call_netdevice_notifiers);
 
 #ifdef CONFIG_NET_INGRESS
-static struct static_key ingress_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(ingress_needed_key);
 
 void net_inc_ingress_queue(void)
 {
-	static_key_slow_inc(&ingress_needed);
+	static_branch_inc(&ingress_needed_key);
 }
 EXPORT_SYMBOL_GPL(net_inc_ingress_queue);
 
 void net_dec_ingress_queue(void)
 {
-	static_key_slow_dec(&ingress_needed);
+	static_branch_dec(&ingress_needed_key);
 }
 EXPORT_SYMBOL_GPL(net_dec_ingress_queue);
 #endif
 
 #ifdef CONFIG_NET_EGRESS
-static struct static_key egress_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(egress_needed_key);
 
 void net_inc_egress_queue(void)
 {
-	static_key_slow_inc(&egress_needed);
+	static_branch_inc(&egress_needed_key);
 }
 EXPORT_SYMBOL_GPL(net_inc_egress_queue);
 
 void net_dec_egress_queue(void)
 {
-	static_key_slow_dec(&egress_needed);
+	static_branch_dec(&egress_needed_key);
 }
 EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
@@ -3514,7 +3514,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 #ifdef CONFIG_NET_CLS_ACT
 	skb->tc_at_ingress = 0;
 # ifdef CONFIG_NET_EGRESS
-	if (static_key_false(&egress_needed)) {
+	if (static_branch_unlikely(&egress_needed_key)) {
 		skb = sch_handle_egress(skb, &rc, dev);
 		if (!skb)
 			goto out;
@@ -4548,7 +4548,7 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc)
 
 skip_taps:
 #ifdef CONFIG_NET_INGRESS
-	if (static_key_false(&ingress_needed)) {
+	if (static_branch_unlikely(&ingress_needed_key)) {
 		skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev);
 		if (!skb)
 			goto out;
-- 
2.13.6
