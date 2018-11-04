Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62757ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951620685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="odMM/CSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeKDXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbeKDXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188F420866;
        Sun,  4 Nov 2018 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339536;
        bh=4+I+CLzE6apcN8eMCgqp2O/9v9nYaWnGsicZecBtHvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odMM/CSmRuJZJg+1wiHuqouZxb7+xSIXupgoaP+Ft00MIkFiu3PRpA8RhuGrzsR7o
         pRlwWv6ircBuV1pv3EfENnLsWbKpSMmffgvMHEHRl7T9IMOgDWuDTlq2oDO9c84BDi
         JTowAkeLbE09w2ii/zaAwpsjqbRTy5N6yY7u8yKc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 31/57] iio: adc: at91: fix acking DRDY irq on simple conversions
Date:   Sun,  4 Nov 2018 08:51:18 -0500
Message-Id: <20181104135144.88324-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit bc1b45326223e7e890053cf6266357adfa61942d ]

When doing simple conversions, the driver did not acknowledge the DRDY irq.
If this irq status is not acked, it will be left pending, and as soon as a
trigger is enabled, the irq handler will be called, it doesn't know why
this status has occurred because no channel is pending, and then it will go
int a irq loop and board will hang.
To avoid this situation, read the LCDR after a raw conversion is done.

Fixes: 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/at91_adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 91c250ae0437..75d2f73582a3 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -281,6 +281,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
 		iio_trigger_poll(idev->trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done = true;
 		wake_up_interruptible(&st->wq_data_avail);
 	}
-- 
2.17.1

