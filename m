Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCZVXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:23:55 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:38852 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeCZVWJ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:09 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/6] net/ipv4: Update ip_tunnel_metadata_cnt static key to modern api
Date: Mon, 26 Mar 2018 14:09:28 -0700
Message-Id: <20180326210929.5244-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to i2c_trace_msg, for better self
documentation.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/net/ip_tunnels.h  | 4 ++--
 net/ipv4/ip_tunnel_core.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 540a4b4417bf..fc494b48a64a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -466,12 +466,12 @@ static inline struct ip_tunnel_info *lwt_tun_info(struct lwtunnel_state *lwtstat
 	return (struct ip_tunnel_info *)lwtstate->data;
 }
 
-extern struct static_key ip_tunnel_metadata_cnt;
+DECLARE_STATIC_KEY_FALSE(ip_tunnel_metadata_cnt);
 
 /* Returns > 0 if metadata should be collected */
 static inline int ip_tunnel_collect_metadata(void)
 {
-	return static_key_false(&ip_tunnel_metadata_cnt);
+	return static_branch_unlikely(&ip_tunnel_metadata_cnt);
 }
 
 void __init ip_tunnel_core_init(void);
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2f39479be92f..dde671e97829 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -423,17 +423,17 @@ void __init ip_tunnel_core_init(void)
 	lwtunnel_encap_add_ops(&ip6_tun_lwt_ops, LWTUNNEL_ENCAP_IP6);
 }
 
-struct static_key ip_tunnel_metadata_cnt = STATIC_KEY_INIT_FALSE;
+DEFINE_STATIC_KEY_FALSE(ip_tunnel_metadata_cnt);
 EXPORT_SYMBOL(ip_tunnel_metadata_cnt);
 
 void ip_tunnel_need_metadata(void)
 {
-	static_key_slow_inc(&ip_tunnel_metadata_cnt);
+	static_branch_inc(&ip_tunnel_metadata_cnt);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_need_metadata);
 
 void ip_tunnel_unneed_metadata(void)
 {
-	static_key_slow_dec(&ip_tunnel_metadata_cnt);
+	static_branch_dec(&ip_tunnel_metadata_cnt);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_unneed_metadata);
-- 
2.13.6
