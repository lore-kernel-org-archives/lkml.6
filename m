Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683A621841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130621;
	bh=paSh/sJFCwCKqMx1H2JQ8yDMI7N0q3iDUCrIwbxd3FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zK1B7X5ZXRxvU/OIbwn/eQqiIx69bkn4xvIfr9r2eVh4XPiRKax6CptbYfuS/8gtj
	 nklche/rOR0I3XWUJSnatUqSPN66PJUuOUzbcvaatbr/HyyDRF7mZavkhkZMkDXAyR
	 +je9EV/qZrKUi4LIAflDboWLeoncs0OdcPQANa/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbfBYVhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbfBYVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1DE217F5;
        Mon, 25 Feb 2019 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130618;
        bh=paSh/sJFCwCKqMx1H2JQ8yDMI7N0q3iDUCrIwbxd3FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx51nCnYfv0MdVDpphoYm+U4ZIYyoA5gT99YfHjK8hp4S91RaBC4M2UV5uW+KVm6R
         E9L+E35ikhKB6wtB6BWFKCkOTFmJwQDPBlGG9ywHxXce7uokMNbSJMrc8irs2E6G9C
         gB7+qCZJA6jPDwzqyEZOkEitiSmnDSnw7a1JcSJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 177/183] Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"
Date:   Mon, 25 Feb 2019 22:12:30 +0100
Message-Id: <20190225195124.985027486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

commit 278e2148c07559dd4ad8602f22366d61eb2ee7b7 upstream.

This reverts commit 5a2de63fd1a5 ("bridge: do not add port to router list
when receives query with source 0.0.0.0") and commit 0fe5119e267f ("net:
bridge: remove ipv6 zero address check in mcast queries")

The reason is RFC 4541 is not a standard but suggestive. Currently we
will elect 0.0.0.0 as Querier if there is no ip address configured on
bridge. If we do not add the port which recives query with source
0.0.0.0 to router list, the IGMP reports will not be about to forward
to Querier, IGMP data will also not be able to forward to dest.

As Nikolay suggested, revert this change first and add a boolopt api
to disable none-zero election in future if needed.

Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Reported-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Fixes: 0fe5119e267f ("net: bridge: remove ipv6 zero address check in mcast queries")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_multicast.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1422,14 +1422,7 @@ static void br_multicast_query_received(
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-
-	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
-	 * the arrival port for IGMP Queries where the source address
-	 * is 0.0.0.0 should not be added to router port list.
-	 */
-	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    saddr->proto == htons(ETH_P_IPV6))
-		br_multicast_mark_router(br, port);
+	br_multicast_mark_router(br, port);
 }
 
 static void br_ip4_multicast_query(struct net_bridge *br,


