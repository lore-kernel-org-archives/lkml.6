Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0959FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36192146E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="igJaYhqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36192146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeKIHpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732334AbeKIHo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:58 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233FC21019;
        Thu,  8 Nov 2018 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714847;
        bh=mnSLyflfQVsZHJAKANJGbHKX5TMHAcbw8wkbyDRlPdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igJaYhqJ+UALHIz6nO7u9TfezZqOT0SPwbz9mPHdtYvbU0jn4dQ8AFk5K3Fj+247N
         fzUY4JyEx0U91VUCY4ruw0sI6Sr8S+QTvr0/3RMmoEq/RFs11iyU8Qq+U+/EaIBslo
         PODzH4SyH4G4FLCeNQOQUYtifvxk7OqZC7dCuwVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 137/171] ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called
Date:   Thu,  8 Nov 2018 13:51:47 -0800
Message-Id: <20181108215136.969600005@linuxfoundation.org>
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
@@ -1692,10 +1692,9 @@ int ndisc_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
-	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+		memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
 		ndisc_recv_ns(skb);
 		break;
 


