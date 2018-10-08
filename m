Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E21C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB7421479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekBGGG8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB7421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeJHWjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeJHWjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A36E21532;
        Mon,  8 Oct 2018 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012416;
        bh=u6/JWDiZPwm1JnwrR/UYMBeMJ9epop8I8GGkpTte0JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekBGGG8m6dyKSuJp0q3N+f8gBlC/YqmEIJvC1m2h9/nbc/nANOjXAHnsC6zYALVjM
         sRYfDFk0/XkfzbIDgcA38R5gODupKlkY61lbC0sQDqjKg2Iq5oy+f7UXjKXgNAeFIk
         zbQYF7qx6z7cQ4bI4feloeHl+fg9KBHV/VabNQs0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Friedemann Gerold <f.gerold@b-c-s.de>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/32] net: aquantia: memory corruption on jumbo frames
Date:   Mon,  8 Oct 2018 11:26:25 -0400
Message-Id: <20181008152629.70812-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Friedemann Gerold <f.gerold@b-c-s.de>

[ Upstream commit d26ed6b0e5e23190d43ab34bc69cbecdc464a2cf ]

This patch fixes skb_shared area, which will be corrupted
upon reception of 4K jumbo packets.

Originally build_skb usage purpose was to reuse page for skb to eliminate
needs of extra fragments. But that logic does not take into account that
skb_shared_info should be reserved at the end of skb data area.

In case packet data consumes all the page (4K), skb_shinfo location
overflows the page. As a consequence, __build_skb zeroed shinfo data above
the allocated page, corrupting next page.

The issue is rarely seen in real life because jumbo are normally larger
than 4K and that causes another code path to trigger.
But it 100% reproducible with simple scapy packet, like:

    sendp(IP(dst="192.168.100.3") / TCP(dport=443) \
          / Raw(RandString(size=(4096-40))), iface="enp1s0")

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")

Reported-by: Friedemann Gerold <f.gerold@b-c-s.de>
Reported-by: Michael Rauch <michael@rauch.be>
Signed-off-by: Friedemann Gerold <f.gerold@b-c-s.de>
Tested-by: Nikita Danilov <nikita.danilov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 0654e0c76bc2..640babf752ea 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -222,9 +222,10 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		}
 
 		/* for single fragment packets use build_skb() */
-		if (buff->is_eop) {
+		if (buff->is_eop &&
+		    buff->len <= AQ_CFG_RX_FRAME_MAX - AQ_SKB_ALIGN) {
 			skb = build_skb(page_address(buff->page),
-					buff->len + AQ_SKB_ALIGN);
+					AQ_CFG_RX_FRAME_MAX);
 			if (unlikely(!skb)) {
 				err = -ENOMEM;
 				goto err_exit;
@@ -244,18 +245,21 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 					buff->len - ETH_HLEN,
 					SKB_TRUESIZE(buff->len - ETH_HLEN));
 
-			for (i = 1U, next_ = buff->next,
-			     buff_ = &self->buff_ring[next_]; true;
-			     next_ = buff_->next,
-			     buff_ = &self->buff_ring[next_], ++i) {
-				skb_add_rx_frag(skb, i, buff_->page, 0,
-						buff_->len,
-						SKB_TRUESIZE(buff->len -
-						ETH_HLEN));
-				buff_->is_cleaned = 1;
-
-				if (buff_->is_eop)
-					break;
+			if (!buff->is_eop) {
+				for (i = 1U, next_ = buff->next,
+				     buff_ = &self->buff_ring[next_];
+				     true; next_ = buff_->next,
+				     buff_ = &self->buff_ring[next_], ++i) {
+					skb_add_rx_frag(skb, i,
+							buff_->page, 0,
+							buff_->len,
+							SKB_TRUESIZE(buff->len -
+							ETH_HLEN));
+					buff_->is_cleaned = 1;
+
+					if (buff_->is_eop)
+						break;
+				}
 			}
 		}
 
-- 
2.17.1

