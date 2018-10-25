Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA73C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0620868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSMmsHOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D0620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeJYWvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbeJYWvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C32322360;
        Thu, 25 Oct 2018 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477120;
        bh=xorLqseD6pm03RkDf+U/08Y7F+8k1kR+AU8tsh5dFV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSMmsHOaPVejweWhB/ca6FZFdwt6vH8mvX25Vf9kfsi3vh9uHfSUtSuBQnYp3F77g
         ZN8E3PbAbzHiyZnCI8OVV1d1IeWiLV6bnhkimiwdNS2aKDsJPzrV8X9ALWAQJMCWcP
         M7qR5NuYcR3pS2ruN/ogWw4wv3rljEPt4KRRfeno=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 61/65] bonding: avoid defaulting hard_header_len to ETH_HLEN on slave removal
Date:   Thu, 25 Oct 2018 10:17:01 -0400
Message-Id: <20181025141705.213937-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 19cdead3e2ef8ed765c5d1ce48057ca9d97b5094 ]

On slave list updates, the bonding driver computes its hard_header_len
as the maximum of all enslaved devices's hard_header_len.
If the slave list is empty, e.g. on last enslaved device removal,
ETH_HLEN is used.

Since the bonding header_ops are set only when the first enslaved
device is attached, the above can lead to header_ops->create()
being called with the wrong skb headroom in place.

If bond0 is configured on top of ipoib devices, with the
following commands:

ifup bond0
for slave in $BOND_SLAVES_LIST; do
	ip link set dev $slave nomaster
done
ping -c 1 <ip on bond0 subnet>

we will obtain a skb_under_panic() with a similar call trace:
	skb_push+0x3d/0x40
	push_pseudo_header+0x17/0x30 [ib_ipoib]
	ipoib_hard_header+0x4e/0x80 [ib_ipoib]
	arp_create+0x12f/0x220
	arp_send_dst.part.19+0x28/0x50
	arp_solicit+0x115/0x290
	neigh_probe+0x4d/0x70
	__neigh_event_send+0xa7/0x230
	neigh_resolve_output+0x12e/0x1c0
	ip_finish_output2+0x14b/0x390
	ip_finish_output+0x136/0x1e0
	ip_output+0x76/0xe0
	ip_local_out+0x35/0x40
	ip_send_skb+0x19/0x40
	ip_push_pending_frames+0x33/0x40
	raw_sendmsg+0x7d3/0xb50
	inet_sendmsg+0x31/0xb0
	sock_sendmsg+0x38/0x50
	SYSC_sendto+0x102/0x190
	SyS_sendto+0xe/0x10
	do_syscall_64+0x67/0x180
	entry_SYSCALL64_slow_path+0x25/0x25

This change addresses the issue avoiding updating the bonding device
hard_header_len when the slaves list become empty, forbidding to
shrink it below the value used by header_ops->create().

The bug is there since commit 54ef31371407 ("[PATCH] bonding: Handle large
hard_header_len") but the panic can be triggered only since
commit fc791b633515 ("IB/ipoib: move back IB LL address into the hard
header").

Reported-by: Norbert P <noe@physik.uzh.ch>
Fixes: 54ef31371407 ("[PATCH] bonding: Handle large hard_header_len")
Fixes: fc791b633515 ("IB/ipoib: move back IB LL address into the hard header")
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 339118f3c718..9e6159271c26 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1106,11 +1106,11 @@ static void bond_compute_features(struct bonding *bond)
 		gso_max_size = min(gso_max_size, slave->dev->gso_max_size);
 		gso_max_segs = min(gso_max_segs, slave->dev->gso_max_segs);
 	}
+	bond_dev->hard_header_len = max_hard_header_len;
 
 done:
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
-	bond_dev->hard_header_len = max_hard_header_len;
 	bond_dev->gso_max_segs = gso_max_segs;
 	netif_set_gso_max_size(bond_dev, gso_max_size);
 
-- 
2.17.1

