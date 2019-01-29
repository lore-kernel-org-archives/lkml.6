Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3492F20855
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="2SPZ6hDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfA2Ii6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:38:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46344 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2Iiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:38:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so16681985ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEY4OzlWgevwGood0/zS+8H1L1rcDa+oZc5FrDXHufI=;
        b=2SPZ6hDyY96b1U9TN7mMQOSEZA4G1ggfoWju5A5g5dy4R3yRcKbVJaYBiZwcryVSEz
         OQexqTADoZAAl7y6RwTx91itD2y0s+vyd72w8dZ2UXms54m9TAgaHbiogpl1odzEhmh/
         NZUf8lROfnkr0adztTBUNT6dcA5ghl8+KCR3ywyCcc0ZlsunUm3y3PCvrHhf5PEsfnaU
         dnT1R7HjqvS3u5081MXjjPQ6oN5gLMmUzEF6ckThixNTrJmqiaJbDsqmIqOuVadAfhXO
         3n/oh5NxGFvl6vaqa5YVuI7b+QtKI3KZYmF7a2T/mW/0qKaE90/k4Bidhwlyalt/H9fn
         WWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEY4OzlWgevwGood0/zS+8H1L1rcDa+oZc5FrDXHufI=;
        b=HVRzSUOwm+Kggi/Sy2xf7mntDRDC+p4ZzZDEh9bvjr4KhgNXBzwVbnQenl/ikytpZQ
         NgW3w6JIK+6CKRi4ZmLyVxf+s+ko37CGP/2Z8WE9wYBsyOoB4SQxXwy6Nsq01Af1UIH8
         WmWhJl747mIo+LkvqIaTw0UyNWyl5+FdzBmNKYgmcwuQpMUUjf4OIUOPpsJWjtbR9ssc
         Ms99lHy/hMp4R8bOj/hj3bZjkjVOMwodFiZouT0qxPq4xchGMaBY3I0qzV83vdnFsVIw
         LOzbMDMwcjMn3Y+ZzMwMUISTm1tX/Kds3/qvYzlpDw9WpOvLb1CkFUXrRzy7qtRGAN+X
         jQfQ==
X-Gm-Message-State: AJcUuke27Qy1cXUuPIvv+X+w3kVeWlG70EKzXaNGfToCFJMeOPqlHDFn
        kCZ6J2Ih1QumZO40+wc1eDG7oJN0Y8U=
X-Google-Smtp-Source: ALg8bN5MNkbSdkzx2Yyug3pz/RCq5Od7aAu5RYol+6myXaSMPwBSPA1dp3cw0aMr9eJIs4ZoxYRSKg==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr17837144lja.148.1548751130789;
        Tue, 29 Jan 2019 00:38:50 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id v17-v6sm3378774ljg.32.2019.01.29.00.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:38:50 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] spi: support inter-word delay requirement for devices
Date:   Tue, 29 Jan 2019 09:38:43 +0100
Message-Id: <20190129083844.20572-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129083844.20572-1-jonas@norrbonn.se>
References: <20190129083844.20572-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Note that, for spi_transfer, there is already a field word_delay that
provides similar functionality.  This field, however, is specified in
clock cycles (and worse, SPI controller cycles, not SCK cycles); that
makes this value dependent on the master clock instead of the device
clock for which the delay is intended to provide some relief.  This
patch leaves this old word_delay in place and provides a time-based
word_delay_us alongside it; the new field fits in the struct padding
so struct size is constant.  There is only one in-kernel user of the
word_delay field and presumably that driver could be reworked to use
the time-based value instead.

The time-based delay is limited to 8 bits as these delays are intended
to be short.  The SAMA5D2 that I've tested this on limits delays to a
maximum of ~100us, which is already many word-transfer periods even at
the minimum transfer speed supported by the controller.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 drivers/spi/spi.c       | 5 +++++
 include/linux/spi/spi.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7c3237..64f13204bcb7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2961,6 +2961,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * it is not set for this transfer.
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
+	 * Ensure transfer word_delay is at least as long as that required by
+	 * device itself.
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
@@ -3031,6 +3033,9 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				!(spi->mode & SPI_RX_QUAD))
 				return -EINVAL;
 		}
+
+		if (xfer->word_delay_us < spi->word_delay_us)
+			xfer->word_delay_us = spi->word_delay_us;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..e04622a01836 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -118,6 +118,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line)
+ * @word_delay_us: microsecond delay to be inserted between consecutive
+ *	words of a transfer
  *
  * @statistics: statistics for the spi_device
  *
@@ -164,6 +166,7 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
 	int			cs_gpio;	/* chip select gpio */
+	uint8_t			word_delay_us;	/* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -706,6 +709,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay_us: microseconds to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
@@ -788,6 +793,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		word_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.19.1

