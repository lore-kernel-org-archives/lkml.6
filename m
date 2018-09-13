Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D84C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4AB2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="TZYC+zrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4AB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIMFrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:47:11 -0400
Received: from vern.gendns.com ([206.190.152.46]:46166 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbeIMFrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T3x7bYOrJg3rL1cBTPFDBaN3nYmffcjukybCVMjRiys=; b=TZYC+zrhEMolBSa2d6k95l0v+
        pJ8T09+8jC+Xd1vi1qLmOIe4aInkcW7CIC6CFGnxDkJY8cgsn6y3pcl2KNSGkKzRcfTe7IfkMgK7e
        goZ6wQv+H2ARLFZZ7HfPDwA2W982/WJmE1x1WoUY9uaCOnpFNw2PMgLxUUww2QtH69DywcsJPGhhA
        99GNW4RPgHCH2S61Pxv4WZjGGatmWUaxm1K02bxGEq/W8ev9JfrY/ffoHviS7wyqnasELp0fqU3Hw
        YZSszslgo//nAPDc1LPdnhMYFmbh4HkcJUE1JdpEKXPTUznBflxTwZIJxIBDmR59KqVuEcJJsOelO
        9PsC2c03Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33924 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0Ffs-00AGoe-T4; Wed, 12 Sep 2018 20:40:01 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
Date:   Wed, 12 Sep 2018 19:39:20 -0500
Message-Id: <20180913003920.30600-5-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180913003920.30600-1-david@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the SPI_CS_WORD flag to the TI DaVinci SPI
driver. This mode can be used as long as we are using the hardware
chip select and not a GPIO chip select.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi-davinci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d502cf504deb..8f7dcbc53c57 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -230,7 +230,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 				!(spi->mode & SPI_CS_HIGH));
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
-			spidat1 |= SPIDAT1_CSHOLD_MASK;
+			if (!(spi->mode & SPI_CS_WORD))
+				spidat1 |= SPIDAT1_CSHOLD_MASK;
 			spidat1 &= ~(0x1 << chip_sel);
 		}
 	}
@@ -440,8 +441,12 @@ static int davinci_spi_setup(struct spi_device *spi)
 			return retval;
 		}
 
-		if (internal_cs)
+		if (internal_cs) {
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+		} else if (spi->mode & SPI_CS_WORD) {
+			dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
+			return -EINVAL;
+		}
 	}
 
 	if (spi->mode & SPI_READY)
@@ -976,7 +981,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	dspi->prescaler_limit = pdata->prescaler_limit;
 	dspi->version = pdata->version;
 
-	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
+	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_WORD;
 	if (dspi->version == SPI_VERSION_2)
 		dspi->bitbang.flags |= SPI_READY;
 
-- 
2.17.1

