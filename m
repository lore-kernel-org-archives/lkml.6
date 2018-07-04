Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A74C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A492473C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A492473C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGDHBj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:01:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeGDHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:01:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fabnD-0000vG-Gp; Wed, 04 Jul 2018 07:01:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jes Sorensen <jes@trained-monkey.org>,
        "David S . Miller" <davem@davemloft.net>, linux-acenic@sunsite.dk,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: alteon: acenic: remove redundant pointer rxdesc
Date:   Wed,  4 Jul 2018 08:01:35 +0100
Message-Id: <20180704070135.13938-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer rxdesc is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'rxdesc' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/alteon/acenic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 8f71b79b4949..08945baee48a 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -1933,7 +1933,7 @@ static void ace_rx_int(struct net_device *dev, u32 rxretprd, u32 rxretcsm)
 	while (idx != rxretprd) {
 		struct ring_info *rip;
 		struct sk_buff *skb;
-		struct rx_desc *rxdesc, *retdesc;
+		struct rx_desc *retdesc;
 		u32 skbidx;
 		int bd_flags, desc_type, mapsize;
 		u16 csum;
@@ -1959,19 +1959,16 @@ static void ace_rx_int(struct net_device *dev, u32 rxretprd, u32 rxretcsm)
 		case 0:
 			rip = &ap->skb->rx_std_skbuff[skbidx];
 			mapsize = ACE_STD_BUFSIZE;
-			rxdesc = &ap->rx_std_ring[skbidx];
 			std_count++;
 			break;
 		case BD_FLG_JUMBO:
 			rip = &ap->skb->rx_jumbo_skbuff[skbidx];
 			mapsize = ACE_JUMBO_BUFSIZE;
-			rxdesc = &ap->rx_jumbo_ring[skbidx];
 			atomic_dec(&ap->cur_jumbo_bufs);
 			break;
 		case BD_FLG_MINI:
 			rip = &ap->skb->rx_mini_skbuff[skbidx];
 			mapsize = ACE_MINI_BUFSIZE;
-			rxdesc = &ap->rx_mini_ring[skbidx];
 			mini_count++;
 			break;
 		default:
-- 
2.17.1

