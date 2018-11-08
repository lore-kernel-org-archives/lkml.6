Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6350C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6388220857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5I467gG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6388220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeKIIDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeKIHk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:59 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78D320883;
        Thu,  8 Nov 2018 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714609;
        bh=3FGUR8ll+H5x3rMFSEi1iIPvB2jDzaIWYWpZIcRq8Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5I467gG/8b+oaQUj5TPM0UVjq+j96qir1xMRwk/dj9lgKXKp6vE+zsd0o/zJswBI
         cJPpuYmGiSlCk025Tq9X23PC/Zp9PLLZnJifLN+Nc86rsOWwXNnqTKU4mIbGu9EoHF
         +aILQL1QUcK5AvOlWuaeOU611Dycr9eyH4Mhikus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 043/171] ipv6: set rt6i_protocol properly in the route when it is installed
Date:   Thu,  8 Nov 2018 13:50:13 -0800
Message-Id: <20181108215130.617964727@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b91d532928dff2141ea9c107c3e73104d9843767 ]

After commit c2ed1880fd61 ("net: ipv6: check route protocol when
deleting routes"), ipv6 route checks rt protocol when trying to
remove a rt entry.

It introduced a side effect causing 'ip -6 route flush cache' not
to work well. When flushing caches with iproute, all route caches
get dumped from kernel then removed one by one by sending DELROUTE
requests to kernel for each cache.

The thing is iproute sends the request with the cache whose proto
is set with RTPROT_REDIRECT by rt6_fill_node() when kernel dumps
it. But in kernel the rt_cache protocol is still 0, which causes
the cache not to be matched and removed.

So the real reason is rt6i_protocol in the route is not set when
it is allocated. As David Ahern's suggestion, this patch is to
set rt6i_protocol properly in the route when it is installed and
remove the codes setting rtm_protocol according to rt6i_flags in
rt6_fill_node.

This is also an improvement to keep rt6i_protocol consistent with
rtm_protocol.

Fixes: c2ed1880fd61 ("net: ipv6: check route protocol when deleting routes")
Reported-by: Jianlin Shi <jishi@redhat.com>
Suggested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 70fa31e37360..4cc12eeca7ab 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2289,6 +2289,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	if (on_link)
 		nrt->rt6i_flags &= ~RTF_GATEWAY;
 
+	nrt->rt6i_protocol = RTPROT_REDIRECT;
 	nrt->rt6i_gateway = *(struct in6_addr *)neigh->primary_key;
 
 	if (ip6_ins_rt(nrt))
@@ -2393,6 +2394,7 @@ static struct rt6_info *rt6_add_route_info(struct net *net,
 		.fc_dst_len	= prefixlen,
 		.fc_flags	= RTF_GATEWAY | RTF_ADDRCONF | RTF_ROUTEINFO |
 				  RTF_UP | RTF_PREF(pref),
+		.fc_protocol = RTPROT_RA,
 		.fc_nlinfo.portid = 0,
 		.fc_nlinfo.nlh = NULL,
 		.fc_nlinfo.nl_net = net,
@@ -2445,6 +2447,7 @@ struct rt6_info *rt6_add_dflt_router(const struct in6_addr *gwaddr,
 		.fc_ifindex	= dev->ifindex,
 		.fc_flags	= RTF_GATEWAY | RTF_ADDRCONF | RTF_DEFAULT |
 				  RTF_UP | RTF_EXPIRES | RTF_PREF(pref),
+		.fc_protocol = RTPROT_RA,
 		.fc_nlinfo.portid = 0,
 		.fc_nlinfo.nlh = NULL,
 		.fc_nlinfo.nl_net = dev_net(dev),
@@ -3241,14 +3244,6 @@ static int rt6_fill_node(struct net *net,
 	}
 	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
 	rtm->rtm_protocol = rt->rt6i_protocol;
-	if (rt->rt6i_flags & RTF_DYNAMIC)
-		rtm->rtm_protocol = RTPROT_REDIRECT;
-	else if (rt->rt6i_flags & RTF_ADDRCONF) {
-		if (rt->rt6i_flags & (RTF_DEFAULT | RTF_ROUTEINFO))
-			rtm->rtm_protocol = RTPROT_RA;
-		else
-			rtm->rtm_protocol = RTPROT_KERNEL;
-	}
 
 	if (rt->rt6i_flags & RTF_CACHE)
 		rtm->rtm_flags |= RTM_F_CLONED;
-- 
2.17.1



