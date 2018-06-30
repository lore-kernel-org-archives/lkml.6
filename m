Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5007C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E224EF6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dU0/PMhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E224EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbeF3KyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:54:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeF3KyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:54:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5UArgTx024488;
        Sat, 30 Jun 2018 05:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530356022;
        bh=LDH0ExJEQ/R9fsfTDeRQtHgbkKstgUbDK3kdVCzrl9c=;
        h=From:To:CC:Subject:Date;
        b=dU0/PMhd27cVQwdt+cjQEqnfH8GQSnc53Csmrt+ZpsLnB/Ht/htgneowSeDA2b6m/
         M56wIuHDj/4ct64120AHLy/G162Qa6rv8zU169tc0u/6jiMk0MYTUao5gJt2w5vbUy
         Y07SkB/2BgyQYHLU5FAaVW1mCEsA8ahx+QOVEfxc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UArgpZ018864;
        Sat, 30 Jun 2018 05:53:42 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 30
 Jun 2018 05:53:42 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 30 Jun 2018 05:53:42 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UArdOo031136;
        Sat, 30 Jun 2018 05:53:40 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: Fix direct mode write timeouts
Date:   Sat, 30 Jun 2018 16:24:21 +0530
Message-ID: <20180630105421.550-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when writing large size files to flash in direct/memory mapped
mode, it is seen that flash write enable command times out with error:
[  503.146293] cadence-qspi 47040000.ospi: Flash command execution timed out.

This is because, we need to make sure previous direct write operation
is complete by polling for IDLE bit in CONFIG_REG before starting the
next operation.

Fix this by polling for IDLE bit after memory mapped write.

Fixes: a27f2eaf2b27 ("mtd: spi-nor: cadence-quadspi: Add support for direct access mode")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index c3f7aaa5d18f..d7e10b36a0b9 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -926,10 +926,12 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
 	if (ret)
 		return ret;
 
-	if (f_pdata->use_direct_mode)
+	if (f_pdata->use_direct_mode) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
-	else
+		ret = cqspi_wait_idle(cqspi);
+	} else {
 		ret = cqspi_indirect_write_execute(nor, to, buf, len);
+	}
 	if (ret)
 		return ret;
 
-- 
2.18.0

