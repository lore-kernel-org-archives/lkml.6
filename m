Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DEECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6F620858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="hAM3Z6ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6F620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeGUUbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:31:55 -0400
Received: from vern.gendns.com ([206.190.152.46]:52769 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeGUUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L3XvHcgGLOww4xzV3cz7hNu4GIK2iP+PsjrCInmI22Y=; b=hAM3Z6jilcwSvjwNyKFwvCZPD
        0pzu+Y8ZpdHBjwrqYspP5+/Bd6NTuHDi+Izr3aNh5BAGt3rzCwCI4oOZNuD7Pji0RksRK9SbE8UTN
        QmbQ2ouiCeqgv3HliHadpGZpSF/eSKUacqMU9hysBhdb/5vQTE9Awy8LH0c2lS2Yq+ZdKiF8sTUH9
        r7TequExmQMZKla17mo/3paar7DvNcg3Q+KEIuaNDcnQf2Rm6xUSJyNedbajB3+IiDxdmnELeXiGV
        PikTPZ2WnQqYeOQDBebR+L/4muXbW9ZZ/nd9+bcxDgFzoRu+AJHdkXwMSPfTWcnpphEcd6L7zzCUQ
        9NLIMUu0A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:35490 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgxhY-009bOk-IN; Sat, 21 Jul 2018 15:38:00 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date:   Sat, 21 Jul 2018 14:37:34 -0500
Message-Id: <20180721193734.6427-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721193734.6427-1-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
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
100Hz).

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index f08c4de2bd10..eae987bef994 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -60,6 +60,8 @@ struct ti_ads7950_state {
 	unsigned int		vref_mv;
 
 	unsigned int		settings;
+	__be16			single_tx;
+	__be16			single_rx;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -287,18 +289,26 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
+static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
+	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret, cmd;
 
+	mutex_lock(&indio_dev->mlock);
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
+	mutex_unlock(&indio_dev->mlock);
 
-	return be16_to_cpu(st->rx_buf[0]);
+	return ret;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -330,13 +340,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
-
-		ret = ti_ads7950_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		ret = ti_ads7950_scan_direct(indio_dev, chan->address);
 		if (ret < 0)
 			return ret;
 
@@ -402,13 +406,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
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

