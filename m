Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106B2151C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXxv7m5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106B2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeJHWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbeJHWi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BF721502;
        Mon,  8 Oct 2018 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012373;
        bh=uNW39bScbjX/4nULeg8A845SEHdemUUqg2Cgv1NAmls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXxv7m5Mf/20C9I9uJ3BkVrw96E90x0vhrFij1RL2JC2+nVkKj2VXGx0RXShmDvGO
         5d8w+jWXcar3SY0vR1kwod4HOS7FNtSGi52teL1glw6fw+vTfg4y1mFl9SYYrlrMSu
         iGEtovhbNgUgHhuxTeX+G90s55O+6P3DvGrnpNxY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Friedemann Gerold <f.gerold@b-c-s.de>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/58] net: aquantia: memory corruption on jumbo frames
Date:   Mon,  8 Oct 2018 11:25:14 -0400
Message-Id: <20181008152523.70705-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
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
index b5f1f62e8e25..d1e1a0ba8615 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -225,9 +225,10 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
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
@@ -247,18 +248,21 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
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

