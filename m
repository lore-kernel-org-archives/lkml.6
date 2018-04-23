Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbeDWVhY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:37:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40480 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeDWVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:37:19 -0400
X-Google-Smtp-Source: AIpwx4+eOPFUMj3+kwV+SK1R4VMSPegMzSi5UPNVWjenH13hBfM/PQW3MGnZQB+Mx7yuYfqiwltwYQ==
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: davem@davemloft.net, dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [net-next 1/2] ipv6: sr: add a per namespace sysctl to control seg6 flowlabel
Date: Mon, 23 Apr 2018 23:36:59 +0200
Message-Id: <1524519420-1612-1-git-send-email-amsalam20@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a per namespace sysctl, named 'seg6_flowlabel', to be used
by seg6_do_srh_encap() to control the behaviour of setting the flowlabel
value of outer IPv6.

The currently support behaviours are as follows:
-1 set flowlabel to zero.
 0 copy flowlabel from Inner paceket in case of Inner IPv6 (0 for IPv4/L2)
 1 Compute the flowlabel using seg6_make_flowlabel()

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 include/net/netns/ipv6.h   | 1 +
 net/ipv6/sysctl_net_ipv6.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 97b3a54..c978a31 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -43,6 +43,7 @@ struct netns_sysctl_ipv6 {
 	int max_hbh_opts_cnt;
 	int max_dst_opts_len;
 	int max_hbh_opts_len;
+	int seg6_flowlabel;
 };
 
 struct netns_ipv6 {
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 6fbdef6..e15cd37 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -152,6 +152,13 @@ static struct ctl_table ipv6_table_template[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+	{
+		.procname	= "seg6_flowlabel",
+		.data		= &init_net.ipv6.sysctl.seg6_flowlabel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
 	{ }
 };
 
@@ -217,6 +224,7 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	ipv6_table[12].data = &net->ipv6.sysctl.max_dst_opts_len;
 	ipv6_table[13].data = &net->ipv6.sysctl.max_hbh_opts_len;
 	ipv6_table[14].data = &net->ipv6.sysctl.multipath_hash_policy,
+	ipv6_table[15].data = &net->ipv6.sysctl.seg6_flowlabel;
 
 	ipv6_route_table = ipv6_route_sysctl_init(net);
 	if (!ipv6_route_table)
-- 
2.1.4
