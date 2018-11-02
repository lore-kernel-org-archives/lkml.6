Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A5BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090592084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgOgtFRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090592084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbeKCEDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:51 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE5F20848;
        Fri,  2 Nov 2018 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184935;
        bh=rwvfxiLOljAcw5bNoVqol4RpGGACl7kxGwqK12/Uzbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgOgtFRpahFANhsragTyXI4Cnt55+1iy8bV3K15OoaxiefacBZ6olYxkJy4vIFjgs
         XqaUmvq9IG3OCa2x6Ssad7zxkmqXEgV76fpxi4GmtXT950ugxroyIa7gU1k6JYNpJr
         pT40yThMcPRbuCiGPCbHs0Crw5fI4s2I6F8fLdpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Adrian Bunk <bunk@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 107/143] mtd: spi-nor: Add support for is25wp series chips
Date:   Fri,  2 Nov 2018 19:34:52 +0100
Message-Id: <20181102182906.395225919@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d616f81cdd2a21edfa90a595a4e9b143f5ba8414 ]

Added support for is25wp032, is25wp064 and is25wp128.

Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[ Adrian Bunk: Trivial adaption to changed context. ]
Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 19c000722cbc..34ecc12ee3d9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1005,6 +1005,12 @@ static const struct flash_info spi_nor_ids[] = {
 
 	/* ISSI */
 	{ "is25cd512", INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
+	{ "is25wp032", INFO(0x9d7016, 0, 64 * 1024,  64,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp064", INFO(0x9d7017, 0, 64 * 1024, 128,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp128", INFO(0x9d7018, 0, 64 * 1024, 256,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
-- 
2.17.1



