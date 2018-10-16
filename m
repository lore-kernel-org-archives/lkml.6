Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F747C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AED2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Vg25in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AED2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeJQBJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbeJQBJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8EC2089E;
        Tue, 16 Oct 2018 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710299;
        bh=94XOFJBcegfgbW0hJVuWgVkNtzlIAvGuNDPy2R/iPw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/Vg25inRNEDX5hkFLQhX0dPUlR+09VIhbty8Ve4XP21+KvLD2xJHJJ4AQg0iB6Gx
         4Jsod5JWlX+xEKqeINSFnV9c95Z4ErYEMEYRIymfrlr6ZfIg5oO265TEp/w9slcNfQ
         pGOliOb3ZAbLi+0Xe972h2vQjF1bPvW4SBkJNtio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Friedemann Gerold <f.gerold@b-c-s.de>,
        Michael Rauch <michael@rauch.be>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 030/109] net: aquantia: memory corruption on jumbo frames
Date:   Tue, 16 Oct 2018 19:04:58 +0200
Message-Id: <20181016170526.700170185@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c |   32 ++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -222,9 +222,10 @@ int aq_ring_rx_clean(struct aq_ring_s *s
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
@@ -244,18 +245,21 @@ int aq_ring_rx_clean(struct aq_ring_s *s
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
 


