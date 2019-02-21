Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C760C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02C320838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760139;
	bh=OcPcXLhVcCVPmaBhU47AZzOt3iGyDk8Wj+yE+sa5npI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aw7AMYCmIsupAFPXAu5g4jS7ncNztInYson6Y4GqEbH1gmHpu++d2uAe6RIUAx4Cp
	 r+Bqon7eKVOHPKBTmlG8v5CQCc43CGRqzTRSH44LwN9jxAXngQedyq+10m+ZDS8e7O
	 zab3Nqm7W8vNerAdySKf6bZybWODkxBprHpnpy6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfBUOmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfBUOmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA052080D;
        Thu, 21 Feb 2019 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760133;
        bh=OcPcXLhVcCVPmaBhU47AZzOt3iGyDk8Wj+yE+sa5npI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8Cw0UaCxHnr0IgYN2GEJf6pI/SnT8d9XipXOoDTjTBfnb8ZoOeBrKo2jCcp2qqv6
         8r1XlIJn+Jq90IY076bqPcnonAAGAJCL6I/h6DJeM0/m8V+obXjwJTGo1OC8ZbH2Vd
         NF0XRrq49nvRiu37PgahA+CvKjZCqUTNAeJKWY6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/30] net: ipv4: use a dedicated counter for icmp_v4 redirect packets
Date:   Thu, 21 Feb 2019 15:35:50 +0100
Message-Id: <20190221125250.988412418@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inetpeer.h | 1 +
 net/ipv4/inetpeer.c    | 1 +
 net/ipv4/route.c       | 7 +++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index 00b5e7825508a..74ff688568a0c 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -39,6 +39,7 @@ struct inet_peer {
 
 	u32			metrics[RTAX_MAX];
 	u32			rate_tokens;	/* rate limiting for ICMP */
+	u32			n_redirects;
 	unsigned long		rate_last;
 	/*
 	 * Once inet_peer is queued for deletion (refcnt == 0), following field
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index d757b9642d0d1..be778599bfedf 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -216,6 +216,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
+			p->n_redirects = 0;
 			/* 60*HZ is arbitrary, but chosen enough high so that the first
 			 * calculation of tokens is at its maximum.
 			 */
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 8501554e96a4a..436b46c0e687f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -887,13 +887,15 @@ void ip_rt_send_redirect(struct sk_buff *skb)
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
@@ -910,6 +912,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
 		++peer->rate_tokens;
+		++peer->n_redirects;
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 		if (log_martians &&
 		    peer->rate_tokens == ip_rt_redirect_number)
-- 
2.19.1



