Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98375C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239CA2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239CA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeIYPxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:53:44 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:57084 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:53:43 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id flmw1y00j3XaVaC01lmwdT; Tue, 25 Sep 2018 11:46:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g4jvk-0001DV-Ot; Tue, 25 Sep 2018 11:46:56 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g4jvk-0002zD-N8; Tue, 25 Sep 2018 11:46:56 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spi-mem: Fix inverted logic in op sanity check
Date:   Tue, 25 Sep 2018 11:46:55 +0200
Message-Id: <20180925094655.11438-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On r8a7791/koelsch:

    m25p80 spi0.0: error -22 reading 9f
    m25p80: probe of spi0.0 failed with error -22

Apparently the logic in spi_mem_check_op() is wrong, rejecting the
spi-mem operation if any buswidth is valid, instead of invalid.

Fixes: 380583227c0c7f52 ("spi: spi-mem: Add extra sanity checks on the op param")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cc3d425aae56c634..62a7b80801d22098 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -169,10 +169,10 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 	    (op->data.nbytes && !op->data.buswidth))
 		return -EINVAL;
 
-	if (spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->addr.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->data.buswidth))
+	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->data.buswidth))
 		return -EINVAL;
 
 	return 0;
-- 
2.17.1

