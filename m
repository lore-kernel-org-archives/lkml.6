Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C732084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="raSMigKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C732084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeKLKDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbeKLIRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:16 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B242154B;
        Sun, 11 Nov 2018 22:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975241;
        bh=q7opT+EaDE7aYma98OrY3+zku8FzLbvUjxF78nU/hkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raSMigKZH7TMRS3j8m+OgkGvxhpnssa+C8c0tzHtA99j26kJ4nZs+Xyxx7fzGvWr3
         +f/7Q8wetFGKaSD1JVOK2RSrMPdvUSlyOvUqmG6mHV1lXJS8pq504LLoJreCbebKrv
         5AsqOg155kJyZxZuSQ2jVoQYk/g2mluSQKaXomDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/361] mtd: rawnand: atmel: Fix potential NULL pointer dereference
Date:   Sun, 11 Nov 2018 14:17:11 -0800
Message-Id: <20181111221631.682136291@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2063,6 +2063,10 @@ atmel_hsmc_nand_controller_legacy_init(s
 	nand_np = dev->of_node;
 	nfc_np = of_find_compatible_node(dev->of_node, NULL,
 					 "atmel,sama5d3-nfc");
+	if (!nfc_np) {
+		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
+		return -ENODEV;
+	}
 
 	nc->clk = of_clk_get(nfc_np, 0);
 	if (IS_ERR(nc->clk)) {


