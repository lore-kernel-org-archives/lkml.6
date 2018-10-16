Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D982098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vtT5yEoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D982098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeJQBF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A172098A;
        Tue, 16 Oct 2018 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710042;
        bh=P7HLrP8Yf5+IZNlK7NQlXBb70EpQedhq3C/kFgbHl84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtT5yEoa/SBYFyEe5Og7NXDT46PsqAfe3qisygRlpVmEyBAJp+mKugSje7lvV47dM
         /ChVC/dtr0nDCVCIgKwC/BMH0SIbJbIRCDlDKoSwgnjpAHkfmAB/muPfnpUfxzeclw
         EyZ3CtoeQPSuI6qB5zpH/2QtmZc3yqTeWOXCJ6N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 047/135] tcp/dccp: fix lockdep issue when SYN is backlogged
Date:   Tue, 16 Oct 2018 19:04:37 +0200
Message-Id: <20181016170517.969907149@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1ad98e9d1bdf4724c0a8532fabd84bf3c457c2bc ]

In normal SYN processing, packets are handled without listener
lock and in RCU protected ingress path.

But syzkaller is known to be able to trick us and SYN
packets might be processed in process context, after being
queued into socket backlog.

In commit 06f877d613be ("tcp/dccp: fix other lockdep splats
accessing ireq_opt") I made a very stupid fix, that happened
to work mostly because of the regular path being RCU protected.

Really the thing protecting ireq->ireq_opt is RCU read lock,
and the pseudo request refcnt is not relevant.

This patch extends what I did in commit 449809a66c1d ("tcp/dccp:
block BH for SYN processing") by adding an extra rcu_read_{lock|unlock}
pair in the paths that might be taken when processing SYN from
socket backlog (thus possibly in process context)

Fixes: 06f877d613be ("tcp/dccp: fix other lockdep splats accessing ireq_opt")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_sock.h |    3 +--
 net/dccp/input.c        |    4 +++-
 net/ipv4/tcp_input.c    |    4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -132,8 +132,7 @@ static inline int inet_request_bound_dev
 
 static inline struct ip_options_rcu *ireq_opt_deref(const struct inet_request_sock *ireq)
 {
-	return rcu_dereference_check(ireq->ireq_opt,
-				     refcount_read(&ireq->req.rsk_refcnt) > 0);
+	return rcu_dereference(ireq->ireq_opt);
 }
 
 struct inet_cork {
--- a/net/dccp/input.c
+++ b/net/dccp/input.c
@@ -606,11 +606,13 @@ int dccp_rcv_state_process(struct sock *
 	if (sk->sk_state == DCCP_LISTEN) {
 		if (dh->dccph_type == DCCP_PKT_REQUEST) {
 			/* It is possible that we process SYN packets from backlog,
-			 * so we need to make sure to disable BH right there.
+			 * so we need to make sure to disable BH and RCU right there.
 			 */
+			rcu_read_lock();
 			local_bh_disable();
 			acceptable = inet_csk(sk)->icsk_af_ops->conn_request(sk, skb) >= 0;
 			local_bh_enable();
+			rcu_read_unlock();
 			if (!acceptable)
 				return 1;
 			consume_skb(skb);
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5976,11 +5976,13 @@ int tcp_rcv_state_process(struct sock *s
 			if (th->fin)
 				goto discard;
 			/* It is possible that we process SYN packets from backlog,
-			 * so we need to make sure to disable BH right there.
+			 * so we need to make sure to disable BH and RCU right there.
 			 */
+			rcu_read_lock();
 			local_bh_disable();
 			acceptable = icsk->icsk_af_ops->conn_request(sk, skb) >= 0;
 			local_bh_enable();
+			rcu_read_unlock();
 
 			if (!acceptable)
 				return 1;


