Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E987A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btTzOVlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E987A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKIRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:16:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39371 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:16:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id n11-v6so550055pfb.6;
        Thu, 08 Nov 2018 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+PAvBAE61dVOxvVN8/bfDlsvUQtrCUyU7kVnOn+CtI=;
        b=btTzOVlB6dWnEac6xl4QIMsbbuXtkwLsUBtSl0JGCToezCRNRI5zEAkM7SCU9Big0+
         t5m6EudaRN/6jil11sVMp0nWTKwnnoQWmSi3NdmTQtHvMzOjC+U55PXF7S8yMBimCvnv
         bhtFagK6+wdHWf9EfKuysu43fy3xLhX9UsbYw6ofxD7aCMUg0cyavjadeTIqd3aQWOcj
         jpBgjwCvFX3uSB6o3qzYEQSxJgP7uXUx//765+JOTpdr9flKsPL6++G2EDoTJPknuW8D
         sZc3tzA7qUvA68f29Kg/NAWPPlXEcFA4GU+q/DdgyNP3cLBq1e8nvBOliy4RpeVQjdMe
         PAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+PAvBAE61dVOxvVN8/bfDlsvUQtrCUyU7kVnOn+CtI=;
        b=ESctIyOrDN4cATI0w382Dd9WZGwBkgndqUo25N0wS87ROy51IUk12ZSahOsBy8jZ5+
         36nklyxNNAoAURkztMnIeZbNseTDK0vWrZROKJDWrxCAJhysByLeov+HyPng4hWfs3/K
         1gIKDc8ePatp0pRIdglMTXqgx5Et9sajSsVJCW+ihQuaqpyqL9xU7WH7rGk+Qeulat8D
         Ji6GQJIDY7vdkfcY7tesULP3ftoPVkfH+AjkgC00QKx3koKyg1zp/OSfDbsuywARiyg1
         RCyWmxK9itInWbjvBxEZfV6akC4Nddt7qdUbhKEQVi2mDPYn56QqDifsytqTLu1SEt/F
         LWpQ==
X-Gm-Message-State: AGRZ1gKEZolSDTxlTLP+byJKDrp/O7yc56+GyvBhV4Na4VTFNyrMlx9A
        6pn0fxLyizfzXeHVpQLkdkw=
X-Google-Smtp-Source: AJdET5e4847IyrQCzTDChObQDm1w48qorPNr35gunbuxYlpp5GRrkwn4fZ4QSMkCkpF3d8dJEutnag==
X-Received: by 2002:a63:6302:: with SMTP id x2mr6503038pgb.183.1541749046936;
        Thu, 08 Nov 2018 23:37:26 -0800 (PST)
Received: from nishad ([106.210.186.71])
        by smtp.gmail.com with ESMTPSA id w2-v6sm6714112pfn.89.2018.11.08.23.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:37:26 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:07:18 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: iio: ad7816: Set RD/WR pin and CONVST pin as
 outputs.
Message-ID: <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541733949.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RD/WR pin and CONVST pin are logical inputs to the AD78xx
chip as per the datasheet. Hence convert them to outputs.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 3cda5cd09365..a2fead85cd46 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -369,14 +369,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		chip->oti_data[i] = 203;
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
-	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
 		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
 			ret);
 		return ret;
 	}
-	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
+					   GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->convert_pin)) {
 		ret = PTR_ERR(chip->convert_pin);
 		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-- 
2.17.1

