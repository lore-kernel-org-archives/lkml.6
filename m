Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeEHQW7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:22:59 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:44861 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbeEHQVy (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:54 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/6] net: Update generic_xdp_needed static key to modern api
Date: Tue,  8 May 2018 09:07:02 -0700
Message-Id: <20180508160703.8125-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to generic_xdp_needed, for better self
documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/core/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 668be88b5308..1a8c0bb44e28 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4136,7 +4136,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 }
 EXPORT_SYMBOL_GPL(generic_xdp_tx);
 
-static struct static_key generic_xdp_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 {
@@ -4176,7 +4176,7 @@ static int netif_rx_internal(struct sk_buff *skb)
 
 	trace_netif_rx(skb);
 
-	if (static_key_false(&generic_xdp_needed)) {
+	if (static_branch_unlikely(&generic_xdp_needed_key)) {
 		int ret;
 
 		preempt_disable();
@@ -4708,9 +4708,9 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			bpf_prog_put(old);
 
 		if (old && !new) {
-			static_key_slow_dec(&generic_xdp_needed);
+			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
-			static_key_slow_inc(&generic_xdp_needed);
+			static_branch_inc(&generic_xdp_needed_key);
 			dev_disable_lro(dev);
 			dev_disable_gro_hw(dev);
 		}
@@ -4738,7 +4738,7 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
 	if (skb_defer_rx_timestamp(skb))
 		return NET_RX_SUCCESS;
 
-	if (static_key_false(&generic_xdp_needed)) {
+	if (static_branch_unlikely(&generic_xdp_needed_key)) {
 		int ret;
 
 		preempt_disable();
-- 
2.13.6
