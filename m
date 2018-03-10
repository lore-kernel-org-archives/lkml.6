Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641211-2-13594196874538116156
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
    t=1520641210; b=YkoCrN0P+dQ4m9/qmhhjkBMl6UasN+v2DKHajz7J5e0gkRe
    pWAvURA0xtikkx2Ue9LzXRgXjYc/gQ2u4Oa2AP4OwEOSxfHtgcP8J/3JHjcdy6kD
    rGcxqypRG8vzgE5aCSlCc80Lz1LHH4QZ2VtZchA7gTUyBrnDjjrFE5+uI0dDrrDj
    w3qOyY6Ocsaq+3TUtRLkTky2KPBvjZRkwySLIkEL4UXQcMDzYi6Zd8dkPStW5f60
    hYrC58qFP4h+j0+oMHgE6ACeYMmPeI0HjYYuxGP5qncoPcHWS8RBIgLfQQmwVfIp
    k35ZyGo7ftc57okOnIpP4+UQXRLT2THWoDTTvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641210; bh=9/ZHbWjCaC5opc69WlAKHXJH1/
    kpEyDsivu4hCVV0gQ=; b=aroykDFEjwbJkFCZI0lctSXvvt4DmOK88LXPxMfKEe
    b3jegH2QKraYyIDfqhp4X0iQ0kL00RBguRpmTZ/r5BTaZlS94IriUbHCD+uRaDsP
    NVk6fLogQcp9/1Yj8i7B8HRBC+c2PnCnao36SfMB3Ylkqg+ad+lvtTsisUiXglfX
    rnK+4ZKkV+OhDEv2OjrkTHT4VDeB1WHE/Nx2BmrBABUNjCJHa0FR4GN/LQ/PLGUP
    EJx6SZU16XlUXYv7FYo/t2g7uax+FyMdHj/s5ipTLaqAqaS/VsZ0PUwFM1+9Yxuc
    QQRcKkDeMNng+aQL5A3hhrfgqmcY7lnDMUPd3pifMRqw==
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
        id S932414AbeCJAUI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:20:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933237AbeCJAUG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:20:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Sebor <msebor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/36] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Fri,  9 Mar 2018 16:18:37 -0800
Message-Id: <20180310001808.517143778@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit ca79bec237f5809a7c3c59bd41cd0880aa889966 ]

gcc-8 has a new warning that detects overlapping input and output arguments
in memcpy(). It triggers for sit_init_net() calling ipip6_tunnel_clone_6rd(),
which is actually correct:

net/ipv6/sit.c: In function 'sit_init_net':
net/ipv6/sit.c:192:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

The problem here is that the logic detecting the memcpy() arguments finds them
to be the same, but the conditional that tests for the input and output of
ipip6_tunnel_clone_6rd() to be identical is not a compile-time constant.

We know that netdev_priv(t->dev) is the same as t for a tunnel device,
and comparing "dev" directly here lets the compiler figure out as well
that 'dev == sitn->fb_tunnel_dev' when called from sit_init_net(), so
it no longer warns.

This code is old, so Cc stable to make sure that we don't get the warning
for older kernels built with new gcc.

Cc: Martin Sebor <msebor@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83456
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -176,7 +176,7 @@ static void ipip6_tunnel_clone_6rd(struc
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
 
-	if (t->dev == sitn->fb_tunnel_dev) {
+	if (dev == sitn->fb_tunnel_dev) {
 		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
 		t->ip6rd.relay_prefix = 0;
 		t->ip6rd.prefixlen = 16;
