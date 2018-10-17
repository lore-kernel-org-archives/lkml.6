Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81597ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050221528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZFWlteU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3050221528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJQWy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJQWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:54:29 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3AC2150F;
        Wed, 17 Oct 2018 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539788305;
        bh=1YNBN0SBWtjodADNrh/Kwtb41xdMAGI2MpXJSkEap6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZFWlteUkWITpyDZU2IwBZ2aRRrwFp7ZNwmaltmc7Kengrsz4vJDF5HVpWNe6jxXT
         KBbau5+0dnNLhDC3Wrb+45vFdtm9DNyYIpKDO5J3RxyxMwrvCqJQMEJ69b0eB8aMKO
         5L1kiiXD2k4X7Pt8X7ZzmI1nuXxqXl+V7CzqqnwQ=
Date:   Wed, 17 Oct 2018 10:58:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181017145823.GC135013@sasha-vm>
References: <20181017144716.GA11485@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181017144716.GA11485@nishad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:17:20PM +0530, Nishad Kamdar wrote:
>+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>+	if (IS_ERR(chip->rdwr_pin)) {
>+		ret = PTR_ERR(chip->rdwr_pin);
>+		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}
>-	gpio_direction_input(chip->rdwr_pin);
>-	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
>-				spi_get_device_id(spi_dev)->name);
>-	if (ret) {
>-		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
>-			chip->convert_pin);
>+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
>+	if (IS_ERR(chip->convert_pin)) {
>+		ret = PTR_ERR(chip->convert_pin);
>+		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}
>-	gpio_direction_input(chip->convert_pin);
>-	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
>-				spi_get_device_id(spi_dev)->name);
>-	if (ret) {
>-		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
>-			chip->busy_pin);
>+	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
>+	if (IS_ERR(chip->busy_pin)) {
>+		ret = PTR_ERR(chip->busy_pin);
>+		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}

Hm, from what I can tell devm_gpio_request() is allocating some memory,
which makes this a series of 4 allocations.

What happens if the fourth allocation fails? Do we leak the first three?

--
Thanks,
Sasha
