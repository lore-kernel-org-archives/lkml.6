Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82452070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498361;
	bh=reaNy0NIcuPvE4vcbar+5H7ObmV5mD9TSV7tWztsKlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DYcaElOrNTCi7laTI5hm7CUUodNmKfG1/K7uEFcsHKQ234jn4+yGmZX2W5eI/3TGC
	 cIGZfhTMyxP5KkHR+gNWUxO/IjKanFFTBtbioZhvHn+C4PNpJQTsjKVSroG3F51n2K
	 AhGwdWSzRlpUaEfIwxT6rPEw8L2gYkAPtsGfA+rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbfBRN7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387427AbfBRN7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4012070D;
        Mon, 18 Feb 2019 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498357;
        bh=reaNy0NIcuPvE4vcbar+5H7ObmV5mD9TSV7tWztsKlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zukxis4/FijhvPt/W911kuCHMy+3kSIqz+JZbdvrD+fJUzFmhwWjkwTeT3ceXXca2
         wlJVsyegqZkSANb7BrjsHa2A/Ed9/pAOqlDyGiFg16Z6Ea9BGeNBcM/c+nnUbY3g1z
         1UZzTZufN4D+E1iC2FPmVh0xBt10tNUHeW7r+lKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/58] bnx2x: disable GSO where gso_size is too big for hardware
Date:   Mon, 18 Feb 2019 14:43:42 +0100
Message-Id: <20190218133510.187123708@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 8914a595110a6eca69a5e275b323f5d09e18f4f9 upstream

If a bnx2x card is passed a GSO packet with a gso_size larger than
~9700 bytes, it will cause a firmware error that will bring the card
down:

bnx2x: [bnx2x_attn_int_deasserted3:4323(enP24p1s0f0)]MC assert!
bnx2x: [bnx2x_mc_assert:720(enP24p1s0f0)]XSTORM_ASSERT_LIST_INDEX 0x2
bnx2x: [bnx2x_mc_assert:736(enP24p1s0f0)]XSTORM_ASSERT_INDEX 0x0 = 0x00000000 0x25e43e47 0x00463e01 0x00010052
bnx2x: [bnx2x_mc_assert:750(enP24p1s0f0)]Chip Revision: everest3, FW Version: 7_13_1
... (dump of values continues) ...

Detect when the mac length of a GSO packet is greater than the maximum
packet size (9700 bytes) and disable GSO.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[jwang: cherry pick for CVE-2018-1000026]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 4bc2c806eb61..eeeb4c5740bf 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -12979,6 +12979,24 @@ static netdev_features_t bnx2x_features_check(struct sk_buff *skb,
 					      struct net_device *dev,
 					      netdev_features_t features)
 {
+	/*
+	 * A skb with gso_size + header length > 9700 will cause a
+	 * firmware panic. Drop GSO support.
+	 *
+	 * Eventually the upper layer should not pass these packets down.
+	 *
+	 * For speed, if the gso_size is <= 9000, assume there will
+	 * not be 700 bytes of headers and pass it through. Only do a
+	 * full (slow) validation if the gso_size is > 9000.
+	 *
+	 * (Due to the way SKB_BY_FRAGS works this will also do a full
+	 * validation in that case.)
+	 */
+	if (unlikely(skb_is_gso(skb) &&
+		     (skb_shinfo(skb)->gso_size > 9000) &&
+		     !skb_gso_validate_mac_len(skb, 9700)))
+		features &= ~NETIF_F_GSO_MASK;
+
 	features = vlan_features_check(skb, features);
 	return vxlan_features_check(skb, features);
 }
-- 
2.19.1



