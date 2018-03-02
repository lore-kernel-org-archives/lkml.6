Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519980922-2-4413394359809223101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980922; b=O6yzoFrKui3DGim1AnFNdmez3xqfoXDP6DOCB3pmYocMG2M
    Bsu9tUPjiX8ksAlX1ME9G/z9ArN+MVpzW4j602Ru1rjT1fbimNhEYtyzoPlZvpD/
    E1gFLL283hh1JqGpoS5ydb6BPJebh3q2dcjXJ/r2JOP9w2hedQJEMG6TyPO+w3Wt
    D+4GotHj2JDd9NXpTdJZoy4eKYTgmjHGpdh/BOnCzi/1ol0IoLj0Or43aRkXdWjI
    gjM9SX4xPJ+xfmI6xrjDZo7UgyQTz5iq5G9PWGAyMnLcFEkrJe+4lC+UhAwbsX0l
    zX79TSW2k9AfKIn91nzBi7qOWuG/mCzw5GD29SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980922; bh=grydVFRmSPanj9Bwk9OUeT8eSL
    XLRm0buxkdnmBgtco=; b=an6P1dK7P+rR6CvPNiDr5Ux1imeFW/uFYmfHmLGdJ3
    nLNwdkQ9+YQqf7UrB3iToNuSMilgGBY1uK5T+I5SFxSkV8kFz5pZSmy5kHKflkE5
    0WouRIE6ZRFXGwXWVbXTEjGXEkPpME95+befv97Hkfv4WY5XufeqQ1fih0NU+J/n
    RD0mCgc23qZgdJQxAhuN33KqJAZkDl2916i4/qNKorRtaf/uwzulQcuZ4YPiuKmS
    7zdOpBlbv0wSZIMfLU/IMZjqKiSulcU1k5lzeZKQDwZSsrLk7m7iK9zoDiLgqxKL
    9MW4Ri9KC8ikZCcCGDBZDrrVQtGxWnGqChRg607TUqJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423639AbeCBIzR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:55:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423609AbeCBIzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:55:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brendan McGrath <redmcg@redmandi.dyndns.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 04/34] ipv6: icmp6: Allow icmp messages to be looped back
Date: Fri,  2 Mar 2018 09:51:00 +0100
Message-Id: <20180302084436.260487712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan McGrath <redmcg@redmandi.dyndns.org>


[ Upstream commit 588753f1eb18978512b1c9b85fddb457d46f9033 ]

One example of when an ICMPv6 packet is required to be looped back is
when a host acts as both a Multicast Listener and a Multicast Router.

A Multicast Router will listen on address ff02::16 for MLDv2 messages.

Currently, MLDv2 messages originating from a Multicast Listener running
on the same host as the Multicast Router are not being delivered to the
Multicast Router. This is due to dst.input being assigned the default
value of dst_discard.

This results in the packet being looped back but discarded before being
delivered to the Multicast Router.

This patch sets dst.input to ip6_input to ensure a looped back packet
is delivered to the Multicast Router.

Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1614,6 +1614,7 @@ struct dst_entry *icmp6_dst_alloc(struct
 	}
 
 	rt->dst.flags |= DST_HOST;
+	rt->dst.input = ip6_input;
 	rt->dst.output  = ip6_output;
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->rt6i_gateway  = fl6->daddr;
