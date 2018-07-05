Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB86C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F082418D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F082418D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeGEJzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:55:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57821 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:55:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb0zN-0007O5-FJ; Thu, 05 Jul 2018 09:55:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: tehuti: remove redundant pointer skb
Date:   Thu,  5 Jul 2018 10:55:49 +0100
Message-Id: <20180705095549.22042-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer skb is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'skb' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/tehuti/tehuti.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index 163d8d16bc24..dc966ddb6d81 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1151,7 +1151,6 @@ static void bdx_recycle_skb(struct bdx_priv *priv, struct rxd_desc *rxdd)
 	struct rx_map *dm;
 	struct rxf_fifo *f;
 	struct rxdb *db;
-	struct sk_buff *skb;
 	int delta;
 
 	ENTER;
@@ -1161,7 +1160,6 @@ static void bdx_recycle_skb(struct bdx_priv *priv, struct rxd_desc *rxdd)
 	DBG("db=%p f=%p\n", db, f);
 	dm = bdx_rxdb_addr_elem(db, rxdd->va_lo);
 	DBG("dm=%p\n", dm);
-	skb = dm->skb;
 	rxfd = (struct rxf_desc *)(f->m.va + f->m.wptr);
 	rxfd->info = CPU_CHIP_SWAP32(0x10003);	/* INFO=1 BC=3 */
 	rxfd->va_lo = rxdd->va_lo;
-- 
2.17.1

