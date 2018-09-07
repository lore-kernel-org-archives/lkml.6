Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4152075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4152075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeIGNLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:11:41 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:31706 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIGNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:11:41 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 330379A934F5E2BBC174;
        Fri,  7 Sep 2018 16:31:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w878VdLj046256;
        Fri, 7 Sep 2018 16:31:40 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018090716314893-7684460 ;
          Fri, 7 Sep 2018 16:31:48 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH] netfilter: masquerade: don't flush all conntracks if only one address deleted on device
Date:   Fri, 7 Sep 2018 16:33:33 +0800
Message-Id: <1536309213-19632-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-09-07 16:31:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-09-07 16:31:24,
        Serialize complete at 2018-09-07 16:31:24
X-MAIL: mse01.zte.com.cn w878VdLj046256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We configured iptables as below, which only allowed incoming data on
established connections:

iptables -t mangle -A PREROUTING -m state --state ESTABLISHED -j ACCEPT
iptables -t mangle -P PREROUTING DROP

When deleting a secondary address, current masquerade implements would
flush all conntracks on this device. All the established connections on
primary address also be deleted, then subsequent incoming data on the
connections would be dropped wrongly because it was identified as NEW
connection.

So when an address was delete, it should only flush connections related
with the address.

Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
---
 net/ipv4/netfilter/nf_nat_masquerade_ipv4.c | 22 +++++++++++++++++++---
 net/ipv6/netfilter/nf_nat_masquerade_ipv6.c | 19 ++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/netfilter/nf_nat_masquerade_ipv4.c b/net/ipv4/netfilter/nf_nat_masquerade_ipv4.c
index ad3aeff..a9d5e01 100644
--- a/net/ipv4/netfilter/nf_nat_masquerade_ipv4.c
+++ b/net/ipv4/netfilter/nf_nat_masquerade_ipv4.c
@@ -104,12 +104,26 @@ static int masq_device_event(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int inet_cmp(struct nf_conn *ct, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct nf_conntrack_tuple *tuple;
+
+	if (!device_cmp(ct, (void *)(long)dev->ifindex))
+		return 0;
+
+	tuple = &ct->tuplehash[IP_CT_DIR_REPLY].tuple;
+
+	return ifa->ifa_address == tuple->dst.u3.ip;
+}
+
 static int masq_inet_event(struct notifier_block *this,
 			   unsigned long event,
 			   void *ptr)
 {
 	struct in_device *idev = ((struct in_ifaddr *)ptr)->ifa_dev;
-	struct netdev_notifier_info info;
+	struct net *net = dev_net(idev->dev);
 
 	/* The masq_dev_notifier will catch the case of the device going
 	 * down.  So if the inetdev is dead and being destroyed we have
@@ -119,8 +133,10 @@ static int masq_inet_event(struct notifier_block *this,
 	if (idev->dead)
 		return NOTIFY_DONE;
 
-	netdev_notifier_info_init(&info, idev->dev);
-	return masq_device_event(this, event, &info);
+	if (event == NETDEV_DOWN)
+		nf_ct_iterate_cleanup_net(net, inet_cmp, ptr, 0, 0);
+
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block masq_dev_notifier = {
diff --git a/net/ipv6/netfilter/nf_nat_masquerade_ipv6.c b/net/ipv6/netfilter/nf_nat_masquerade_ipv6.c
index e6eb7cf..3e4bf22 100644
--- a/net/ipv6/netfilter/nf_nat_masquerade_ipv6.c
+++ b/net/ipv6/netfilter/nf_nat_masquerade_ipv6.c
@@ -87,18 +87,30 @@ static struct notifier_block masq_dev_notifier = {
 struct masq_dev_work {
 	struct work_struct work;
 	struct net *net;
+	struct in6_addr addr;
 	int ifindex;
 };
 
+static int inet_cmp(struct nf_conn *ct, void *work)
+{
+	struct masq_dev_work *w = (struct masq_dev_work *)work;
+	struct nf_conntrack_tuple *tuple;
+
+	if (!device_cmp(ct, (void *)(long)w->ifindex))
+		return 0;
+
+	tuple = &ct->tuplehash[IP_CT_DIR_REPLY].tuple;
+
+	return ipv6_addr_equal(&w->addr, &tuple->dst.u3.in6);
+}
+
 static void iterate_cleanup_work(struct work_struct *work)
 {
 	struct masq_dev_work *w;
-	long index;
 
 	w = container_of(work, struct masq_dev_work, work);
 
-	index = w->ifindex;
-	nf_ct_iterate_cleanup_net(w->net, device_cmp, (void *)index, 0, 0);
+	nf_ct_iterate_cleanup_net(w->net, inet_cmp, (void *)w, 0, 0);
 
 	put_net(w->net);
 	kfree(w);
@@ -147,6 +159,7 @@ static int masq_inet_event(struct notifier_block *this,
 		INIT_WORK(&w->work, iterate_cleanup_work);
 		w->ifindex = dev->ifindex;
 		w->net = net;
+		w->addr = ifa->addr;
 		schedule_work(&w->work);
 
 		return NOTIFY_DONE;
-- 
1.8.3.1

