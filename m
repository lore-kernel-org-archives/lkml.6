Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B9B2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfBCOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55902 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730603AbfBCOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:41 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeR-0006T3-MH; Sun, 03 Feb 2019 14:21:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9i-0007Dq-28; Sun, 03 Feb 2019 14:49:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.329975308@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 207/305] net-gro: reset skb->pkt_type in napi_reuse_skb()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 33d9a2c72f086cbf1087b2fd2d1a15aa9df14a7f upstream.

eth_type_trans() assumes initial value for skb->pkt_type
is PACKET_HOST.

This is indeed the value right after a fresh skb allocation.

However, it is possible that GRO merged a packet with a different
value (like PACKET_OTHERHOST in case macvlan is used), so
we need to make sure napi->skb will have pkt_type set back to
PACKET_HOST.

Otherwise, valid packets might be dropped by the stack because
their pkt_type is not PACKET_HOST.

napi_reuse_skb() was added in commit 96e93eab2033 ("gro: Add
internal interfaces for VLAN"), but this bug always has
been there.

Fixes: 96e93eab2033 ("gro: Add internal interfaces for VLAN")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4170,6 +4170,10 @@ static void napi_reuse_skb(struct napi_s
 	skb->vlan_tci = 0;
 	skb->dev = napi->dev;
 	skb->skb_iif = 0;
+
+	/* eth_type_trans() assumes pkt_type is PACKET_HOST */
+	skb->pkt_type = PACKET_HOST;
+
 	skb->encapsulation = 0;
 	skb_shinfo(skb)->gso_type = 0;
 	skb->truesize = SKB_TRUESIZE(skb_end_offset(skb));

