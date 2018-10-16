Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A82089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxSXKMnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730A82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeJQBPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F2E2098A;
        Tue, 16 Oct 2018 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710656;
        bh=zaRwU2hpEdeZ1ZkbcMvV2VPJuOewjd1Pz3CsEvj3cNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxSXKMnlAej2BkFO0g+yUrryobWUER/mCjVmjVRQuNh1NSHsuCrTmVYCJ+LbAvTuv
         uPELM7U+khzjhvsjTh4a8nWT5mrLSJiAlhKBkLB+LXO/A/gA0B6NOAxN2WI7DtSxRh
         Eav7UjS00Hm3xmGLJe1zd77i7/zNqf8YWRRAfh/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 42/71] inet: make sure to grab rcu_read_lock before using ireq->ireq_opt
Date:   Tue, 16 Oct 2018 19:09:39 +0200
Message-Id: <20181016170541.488790000@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2ab2ddd301a22ca3c5f0b743593e4ad2953dfa53 ]

Timer handlers do not imply rcu_read_lock(), so my recent fix
triggered a LOCKDEP warning when SYNACK is retransmit.

Lets add rcu_read_lock()/rcu_read_unlock() pairs around ireq->ireq_opt
usages instead of guessing what is done by callers, since it is
not worth the pain.

Get rid of ireq_opt_deref() helper since it hides the logic
without real benefit, since it is now a standard rcu_dereference().

Fixes: 1ad98e9d1bdf ("tcp/dccp: fix lockdep issue when SYN is backlogged")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_sock.h         |    5 -----
 net/dccp/ipv4.c                 |    4 +++-
 net/ipv4/inet_connection_sock.c |    5 ++++-
 net/ipv4/tcp_ipv4.c             |    4 +++-
 4 files changed, 10 insertions(+), 8 deletions(-)

--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -132,11 +132,6 @@ static inline int inet_request_bound_dev
 	return sk->sk_bound_dev_if;
 }
 
-static inline struct ip_options_rcu *ireq_opt_deref(const struct inet_request_sock *ireq)
-{
-	return rcu_dereference(ireq->ireq_opt);
-}
-
 struct inet_cork {
 	unsigned int		flags;
 	__be32			addr;
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -493,9 +493,11 @@ static int dccp_v4_send_response(const s
 
 		dh->dccph_checksum = dccp_v4_csum_finish(skb, ireq->ir_loc_addr,
 							      ireq->ir_rmt_addr);
+		rcu_read_lock();
 		err = ip_build_and_send_pkt(skb, sk, ireq->ir_loc_addr,
 					    ireq->ir_rmt_addr,
-					    ireq_opt_deref(ireq));
+					    rcu_dereference(ireq->ireq_opt));
+		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
 
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -410,7 +410,8 @@ struct dst_entry *inet_csk_route_req(con
 	struct ip_options_rcu *opt;
 	struct rtable *rt;
 
-	opt = ireq_opt_deref(ireq);
+	rcu_read_lock();
+	opt = rcu_dereference(ireq->ireq_opt);
 
 	flowi4_init_output(fl4, ireq->ir_iif, ireq->ir_mark,
 			   RT_CONN_FLAGS(sk), RT_SCOPE_UNIVERSE,
@@ -424,11 +425,13 @@ struct dst_entry *inet_csk_route_req(con
 		goto no_route;
 	if (opt && opt->opt.is_strictroute && rt->rt_uses_gateway)
 		goto route_err;
+	rcu_read_unlock();
 	return &rt->dst;
 
 route_err:
 	ip_rt_put(rt);
 no_route:
+	rcu_read_unlock();
 	__IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
 	return NULL;
 }
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -859,9 +859,11 @@ static int tcp_v4_send_synack(const stru
 	if (skb) {
 		__tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
 
+		rcu_read_lock();
 		err = ip_build_and_send_pkt(skb, sk, ireq->ir_loc_addr,
 					    ireq->ir_rmt_addr,
-					    ireq_opt_deref(ireq));
+					    rcu_dereference(ireq->ireq_opt));
+		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
 


