Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E5C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEEB21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGHNw6WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEEB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeK3Auc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:50:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3Auc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:50:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1953652wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0QRTCt9y0nVCiZHknMcc5NdE9lCatyyRD51UF2K9c8=;
        b=aGHNw6WSJbHOKCrQw7KARl7wF0noFNB1GncFwsGg6bc7DmwqQroxqOD8UTucPpeIdy
         bLCowS9SZIp7Fp0Pkc5SYJbxB0UnXuNLeX/bifiloK8NPVsKv5ihzVctaaZJSpOYUl/T
         vHfmaLQcLzgxkSfaS7lLxpwClsTNdbc0kCzxvo9QA3PGA2cPrIC/qJ2yGopJZd+819bn
         foebyEiVS9rZe+LKuYTGp0fa1Y5ExgtR3iJA21iy3t6FxyTXLtX7OxRG3egjV9LwG164
         PYWfalz2JvST0vd2XPWEosTMcyHygnsMlHPSlaFIatdogHsulpSUoM7gVEPs8sDaaime
         sy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0QRTCt9y0nVCiZHknMcc5NdE9lCatyyRD51UF2K9c8=;
        b=BTpclN8VZto/rR1MwekdojuQhGIp93c+RpXEG2m9aw4FNlKwdwYZ0/33US3WPsG1Ra
         Vnk2D5l02fS13bG1uNDRKfsM8JVuEEvKbAhOpFFe1aTKdTZTV4w96mK1cUicCmZatbtX
         uAmjGHXtL/K/R/vNaD1bUhnEfT2x68eh/Fw5iGFeuumlKK2dwXNI2ysi7u+6b86rWpo1
         IoMgp1uSul0eC+atMwo+MdiTd9vJZMP5em5TXM+6JZafKYo27dLKO60bcZGDOwZiv768
         jfRvrYXn3JI+ifx9sBNWap2QxACsztQIZR4s2oy6LoCXWMBuitUeasbmFr1BZkJ5ZDJq
         CQLg==
X-Gm-Message-State: AA+aEWaRA0qz0k7ymWsLhSH5Gp946wp6wfmh/o+CWLvWdwIx3j0OtwSL
        yNf9UZdGV3m0t/L/+15X9Mcv/bgP
X-Google-Smtp-Source: AFSGD/X7rR/EO7gk8aIak+QpCZ3tnj4DYNV+ebh++SgTsEu84qIkVLPAoXGbJnzeLmChM5qWe8Zn9g==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr1622059wru.245.1543499106285;
        Thu, 29 Nov 2018 05:45:06 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba? ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id d4sm2018679wrp.89.2018.11.29.05.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 05:45:05 -0800 (PST)
Subject: Re: [PATCH] staging: wilc1000: correct inconsistent indenting
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     ajay.kathat@microchip.com, adham.abozaeid@microchip.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181128181724.25194-1-straube.linux@gmail.com>
 <d93b32c5861eb5ae552b2ed3fc65c087dc7fa328.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <325d0ffa-85a2-7fcd-30ae-798c0c2c06dc@gmail.com>
Date:   Thu, 29 Nov 2018 14:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d93b32c5861eb5ae552b2ed3fc65c087dc7fa328.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 7:24 AM, Joe Perches wrote:
> On Wed, 2018-11-28 at 19:17 +0100, Michael Straube wrote:
>> Correct inconsistent indenting reported by smatch.
> []
>> diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
> []
>> @@ -963,7 +963,7 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
>>   			dev_err(&spi->dev,
>>   				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
>>   				j, tmp, unknown_mask);
>> -				happened = 1;
>> +			happened = 1;s a
>>   		}
>>   
>>   		j++;
> 
> Perhaps a little refactoring instead
> ---
>   drivers/staging/wilc1000/wilc_spi.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
> index 35ff432587fe..a38ddb1f0a1f 100644
> --- a/drivers/staging/wilc1000/wilc_spi.c
> +++ b/drivers/staging/wilc1000/wilc_spi.c
> @@ -927,7 +927,8 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
>   	int ret;
>   	u32 tmp;
>   	u32 byte_cnt;
> -	int happened, j;
> +	bool unexpected_irq;
> +	int j;
>   	u32 unknown_mask;
>   	u32 irq_flags;
>   	int k = IRG_FLAGS_OFFSET + 5;
> @@ -947,8 +948,6 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
>   
>   	j = 0;
>   	do {
> -		happened = 0;
> -
>   		wilc_spi_read_reg(wilc, 0x1a90, &irq_flags);
>   		tmp |= ((irq_flags >> 27) << IRG_FLAGS_OFFSET);
>   
> @@ -959,15 +958,14 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
>   
>   		unknown_mask = ~((1ul << spi_priv->nint) - 1);
>   
> -		if ((tmp >> IRG_FLAGS_OFFSET) & unknown_mask) {
> +		unexpected_irq = (tmp >> IRG_FLAGS_OFFSET) & unknown_mask;
> +		if (unexpected_irq)
>   			dev_err(&spi->dev,
>   				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
>   				j, tmp, unknown_mask);
> -				happened = 1;
> -		}
>   
>   		j++;
> -	} while (happened);
> +	} while (unexpected_irq);
>   
>   	*int_status = tmp;
>   
> 
Hi Joe,

that looks good to me.
Naming the loop condition unexpected_irq also improves readability.

I will send a new patch, thanks.
Michael
