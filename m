Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE0E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760506;
	bh=PsHAdz1vOML8vDiKVw+GDmS6/j4yV7AWruhMqWlF9CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqTrN/L83Ogys/PMklEtVLgObiJA+v0uMvwhhoHXsihGiCMyX1cOJEaUQ9A3m1U+v
	 zbAT5faDXDzGB1JabEdF1f3AZOwRJUMhNz3s5wwFiPk0m16X5wIdb+4ME8gkLkRBwd
	 OuJlnbTiQtKRFZkWOeWUmOMZXAZGdKHGVgg7MJyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfBUOsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbfBUOkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1082080D;
        Thu, 21 Feb 2019 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760020;
        bh=PsHAdz1vOML8vDiKVw+GDmS6/j4yV7AWruhMqWlF9CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvLSbKkfLXxZyoJ/3XKJtg2Z8SbOkq1INPf9hnFC5YtBBxL9FtdB/OTRJaOsOVDFs
         zRGh1hUVTEF9Cbmthhof5RFCbo1NXP1AppjKfA6sDgTY/ttInRhBvBxw4F2GF028wp
         dYp8CvhhEnj/kauSQ3VZ+O/V2ag4NeUwkCQ5DuAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/23] net: ipv4: use a dedicated counter for icmp_v4 redirect packets
Date:   Thu, 21 Feb 2019 15:35:45 +0100
Message-Id: <20190221125246.479532774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 64007ce87273e..f9cef27907ed4 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -215,6 +215,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
+			p->n_redirects = 0;
 			/* 60*HZ is arbitrary, but chosen enough high so that the first
 			 * calculation of tokens is at its maximum.
 			 */
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7afa8d2463d85..cb30f4e4e5533 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -904,13 +904,15 @@ void ip_rt_send_redirect(struct sk_buff *skb)
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
@@ -927,6 +929,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
 		++peer->rate_tokens;
+		++peer->n_redirects;
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 		if (log_martians &&
 		    peer->rate_tokens == ip_rt_redirect_number)
-- 
2.19.1



