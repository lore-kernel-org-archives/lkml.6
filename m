Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B67C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5569263B6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nBXosJ5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5569263B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964872AbeF0MPX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:15:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54092 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeF0MPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:15:22 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] clk: ingenic: Fix incorrect data for the i2s clock
Date:   Wed, 27 Jun 2018 14:14:58 +0200
Message-Id: <20180627121459.13987-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530101721; bh=kj95zYmaS1loJB4uJtzwSBHb9jt8iEKhgtmfXJ8xv0A=; h=From:To:Cc:Subject:Date:Message-Id; b=nBXosJ5hRQmMo+0F+qJF472eT5OXo0C1z8FMG8Q8KhiAup6tmIdbCS+xqNLHDat7QD/ZiX3pi6tA1fY/pX/bqMrKrVYRw0ePumAawENQdOr1SxgXWBSERhlOUcvkXOMYW7QHbq576I8IE07GGQ4hRRvbX+oh/3anhC5L8BUk1Hk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register field for configuring the divider for the i2s clock
occupies the bits [8-0], which means 9 bits and not 8.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4740-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 32fcc75f6f77..bc073dd4470d 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -134,7 +134,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
 		.mux = { CGU_REG_CPCCR, 31, 1 },
-		.div = { CGU_REG_I2SCDR, 0, 1, 8, -1, -1, -1 },
+		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 6 },
 	},
 
-- 
2.11.0

