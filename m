Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFBBC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71462133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Z3XrOsD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71462133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeIMFrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:47:01 -0400
Received: from vern.gendns.com ([206.190.152.46]:46148 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeIMFrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eXHkYVbfJ/7IzoGAj2IYdyJDsqwaXzDNLq7xn+GmZzU=; b=Z3XrOsD3VifUxYNiYdPE+fRvu
        quXlTCVcarz1OXQf+wEGp3AF5pCZnU9xmUbjCCXq86k4MVC3Xwn8G6/2bHLJ1bakXlgggKAUBgDU5
        uO28p8cCRLQHp4uN+35JD9fXfAz61o4bjmZGki6147XZ9h9AvhBE+lIVmyaGnUEdS9cw6NrbeJtW5
        EdMG7wHAphy2kIradQAijTqQhCD/M3H5FvZ7Nt/E6suxTdsFORqjKYt0FP/5sYFpAbadV6tQ3DIgl
        AxlQGK0NHmOzEJR4xNqD1y0F+fdA5e69fCHdhFawTyit0nc4E2Yl3T+b1Qlx7tlf5d+PV8QI1t5Yc
        KVaj727qA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33924 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0Ffp-00AGoe-Ea; Wed, 12 Sep 2018 20:39:57 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] spi: add new SPI_CS_WORD flag
Date:   Wed, 12 Sep 2018 19:39:17 -0500
Message-Id: <20180913003920.30600-2-david@lechnology.com>
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

This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
that a SPI device requires the chip select to be toggled after each
word that is transferred.

Signed-off-by: David Lechner <david@lechnology.com>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d698f9db3484..7bb36145e2ba 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,7 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
@@ -177,7 +178,6 @@ struct spi_device {
 	 * the controller talks to each chip, like:
 	 *  - memory packing (12 bit samples into low bits, others zeroed)
 	 *  - priority
-	 *  - drop chipselect after each word
 	 *  - chipselect delays
 	 *  - ...
 	 */
-- 
2.17.1

