Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243AC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416C02084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUPQkD/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416C02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeKCDvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbeKCDvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:51:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E153720847;
        Fri,  2 Nov 2018 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184200;
        bh=CNUIqoRNb7EWS/eBQixQ62OQSJRkfYfd62Dtq0k6Nec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUPQkD/celYgJRe3hgUqcVscExdQEJawJXUQ2zdKk1YAJVE9kAH1/jl4ngSQmIvpn
         FoT+PBF2+Q4xIEWN+ZdXWgMPUPgPrQxKOmxpv+MRkoLiTdAbXTxAA7ANYb31Ev14pj
         rs4ZEiB0HQLvCh6Nnf3MKRulL1hvzJkt6VQ609Zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 105/150] ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called
Date:   Fri,  2 Nov 2018 19:34:27 +0100
Message-Id: <20181102182910.616911895@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit ee1abcf689353f36d9322231b4320926096bdee0 ]

Commit a61bbcf28a8c ("[NET]: Store skb->timestamp as offset to a base
timestamp") introduces a neighbour control buffer and zeroes it out in
ndisc_rcv(), as ndisc_recv_ns() uses it.

Commit f2776ff04722 ("[IPV6]: Fix address/interface handling in UDP and
DCCP, according to the scoping architecture.") introduces the usage of the
IPv6 control buffer in protocol error handlers (e.g. inet6_iif() in
present-day __udp6_lib_err()).

Now, with commit b94f1c0904da ("ipv6: Use icmpv6_notify() to propagate
redirect, instead of rt6_redirect()."), we call protocol error handlers
from ndisc_redirect_rcv(), after the control buffer is already stolen and
some parts are already zeroed out. This implies that inet6_iif() on this
path will always return zero.

This gives unexpected results on UDP socket lookup in __udp6_lib_err(), as
we might actually need to match sockets for a given interface.

Instead of always claiming the control buffer in ndisc_rcv(), do that only
when needed.

Fixes: b94f1c0904da ("ipv6: Use icmpv6_notify() to propagate redirect, instead of rt6_redirect().")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1732,10 +1732,9 @@ int ndisc_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
-	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+		memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
 		ndisc_recv_ns(skb);
 		break;
 


