Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425423AbeE1Q3n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936412AbeE1KJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 096/185] vti4: Dont count header length twice on tunnel setup
Date: Mon, 28 May 2018 12:02:17 +0200
Message-Id: <20180528100059.114484009@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit dd1df24737727e119c263acf1be2a92763938297 ]

This re-introduces the effect of commit a32452366b72 ("vti4:
Don't count header length twice.") which was accidentally
reverted by merge commit f895f0cfbb77 ("Merge branch 'master' of
git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec").

The commit message from Steffen Klassert said:

    We currently count the size of LL_MAX_HEADER and struct iphdr
    twice for vti4 devices, this leads to a wrong device mtu.
    The size of LL_MAX_HEADER and struct iphdr is already counted in
    ip_tunnel_bind_dev(), so don't do it again in vti_tunnel_init().

And this is still the case now: ip_tunnel_bind_dev() already
accounts for the header length of the link layer (not
necessarily LL_MAX_HEADER, if the output device is found), plus
one IP header.

For example, with a vti device on top of veth, with MTU of 1500,
the existing implementation would set the initial vti MTU to
1332, accounting once for LL_MAX_HEADER (128, included in
hard_header_len by vti) and twice for the same IP header (once
from hard_header_len, once from ip_tunnel_bind_dev()).

It should instead be 1480, because ip_tunnel_bind_dev() is able
to figure out that the output device is veth, so no additional
link layer header is attached, and will properly count one
single IP header.

The existing issue had the side effect of avoiding PMTUD for
most xfrm policies, by arbitrarily lowering the initial MTU.
However, the only way to get a consistent PMTU value is to let
the xfrm PMTU discovery do its course, and commit d6af1a31cc72
("vti: Add pmtu handling to vti_xmit.") now takes care of local
delivery cases where the application ignores local socket
notifications.

Fixes: b9959fd3b0fa ("vti: switch to new ip tunnel code")
Fixes: f895f0cfbb77 ("Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_vti.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -365,7 +365,6 @@ static int vti_tunnel_init(struct net_de
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
-	dev->hard_header_len	= LL_MAX_HEADER + sizeof(struct iphdr);
 	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->iflink		= 0;
