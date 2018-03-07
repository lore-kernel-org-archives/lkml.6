Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453054-5-9339629592270241771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453053; b=PEGO9Tg0SOsIfoYYIqDvtz8WrsI6hWQRRc80i+hSvwWesfw
    6og3p340Pzm+qCTHmZO74kIcECtofgyESts3bXvGeOtX+jVyZLhrQJ4ZVq7TdxJ4
    JzT4ArPjR4ckZVOfsOqM5DSj7jAnmCsnw5r58tCAR0EZCisNh5BVVVbxz4Keu64Y
    i4YhWXRVwfSgEASJ0mzCKbPc/6rMs7CgO/wysEv4T1D+YrdG8HT0zTk2SwLOWd5P
    NX9jde+D2IjAg7H96tnQqK0u2gVRKHesxSMtFFzQZ7MzBTyjD1ew5vEre9tvU0Z1
    6f7S1LvP8rIWk1n5gk0ZvgZTbQfHspzwYkNKmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453053; bh=UwF8tTKD8BupD7+siWD5ruQgT+
    EaaaMQ94OJPaYf+8E=; b=YiJ26+jcIZ/LS5SYiLYW/CKLOUozOh3wls0MNQtjU5
    GIbJ7yJC6m6I3tAvNI4a3c5BHRDQI27M/ORoKfRxCnsF433Rt4Vl27LY244ZU71e
    8q3RR929Uk0VyL8BcOEA7jtStUIChkDNpZcjCXLfdkx+rpI/0CYtmX2xeHydkMrR
    9OQhdGIHFzPDaIdP+d2PYS1SnWGz8MojoGheil43jONlcWKpTG3FSSXcC6GtyrSZ
    nXlglFpoqJtqFFcfSt2e1/4q6w+5kUk6INtnJBjGaeFLi9g+4+dlP9tBmCizKND8
    xBIP/158saB0sm1Skdj2w/2O1lGN2ztAf9f9dZqnzaYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965406AbeCGUED (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:04:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965539AbeCGTqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@idosch.org>,
        David Ahern <dsahern@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 063/110] net: ipv4: Set addr_type in hash_keys for forwarded case
Date: Wed,  7 Mar 2018 11:38:46 -0800
Message-Id: <20180307191047.652583652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 1fe4b1184c2ae2bfbf9e8b14c9c0c1945c98f205 ]

The result of the skb flow dissect is copied from keys to hash_keys to
ensure only the intended data is hashed. The original L4 hash patch
overlooked setting the addr_type for this case; add it.

Fixes: bf4e0a3db97eb ("net: ipv4: add support for ECMP hash policy choice")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: David Ahern <dsahern@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1832,6 +1832,8 @@ int fib_multipath_hash(const struct fib_
 				return skb_get_hash_raw(skb) >> 1;
 			memset(&hash_keys, 0, sizeof(hash_keys));
 			skb_flow_dissect_flow_keys(skb, &keys, flag);
+
+			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
 			hash_keys.addrs.v4addrs.src = keys.addrs.v4addrs.src;
 			hash_keys.addrs.v4addrs.dst = keys.addrs.v4addrs.dst;
 			hash_keys.ports.src = keys.ports.src;
