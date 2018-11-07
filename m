Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2792081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GzhcDwDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2792081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbeKGXUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:20:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeKGXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:20:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so12337080wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTtCONszpli1DJ1qUjvSwAhBTvTC5D45YpOl9oonXmw=;
        b=GzhcDwDOXzujAkhVxq5l0PEDGU3DCktMY2n6nAI4knP0WOejLJOH+DCoE3gjwYXZQE
         KnbpZh3fBIyxIySCT4QaRaxbtRnKmWN8BXQTyCGJGGOstuH6ggs5GRSJPwgnKPP8VQzo
         c2XMh5YUDNWBDgep08Paq9ZPEQYxsE2+nAkJ/waHtIntXNpJBAv+EiVl9FX6kYVObSIE
         WiuTINmx2i/P3YvowSx1z/XhZfBghuC5VnA6nqQ7XL6jVQ7F1n7CoCoNON4yG3tFOKB/
         vdaolVt32oSL7IO4JYKW0A571tm8r8sYkQujHTC8qNfopk7+0QLcrHlrJhuBjCvhTd2c
         PDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTtCONszpli1DJ1qUjvSwAhBTvTC5D45YpOl9oonXmw=;
        b=IQ/Bn7zG++71HJQNAtbtla852GSsdX+o/8sR6CWhrbPq3LCNdgmY2jMFiatCAxLx9s
         7UEHAF/J8SeEd5RErr0IPFXu1rpVTyTWFd9eE8GvIkVXCIDBQfpn/t/AfiHumnZFu8bi
         LENEWbzuDAPBmlbKLIWiWeVUqm9B865aLLpuMQaexltIr3E8XU1TVPDLE2CckHOUZY+x
         x94TbMACA9qFwWbS35HAONWgRsvSWfPEIeWpwEdPPEgFJ0qJLCd1dT/gn+NDPY+DSenk
         HGQsU4gYGVIgxlo5z3Xfqtm6A22MwP3mqMSpYryeyL9DO5rO9vy9HzhiHltrctgIJCc4
         nbBg==
X-Gm-Message-State: AGRZ1gLeZLPavK1qNs3T6B36wp4xE6/rqIWsMNX1oWh1N2bOfUyDoQ++
        jngW2n5eqvCyVy64e3G5Iz+BEA==
X-Google-Smtp-Source: AJdET5f0fdCFCSIs3qokoLCdF08hKXdT42siQrR+qiJlt0VWbo7oeHsumBSMg0MMkuE0rXW1hbnTiQ==
X-Received: by 2002:adf:e70d:: with SMTP id c13-v6mr309341wrm.50.1541598571626;
        Wed, 07 Nov 2018 05:49:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8070:8895:9700:887:8ecc:df73:24eb])
        by smtp.gmail.com with ESMTPSA id y83-v6sm1206778wmb.20.2018.11.07.05.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:49:31 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org
Cc:     tyhicks@canonical.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 1/2] br_netfilter: add struct netns_brnf
Date:   Wed,  7 Nov 2018 14:48:58 +0100
Message-Id: <20181107134859.19896-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107134859.19896-1-christian@brauner.io>
References: <20181107134859.19896-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds struct netns_brnf in preparation for per-network-namespace
br_netfilter settings. The individual br_netfilter sysctl options are moved
into a central place in struct net. The struct is only included when
the CONFIG_BRIDGE_NETFILTER kconfig option is enabled in the kernel.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/net/net_namespace.h     |  3 ++
 include/net/netns/netfilter.h   | 16 ++++++++
 net/bridge/br_netfilter_hooks.c | 68 ++++++++++++++++-----------------
 3 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 99d4148e0f90..bea0474cd3ea 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -125,6 +125,9 @@ struct net {
 #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
 	struct netns_ct		ct;
 #endif
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	struct netns_brnf	brnf;
+#endif
 #if defined(CONFIG_NF_TABLES) || defined(CONFIG_NF_TABLES_MODULE)
 	struct netns_nftables	nft;
 #endif
diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index ca043342c0eb..eedbd1ac940e 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -35,4 +35,20 @@ struct netns_nf {
 	bool			defrag_ipv6;
 #endif
 };
+
+struct netns_brnf {
+#ifdef CONFIG_SYSCTL
+	struct ctl_table_header *ctl_hdr;
+#endif
+
+	/* default value is 1 */
+	int call_iptables;
+	int call_ip6tables;
+	int call_arptables;
+
+	/* default value is 0 */
+	int filter_vlan_tagged;
+	int filter_pppoe_tagged;
+	int pass_vlan_indev;
+};
 #endif
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index b1b5e8516724..656a084f4825 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -53,23 +53,6 @@ struct brnf_net {
 	bool enabled;
 };
 
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_header *brnf_sysctl_header;
-static int brnf_call_iptables __read_mostly = 1;
-static int brnf_call_ip6tables __read_mostly = 1;
-static int brnf_call_arptables __read_mostly = 1;
-static int brnf_filter_vlan_tagged __read_mostly;
-static int brnf_filter_pppoe_tagged __read_mostly;
-static int brnf_pass_vlan_indev __read_mostly;
-#else
-#define brnf_call_iptables 1
-#define brnf_call_ip6tables 1
-#define brnf_call_arptables 1
-#define brnf_filter_vlan_tagged 0
-#define brnf_filter_pppoe_tagged 0
-#define brnf_pass_vlan_indev 0
-#endif
-
 #define IS_IP(skb) \
 	(!skb_vlan_tag_present(skb) && skb->protocol == htons(ETH_P_IP))
 
@@ -91,15 +74,15 @@ static inline __be16 vlan_proto(const struct sk_buff *skb)
 
 #define IS_VLAN_IP(skb) \
 	(vlan_proto(skb) == htons(ETH_P_IP) && \
-	 brnf_filter_vlan_tagged)
+	 init_net.brnf.filter_vlan_tagged)
 
 #define IS_VLAN_IPV6(skb) \
 	(vlan_proto(skb) == htons(ETH_P_IPV6) && \
-	 brnf_filter_vlan_tagged)
+	 init_net.brnf.filter_vlan_tagged)
 
 #define IS_VLAN_ARP(skb) \
 	(vlan_proto(skb) == htons(ETH_P_ARP) &&	\
-	 brnf_filter_vlan_tagged)
+	 init_net.brnf.filter_vlan_tagged)
 
 static inline __be16 pppoe_proto(const struct sk_buff *skb)
 {
@@ -110,12 +93,12 @@ static inline __be16 pppoe_proto(const struct sk_buff *skb)
 #define IS_PPPOE_IP(skb) \
 	(skb->protocol == htons(ETH_P_PPP_SES) && \
 	 pppoe_proto(skb) == htons(PPP_IP) && \
-	 brnf_filter_pppoe_tagged)
+	 init_net.brnf.filter_pppoe_tagged)
 
 #define IS_PPPOE_IPV6(skb) \
 	(skb->protocol == htons(ETH_P_PPP_SES) && \
 	 pppoe_proto(skb) == htons(PPP_IPV6) && \
-	 brnf_filter_pppoe_tagged)
+	 init_net.brnf.filter_pppoe_tagged)
 
 /* largest possible L2 header, see br_nf_dev_queue_xmit() */
 #define NF_BRIDGE_MAX_MAC_HEADER_LENGTH (PPPOE_SES_HLEN + ETH_HLEN)
@@ -430,7 +413,7 @@ static struct net_device *brnf_get_logical_dev(struct sk_buff *skb, const struct
 	struct net_device *vlan, *br;
 
 	br = bridge_parent(dev);
-	if (brnf_pass_vlan_indev == 0 || !skb_vlan_tag_present(skb))
+	if (init_net.brnf.pass_vlan_indev == 0 || !skb_vlan_tag_present(skb))
 		return br;
 
 	vlan = __vlan_find_dev_deep_rcu(br, skb->vlan_proto,
@@ -487,7 +470,7 @@ static unsigned int br_nf_pre_routing(void *priv,
 	br = p->br;
 
 	if (IS_IPV6(skb) || IS_VLAN_IPV6(skb) || IS_PPPOE_IPV6(skb)) {
-		if (!brnf_call_ip6tables &&
+		if (!init_net.brnf.call_ip6tables &&
 		    !br_opt_get(br, BROPT_NF_CALL_IP6TABLES))
 			return NF_ACCEPT;
 
@@ -495,7 +478,8 @@ static unsigned int br_nf_pre_routing(void *priv,
 		return br_nf_pre_routing_ipv6(priv, skb, state);
 	}
 
-	if (!brnf_call_iptables && !br_opt_get(br, BROPT_NF_CALL_IPTABLES))
+	if (!init_net.brnf.call_iptables &&
+	    !br_opt_get(br, BROPT_NF_CALL_IPTABLES))
 		return NF_ACCEPT;
 
 	if (!IS_IP(skb) && !IS_VLAN_IP(skb) && !IS_PPPOE_IP(skb))
@@ -637,7 +621,8 @@ static unsigned int br_nf_forward_arp(void *priv,
 		return NF_ACCEPT;
 	br = p->br;
 
-	if (!brnf_call_arptables && !br_opt_get(br, BROPT_NF_CALL_ARPTABLES))
+	if (!init_net.brnf.call_arptables &&
+	    !br_opt_get(br, BROPT_NF_CALL_ARPTABLES))
 		return NF_ACCEPT;
 
 	if (!IS_ARP(skb)) {
@@ -1032,42 +1017,42 @@ int brnf_sysctl_call_tables(struct ctl_table *ctl, int write,
 static struct ctl_table brnf_table[] = {
 	{
 		.procname	= "bridge-nf-call-arptables",
-		.data		= &brnf_call_arptables,
+		.data		= &init_net.brnf.call_arptables,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
 	{
 		.procname	= "bridge-nf-call-iptables",
-		.data		= &brnf_call_iptables,
+		.data		= &init_net.brnf.call_iptables,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
 	{
 		.procname	= "bridge-nf-call-ip6tables",
-		.data		= &brnf_call_ip6tables,
+		.data		= &init_net.brnf.call_ip6tables,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
 	{
 		.procname	= "bridge-nf-filter-vlan-tagged",
-		.data		= &brnf_filter_vlan_tagged,
+		.data		= &init_net.brnf.filter_vlan_tagged,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
 	{
 		.procname	= "bridge-nf-filter-pppoe-tagged",
-		.data		= &brnf_filter_pppoe_tagged,
+		.data		= &init_net.brnf.filter_pppoe_tagged,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
 	{
 		.procname	= "bridge-nf-pass-vlan-input-dev",
-		.data		= &brnf_pass_vlan_indev,
+		.data		= &init_net.brnf.pass_vlan_indev,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
@@ -1076,6 +1061,16 @@ static struct ctl_table brnf_table[] = {
 };
 #endif
 
+static inline void br_netfilter_sysctl_default(struct netns_brnf *brnf)
+{
+	brnf->call_iptables = 1;
+	brnf->call_ip6tables = 1;
+	brnf->call_arptables = 1;
+	brnf->filter_vlan_tagged = 0;
+	brnf->filter_pppoe_tagged = 0;
+	brnf->pass_vlan_indev = 0;
+}
+
 static int __init br_netfilter_init(void)
 {
 	int ret;
@@ -1090,9 +1085,12 @@ static int __init br_netfilter_init(void)
 		return ret;
 	}
 
+	/* Always set default values. Even if CONFIG_SYSCTL is not set. */
+	br_netfilter_sysctl_default(&init_net.brnf);
+
 #ifdef CONFIG_SYSCTL
-	brnf_sysctl_header = register_net_sysctl(&init_net, "net/bridge", brnf_table);
-	if (brnf_sysctl_header == NULL) {
+	init_net.brnf.ctl_hdr = register_net_sysctl(&init_net, "net/bridge", brnf_table);
+	if (!init_net.brnf.ctl_hdr) {
 		printk(KERN_WARNING
 		       "br_netfilter: can't register to sysctl.\n");
 		unregister_netdevice_notifier(&brnf_notifier);
@@ -1111,7 +1109,7 @@ static void __exit br_netfilter_fini(void)
 	unregister_netdevice_notifier(&brnf_notifier);
 	unregister_pernet_subsys(&brnf_net_ops);
 #ifdef CONFIG_SYSCTL
-	unregister_net_sysctl_table(brnf_sysctl_header);
+	unregister_net_sysctl_table(init_net.brnf.ctl_hdr);
 #endif
 }
 
-- 
2.19.1

