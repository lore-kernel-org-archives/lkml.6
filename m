Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B87C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692E223DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="rYvw9Glu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692E223DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeGELSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:18:01 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:15227 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753894AbeGELR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789477;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=aqTVBgAUlRCK+LAYDu6utyBdk4sV1FurHkv030PioW4=;
        b=rYvw9GluoqePq5PBMiLRIITODlNBN8RUM2Lk8PHtzjA8mmSSvUSGItp/Cbg8nVBmDi
        yggnJnzWzPkad4RkLp6hl9ZrdNfwab3y/KLbJW5nGd1MOkuZfP8diJOt+auB3sTxeUoC
        nvzcVcVoU2zJlII/xbgOrHnwrf+iFTyDB66dVbWxVei+cze7CRPxHZpOreuLs7s8wnzy
        IXiTSU5xHdDF6ZwSKyBb1IrJUF8NV3T1dv9ZBwX3QTJeDZ4gFXZiPu0L5rLOdTVut1xW
        36gLD2BzBt2GAiQT3x0Ell5Y/Dknr2YVQfyWu/ZzgA5vX7T6LPPXAGT9ZHATzWGsqagB
        vTSA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BHK4i5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:17:20 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Philipp Puschmann <pp@emlix.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] mtd: m25p80: Call spi_mem_get_name() to let controller set a custom name
Date:   Thu,  5 Jul 2018 13:14:58 +0200
Message-Id: <1530789310-16254-3-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
set a custom name for the memory device if necessary.
This is useful to keep mtdparts compatible when controller drivers are
ported from the MTD to the SPI layer.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/mtd/devices/m25p80.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..482f0ef 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
 			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
 	}
 
-	if (data && data->name)
-		nor->mtd.name = data->name;
+	nor->mtd.name = spi_mem_get_name(spimem);
 
 	/* For some (historical?) reason many platforms provide two different
 	 * names in flash_platform_data: "name" and "type". Quite often name is
-- 
2.7.4

