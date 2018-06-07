Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BYU6M89BGVuddAAAmS7hNA
	; Thu, 07 Jun 2018 14:31:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 18AF6607E7; Thu,  7 Jun 2018 14:31:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 82AA76063F;
	Thu,  7 Jun 2018 14:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82AA76063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933804AbeFGObn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:31:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40253 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932913AbeFGObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:31:40 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbN-0005a0-3K; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Gs-IN; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "Sabrina Dubroca" <sd@queasysnail.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.951852808@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 374/410] vti4: Don't count header length twice on
 tunnel setup
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

commit dd1df24737727e119c263acf1be2a92763938297 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/ip_vti.c | 1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -359,7 +359,6 @@ static int vti_tunnel_init(struct net_de
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
-	dev->hard_header_len	= LL_MAX_HEADER + sizeof(struct iphdr);
 	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->iflink		= 0;
