Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D321C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5E921A32
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5E921A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeHFTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:00:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:00:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fmiiT-0006PI-Q9; Mon, 06 Aug 2018 16:50:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sunil Goutham <sgoutham@cavium.com>,
        Robert Richter <rric@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: thunderx: check for failed allocation lmac->dmacs
Date:   Mon,  6 Aug 2018 17:50:45 +0100
Message-Id: <20180806165045.15707-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The allocation of lmac->dmacs is not being checked for allocation
failure. Add the check.

Fixes: 3a34ecfd9d3f ("net: thunderx: add MAC address filter tracking for LMAC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 5d08d2aeb172..e337da6ba2a4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1083,6 +1083,8 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 	lmac->dmacs_count = (RX_DMAC_COUNT / bgx->lmac_count);
 	lmac->dmacs = kcalloc(lmac->dmacs_count, sizeof(*lmac->dmacs),
 			      GFP_KERNEL);
+	if (!lmac->dmacs)
+		return -ENOMEM;
 
 	/* Enable lmac */
 	bgx_reg_modify(bgx, lmacid, BGX_CMRX_CFG, CMR_EN);
-- 
2.17.1

