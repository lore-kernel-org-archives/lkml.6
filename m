Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E21C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8177720881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8177720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeIMTAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbeIMTAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76CFBD10;
        Thu, 13 Sep 2018 13:51:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 021/197] erspan: set erspan_ver to 1 by default when adding an erspan dev
Date:   Thu, 13 Sep 2018 15:29:30 +0200
Message-Id: <20180913131842.412239756@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 84581bdae9587023cea1d139523f0ef0f28bd88d ]

After erspan_ver is introudced, if erspan_ver is not set in iproute, its
value will be left 0 by default. Since Commit 02f99df1875c ("erspan: fix
invalid erspan version."), it has broken the traffic due to the version
check in erspan_xmit if users are not aware of 'erspan_ver' param, like
using an old version of iproute.

To fix this compatibility problem, it sets erspan_ver to 1 by default
when adding an erspan dev in erspan_setup. Note that we can't do it in
ipgre_netlink_parms, as this function is also used by ipgre_changelink.

Fixes: 02f99df1875c ("erspan: fix invalid erspan version.")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c  |    3 +++
 net/ipv6/ip6_gre.c |    1 +
 2 files changed, 4 insertions(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1511,11 +1511,14 @@ nla_put_failure:
 
 static void erspan_setup(struct net_device *dev)
 {
+	struct ip_tunnel *t = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->netdev_ops = &erspan_netdev_ops;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	ip_tunnel_setup(dev, erspan_net_id);
+	t->erspan_ver = 1;
 }
 
 static const struct nla_policy ipgre_policy[IFLA_GRE_MAX + 1] = {
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1776,6 +1776,7 @@ static void ip6gre_netlink_parms(struct
 	if (data[IFLA_GRE_COLLECT_METADATA])
 		parms->collect_md = true;
 
+	parms->erspan_ver = 1;
 	if (data[IFLA_GRE_ERSPAN_VER])
 		parms->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
 


