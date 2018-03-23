Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806447-2-9787242868986195429
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
    t=1521806447; b=GpQP9l8a0wofuRGpHlWFQuJVs2QSIQ48hnRktt2Sjfx9wPW
    jfbWxyEq/CzRLmYt/UDb4BKKO0y0MyBwzy5WNM30IAgVJiAytcI2O82ss6aWjV4S
    lCrpJLz1EArtMvLYoh3EvY1tZ/UhTk5SY1Jv5Ehw0AUoLxPZzclMTCDV9klUMib+
    CR9Cwt9tQXdKDi1gvnSxV+Ze0/ijyX8HGjNmygn9WaxHcFlpFtCbt3oSUJClXI7y
    RVJ9nTJAArv6c8d5hH62f05gd1OquL6aj8SyRRjGDktDOiuEDowMvI/aQgJoMkHy
    nh6ry/V6ExeU5h6fRPMwQBoHxMbmrT8/Z0QlunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806447; bh=ZG5tRmRu3fCrGP7pFtaWpnjVih
    QxlXIEdcwNw7CqBkw=; b=P/YUcltb3zZ3vX+GyLG4BmTU1rJhAQLTkpP+36HEC0
    HiPY8pjlo2gVSmgm3JhLTM11m3LLTK2tIw/bbrHx12CKCgvm01AdAZAteKCaIxyk
    gBBRIclFWyc4lor4aCinbihZBWnGGK4QLozwyuOfdW8J4SZQ6y4mCyaUHavE8nLH
    5TSrrzW7Sk0kKeIJ1Q5dlsVZYjgW8OTN2GeWiu/Nn+E0cAPJoJJ7eqzR863ah/vK
    yTgC0A/95Mz+ZlzqzakB0QkhD9F4rZMXPq3ejY2/aQBrbwaOowe7KEu1CiAAIPEO
    cGN+ZOsvlbykjcC9eIG39JHGJJy61wi6s8jKngImVVLA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1753472AbeCWJ77 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeCWJ76 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 63/84] ip_gre: fix potential memory leak in erspan_rcv
Date: Fri, 23 Mar 2018 10:54:17 +0100
Message-Id: <20180323095421.489923342@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>


[ Upstream commit 50670b6ee9bc4ae8f9ce3112b437987adf273245 ]

If md is NULL, tun_dst must be freed, otherwise it will cause memory
leak.

Fixes: 1a66a836da6 ("gre: add collect_md mode to ERSPAN tunnel")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -303,8 +303,10 @@ static int erspan_rcv(struct sk_buff *sk
 				return PACKET_REJECT;
 
 			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
-			if (!md)
+			if (!md) {
+				dst_release((struct dst_entry *)tun_dst);
 				return PACKET_REJECT;
+			}
 
 			md->index = index;
 			info = &tun_dst->u.tun_info;
