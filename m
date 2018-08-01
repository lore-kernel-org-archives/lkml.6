Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51CC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9617208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9617208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeHADrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:47:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732970AbeHADrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:47:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4E02F37C50F7;
        Wed,  1 Aug 2018 10:04:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 10:04:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ip_gre: remove redundant variables t_hlen
Date:   Wed, 1 Aug 2018 10:04:02 +0800
Message-ID: <20180801020402.16448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ffc2b6ee4174 ("ip_gre: fix IFLA_MTU ignored on NEWLINK")
variable t_hlen is assigned values that are never read,
hence they are redundant and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ipv4/ip_gre.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index c8ca5d8..51a5d06 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -985,7 +985,6 @@ static void ipgre_tunnel_setup(struct net_device *dev)
 static void __gre_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel;
-	int t_hlen;
 
 	tunnel = netdev_priv(dev);
 	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
@@ -993,8 +992,6 @@ static void __gre_tunnel_init(struct net_device *dev)
 
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 
-	t_hlen = tunnel->hlen + sizeof(struct iphdr);
-
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 
@@ -1304,13 +1301,11 @@ static const struct net_device_ops gre_tap_netdev_ops = {
 static int erspan_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	int t_hlen;
 
 	tunnel->tun_hlen = 8;
 	tunnel->parms.iph.protocol = IPPROTO_GRE;
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
 		       erspan_hdr_len(tunnel->erspan_ver);
-	t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
-- 
2.7.0


