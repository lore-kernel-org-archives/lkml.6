Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805504-2-11257056719297761172
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
    t=1521805503; b=ho21ZgyvJHH78ZlBvkI3dVMpsPGgAyiULdCQhuvG5hFmJZS
    ky+mGfc/eBIJ0YakUtsV+oYujdMIpEcK0ny6cjyPeeGk9dtvzAwDBvpY1GaCnNTb
    NW1riDsxRkKTq/3Hecs899xoXDjay5ZGYUlxFbbNBYAshLEp+fkR1/oSSLEWj3Pr
    2Chuo7+Ffzje06C36o3hBhHSHqwOYcAFMyrem8cP+Pmz+8MutipDftkxYNwVNY20
    o2Z/UZKNa+s3DaDvK1iCQZri3MEcEPYCzfMrZR0w8mws0grn8yTcpMyxxo4LLmLT
    5Qgi2bP9zfkkYVgr9TlWTwo9b094W7f3VxU2XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805503; bh=71WFCAGJRd9GWjtPQ0X95I+iQo
    r8DA7rwDJ5gXvL3Hc=; b=EAJNgJAu5trDQBOMqj2rzl/b7e2ccJA0klPP8lS/5V
    v9KJt+CcSBMG+mPYkueU+49VHnE/eLDDVm2HCyhxtHofifekxDUgT5ZahLi7BDgo
    Wz6qY+LhuIbqVD3f55wzpcyhBjkW6hGmikueNLuf8hJlghBbVk5MpKVLCcfsJpbJ
    9h2sNETJeVDxq1JXrpTcKvzuIBm3b7RcBRhBalZlUi16twbj+EFSAfhxq91Q2Y0E
    N8W88JGg+k1VVBKiSFqFmbbSMdclhGZrtT5ZK7gRyv/0WXWq1hY5Thow/0ebGb7e
    mdgTtBusALgb+byUSZJWVN2kxML1cQn6fxhKzlTya4SA==
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
        id S1753982AbeCWKDS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:03:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeCWKDQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 54/77] ip_gre: fix potential memory leak in erspan_rcv
Date: Fri, 23 Mar 2018 10:54:28 +0100
Message-Id: <20180323094145.886610783@linuxfoundation.org>
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
