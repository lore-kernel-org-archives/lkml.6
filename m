Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06310C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+iEQAe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04B720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFTU2O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:28:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35018 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeFTU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:28:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so386237plt.2;
        Wed, 20 Jun 2018 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7OWw0y6sCQpDjtt//2VWjVs4J4f/XVp9B/7/tWdZI2Q=;
        b=D+iEQAe8DU7nPttACnxNWFPs6rzmbrXO8T9obtD5+ZJHbFNTejG133E9apEny161VI
         oAjDoVGtp7eWNCwF+I7PmBOGEOzaLwpiSZWRqHNGfWMNEZ/3GL8pEU1/4WkQhW5sHYNN
         ddHPAmccEpTxPVRlBjtZrhScAksEf+Yn8A69pkRMLNL76x8IrFr3Z8a/dlFVHpNiqCYv
         P7XXbaxuv0EeMWCVw+gwOA1X7wmWURka7KVyivX9q3ASdixcTPk8tBbk377q8wEnRkQu
         ZVC6U7zVN5ZHC+pfYdGm4Cyp/vH9aElh5UhpmadX3YgpwJFldG1ysKxO89BfuOmq3664
         pMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OWw0y6sCQpDjtt//2VWjVs4J4f/XVp9B/7/tWdZI2Q=;
        b=OA02OVmpnzcD/a1MzR6ew82uiIIa4TqZsA6YdlhH+i906KGzhkbKUsdDn7D4cyaO4k
         pKVd0138cGTml60L8MStQ7317pOTBL4MLURtOorqg7sZrKNgp9tYc8zwN/8MdSsowClR
         ykWa5tGpBCqR56/HCr1+rSu7Tn9zLU1/xDr8ndUhj43gYsgmhvSxNLaJH4EJGvp9EXoe
         gzO1S9xY3tKMaBTglYvUBCG8V3Roho/9otnwWi3Vw+zweUv4epHdB2cfaBo5fQe1mrd2
         JVvLpQC7SSNYZI1vP662rQnW+OenXQ/vt0hFfwZ8/ww9Bt1/NByjVnEqCDhjcG8UUtBT
         f2Ng==
X-Gm-Message-State: APt69E2DIFfSqToEw2nzBNgYLZSgh3otdJGFgMM7pQVSx70GQ1jMiPiV
        mZeiFDEStHfl4et7vtaanTo=
X-Google-Smtp-Source: ADUXVKIa+VuTHgdKB3sJxedOmbnZG+BZRSMxGrgS8e5vBphnNC2iy3rdu63xV3+kSiHJdHncql+yXA==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1-v6mr25362351pld.29.1529526488599;
        Wed, 20 Jun 2018 13:28:08 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id y18-v6sm4400519pfl.122.2018.06.20.13.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 13:28:07 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:28:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 03/10] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Message-ID: <20180620202805.GB75925@dtor-ws>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620051803.12206-4-peda@axentia.se>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:17:56AM +0200, Peter Rosin wrote:
> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
> sit behind a mux-locked mux, the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Still

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge through I2C tree.

> ---
>  drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
> index bda0500c9b57..714affdd742f 100644
> --- a/drivers/input/touchscreen/rohm_bu21023.c
> +++ b/drivers/input/touchscreen/rohm_bu21023.c
> @@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
>  	msg[1].len = len;
>  	msg[1].buf = buf;
>  
> -	i2c_lock_adapter(adap);
> +	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
>  
>  	for (i = 0; i < 2; i++) {
>  		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
> @@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
>  		}
>  	}
>  
> -	i2c_unlock_adapter(adap);
> +	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
>  
>  	return ret;
>  }
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
