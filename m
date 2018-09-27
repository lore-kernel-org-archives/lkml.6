Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A88C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0649E21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0649E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeI0PZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA0CE1116;
        Thu, 27 Sep 2018 09:07:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 19/88] ipv6: use rt6_info members when dst is set in rt6_fill_node
Date:   Thu, 27 Sep 2018 11:03:00 +0200
Message-Id: <20180927090302.801598281@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

[ Upstream commit 22d0bd82cc7cec7d9ed4bd5913f3ab65643364be ]

In inet6_rtm_getroute, since Commit 93531c674315 ("net/ipv6: separate
handling of FIB entries from dst based routes"), it has used rt->from
to dump route info instead of rt.

However for some route like cache, some of its information like flags
or gateway is not the same as that of the 'from' one. It caused 'ip
route get' to dump the wrong route information.

In Jianlin's testing, the output information even lost the expiration
time for a pmtu route cache due to the wrong fib6_flags.

So change to use rt6_info members for dst addr, src addr, flags and
gateway when it tries to dump a route entry without fibmatch set.

v1->v2:
  - not use rt6i_prefsrc.
  - also fix the gw dump issue.

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4670,20 +4670,31 @@ static int rt6_fill_node(struct net *net
 			 int iif, int type, u32 portid, u32 seq,
 			 unsigned int flags)
 {
-	struct rtmsg *rtm;
+	struct rt6_info *rt6 = (struct rt6_info *)dst;
+	struct rt6key *rt6_dst, *rt6_src;
+	u32 *pmetrics, table, rt6_flags;
 	struct nlmsghdr *nlh;
+	struct rtmsg *rtm;
 	long expires = 0;
-	u32 *pmetrics;
-	u32 table;
 
 	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*rtm), flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
+	if (rt6) {
+		rt6_dst = &rt6->rt6i_dst;
+		rt6_src = &rt6->rt6i_src;
+		rt6_flags = rt6->rt6i_flags;
+	} else {
+		rt6_dst = &rt->fib6_dst;
+		rt6_src = &rt->fib6_src;
+		rt6_flags = rt->fib6_flags;
+	}
+
 	rtm = nlmsg_data(nlh);
 	rtm->rtm_family = AF_INET6;
-	rtm->rtm_dst_len = rt->fib6_dst.plen;
-	rtm->rtm_src_len = rt->fib6_src.plen;
+	rtm->rtm_dst_len = rt6_dst->plen;
+	rtm->rtm_src_len = rt6_src->plen;
 	rtm->rtm_tos = 0;
 	if (rt->fib6_table)
 		table = rt->fib6_table->tb6_id;
@@ -4698,7 +4709,7 @@ static int rt6_fill_node(struct net *net
 	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
 	rtm->rtm_protocol = rt->fib6_protocol;
 
-	if (rt->fib6_flags & RTF_CACHE)
+	if (rt6_flags & RTF_CACHE)
 		rtm->rtm_flags |= RTM_F_CLONED;
 
 	if (dest) {
@@ -4706,7 +4717,7 @@ static int rt6_fill_node(struct net *net
 			goto nla_put_failure;
 		rtm->rtm_dst_len = 128;
 	} else if (rtm->rtm_dst_len)
-		if (nla_put_in6_addr(skb, RTA_DST, &rt->fib6_dst.addr))
+		if (nla_put_in6_addr(skb, RTA_DST, &rt6_dst->addr))
 			goto nla_put_failure;
 #ifdef CONFIG_IPV6_SUBTREES
 	if (src) {
@@ -4714,12 +4725,12 @@ static int rt6_fill_node(struct net *net
 			goto nla_put_failure;
 		rtm->rtm_src_len = 128;
 	} else if (rtm->rtm_src_len &&
-		   nla_put_in6_addr(skb, RTA_SRC, &rt->fib6_src.addr))
+		   nla_put_in6_addr(skb, RTA_SRC, &rt6_src->addr))
 		goto nla_put_failure;
 #endif
 	if (iif) {
 #ifdef CONFIG_IPV6_MROUTE
-		if (ipv6_addr_is_multicast(&rt->fib6_dst.addr)) {
+		if (ipv6_addr_is_multicast(&rt6_dst->addr)) {
 			int err = ip6mr_get_route(net, skb, rtm, portid);
 
 			if (err == 0)
@@ -4754,7 +4765,14 @@ static int rt6_fill_node(struct net *net
 	/* For multipath routes, walk the siblings list and add
 	 * each as a nexthop within RTA_MULTIPATH.
 	 */
-	if (rt->fib6_nsiblings) {
+	if (rt6) {
+		if (rt6_flags & RTF_GATEWAY &&
+		    nla_put_in6_addr(skb, RTA_GATEWAY, &rt6->rt6i_gateway))
+			goto nla_put_failure;
+
+		if (dst->dev && nla_put_u32(skb, RTA_OIF, dst->dev->ifindex))
+			goto nla_put_failure;
+	} else if (rt->fib6_nsiblings) {
 		struct fib6_info *sibling, *next_sibling;
 		struct nlattr *mp;
 
@@ -4777,7 +4795,7 @@ static int rt6_fill_node(struct net *net
 			goto nla_put_failure;
 	}
 
-	if (rt->fib6_flags & RTF_EXPIRES) {
+	if (rt6_flags & RTF_EXPIRES) {
 		expires = dst ? dst->expires : rt->expires;
 		expires -= jiffies;
 	}
@@ -4785,7 +4803,7 @@ static int rt6_fill_node(struct net *net
 	if (rtnl_put_cacheinfo(skb, dst, 0, expires, dst ? dst->error : 0) < 0)
 		goto nla_put_failure;
 
-	if (nla_put_u8(skb, RTA_PREF, IPV6_EXTRACT_PREF(rt->fib6_flags)))
+	if (nla_put_u8(skb, RTA_PREF, IPV6_EXTRACT_PREF(rt6_flags)))
 		goto nla_put_failure;
 
 


