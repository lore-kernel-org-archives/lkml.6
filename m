Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519412047-2-4059768870757790862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519412046; b=VtffnNbnQyAxdo1PaHCCy6frqZs1+lH/dcBFeDK6WvFs69a
    l7DAfY4mjtuyeJs3j2UyaPk+fqfbjjQwC9051+tdVszww8swxkuMhDihXsEkiNJs
    Ga4Tuda0YhjBgpFLzSy766eS1Ob0ksXrDl5QwHjHg9WcAX9C1PtwOIvXgeC3okjK
    J8RjsasIS72yjcKVST917Xrx1dr8LrQGKPOLaeDtyk83KxYTT39m5ZmnoMAySqf2
    868t8aDh3zJe3ZHlLNeDLa6IE3mcJF/An7McdVuJMau34iE+vf9qTjWDG2pKLMox
    k4p4g4/w7ZO0hoIOdT8IG2m0RTcJ1bi1tw074tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519412046; bh=NcnxIGl+zIxCrhGNfXrfgPGLqa
    z2pxUweK2ZFULA72o=; b=oQk7MlY55suAvv87cpc7qxsD5gTWbVZoapKdyQV/VI
    qTHJOh/ww+md7vHaDNCsCnJM0rGDXWVglGe15kybNcrjh6oowLyM+LicTMp43fMW
    BQOjHULCgrwkQvymquWCNiRvpwm1ZYnFsYsiz4ansgGCNY0KVVXY62Yq428AZl7E
    WnjLaV/Tbkl0fNOZdPWZ3WuVErnvXAMgwKfiRjzVP4xYDKtnwD+h9f5ve7sA54iv
    1hqOk3qewrfLmFBKc2wgqzuRiE8/NJM3aB/xYO94AnFG0+6ezp9xuc4wekfNtUOp
    E3r1PlwJfkGDzSZQRQTrn+wTA+WXiEI26Dy8kroCAG9Q==
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
        id S964828AbeBWSyC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964880AbeBWSyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <gfree.wind@vip.163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 103/159] ipvlan: Add the skb->mark as flow4s member to lookup route
Date: Fri, 23 Feb 2018 19:26:51 +0100
Message-Id: <20180223170755.869038313@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Gao Feng <gfree.wind@vip.163.com>


[ Upstream commit a98a4ebc8c61d20f0150d6be66e0e65223a347af ]

Current codes don't use skb->mark to assign flowi4_mark, it would
make the policy route rule with fwmark doesn't work as expected.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -375,6 +375,7 @@ static int ipvlan_process_v4_outbound(st
 		.flowi4_oif = dev->ifindex,
 		.flowi4_tos = RT_TOS(ip4h->tos),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
+		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
 		.saddr = ip4h->saddr,
 	};
