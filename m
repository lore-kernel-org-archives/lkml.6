Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072EC61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102262133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="B06DEJ85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102262133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeIMFrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:47:02 -0400
Received: from vern.gendns.com ([206.190.152.46]:46153 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbeIMFrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HGhbgAqHWtAOSQXGQmSRWuXfZcabuZIwSzqWuXebhNI=; b=B06DEJ85p9daS09m9fm+Qbs9X
        dKX+/7Zfp/2WYRPensoZ34z7P35ZkMWqXBeq9YwusUBQaOeIxkU+HpjI44OwGVKNWE6WbWCSX4Htq
        r2rBg5jnpH516vYSthwvJYJFTYhygRB0KL2gYoCKwcDcd6t65AwLdIPgNhy1G+aOC27bE5PDz1sAa
        w7F0PVrKGMvN9CxINSAnkWbu3+wg2JTdDqs2k509/4axjWCzOYvg0L36M6zao2qdBoVA0TaZbVZPx
        nJMBvOakUu+GZsKHmFfpXVOezSIXTZK3TDYRH2VeLlQQwqrGYtFYhhHwG2B5ka/NFjdFhvUerHmcG
        189ahfNTA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33924 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0Ffq-00AGoe-JV; Wed, 12 Sep 2018 20:39:58 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] spi: add software implementation for SPI_CS_WORD
Date:   Wed, 12 Sep 2018 19:39:18 -0500
Message-Id: <20180913003920.30600-3-david@lechnology.com>
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

This adds a default software implementation for the SPI_CS_WORD flag for
controllers that don't have such a feature.

The SPI_CS_WORD flag indicates that the CS line should be toggled
between each word sent, not just between each transfer. The
implementation works by using existing functions to split transfers into
one-word-sized transfers and sets the cs_change bit for each of the
new transfers.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi.c | 31 +++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036c..84518ed58872 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2783,8 +2783,10 @@ int spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
+	 * SPI_CS_WORD has a fallback software implementation,
+	 * so it is ignored here.
 	 */
-	bad_bits = spi->mode & ~spi->controller->mode_bits;
+	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
 	if (ugly_bits) {
@@ -2838,6 +2840,33 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	/* If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
+		size_t maxsize;
+		int ret;
+
+		maxsize = (spi->bits_per_word + 7) / 8;
+
+		/* spi_split_transfers_maxsize() requires message->spi */
+		message->spi = spi;
+
+		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
+						  GFP_KERNEL);
+		if (ret)
+			return ret;
+
+		list_for_each_entry(xfer, &message->transfers, transfer_list) {
+			/* don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &message->transfers))
+				break;
+			xfer->cs_change = 1;
+		}
+	}
+
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
-- 
2.17.1

