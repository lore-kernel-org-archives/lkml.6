Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989402-2-3026159066449718700
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
    t=1519989402; b=Tgz94gZH+eWjCRAs227x+dh1cpSgzWQig1hF78suj0g+LPj
    ISkcfa94rsF2Z6vbO2CVNPNrlK4pzMPKHaaTSut+kXpopfHg4tABPe8i6PGNTzHr
    AwGwEzd/BjPXycNC+O2qU4URzVOPvEUVc5LWAlEOl7VXASHA51qZdBgRfxb2Ahzx
    /M4Yce7u2tyhOQnIUnF2e0XqlF7YJ8RFllwZa5T79gK3gLqnjW1B6hOJIHU1oQwT
    H0nwoIJmSjd3MoxdjlL14NVHTVtWbLg9D4JlIyV4b4fpuADMisnbgL7rayyTwF3D
    /luZeHIqzzu2Md5hJ71o3kgnXAIxJ7s5lRZV0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989402; bh=CiD19HsPrAb6I4uO3wbPwEpnvo
    Yy06bWnMMv4gIDcRw=; b=ewAwh2a0LngPjIJaBTsIgRikN5zUJrQ0gzd+SFWPRN
    /PwFqps3JWNmFAKbyp297EFtgX1T7CDh/qgp6xSHi9aW+5EysYIrGURHDmqPclQV
    55RW4bHOByHjaRgqNoLlGwXGedsS0WCzfiU3A81TuyWfQlbm7VLTP8mFHheSk+N8
    X+CVhePLgGDPrMb/tSILzqYGKl8KLPqudu3yA9iYscBQWfwcKumakFTZqMoBCRwD
    TQPH5Jiocxz7KJW8FjNdKqsoItSpaaIVy0qy+fAjhA8ZHWn6kCvPy5tFetxWOexg
    TpFJJHQd4ZjOvRrhg3JeoIbyssQCRpfX7zvdYOtqyi2Q==
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
        id S1423039AbeCBLPy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:15:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423374AbeCBIxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brendan McGrath <redmcg@redmandi.dyndns.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 04/24] ipv6: icmp6: Allow icmp messages to be looped back
Date: Fri,  2 Mar 2018 09:51:01 +0100
Message-Id: <20180302084239.401231524@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1367,6 +1367,7 @@ struct dst_entry *icmp6_dst_alloc(struct
 	}
 
 	rt->dst.flags |= DST_HOST;
+	rt->dst.input = ip6_input;
 	rt->dst.output  = ip6_output;
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->rt6i_gateway  = fl6->daddr;
