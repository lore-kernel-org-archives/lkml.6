Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D81AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfA1QSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:00 -0500
Received: from shell.v3.sk ([90.176.6.54]:52687 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388316AbfA1QR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1FFFFCCC91;
        Mon, 28 Jan 2019 17:17:55 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2PIk7i8RiCyM; Mon, 28 Jan 2019 17:17:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C558DCCC92;
        Mon, 28 Jan 2019 17:17:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cfMs2DyEIc94; Mon, 28 Jan 2019 17:17:51 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C532ECCC91;
        Mon, 28 Jan 2019 17:17:50 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] benet: remove broken and unused macro
Date:   Mon, 28 Jan 2019 17:17:40 +0100
Message-Id: <20190128161740.16129-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_broadcast_packet() expands to compare_ether_addr() which doesn't
exist since commit 7367d0b573d1 ("drivers/net: Convert uses of
compare_ether_addr to ether_addr_equal"). It turns out it's actually not
used.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/et=
hernet/emulex/benet/be_main.c
index d5026909dec5..3c7c04406a2b 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1270,10 +1270,6 @@ static void be_xmit_flush(struct be_adapter *adapt=
er, struct be_tx_obj *txo)
 #define is_arp_allowed_on_bmc(adapter, skb)	\
 	(is_arp(skb) && is_arp_filt_enabled(adapter))
=20
-#define is_broadcast_packet(eh, adapter)	\
-		(is_multicast_ether_addr(eh->h_dest) && \
-		!compare_ether_addr(eh->h_dest, adapter->netdev->broadcast))
-
 #define is_arp(skb)	(skb->protocol =3D=3D htons(ETH_P_ARP))
=20
 #define is_arp_filt_enabled(adapter)	\
--=20
2.20.1

