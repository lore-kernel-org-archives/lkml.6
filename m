Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DACBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F82208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="kz7wPN1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F82208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGQAFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:05:49 -0400
Received: from vern.gendns.com ([206.190.152.46]:55068 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbeGQAFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uwXQkWav0Ka/VVU2KBeDT2x7s4BhxMjd8D6QCYMB1/Y=; b=kz7wPN1l92RUbeU8Pwp9OWfTyn
        P3WEU5MblWeXT9CJtoraCxI0uLPW50wSPy4mrfWjALG1bCjzrqRRHi2FDFMGRMfjnsJebFCtYrvoo
        +29geTR2QYECm0oloqyKIUSffJfdOUK7emoffkGEn9mQ9HpHIPxX91Kl67KqyPj4Ln3hYylQbli/n
        HnADiUSQeIBuJfKnROetGsf1L7OnuvmahrwQdqxUm6pukuf+Zq7nwN5MfYpSe0X3PQrfsgrHk+so8
        +Gr2QVtOVstyfDLKwbL3F+EKKu2vh9ZbxpMahRerD3W7U/pwTS6UeF37tpuCd5LKMHaGsF/O9W9De
        hZV0pxZA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49732 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffD2F-00CMu1-TQ; Mon, 16 Jul 2018 19:36:08 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date:   Mon, 16 Jul 2018 18:35:50 -0500
Message-Id: <20180716233550.6449-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
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

This modifies the TI ADS7950 A/DC driver to allow the simultaneous use
of both the triggered buffer and reading channels directly (via in-
kernel API or sysfs).

The use case for this is on LEGO MINDSTORMS EV3. Two of the voltage
channels are used in-kernel by a power supply driver, which reads the
values using iio_read_channel_processed(). These channels are only read
at a slow rate (<= 1Hz).  However, we want to be able to read 12 other
channels at the same time using the triggered buffer at a high rate (>=
100Hz) without breaking the power supply driver.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0225c1b333ab..ba7e5a027490 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -58,6 +58,7 @@
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
 
 struct ti_ads7950_state {
+	struct iio_dev		*indio_dev;
 	struct spi_device	*spi;
 	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
 	struct spi_transfer	scan_single_xfer[3];
@@ -68,6 +69,8 @@ struct ti_ads7950_state {
 	unsigned int		vref_mv;
 
 	unsigned int		settings;
+	__be16			single_tx;
+	__be16			single_rx;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -299,14 +302,21 @@ static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
 {
 	int ret, cmd;
 
+	mutex_lock(&st->indio_dev->mlock);
+
 	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
-	st->tx_buf[0] = cpu_to_be16(cmd);
+	st->single_tx = cpu_to_be16(cmd);
 
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = be16_to_cpu(st->single_rx);
+
+out:
+	mutex_unlock(&st->indio_dev->mlock);
 
-	return be16_to_cpu(st->rx_buf[0]);
+		return ret;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -338,13 +348,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
-
 		ret = ti_ads7950_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -389,6 +393,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, indio_dev);
 
+	st->indio_dev = indio_dev;
 	st->spi = spi;
 	st->settings = TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_RANGE_5V;
 
@@ -410,13 +415,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	 * was read at the end of the first transfer.
 	 */
 
-	st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
+	st->scan_single_xfer[0].tx_buf = &st->single_tx;
 	st->scan_single_xfer[0].len = 2;
 	st->scan_single_xfer[0].cs_change = 1;
-	st->scan_single_xfer[1].tx_buf = &st->tx_buf[0];
+	st->scan_single_xfer[1].tx_buf = &st->single_tx;
 	st->scan_single_xfer[1].len = 2;
 	st->scan_single_xfer[1].cs_change = 1;
-	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
+	st->scan_single_xfer[2].rx_buf = &st->single_rx;
 	st->scan_single_xfer[2].len = 2;
 
 	spi_message_init_with_transfers(&st->scan_single_msg,
-- 
2.17.1

