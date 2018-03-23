Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805511-2-9923690411933333920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805510; b=cKWEJ/t5g3pT264JvWSSgsL6tULwIelbPO7ttH6lvjKKw+X
    DwD1hn5IkNKJtbrqceqWuomcdE/c7EvMvqTWfk3ER5odRn3ZZ/zj+9DAMVvpZk7j
    d7FB02adBRWIhTTTUbgR6cmmhQuCKEm5eMaHgU56zXZKA3yz2ShxKmtCBznhLoGP
    uuKgB8ks5xmeGPWi28YxGEWYOa6Uhb7h0moeSL+WxI4S2sKGlWKfoWKjO5x9UIQi
    aT3yc6STVKdXFureRFKYTrIWq2D2HnjYqEwgF9NGTloJXbK1HIQLi9CXnY6fhPyG
    yPXY/8xRaXXaXlrJfCN6NwB64a1w5YAxB3hX4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805510; bh=CVUehAgOJyR8muWPRkl5tF3ohX
    gx4ZKvyeLbe8ywHMs=; b=ivf2FBFhc3IpuyFbuG4GyXm36Fsv+nI+uFEK6AFWdS
    KnzIwXz47BOhhFZZF40xOTOh0pEklzyyHhmam/soyERzvllCkIxP5SErs6d/ucHE
    WVdBi2vQuYp5X7JnjWXY5JhAxa9A/W1U5BpgzsOCW+VtOy4o4fwLpsJ4W+3TQJlg
    UNoyzUw/qJuRZKqJBPUcY+DnPeypSo7HHfCkxQV4nxi1qT6sTIMYOX4Z9tH8wxDn
    damshDfL0gIbJ6TrhTpTVynmCvq3T3rAqvZIF2yu+O4/DFik/B4wCg1rxlOeq33g
    vcjdrq9hkXz6UF0tzu54WCt35hz3jRySG0aUwbI+SUPA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeCWKDP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:03:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754379AbeCWKDN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 53/77] ip_gre: fix error path when erspan_rcv failed
Date: Fri, 23 Mar 2018 10:54:27 +0100
Message-Id: <20180323094145.801828772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>


[ Upstream commit dd8d5b8c5b22e31079b259b8bfb686f1fac1080a ]

When erspan_rcv call return PACKET_REJECT, we shoudn't call ipgre_rcv to
process packets again, instead send icmp unreachable message in error
path.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Acked-by: William Tu <u9012063@gmail.com>
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -408,11 +408,13 @@ static int gre_rcv(struct sk_buff *skb)
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN))) {
 		if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
 			return 0;
+		goto out;
 	}
 
 	if (ipgre_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
 		return 0;
 
+out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
 	kfree_skb(skb);
