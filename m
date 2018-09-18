Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6FEECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C23206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="VX01wqp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C23206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeIRWnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:04 -0400
Received: from vern.gendns.com ([206.190.152.46]:51319 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbeIRWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CVEZQfhpOax9V6w0fywqhXogT8tOUapZhE83QXy6kl4=; b=VX01wqp2ekQc5sd9DU9Xtm3wz
        rHlWXcmbNeEZqoz/m5/juvXTxxDXFP7RC+5YF19fxiTW/Tl9bmeoMkwngcdYO7ix8owmHAxEn99JC
        /DFM2MdlmZQzWOuZ6xNouBa0ZBKGlRTQVuAdlYxSK1wgnl+m+M9pnmrO6knRNDuvFponbiFcuoepP
        HHf7nUeg9dLtDAOBx4D/eX5TMvOGDTZ6vqZtzc6Ql+0cetZkGuyft23UinIwLock7vLkaGdVbMhJK
        iPEvFcpAZkXarlNd8dDfN5iALfaB/PJrSyZWIwNXwnsxZvgJ1DYbZbvU/p9epiw+erWD0EJ6Ioada
        0ySTcejZw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37876 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g2JVB-0074xZ-SO; Tue, 18 Sep 2018 13:09:30 -0400
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
Subject: [PATCH 1/3] spi: always use software fallback for SPI_CS_WORD when using cs_gio
Date:   Tue, 18 Sep 2018 12:08:48 -0500
Message-Id: <20180918170850.2749-2-david@lechnology.com>
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

This modifies the condition for using the software fallback
implementation for SPI_CS_WORD when the SPI controller is using a GPIO
for the CS line. When using a GPIO for CS, the hardware implementation
won't work, so we just enable the software fallback globally in this
case.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e4fb87b304a0..03833924ca6c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2841,11 +2841,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		return -EINVAL;
 
 	/* If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
 	 * splitting transfers into one-word transfers and ensuring that
 	 * cs_change is set for each transfer.
 	 */
-	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
+	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					  gpio_is_valid(spi->cs_gpio))) {
 		size_t maxsize;
 		int ret;
 
-- 
2.17.1

