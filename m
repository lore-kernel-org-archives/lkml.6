Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6F2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Ua57QojD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6F2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbeIRWnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:51325 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbeIRWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HNlo3xyc6igs5gw6PG6FCqhsrp4IMHY7I7PXOCtKR3g=; b=Ua57QojDERr54TiQFBWLH0OdD
        NdeJcidJ0dWq4phGknkyjTLsj+rqDYXxsqZnioD44B8RoD41Cb22ZtEcj7LEQEUO68ETndSc0/Qsm
        jer2L88MK2E/dR2gOgf6A8Prcv2sZTRCm5YN953oh3Mzh8RsDknjSCUHXcvIeVyCb3cgGcDuJl1Ze
        fq3k0pB9vvhOQxLtyjuEd0S+qZdXCCbpNgx1j5EOoFaLaGaSYN2HZhqG0b88wybHCiERFSLa3NL/5
        Z/SEyn0ngJzJYe/OQiMWJ6DUQUe32lmfbe5HfLRHT1uRb05owaCDrSnJE08SVitNfmSAM/SkYU4Ao
        YU65gLEoA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37876 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g2JVD-0074xZ-53; Tue, 18 Sep 2018 13:09:31 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio
Date:   Tue, 18 Sep 2018 12:08:49 -0500
Message-Id: <20180918170850.2749-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918170850.2749-1-david@lechnology.com>
References: <20180918170850.2749-1-david@lechnology.com>
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

This remove the check and subsequent return of error for the case when
a SPI device requires SPI_CS_WORD and is also configured to use a GPIO
for the CS line.

Commit a134cc414e86 ("spi: always use software fallback for SPI_CS_WORD
when using cs_gio") handles this case now, so this check is no longer
necessary.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 205f763c7383..56adec83f8fc 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -441,9 +441,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 		if (internal_cs) {
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
-		} else if (spi->mode & SPI_CS_WORD) {
-			dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
-			return -EINVAL;
 		}
 	}
 
-- 
2.17.1

