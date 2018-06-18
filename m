Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5082C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFC820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4ciw9+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFC820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754989AbeFRG17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:27:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36332 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754895AbeFRG16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:27:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so15477421wrm.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/6GCFGItDSeWvpVMsiC9ytjvE6PLTlKysqW1zRG8L0g=;
        b=Z4ciw9+qWRTqVylYLoEx75/+mhpAaGkOwm9PlG8hsMUSWwKqH23kJ5Tz+wfqOi7ttY
         knfEguo+YC9g/1M98lxzVKtZ0udulWEeSpDXXDCB3JOCEnBagD3hV5UINZFE9/Bn+of+
         J6hzvAyvAw1ekrPgEwVuxsHV4XU7/d82JqwTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/6GCFGItDSeWvpVMsiC9ytjvE6PLTlKysqW1zRG8L0g=;
        b=VsHMmtGdL5RggWBFA+GKAbLGkCcYZtax/DxUFFPa/1cVkqhzxzU6sKYEgcrr8X33BO
         5G8+UU67dZwLhu+Vbgd7q43Odopv3go6tCNP49c+mzZVDjmc4TSbt8JKNvswD6SJATWt
         SURJY5NIwcbEqKI2d+77Jp9+HTMlniIY8PZzyEf84EAl3YwrmDDNfFxeEka61DlXZMF2
         oKcNnRBgyZ85j+O5iy+/FyUcbYH95yy97LTCUar/hh8PbQklfIDEtWD0sa7rUxjv6eoq
         qEYkqSBx2tBq4HctShcpDr9KdNhowEMtGa01zcFj7PrN/iYQ45RPzPSO1HzDIFAv+Iwr
         H7Nw==
X-Gm-Message-State: APt69E3EZEByO8ojvcR2NDompBjT8JGdz30SwbE0sAGWb0Ihwun5vKWR
        B3ZHff2qmrZW85RBbitQSBCbQg==
X-Google-Smtp-Source: ADUXVKIJaZagjkBdfHE+zlxQu2KrkQvg68bis7VGBcZTVID0pezprG5rTHd1RC40PPPi2m86naOIUw==
X-Received: by 2002:adf:fd88:: with SMTP id d8-v6mr8520197wrr.276.1529303277151;
        Sun, 17 Jun 2018 23:27:57 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id v138-v6sm8541450wmd.47.2018.06.17.23.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:27:56 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:27:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     andy.shevchenko@gmail.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180618062754.GF31141@dell>
References: <20180604115750.6126-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604115750.6126-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018, Charles Keepax wrote:

> Some Arizona CODECs have a small timing window where they will
> NAK an I2C transaction if it happens before the boot done bit is
> set. This can cause the read of the register containing the boot
> done bit to fail until it is set. Since regmap_read_poll_timeout
> will abort polling if a read fails it can't be reliably used to
> poll the boot done bit over I2C.
> 
> Do a partial revert of ef84f885e037 ("mfd: arizona: Refactor
> arizona_poll_reg"), removing the regmap_read_poll_timeout but
> leaving the refactoring to make the arizona_poll_reg take more
> sensible arguments.
> 
> Fixes: ef84f885e037 ("mfd: arizona: Refactor arizona_poll_reg")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Explicitly include ktime header
>  - Use USEC_PER_MSEC instead of a constant
>  - Refactor the loop to not use a while (true)
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 83f1c5a516d99..fe0c151d9d9d7 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -24,6 +24,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/slab.h>
> +#include <linux/ktime.h>
>  #include <linux/platform_device.h>
>  
>  #include <linux/mfd/arizona/core.h>
> @@ -240,18 +241,28 @@ static int arizona_poll_reg(struct arizona *arizona,
>  			    int timeout_ms, unsigned int reg,
>  			    unsigned int mask, unsigned int target)
>  {
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * USEC_PER_MSEC);
>  	unsigned int val = 0;
> -	int ret;
> +	int ret = regmap_read(arizona->regmap, reg, &val);

I'm not a fan of this type of initialisation.

Also, what's the point of assigning 'ret' if you never check it?

> -	ret = regmap_read_poll_timeout(arizona->regmap,
> -				       reg, val, ((val & mask) == target),
> -				       ARIZONA_REG_POLL_DELAY_US,
> -				       timeout_ms * 1000);
> -	if (ret)
> -		dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n",
> -			reg, val);
> +	while (ktime_compare(ktime_get(), timeout) <= 0) {
> +		if ((val & mask) == target)
> +			return 0;
>  
> -	return ret;
> +		usleep_range(ARIZONA_REG_POLL_DELAY_US / 2,
> +			     ARIZONA_REG_POLL_DELAY_US);
> +
> +		ret = regmap_read(arizona->regmap, reg, &val);
> +	}
> +
> +	if (ret) {
> +		dev_err(arizona->dev, "Failed polling reg 0x%x: %d\n",
> +			reg, ret);
> +		return ret;
> +	}
> +
> +	dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n", reg, val);
> +	return -ETIMEDOUT;
>  }
>  
>  static int arizona_wait_for_boot(struct arizona *arizona)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
