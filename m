Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE820847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfakxAlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CE820847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeKCDyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:35 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A16720837;
        Fri,  2 Nov 2018 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184382;
        bh=sdDH0iOihs1E7t16M1FajuNFq9k0F3Px3JMv9jsr3hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfakxAlUx9CPTqXKoQWYz1WyQWY4BxTsICyAsuf5E0/yYLQDoxOYQN1WHtnPjSPTk
         0M8S1m+vALAW4QeuxeKlRif0zbzDKAweZNG8RWbFwXv9OQQyj1Vv6ld4Rc5UEsHesI
         azVb91q8xqv4NWdpEDbux+buxSyXn6bDSaCRTWfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 4.18 150/150] net: bridge: remove ipv6 zero address check in mcast queries
Date:   Fri,  2 Nov 2018 19:35:12 +0100
Message-Id: <20181102182912.786826018@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 0fe5119e267f3e3d8ac206895f5922195ec55a8a upstream.

Recently a check was added which prevents marking of routers with zero
source address, but for IPv6 that cannot happen as the relevant RFCs
actually forbid such packets:
RFC 2710 (MLDv1):
"To be valid, the Query message MUST
 come from a link-local IPv6 Source Address, be at least 24 octets
 long, and have a correct MLD checksum."

Same goes for RFC 3810.

And also it can be seen as a requirement in ipv6_mc_check_mld_query()
which is used by the bridge to validate the message before processing
it. Thus any queries with :: source address won't be processed anyway.
So just remove the check for zero IPv6 source address from the query
processing function.

Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_multicast.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1426,8 +1426,7 @@ static void br_multicast_query_received(
 	 * is 0.0.0.0 should not be added to router port list.
 	 */
 	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    (saddr->proto == htons(ETH_P_IPV6) &&
-	     !ipv6_addr_any(&saddr->u.ip6)))
+	    saddr->proto == htons(ETH_P_IPV6))
 		br_multicast_mark_router(br, port);
 }
 


