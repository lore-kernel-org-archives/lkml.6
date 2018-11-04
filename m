Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD75ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1859C20880
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1B3S0z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeKDXJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731519AbeKDXJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2215A2086C;
        Sun,  4 Nov 2018 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339646;
        bh=Sc1e1JbgPz6oHD/juV+LNcV109OdYgGpq1PjwwODMvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1B3S0z6R+xctPdtsIubKK/9igpot9cFho136JOFfysOPVVCThbN+uSZiGu7GKtaD
         +evlBTxtW4RcUZMYllRsuVD9+0hIcf9cUni/OeSlQHp9mA8iiQKQuQMSZ+hFufLATV
         ins4o1rxZnvLL1F2gnYZZ9YkPLPuokNtZVwX/h3k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/21] iio: adc: at91: fix wrong channel number in triggered buffer mode
Date:   Sun,  4 Nov 2018 08:53:44 -0500
Message-Id: <20181104135355.88602-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135355.88602-1-sashal@kernel.org>
References: <20181104135355.88602-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit aea835f2dc8a682942b859179c49ad1841a6c8b9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/at91_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index bbdac07f4aaa..1ba69bbc3142 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -247,12 +247,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
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
 
-- 
2.17.1

