Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC625C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1420847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEk7j6HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF1420847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeKAI1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeKAIKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6967B20840;
        Wed, 31 Oct 2018 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027408;
        bh=lYf/8w0NLs3qnhGNga5kU9UzAUFodpMAeTht1q5mq+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEk7j6HQ3An2JuZbFvUTBuJ+a7ski0+BASI73tU24i9OjTmczyj99cp290Kp4PxAg
         eUqYoKnkyP6jljT2kJOo0+x6l/VBOdBwIi4Y5hM/GrIs+2SzcEEmajpD7pvF5Iuni7
         vBuqL+2bmxyqYU09m4sZgiDORNivV3cVeCpMjnJw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 21/73] mtd: rawnand: atmel: Fix potential NULL pointer dereference
Date:   Wed, 31 Oct 2018 19:08:56 -0400
Message-Id: <20181031230948.29203-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit fbed20280d912449cfb40c382cb55e3d11502587 ]

There is a potential execution path in which function
of_find_compatible_node() returns NULL. In such a case,
we end up having a NULL pointer dereference when accessing
pointer *nfc_np* in function of_clk_get().

So, we better don't take any chances and fix this by null
checking pointer *nfc_np* before calling of_clk_get().

Addresses-Coverity-ID: 1473052 ("Dereference null return value")
Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/atmel/nand-controller.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 148744418e82..32a2f947a454 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -2079,6 +2079,10 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	nand_np = dev->of_node;
 	nfc_np = of_find_compatible_node(dev->of_node, NULL,
 					 "atmel,sama5d3-nfc");
+	if (!nfc_np) {
+		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
+		return -ENODEV;
+	}
 
 	nc->clk = of_clk_get(nfc_np, 0);
 	if (IS_ERR(nc->clk)) {
-- 
2.17.1

