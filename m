Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC882075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVxJbJyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC882075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJYWFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:05:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34830 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbeJYWFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:05:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id v68-v6so5677356qka.2;
        Thu, 25 Oct 2018 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aoQwXLUABqhn/lJKD95mvDe1OgsY4lA2OFgkXLoK+jo=;
        b=ZVxJbJyRAbu8NYES1iGOkZhkonbeZfo0o8dIytY88LonlpYFG0qA6V5/5kwGyAz9Nw
         kGvpItkEjrcXooLrkikPvhNYcJilPLC7GvcSTnX76eCB8O44zOqSir47S1bQGcouSb9l
         QBD/JHVtmJicNHjNJYybDrGFggZzvE31BCk5WjCa4GxbX2Fgmhtj7m97RsERYEaVTVj3
         pkmHKtSKDgRaw07sjF0oJkWtkiksbcF4UFLzoxowoQZhdETaPzpuBbZnVpk7NCZVx81Q
         auXi6hiSs2QACm8dMvddv7tDglAr4F9GOMfOOrrLa9pRakQutgffG+vrDXOqEjZ9CXwc
         aDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aoQwXLUABqhn/lJKD95mvDe1OgsY4lA2OFgkXLoK+jo=;
        b=r95NTJfK3WovUbT/2fbwG7g+bXHV4yAaS5DP4pBDf/s+vRVTcnibQj4Xe/wld1IzhO
         /hlPI8RdPoWs72/OiL1OPZD5UibIeGEZHS+fP9Xj7jwuaav777YBbeOQG3apUS/j5uhd
         EG4vJUO5nF2UJbIFQAlkglVVxvWOvRpU+N/9MOb7vMMQWvjEikXeg7ZX+Jr7gn2CgwuV
         SPWrRV99F8p5Ar0P9Yo7UVkgPKnXwcvYvZQLVvUzqry4KK85ErJTj1nChJzLa+VQgC4N
         LnW1HKWeM7YRL7brJoePnxSOkKweTX6JqVec4bkpVEMXVZo90bTkJDEIZ92cpcVykpA1
         KD2g==
X-Gm-Message-State: AGRZ1gLPghq8LnlvrBQvEIJKDMVsKKI7hFnX8ZK15yYvB/1dthRMUxQF
        itN6SKdzgHKUX3MfCrGhkXE=
X-Google-Smtp-Source: AJdET5eVHi1rNK9OK6GtFaC/iDGqJDD8X2U5dS1SYMeKwroVR5X2QR3C5sFP9UyTpy9+BKrVESlTuw==
X-Received: by 2002:a37:2e05:: with SMTP id u5-v6mr1435437qkh.38.1540474352151;
        Thu, 25 Oct 2018 06:32:32 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e5-v6sm3892422qtr.17.2018.10.25.06.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 06:32:31 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:32:26 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7780: update voltage on read
Message-ID: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7780 driver previously did not read the correct device output.
This patch fixes two issues.

- The driver read an outdated value set at initialization. It now
updates its voltage on read.
- Variable val subtracted an uninitialized value on
IIO_CHAN_INFO_OFFSET. This was fixed by assiging the correct value
instead.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b67412db0318..06700fe554a2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -87,16 +87,20 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv = 0;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv)
+			st->int_vref_mv = voltage_uv/1000;
 		*val = st->int_vref_mv * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		*val -= (1 << (chan->scan_type.realbits - 1));
+		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	}
 
-- 
2.19.1

