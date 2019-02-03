Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1CDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A72084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfBCOUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55534 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730093AbfBCOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdX-0006Li-8C; Sun, 03 Feb 2019 14:20:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-00070A-AC; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sabrina Dubroca" <sd@queasysnail.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.671429672@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 118/305] ipv6/ndisc: Preserve IPv6 control buffer if
 protocol error handlers are called
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

commit ee1abcf689353f36d9322231b4320926096bdee0 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/ndisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1568,10 +1568,9 @@ int ndisc_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
-	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+		memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
 		ndisc_recv_ns(skb);
 		break;
 

