Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C50C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0560206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="JQwa7N89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0560206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeLEKMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:12:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45148 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeLEKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:12:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so16466141edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4DP5zWXPunjYKEtXdIUQJ80m+wyDhMSo94sqR4GiQiY=;
        b=JQwa7N89LS1QWImmZJbxYzivHzq5vkHw1qcjeVXt6jZPagE6mLc1Oxzl+0IN15fhI1
         Oi38GWY7kKZrPnO2EZtRPP6E1DKynArVN8ZHBRqPI7MW7Z+N8GJO5Ah42YTvPtYY/LrK
         WW+cSDulBEGexNxHhm2R9BQ3s844xTwOFwFg8ScZiJSm/rpX8DedFN7aR2semelPM557
         WcdiOV7OY1Z8+Q2260gHl26rkB7SNjBHGHkLUV6kVBccVYd8FCCsjsk/eT3qVgcx4lBv
         6OIIZMudrmwPQLK2JjUtTg2spk9lPHzIlMLfL4d4XVdK5N9EtHNeygwHNcokvygSXKu1
         Qm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4DP5zWXPunjYKEtXdIUQJ80m+wyDhMSo94sqR4GiQiY=;
        b=Yx/U1i/kPaSVP1+3xRO2Wu4RqCXimykmtv1pE3RiIHd96ngBzMnob7ZShgST54ym3Q
         lovPoQIPLKKUhPueU10x6NMq8GuJBDV9wpXsfRz6bCbaJwbwwJtfMyvempAMgEFqluEh
         qU+ZO7YpC2OuNdKtfsj+3NF9O97nOEZbGrPDegL1FRHXTTFzmieXj5N8bXkxYWTfx2Kb
         gA09il1XPYwaESRC8No/vGNnJ9TjvLTBLnyuxv3FjDHLbk2KRwp1g8YrnpATQuakbkcw
         tux7cux610E5SqldrX75Z41sGDEd20NO63R++mFi2PE7Q09rCJf10CpD5TFRIYM4jpNY
         RUgw==
X-Gm-Message-State: AA+aEWbCzjE5yIr9mf2ZKuBfvjmFMCEeaiZE/tBSVulI0Yt0GGCwqH4h
        KwJhFg5cR+Qo99QTd6JhI53FQ82q6qc=
X-Google-Smtp-Source: AFSGD/XjRDsNjlbSRBfa8VtzzC1ZewxjhQJVwVmuzGs0XFVYLJYRQ70KaSSFR5xmPW/xrsgLIqGk0w==
X-Received: by 2002:a17:906:7f89:: with SMTP id f9-v6mr18186219ejr.51.1544004745950;
        Wed, 05 Dec 2018 02:12:25 -0800 (PST)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id k11sm5124774edq.51.2018.12.05.02.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:12:25 -0800 (PST)
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
To:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
Date:   Wed, 5 Dec 2018 10:12:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 20:58, Cristian Sicilia wrote:
> Some concatenated strings are now spaced.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>   drivers/staging/greybus/loopback.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 1085e06..acfa392 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -141,7 +141,7 @@ static ssize_t name##_##field##_show(struct device *dev,	\
>   	/* Report 0 for min and max if no transfer successed */		\
>   	if (!gb->requests_completed)					\
>   		return sprintf(buf, "0\n");				\
> -	return sprintf(buf, "%"#type"\n", gb->name.field);	\
> +	return sprintf(buf, "%" #type "\n", gb->name.field);		\
>   }									\
>   static DEVICE_ATTR_RO(name##_##field)
>   
> @@ -176,7 +176,7 @@ static ssize_t field##_show(struct device *dev,				\
>   			    char *buf)					\
>   {									\
>   	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%"#type"\n", gb->field);			\
> +	return sprintf(buf, "%" #type "\n", gb->field);			\
>   }									\
>   static ssize_t field##_store(struct device *dev,			\
>   			    struct device_attribute *attr,		\
> @@ -212,7 +212,7 @@ static ssize_t field##_show(struct device *dev,				\
>   			    char *buf)					\
>   {									\
>   	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%"#type"\n", gb->field);			\
> +	return sprintf(buf, "%" #type "\n", gb->field);			\
>   }									\
>   static ssize_t field##_store(struct device *dev,			\
>   			    struct device_attribute *attr,		\
> 
Eh.

But doesn't all of this add an extra two space to the resultant string ?

Not what we want.

---
bod
