Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641351-2-441938113216183895
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
    t=1520641350; b=VoVfMwTbMO6O40De8rUFGKulK/XdNcG1HN5KPP7zVw3IHMR
    1UOI8oSu5LGy2YnBmnBFR8Higv2IFKGLhGBYAUePdRczwdWuj7JuPeJgCWflgecU
    v4Sw56X3jfurGWoRHI7pvPsD6dwWgux0ydEpreC8gJCGOm1aHbx/TLGw5pcxxllx
    WXVelDdyK030aJafV6aUjBEN18zscRYDN81XlwLDr5FEbTmpdAYddOh01TxwPPCE
    sYQitU36kn5N1vs4uX6u8FpRNb02XSMWyimNoqiNeCYwvg3n3nX91Sw/qPoGbqH5
    uImvGqgwQMNZbYc0WvdyWv1UgskPWRJz1GnuE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641350; bh=Ws8Ofx0bASgqATAfFykxNu4OBp
    gujsaa9xXlgnnrI+I=; b=arPAG9Tm3yl+z/FOkVvKsXUb9T64FZopq1udkPeM1c
    zxMTQjjHG2ncl645zSDrnVRHgYlRTlCDWaKamUeITXTOr71AatIMD1lk/x5pEDou
    nmDmzuXaMuyoPkdPXEDmXvbxKIs7HrlDNzAp8ZAZOuP0JBP1/qjrC1CnQ85wdX9L
    2P5cx4qLYkOjSmabOwgReu1m1R8g/i0A/HX0VtNVxCBq3ok8Bq7CzZL32l2p+Ii9
    HxWBBi2iNM2SeLkJ+EGNSRdAHx+2moxkVffSJRVqZhnnYMuvZKmnXyDe1ALUjNm3
    frD6YjONaUHNV/p84qcJVhv9+nSza1PbiUNJ6HcIvijw==
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
        id S932801AbeCJAWY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:22:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeCJAWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:22:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 48/65] sctp: fix dst refcnt leak in sctp_v6_get_dst()
Date: Fri,  9 Mar 2018 16:18:48 -0800
Message-Id: <20180310001828.807994342@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2 ]

When going through the bind address list in sctp_v6_get_dst() and
the previously found address is better ('matchlen > bmatchlen'),
the code continues to the next iteration without releasing currently
held destination.

Fix it by releasing 'bdst' before continue to the next iteration, and
instead of introducing one more '!IS_ERR(bdst)' check for dst_release(),
move the already existed one right after ip6_dst_lookup_flow(), i.e. we
shouldn't proceed further if we get an error for the route lookup.

Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using secondary addresses for ipv6")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -324,8 +324,10 @@ static void sctp_v6_get_dst(struct sctp_
 		final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
 		bdst = ip6_dst_lookup_flow(sk, fl6, final_p);
 
-		if (!IS_ERR(bdst) &&
-		    ipv6_chk_addr(dev_net(bdst->dev),
+		if (IS_ERR(bdst))
+			continue;
+
+		if (ipv6_chk_addr(dev_net(bdst->dev),
 				  &laddr->a.v6.sin6_addr, bdst->dev, 1)) {
 			if (!IS_ERR_OR_NULL(dst))
 				dst_release(dst);
@@ -334,8 +336,10 @@ static void sctp_v6_get_dst(struct sctp_
 		}
 
 		bmatchlen = sctp_v6_addr_match_len(daddr, &laddr->a);
-		if (matchlen > bmatchlen)
+		if (matchlen > bmatchlen) {
+			dst_release(bdst);
 			continue;
+		}
 
 		if (!IS_ERR_OR_NULL(dst))
 			dst_release(dst);
