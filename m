Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8B6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33573204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33573204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbeIMTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeIMTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F65FD19;
        Thu, 13 Sep 2018 13:55:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Mamedov <rm@romanrm.net>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 069/197] netfilter: ip6t_rpfilter: set F_IFACE for linklocal addresses
Date:   Thu, 13 Sep 2018 15:30:18 +0200
Message-Id: <20180913131844.281026884@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit da786717e0894886301ed2536843c13f9e8fd53e ]

Roman reports that DHCPv6 client no longer sees replies from server
due to

ip6tables -t raw -A PREROUTING -m rpfilter --invert -j DROP

rule.  We need to set the F_IFACE flag for linklocal addresses, they
are scoped per-device.

Fixes: 47b7e7f82802 ("netfilter: don't set F_IFACE on ipv6 fib lookups")
Reported-by: Roman Mamedov <rm@romanrm.net>
Tested-by: Roman Mamedov <rm@romanrm.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/netfilter/ip6t_rpfilter.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -26,6 +26,12 @@ static bool rpfilter_addr_unicast(const
 	return addr_type & IPV6_ADDR_UNICAST;
 }
 
+static bool rpfilter_addr_linklocal(const struct in6_addr *addr)
+{
+	int addr_type = ipv6_addr_type(addr);
+	return addr_type & IPV6_ADDR_LINKLOCAL;
+}
+
 static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 				     const struct net_device *dev, u8 flags)
 {
@@ -48,7 +54,11 @@ static bool rpfilter_lookup_reverse6(str
 	}
 
 	fl6.flowi6_mark = flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
-	if ((flags & XT_RPFILTER_LOOSE) == 0)
+
+	if (rpfilter_addr_linklocal(&iph->saddr)) {
+		lookup_flags |= RT6_LOOKUP_F_IFACE;
+		fl6.flowi6_oif = dev->ifindex;
+	} else if ((flags & XT_RPFILTER_LOOSE) == 0)
 		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);


