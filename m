Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A827345
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012A827345
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965649AbeF1Mm6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:42:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46886 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965476AbeF1Mm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:42:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3204720DCD; Thu, 28 Jun 2018 14:42:54 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id D319020CFE;
        Thu, 28 Jun 2018 14:42:43 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 4/4] net: mvpp2: Use htons when checking protocol info
Date:   Thu, 28 Jun 2018 14:42:07 +0200
Message-Id: <20180628124207.11635-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
References: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking the skb->protocol field, we have to make sure we use the
proper endianness using htons, and not swab16.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ded187a20b6c..88f3da184d76 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1738,7 +1738,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_proto,
 	command |= (ip_hdr_len << MVPP2_TXD_IP_HLEN_SHIFT);
 	command |= MVPP2_TXD_IP_CSUM_DISABLE;
 
-	if (l3_proto == swab16(ETH_P_IP)) {
+	if (l3_proto == htons(ETH_P_IP)) {
 		command &= ~MVPP2_TXD_IP_CSUM_DISABLE;	/* enable IPv4 csum */
 		command &= ~MVPP2_TXD_L3_IP6;		/* enable IPv4 */
 	} else {
-- 
2.11.0

