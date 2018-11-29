Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0469C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65317208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dArobZo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65317208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeK2RGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:59 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9560821104;
        Thu, 29 Nov 2018 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471308;
        bh=3pjTNHMSJIv3ge0q4+UT4yfiTSzTxwDGpR82iYL29Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dArobZo+xJYjhscaGMshJCAlRGDJw/3LOdbDi98C92rDgXu29AaB20f2jAtvbr1jW
         k2KTZO2xKe6bp1BsmO9diHqm+h0g269Os54/aLd2ngeOEgL1qQMzvVMl3wLKmPyGB1
         tLXDMt7a3FvdGn64R7DpFw0FoihHCw+SnXAK+JhQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/35] batman-adv: Use explicit tvlv padding for ELP packets
Date:   Thu, 29 Nov 2018 01:00:42 -0500
Message-Id: <20181129060110.159878-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit f4156f9656feac21f4de712fac94fae964c5d402 ]

The announcement messages of batman-adv COMPAT_VERSION 15 have the
possibility to announce additional information via a dynamic TVLV part.
This part is optional for the ELP packets and currently not parsed by the
Linux implementation. Still out-of-tree versions are using it to transport
things like neighbor hashes to optimize the rebroadcast behavior.

Since the ELP broadcast packets are smaller than the minimal ethernet
packet, it often has to be padded. This is often done (as specified in
RFC894) with octets of zero and thus work perfectly fine with the TVLV
part (making it a zero length and thus empty). But not all ethernet
compatible hardware seems to follow this advice. To avoid ambiguous
situations when parsing the TVLV header, just force the 4 bytes (TVLV
length + padding) after the required ELP header to zero.

Fixes: d6f94d91f766 ("batman-adv: ELP - adding basic infrastructure")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e92dfedccc16..fbc132f4670e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -338,19 +338,21 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
  */
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
+	static const size_t tvlv_padding = sizeof(__be32);
 	struct batadv_elp_packet *elp_packet;
 	unsigned char *elp_buff;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
 
-	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
+	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN + tvlv_padding;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
 	if (!hard_iface->bat_v.elp_skb)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb,
+				BATADV_ELP_HLEN + tvlv_padding);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
 
 	elp_packet->packet_type = BATADV_ELP;
-- 
2.17.1

