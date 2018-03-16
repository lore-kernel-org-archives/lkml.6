Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221851-2-7713459722916360520
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
    t=1521221851; b=Xu5LkrqMLhjm3agc1oJ4uLx2w6Uzoe6v3PuYLZG/emtquA5
    Rc2s53Ckyq2uGn5e8lDjdi/GRL0rwhiSdkm2bYu8eLRMl33TucnD5MCZmeSiWJMD
    fe2tzkVgrnSpFf11CETiaDQ1kUawKoHSx4EaN+MDR+nu8KOM5Po2i8xzp8EQN+/F
    NYNsNPaXW2/P4lCkoQuRir2AbxTQQlPooOQhcY1ZeI5zWL80FBYKI7m9vpBX4qWU
    3+34uKm3/mv4MgSl6XDtsII2pmcnIaol1mESzJL9Dh2hX6grKM218UNMAhIZ1qAm
    pMuLvlZaEGcHXz9h2ZZBcOlYPFYKJhJcpAsAfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221851; bh=iZZfzlmh7DC1ziPgrShjkhCsIw
    lHjkhcpmhDuNe/Bvo=; b=nBlEZXzMhz/JYCmQ9XyXInZWBC+mufwmEVokR/azbe
    s3KN8byHDyefl2xoam/X3u+0mcwha1yns1PSv3DAjIvhPO9Ja2bXSA7vKwrXOpjq
    n/8mA9ceOBNp2Qy/wyGiAoBS0+S1yRuh6IrsTfJ3NGN7KGvLYoL7Ot3E0cv+j4ss
    MIYPsiTTsyAyIKbpTSxTfypnEXyZh5RGx8VCH3VedXI3qyNmYjlbXJTIdnEy5wCJ
    MwOkiCRJkC+M8sKU4xKA2sPaYoCThII6+07Maaz1+LCCQUYtyOTqxxODpOzw/ubp
    KLOyEZRtmcH4LPcFv2RPQXN4I+9z9KV2tG7nttInfGwA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1753882AbeCPP03 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeCPP01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 12/25] netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
Date: Fri, 16 Mar 2018 16:22:59 +0100
Message-Id: <20180316152233.251750724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit b078556aecd791b0e5cb3a59f4c3a14273b52121 upstream.

l4proto->manip_pkt() can cause reallocation of skb head so pointer
to the ipv6 header must be reloaded.

Reported-and-tested-by: <syzbot+10005f4292fc9cc89de7@syzkaller.appspotmail.com>
Fixes: 58a317f1061c89 ("netfilter: ipv6: add IPv6 NAT support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
@@ -99,6 +99,10 @@ static bool nf_nat_ipv6_manip_pkt(struct
 	    !l4proto->manip_pkt(skb, &nf_nat_l3proto_ipv6, iphdroff, hdroff,
 				target, maniptype))
 		return false;
+
+	/* must reload, offset might have changed */
+	ipv6h = (void *)skb->data + iphdroff;
+
 manip_addr:
 	if (maniptype == NF_NAT_MANIP_SRC)
 		ipv6h->saddr = target->src.u3.in6;
