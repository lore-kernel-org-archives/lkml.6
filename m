Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184557-2-7047636609376889169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184557; b=nVsf4cIe9zH4oXFu9NIsd8gep4YrN5Ovx0Ng9A258I224pA
    tG8OgTyv9Onzk2ZD0fmT1x61eFOcd4IxjOVOdStEkeD7uCaK2pENnDdopmv5jxep
    JRREV5nIyqNNUgMBm56ky3E9WGX4w6O2/Gh5QoUvb/iImM6FT8NeI3rtFsbwq8gq
    IdYNGp1q230B3XnKfcLFjASY0mqV0cktIcpgiRxOcvQbTx0H+aZGkIcwsI8RhMd1
    kfONZ6nK/QTYfdRHZEfewyhWFOxT3UL7/oOq/VjxO4MXnH8+MHnDU8aRftgXGVOn
    TOmI1XWZ9jMVpHJzPN/zNfxu9MIvMvA/YSsybyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184557; bh=PSM4xYTpH8QTJTDnqv+CmDMUCv
    7gRaHeyGj88ckj4xA=; b=ZyxgBAXwvh4AYJM/CvczHuugWIGtylxp1CVwbZZmVz
    KEhBjdyML8AxbMZemQGs6K92sCuQj3Tq1iR/X5dXtmxiGMqL0fNeDjOEIGxvk6nq
    Au6S5UUmh5equGUHDqs3320F6WjtApzzA5BwTtOAJgQeka7XWu+gvrVt7vT1JS5S
    VbC1Io+/fBABhdwK9deicafGbHyPrUyf7c+1v8THtDVG5dzfdMEcNNqgYZ/VtRxb
    odp62Ag9QBn5UcjO/abg9HYCAxUTO2jt77Po6oeJCYouinUl/xRGL27Go4szX9z3
    Pba0XeEcuEqsfnLJ2vBQkVEPnTDJI586EOUMPEvxzVgA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeBINpR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBINpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/22] ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only
Date: Fri,  9 Feb 2018 14:40:04 +0100
Message-Id: <20180209133935.189090931@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin KaFai Lau <kafai@fb.com>


[ Upstream commit 7ece54a60ee2ba7a386308cae73c790bd580589c ]

If a sk_v6_rcv_saddr is !IPV6_ADDR_ANY and !IPV6_ADDR_MAPPED, it
implicitly implies it is an ipv6only socket.  However, in inet6_bind(),
this addr_type checking and setting sk->sk_ipv6only to 1 are only done
after sk->sk_prot->get_port(sk, snum) has been completed successfully.

This inconsistency between sk_v6_rcv_saddr and sk_ipv6only confuses
the 'get_port()'.

In particular, when binding SO_REUSEPORT UDP sockets,
udp_reuseport_add_sock(sk,...) is called.  udp_reuseport_add_sock()
checks "ipv6_only_sock(sk2) == ipv6_only_sock(sk)" before adding sk to
sk2->sk_reuseport_cb.  In this case, ipv6_only_sock(sk2) could be
1 while ipv6_only_sock(sk) is still 0 here.  The end result is,
reuseport_alloc(sk) is called instead of adding sk to the existing
sk2->sk_reuseport_cb.

It can be reproduced by binding two SO_REUSEPORT UDP sockets on an
IPv6 address (!ANY and !MAPPED).  Only one of the socket will
receive packet.

The fix is to set the implicit sk_ipv6only before calling get_port().
The original sk_ipv6only has to be saved such that it can be restored
in case get_port() failed.  The situation is similar to the
inet_reset_saddr(sk) after get_port() has failed.

Thanks to Calvin Owens <calvinowens@fb.com> who created an easy
reproduction which leads to a fix.

Fixes: e32ea7e74727 ("soreuseport: fast reuseport UDP socket selection")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/af_inet6.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -284,6 +284,7 @@ int inet6_bind(struct socket *sock, stru
 	struct net *net = sock_net(sk);
 	__be32 v4addr = 0;
 	unsigned short snum;
+	bool saved_ipv6only;
 	int addr_type = 0;
 	int err = 0;
 
@@ -389,19 +390,21 @@ int inet6_bind(struct socket *sock, stru
 	if (!(addr_type & IPV6_ADDR_MULTICAST))
 		np->saddr = addr->sin6_addr;
 
+	saved_ipv6only = sk->sk_ipv6only;
+	if (addr_type != IPV6_ADDR_ANY && addr_type != IPV6_ADDR_MAPPED)
+		sk->sk_ipv6only = 1;
+
 	/* Make sure we are allowed to bind here. */
 	if ((snum || !inet->bind_address_no_port) &&
 	    sk->sk_prot->get_port(sk, snum)) {
+		sk->sk_ipv6only = saved_ipv6only;
 		inet_reset_saddr(sk);
 		err = -EADDRINUSE;
 		goto out;
 	}
 
-	if (addr_type != IPV6_ADDR_ANY) {
+	if (addr_type != IPV6_ADDR_ANY)
 		sk->sk_userlocks |= SOCK_BINDADDR_LOCK;
-		if (addr_type != IPV6_ADDR_MAPPED)
-			sk->sk_ipv6only = 1;
-	}
 	if (snum)
 		sk->sk_userlocks |= SOCK_BINDPORT_LOCK;
 	inet->inet_sport = htons(inet->inet_num);
