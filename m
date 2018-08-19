Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64583C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2538D215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538D215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHSKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 06:16:24 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43615 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 06:16:23 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b7916c6970-54351; Sun, 19 Aug 2018 15:05:45 +0800 (CST)
X-RM-TRANSID: 2ee95b7916c6970-54351
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b7916c88cf-d8acd;
        Sun, 19 Aug 2018 15:05:45 +0800 (CST)
X-RM-TRANSID: 2eea5b7916c88cf-d8acd
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH 2/2] ip6_vti: fix creating fallback tunnel device for vti6
Date:   Sun, 19 Aug 2018 15:05:05 +0800
Message-Id: <1534662305-16734-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set fb_tunnels_only_for_init_net to 1, don't create fallback tunnel
device for vti6 when a new namespace is created.

Tested:
[root@builder2 ~]# modprobe ip6_tunnel
[root@builder2 ~]# modprobe ip6_vti
[root@builder2 ~]# echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
[root@builder2 ~]# unshare -n
[root@builder2 ~]# ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group
default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/ip6_vti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index c72ae3a..3b9f39f 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1114,6 +1114,8 @@ static int __net_init vti6_init_net(struct net *net)
 	ip6n->tnls[0] = ip6n->tnls_wc;
 	ip6n->tnls[1] = ip6n->tnls_r_l;
 
+	if (!net_has_fallback_tunnels(net))
+		return 0;
 	err = -ENOMEM;
 	ip6n->fb_tnl_dev = alloc_netdev(sizeof(struct ip6_tnl), "ip6_vti0",
 					NET_NAME_UNKNOWN, vti6_dev_setup);
-- 
1.8.3.1



