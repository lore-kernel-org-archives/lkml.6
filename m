Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E4A204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="io7Dv7w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E4A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeKBW5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:57:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33469 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:57:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id o89so3149851qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5IrRo836/EZuNtecTHHEBsqnp85MzPlSS4Bg+Ua1VEc=;
        b=io7Dv7w8ZcC4qKlPesPZ505vBn42poyeBa52VNxI3QRRtUiuR+Bms+Vlf97RNGPdbl
         K8t/kCzZdlBWVpULVEe1V14StyBz+UXsUl+t4eUMYEAggwggXLJl6k4bxB4IuGdlva4/
         qAdRS8Fpmyzm29zidjSZlnJcej13HNCEadK+q/njeiE5C479Z/FULxIpMeELzxwcbv5l
         2sw+SHKbH2ac+mNNAT/P2EJV6OgahIIrJSboTOEkCWcJPA7U0zNII7rW9Ekm90IiFwPA
         L1qL+l/ZeVecjIExikZs2/vGZ4uvZHCEez6oksnbbh5cM7yyqrrOe3+hdQk3q8MmC+JT
         SEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5IrRo836/EZuNtecTHHEBsqnp85MzPlSS4Bg+Ua1VEc=;
        b=jnMaCwRckVC030Z8jQdVXwix33hscr2XZE+7YqweT2IIjAA3oYLYjIbtmIOj1VSeD8
         vBc+vAvNNiFIIH78Age8wTArP5End2CkBK3KcvhEic16kvd2U6PJfWHoItepwZm95ev+
         wIifYM2WKht/EdLjeBNPschgszxVfj3wloeWS/v0EIV07FKnnVIJc1Vyy+ZQTtrY38oE
         4fAbDPahQHbPz6e0iC69bTESUztGXgIUdMN8/Z15YNvo5dr1U7ZVsuZrWu0CNM9WZNKL
         /7vZ+8QEX/S6wn7yZTrVw/yIhKC0zBnCSTeqcbUEXHlgE5FWUObQkM3Cu6ClqXu1uKRX
         7TFQ==
X-Gm-Message-State: AGRZ1gKG8/zPBbE3ACL3+/T69jbsKg1A9MbxgGkDNBSyGTnhKv26zWXT
        jBkmQuhl9w17JstTiNjjib8tzQ==
X-Google-Smtp-Source: AJdET5c5gQdh3X9Aq88qX0Z1pPeegk8tHM0YiQeN9slGkyZSwQZDcHIkxJQJQhDCQKJF3T1xf9QpTg==
X-Received: by 2002:a0c:bb82:: with SMTP id i2mr1500246qvg.159.1541166604366;
        Fri, 02 Nov 2018 06:50:04 -0700 (PDT)
Received: from ?IPv6:2804:14c:81:942d::1? ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 38sm13245612qkw.56.2018.11.02.06.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:50:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
 <20181027020005.3140-2-matheus.bernardino@usp.br>
 <20181028164038.0c920358@archlinux>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Message-ID: <707d385e-7c08-91a3-2925-0cadf5bc2ac4@usp.br>
Date:   Fri, 2 Nov 2018 10:49:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181028164038.0c920358@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/18 1:40 PM, Jonathan Cameron wrote:
> On Fri, 26 Oct 2018 23:00:00 -0300
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
>> Previously, when spi_read returned an error code inside ad2s90_read_raw,
>> the code was ignored and IIO_VAL_INT was returned. This patch makes the
>> function return the error code returned by spi_read when it fails.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Hi Matheus,
>
> One quick process note is that it takes people a while to get around to reviewing
> a series, so whilst it's tempting to very quickly send out a fix the moment
> someone points out something that needs fixing, it is perhaps better to wait
> at least a few days to see if you can pick up a few more reviews before you
> do a V2.
>
> A few comments on this one inline.  I think it can be done 'slightly'
> (and I mean only slightly) nicer than the version you have.  Result is the
> same though.
>
> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
>> index 59586947a936..11fac9f90148 100644
>> --- a/drivers/staging/iio/resolver/ad2s90.c
>> +++ b/drivers/staging/iio/resolver/ad2s90.c
>> @@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>>   	struct ad2s90_state *st = iio_priv(indio_dev);
>>   
>>   	mutex_lock(&st->lock);
>> +
> Unconnected change.  I'm not against the change in principle but please
> group white space tidying up in it's own patch.
>
>>   	ret = spi_read(st->sdev, st->rx, 2);
>> -	if (ret)
>> -		goto error_ret;
>> +	if (ret < 0) {
>> +		mutex_unlock(&st->lock);
>> +		return ret;
> I'd actually prefer to keep the return path the same as before as then
> it is easy (if the function gets more complex in future) to be sure
> that all paths unlock the mutex.


Ok, got it! But then, in patch 5, when we add the switch for 
IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW, should I keep the goto and 
label inside the switch case? I mean, should it be something like this:


     switch (m) {
     case IIO_CHAN_INFO_SCALE:
         ... // Does not use mutex
     case IIO_CHAN_INFO_RAW:
         mutex_lock(&st->lock);
         ret = spi_read(st->sdev, st->rx, 2);
         if (ret)
             goto error_ret;
         *val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);

error_ret:
         mutex_unlock(&st->lock);

         return ret ? ret : IIO_VAL_INT;
     default:
         break;
     }


Matheus


>> +	}
>> +
>>   	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>>   
>> -error_ret:
>>   	mutex_unlock(&st->lock);
>>   
>>   	return IIO_VAL_INT;
> The 'standard' if slightly nasty way of doing this is:
>
> 	return ret ? ret : IIO_VAL_INT;
>
