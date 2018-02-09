Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184254-2-628865797155322597
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
    t=1518184253; b=VWww3DHdEleLGoXpPKvxPPCu7IRZhUAfBRcuXfGRVKR5TWe
    I2Ie6n1/3uhgzspesEmRWMJFV/xT7/db5MMiDkQhsPUe45e3M+6UuJY2qR0v3F/6
    sB0wGa3tmhVgiS4Iu3GxHwbNX4+uDb+Ivt6BTgJpkAIt5NaKHQunMsKfqCQ+Q45u
    kphouSeEj+lYY2WvTdpHVXK5kF3gsT84Y+1Om1EuNwnRvu6YjmuhByIiXsvtSejA
    McCSQ6GkB/0tUkqyJghxjdBJHIarXqBai4Hn1uytz6K0An+TwcBCQuiNIIlcLlQ+
    buKh80VLVVH3sxOd7Bkl1keuabJELZNrsMinPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184253; bh=SIINBy/BLwf7ffeVoby9XVmYLE
    Ai/jmAk7lHTpbW5ds=; b=SJRjhWe2iOGt8GY+dDS6QFcoJzfj4oLhox3HUPUcWu
    AkMcYXCNgkyALbFWw2w5HrSY4gwt2MwOUDK3I5Ybb5xOEcCaigTjjSLbi8ulZJ4K
    XDG2lxxPxG7GZ5BFSpWjqihm5NISO27NXkh6fHvzCzB/oBQotw7SvV8Bjsr0f6jC
    8cVL8DjHoj4UY0WbC61Yr4bBkeaJ8DKWyOzI8EKm4i5qB0fjXsdR+kc90J/f4Vav
    EeENVKRq7rSELEg9o9cFopXMvvPcEFcqzT6GbTj/9Mq4j9n+Nz2btPGDcUotuEJS
    NSYUXPldV2OoKmvSX2+5iZyZ0FmM8Ybdr3p9ZY8BkfAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbeBINq2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeBINq1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 15/23] ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only
Date: Fri,  9 Feb 2018 14:40:13 +0100
Message-Id: <20180209133939.104334991@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
