Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245D20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B245D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeK2R25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:28:57 -0500
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:57138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727406AbeK2R25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:28:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 70AA683777F0;
        Thu, 29 Nov 2018 06:24:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: error01_62fcb2d6b0622
X-Filterd-Recvd-Size: 2721
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Nov 2018 06:24:40 +0000 (UTC)
Message-ID: <d93b32c5861eb5ae552b2ed3fc65c087dc7fa328.camel@perches.com>
Subject: Re: [PATCH] staging: wilc1000: correct inconsistent indenting
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     ajay.kathat@microchip.com, adham.abozaeid@microchip.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Nov 2018 22:24:38 -0800
In-Reply-To: <20181128181724.25194-1-straube.linux@gmail.com>
References: <20181128181724.25194-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-28 at 19:17 +0100, Michael Straube wrote:
> Correct inconsistent indenting reported by smatch.
[]
> diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
[]
> @@ -963,7 +963,7 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
>  			dev_err(&spi->dev,
>  				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
>  				j, tmp, unknown_mask);
> -				happened = 1;
> +			happened = 1;s a
>  		}
>  
>  		j++;

Perhaps a little refactoring instead
---
 drivers/staging/wilc1000/wilc_spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
index 35ff432587fe..a38ddb1f0a1f 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/wilc_spi.c
@@ -927,7 +927,8 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 	int ret;
 	u32 tmp;
 	u32 byte_cnt;
-	int happened, j;
+	bool unexpected_irq;
+	int j;
 	u32 unknown_mask;
 	u32 irq_flags;
 	int k = IRG_FLAGS_OFFSET + 5;
@@ -947,8 +948,6 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 
 	j = 0;
 	do {
-		happened = 0;
-
 		wilc_spi_read_reg(wilc, 0x1a90, &irq_flags);
 		tmp |= ((irq_flags >> 27) << IRG_FLAGS_OFFSET);
 
@@ -959,15 +958,14 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 
 		unknown_mask = ~((1ul << spi_priv->nint) - 1);
 
-		if ((tmp >> IRG_FLAGS_OFFSET) & unknown_mask) {
+		unexpected_irq = (tmp >> IRG_FLAGS_OFFSET) & unknown_mask;
+		if (unexpected_irq)
 			dev_err(&spi->dev,
 				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
 				j, tmp, unknown_mask);
-				happened = 1;
-		}
 
 		j++;
-	} while (happened);
+	} while (unexpected_irq);
 
 	*int_status = tmp;
 

