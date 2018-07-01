Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B274A252C1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B274A252C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030784AbeGAQd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:33:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030751AbeGAQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A693349B;
        Sun,  1 Jul 2018 16:33:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 092/157] iio: sca3000: Fix an error handling path in sca3000_probe()
Date:   Sun,  1 Jul 2018 18:22:44 +0200
Message-Id: <20180701160857.164940769@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 4a5b45383ca371e123ba103d34d4b3b87616245c upstream.

Use 'devm_iio_kfifo_allocate()' instead of 'iio_kfifo_allocate()' in order
to simplify code and avoid a memory leak in an error path in
'sca3000_probe()'. A call to 'sca3000_unconfigure_ring()' was missing.

Sent via the next merge window as unimportant bug and there are
other patches dependent on it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/sca3000.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1277,7 +1277,7 @@ static int sca3000_configure_ring(struct
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_kfifo_allocate();
+	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1287,11 +1287,6 @@ static int sca3000_configure_ring(struct
 	return 0;
 }
 
-static void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
-{
-	iio_kfifo_free(indio_dev->buffer);
-}
-
 static inline
 int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 {
@@ -1547,8 +1542,6 @@ static int sca3000_remove(struct spi_dev
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 
-	sca3000_unconfigure_ring(indio_dev);
-
 	return 0;
 }
 


