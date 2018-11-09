Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DDA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJwqF1YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DDA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeKINEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:04:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42690 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeKINEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:04:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so265416plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 19:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yX2sCd2EA1FTKfmRYjC58TpT5nQVf8lwKNV7j+JnwoA=;
        b=GJwqF1YAE8+XFqsMPGlLa5K1x5M0ynidJ3srGG1Gsug9GkYRPjW8nKPItLgwL/t5XL
         tRsXtSnck7I/I/g9dn12vUY8YP7xJLjaZ8iKmkIfoHGA+I8ODwETEG/KVDaE5g4hM0BS
         KNE4gfzekefEf9dP9Pl1Zfva2OtQGZMkNSStM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yX2sCd2EA1FTKfmRYjC58TpT5nQVf8lwKNV7j+JnwoA=;
        b=cu/Skcj5yjnzsxxrLDNSreyBmuoJ0uugJ6wMYpa7lYN2fjurNa+33FTY2E4NR3wkb6
         lKr+zndhGqKzaR/NenS8FjITJzJs1t7oGFZrTICMsRDzN30jNfXbH0+cuAH0dg0lI+A+
         jMi7vrQjya1reZLFH7r3RdcluzdFTRk20rWW2e77OHMw/51GyrqWDiMPoNvYh3Pxlm8m
         heg1x0oi59IhsAy6nzH1dXHBrvLIBydHOu2FK0ieH4um9aPM+qzTJxEpKQX95klEvoEd
         QCuHUNjiAe5/jzGKuASKKM5RbrpykgHB47wO7nOT7t8UezKQEL74ErZG+JwMLgBqgDcc
         93KQ==
X-Gm-Message-State: AGRZ1gL3HkQlfR88SuhrYcnCw3h5mRnx5zCteB2ChbmHrXwEP9FHaSDJ
        9dIFPDlawJ6M137zHiiF7BUz/g==
X-Google-Smtp-Source: AJdET5ffLVtugP0nUJykP0UozNL8jk5m3ALMixWhiyHtZCc9UbFIoEeKNfEcwEcLtAojDmgRg1u+eA==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr7176191plt.33.1541733959593;
        Thu, 08 Nov 2018 19:25:59 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h7-v6sm6656675pfd.35.2018.11.08.19.25.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 19:25:58 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
Date:   Fri,  9 Nov 2018 11:25:31 +0800
Message-Id: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

Sometimes the ADC controller met some problems, and it will not complete
the data conversion, that will can not wake up the read process any more
to block users. So we should add one maximum conversion time to avoid
this issue.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 7940b23..f7f7a189 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -52,6 +52,9 @@
 /* Timeout (ms) for the trylock of hardware spinlocks */
 #define SC27XX_ADC_HWLOCK_TIMEOUT	5000
 
+/* Timeout (ms) for ADC data conversion according to ADC datasheet */
+#define SC27XX_ADC_RDY_TIMEOUT		100
+
 /* Maximum ADC channel number */
 #define SC27XX_ADC_CHANNEL_MAX		32
 
@@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto disable_adc;
 
-	wait_for_completion(&data->completion);
+	ret = wait_for_completion_timeout(&data->completion,
+				msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
+	if (!ret) {
+		dev_err(data->dev, "read ADC data timeout\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
 
 disable_adc:
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-- 
1.7.9.5

