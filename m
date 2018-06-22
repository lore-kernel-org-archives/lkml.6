Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB806C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D324589
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bCryuHPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7D324589
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934308AbeFVQJ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:09:29 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30603 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeFVQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:08:16 -0400
X-Greylist: delayed 9753 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2018 12:08:16 EDT
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5MG6m5b022587;
        Sat, 23 Jun 2018 01:06:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5MG6m5b022587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529683610;
        bh=pdf/O8QHUqt1xQlmY1D7Yg8YTRJXS1L0AwRzgL1wC9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCryuHPBgmvG8KxL/cqaGRl4BiQyssZDN+L8N6z6U1z39WHatKlJl7hpPKXvI0Lz1
         jwPsLnWmW3THSiyNfqf+1rN2iw0sF5Ksqdlf7oRn30I12B8rJKQle6XD6NySU4FAfZ
         fQmmKDCjS52N8nkqWU1iKMQbwtz35+4ImX8nWh87OmhHi8r46lqzNBlKR8zdFZypGv
         7cV7p+CiakuEmPG1cz8D9jNrOsSfB5HdWqODeNSyL80CoGePqBWJiEq7v/Y2gU4S/1
         lqQmQufTFndeQkTGBBLxa6q1e5Z1yYwirI+3a2DWMOGqW/wPCIbCkB0/5lfozYlkVY
         A08KBZn3+OsRA==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v4 1/5] mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally
Date:   Sat, 23 Jun 2018 01:06:34 +0900
Message-Id: <1529683598-25783-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1bb88666775e ("mtd: nand: denali: handle timing parameters
by setup_data_interface()"), denali_dt.c gets the clock rate from the
clock driver.  The driver expects the frequency of the bus interface
clock, whereas the clock driver of SOCFPGA provides the core clock.
Thus, the setup_data_interface() hook calculates timing parameters
based on a wrong frequency.

To make it work without relying on the clock driver, hard-code the clock
frequency, 200MHz.  This is fine for existing DT of UniPhier, and also
fixes the issue of SOCFPGA because both platforms use 200 MHz for the
bus interface clock.

Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
Cc: linux-stable <stable@vger.kernel.org> #4.14+
Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Richard Weinberger <richard@nod.at>
---

Changes in v4:
  - split into a very simple patch for backport candiate

 drivers/mtd/nand/raw/denali_dt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index cfd33e6..5869e90 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -123,7 +123,11 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	denali->clk_x_rate = clk_get_rate(dt->clk);
+	/*
+	 * Hardcode the clock rate for the backward compatibility.
+	 * This works for both SOCFPGA and UniPhier.
+	 */
+	denali->clk_x_rate = 200000000;
 
 	ret = denali_init(denali);
 	if (ret)
-- 
2.7.4

