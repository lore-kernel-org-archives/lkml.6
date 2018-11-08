Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDB2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Ibss5zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BDB2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeKIHiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbeKIHiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:08 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D2520892;
        Thu,  8 Nov 2018 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714439;
        bh=kzDABeTk9QOnqbP+2hp0YUUNdh/tMOEcvjdATl8X1qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Ibss5zTd2NrkVOV04S5JFAwtAKoBgSCsuQYeU3Gsuy/mQIWQDS1wt/V9c3SxxewU
         bimYO5j2F3S3sKIC4WAsxpqpx2Ar3F5i1MqXKINoe6J6dr0zwavUkG8bJfuRzZ+wDk
         1Hv6u3zzeBuZ/0dozj657rEGiETcxa7w2pPLvyvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 091/114] ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called
Date:   Thu,  8 Nov 2018 13:51:46 -0800
Message-Id: <20181108215109.010136833@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1649,10 +1649,9 @@ int ndisc_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
-	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+		memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
 		ndisc_recv_ns(skb);
 		break;
 


