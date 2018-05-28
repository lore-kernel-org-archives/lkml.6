Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164088AbeE1KxI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164055AbeE1Kwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 260/496] batman-adv: fix header size check in batadv_dbg_arp()
Date: Mon, 28 May 2018 12:00:45 +0200
Message-Id: <20180528100330.824155232@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <mschiffer@universe-factory.net>

[ Upstream commit 6f27d2c2a8c236d296201c19abb8533ec20d212b ]

Checking for 0 is insufficient: when an SKB without a batadv header, but
with a VLAN header is received, hdr_size will be 4, making the following
code interpret the Ethernet header as a batadv header.

Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/distributed-arp-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -391,7 +391,7 @@ static void batadv_dbg_arp(struct batadv
 		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
 		   batadv_arp_hw_dst(skb, hdr_size), &ip_dst);
 
-	if (hdr_size == 0)
+	if (hdr_size < sizeof(struct batadv_unicast_packet))
 		return;
 
 	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
