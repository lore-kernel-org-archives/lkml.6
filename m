Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F39C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5752B20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAHLJjcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5752B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbeKLIpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403931AbeKLIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:55 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94871223C7;
        Sun, 11 Nov 2018 22:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975577;
        bh=ef4lVZqZtUAl+cQVess6mDqcqbxJJRqvbBvmbPZVSOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAHLJjcdPCrrrzM/tgEsLQTKG/gWVQaYNO/vzOgl8i9iQYGWmy9TdQEOZ5+WIGsoV
         t3uURpxXkqhcxW0bQvoj212aXODgHMH3/4N64Ln1nUgxBh1Xy3tN5MPBNS9srqzqt/
         /KcRiNlEIr5ml10bIqYoHQXhhUjnR19gb8N4TVPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 162/222] iio: adc: at91: fix wrong channel number in triggered buffer mode
Date:   Sun, 11 Nov 2018 14:24:19 -0800
Message-Id: <20181111221701.773803757@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@microchip.com>

commit aea835f2dc8a682942b859179c49ad1841a6c8b9 upstream.

When channels are registered, the hardware channel number is not the
actual iio channel number.
This is because the driver is probed with a certain number of accessible
channels. Some pins are routed and some not, depending on the description of
the board in the DT.
Because of that, channels 0,1,2,3 can correspond to hardware channels
2,3,4,5 for example.
In the buffered triggered case, we need to do the translation accordingly.
Fixed the channel number to stop reading the wrong channel.

Fixes: 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/at91_adc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_hand
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct at91_adc_state *st = iio_priv(idev);
+	struct iio_chan_spec const *chan;
 	int i, j = 0;
 
 	for (i = 0; i < idev->masklength; i++) {
 		if (!test_bit(i, idev->active_scan_mask))
 			continue;
-		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
+		chan = idev->channels + i;
+		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
 		j++;
 	}
 


