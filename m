Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49495C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFA21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx6Nw0Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FFA21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJQBCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJQBC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5F02089E;
        Tue, 16 Oct 2018 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709867;
        bh=nRKtNJ6V9mZTNYMRIsRQO9eNE9VfPrZjOcjHs9WRIng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tx6Nw0LgVDG0mFhTImaFz2XPBqKDOH0KB63qXtzzbZgsFjxbo/OZrJRnmmbku9lF9
         ecNMwcmLITEL2r9CpHIKBUq1QsU1A9aYCI43xhbCRDhgjjmgIwCkzHPHDafga3WWhK
         RtIGFpwpB3mpnPSbv5t5RVx1+Yf8GaC1tOpZdJCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ian.periam@dialogic.com,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 023/135] sctp: update dst pmtu with the correct daddr
Date:   Tue, 16 Oct 2018 19:04:13 +0200
Message-Id: <20181016170516.825577827@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d7ab5cdce54da631f0c8c11e506c974536a3581e ]

When processing pmtu update from an icmp packet, it calls .update_pmtu
with sk instead of skb in sctp_transport_update_pmtu.

However for sctp, the daddr in the transport might be different from
inet_sock->inet_daddr or sk->sk_v6_daddr, which is used to update or
create the route cache. The incorrect daddr will cause a different
route cache created for the path.

So before calling .update_pmtu, inet_sock->inet_daddr/sk->sk_v6_daddr
should be updated with the daddr in the transport, and update it back
after it's done.

The issue has existed since route exceptions introduction.

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Reported-by: ian.periam@dialogic.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/transport.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -260,6 +260,7 @@ void sctp_transport_pmtu(struct sctp_tra
 bool sctp_transport_update_pmtu(struct sctp_transport *t, u32 pmtu)
 {
 	struct dst_entry *dst = sctp_transport_dst_check(t);
+	struct sock *sk = t->asoc->base.sk;
 	bool change = true;
 
 	if (unlikely(pmtu < SCTP_DEFAULT_MINSEGMENT)) {
@@ -271,12 +272,19 @@ bool sctp_transport_update_pmtu(struct s
 	pmtu = SCTP_TRUNC4(pmtu);
 
 	if (dst) {
-		dst->ops->update_pmtu(dst, t->asoc->base.sk, NULL, pmtu);
+		struct sctp_pf *pf = sctp_get_pf_specific(dst->ops->family);
+		union sctp_addr addr;
+
+		pf->af->from_sk(&addr, sk);
+		pf->to_sk_daddr(&t->ipaddr, sk);
+		dst->ops->update_pmtu(dst, sk, NULL, pmtu);
+		pf->to_sk_daddr(&addr, sk);
+
 		dst = sctp_transport_dst_check(t);
 	}
 
 	if (!dst) {
-		t->af_specific->get_dst(t, &t->saddr, &t->fl, t->asoc->base.sk);
+		t->af_specific->get_dst(t, &t->saddr, &t->fl, sk);
 		dst = t->dst;
 	}
 


