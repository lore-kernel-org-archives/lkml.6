Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeEHQVw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:21:52 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:41951 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755503AbeEHQVo (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:44 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/6] net/ipv4: Update ip_tunnel_metadata_cnt static key to modern api
Date: Tue,  8 May 2018 09:06:58 -0700
Message-Id: <20180508160703.8125-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/net/ip_tunnels.h  | 4 ++--
 net/ipv4/ip_tunnel_core.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 751646adc769..90ff430f5e9d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -477,12 +477,12 @@ static inline struct ip_tunnel_info *lwt_tun_info(struct lwtunnel_state *lwtstat
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
