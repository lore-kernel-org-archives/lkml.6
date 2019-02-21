Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91122C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6033C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759956;
	bh=EqN6E9PQo+6dSHq/kIYUe61z61UPtShXJPrKztkMYoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gk4siiUdLhFJgbTupOB2TycU5Y/ZoX5mwElSnMhWnFJpLDT0XBUqKySWe2l6Dufcv
	 YW16aeMrjbzA2RilkaXnPoBcZqA7A/gRRTFpUUNPln3TAr1vFfCBXqUSSWnyk5uOoT
	 16Qfn7jVBY7nAF2Qk4YNnbIbXhLnKORb9+2vxkyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfBUOjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfBUOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84642084D;
        Thu, 21 Feb 2019 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759951;
        bh=EqN6E9PQo+6dSHq/kIYUe61z61UPtShXJPrKztkMYoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDCrzloRSrhwIchHcLv0UFh50OniekPlKQtnUW0DTLL5DuoLBLksYPr5vZCqjHCTE
         JEBqMKJeI7k79biKv6lVFxTLdhVoyG5dwDlUGmIxDfE7798fFCwuPlkIL6REPmrD4I
         vx77VAIAHNEyl8xjF+qqjMO11eEaAmvb8shHQMVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/20] net: ipv4: use a dedicated counter for icmp_v4 redirect packets
Date:   Thu, 21 Feb 2019 15:35:54 +0100
Message-Id: <20190221125243.943518850@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
References: <20190221125242.153179182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit c09551c6ff7fe16a79a42133bcecba5fc2fc3291 ]

According to the algorithm described in the comment block at the
beginning of ip_rt_send_redirect, the host should try to send
'ip_rt_redirect_number' ICMP redirect packets with an exponential
backoff and then stop sending them at all assuming that the destination
ignores redirects.
If the device has previously sent some ICMP error packets that are
rate-limited (e.g TTL expired) and continues to receive traffic,
the redirect packets will never be transmitted. This happens since
peer->rate_tokens will be typically greater than 'ip_rt_redirect_number'
and so it will never be reset even if the redirect silence timeout
(ip_rt_redirect_silence) has elapsed without receiving any packet
requiring redirects.

Fix it by using a dedicated counter for the number of ICMP redirect
packets that has been sent by the host

I have not been able to identify a given commit that introduced the
issue since ip_rt_send_redirect implements the same rate-limiting
algorithm from commit 1da177e4c3f4 ("Linux-2.6.12-rc2")

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inetpeer.h |    1 +
 net/ipv4/inetpeer.c    |    1 +
 net/ipv4/route.c       |    7 +++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -40,6 +40,7 @@ struct inet_peer {
 
 	u32			metrics[RTAX_MAX];
 	u32			rate_tokens;	/* rate limiting for ICMP */
+	u32			n_redirects;
 	unsigned long		rate_last;
 	union {
 		struct list_head	gc_list;
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -448,6 +448,7 @@ relookup:
 		atomic_set(&p->rid, 0);
 		p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 		p->rate_tokens = 0;
+		p->n_redirects = 0;
 		/* 60*HZ is arbitrary, but chosen enough high so that the first
 		 * calculation of tokens is at its maximum.
 		 */
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -882,13 +882,15 @@ void ip_rt_send_redirect(struct sk_buff
 	/* No redirected packets during ip_rt_redirect_silence;
 	 * reset the algorithm.
 	 */
-	if (time_after(jiffies, peer->rate_last + ip_rt_redirect_silence))
+	if (time_after(jiffies, peer->rate_last + ip_rt_redirect_silence)) {
 		peer->rate_tokens = 0;
+		peer->n_redirects = 0;
+	}
 
 	/* Too many ignored redirects; do not send anything
 	 * set dst.rate_last to the last seen redirected packet.
 	 */
-	if (peer->rate_tokens >= ip_rt_redirect_number) {
+	if (peer->n_redirects >= ip_rt_redirect_number) {
 		peer->rate_last = jiffies;
 		goto out_put_peer;
 	}
@@ -905,6 +907,7 @@ void ip_rt_send_redirect(struct sk_buff
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
 		++peer->rate_tokens;
+		++peer->n_redirects;
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 		if (log_martians &&
 		    peer->rate_tokens == ip_rt_redirect_number)


