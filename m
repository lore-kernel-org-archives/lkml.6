Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9684CC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739A2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2ykPIAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAGTca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:32:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34366 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfAGTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:32:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so626351plz.1;
        Mon, 07 Jan 2019 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9Zm2zLLTG+FgZqASlSTT+P/5IN9Lxy3p1LmClfLLK4=;
        b=a2ykPIAoav8CA0bfAoMkV/kY/5ulAbVbjg4ui8IXYw8EqzEpQJE1yQ4YS9s2h4sp/E
         H5YUGH+xSdUmisblsMJ2dX1PA2IXC7oLqFIUIOdm+7ZLRisE8Iruyj5pIpkNIDeymNFE
         NUUOWa5RzH0IQ9cpczVSZ/OENik3jZcYiEMLN+jFgqohTDUVlq6stCO/gL4ZdCr/lf8o
         YAa+CDZrFXqDQp6D2XGKOXtAQaJBeVMWl8c3IpA4byuiGd4tsIB4JvEN8WlBLdLo9UGN
         LgVEtJtgn5+fBMgS3DWVrTnyOGIkafgiOkY82xJMSXVLfzir2r3VCdAEK1VJimJjILmp
         gluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9Zm2zLLTG+FgZqASlSTT+P/5IN9Lxy3p1LmClfLLK4=;
        b=Jl5Nx93CPIE0vM7t7v2HwRKI9GVAQYAL5XHN7UiRHKN0Ff9i1kmywHgMFqRYhFoGqZ
         XwnAbW1Xa7QDByVIERR/jARAU/exW06ZyJVNTaYul6ZLn4AoZF1pgXyIgeZsLwNLykMY
         ZsMZWtPrdwXATXOsGXbPQk08BbaAL3aUUQcr9hUuwqFaEk/agv9XLTHmk6wX34cqDkfo
         KDtM7rUud/bEBU0kSoQ6+J1MFnpbxDdjKHR1NYFM9JTf1apb+q8PTrAReQS9UjHAj2jG
         3/kmhml3tudEWbowDtyCBjCNsbI1dvkgCbm0EEmZMlGq6A5ALy0icyuTS78HWa5h0uPP
         MLUQ==
X-Gm-Message-State: AJcUukfteaHM7qUZBtnq16te/6qubaQNtJ5c0GCR43Dl2pGthdbL6cwJ
        VDju1cBRtESaeYOA8h+ldaM=
X-Google-Smtp-Source: ALg8bN5FFGQFx5Fy6b33H/T8FSMY5XEvJgtuV8IgNh41BJgR10T/iuY+uO63LBzZKUjONwvCaK1hsw==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5mr62118791pll.63.1546889549245;
        Mon, 07 Jan 2019 11:32:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm85827098pgl.69.2019.01.07.11.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:32:28 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:32:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (occ): Fix potential integer overflow
Message-ID: <20190107193227.GA10660@roeck-us.net>
References: <20190107183431.GA12428@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107183431.GA12428@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 12:34:31PM -0600, Gustavo A. R. Silva wrote:
> Cast get_unaligned_be32(...) to u64 in order to give the compiler
> complete information about the proper arithmetic to use and avoid
> a potential integer overflow.
> 
> Notice that such function call is used in contexts that expect
> expressions of type u64 (64 bits, unsigned); and the following
> expressions are currently being evaluated using 32-bit
> arithmetic:
> 
> val = get_unaligned_be32(&power->update_tag) *
>                         occ->powr_sample_time_us;
> 
> val = get_unaligned_be32(&power->vdn.update_tag) *
>                         occ->powr_sample_time_us;
> 
> Addresses-Coverity-ID: 1442357 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1442476 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1442508 ("Unintentional integer overflow")
> Fixes: ff692d80b2e2 ("hwmon (occ): Add sensor types and versions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 423903f87955..391118c8aae8 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -380,8 +380,8 @@ static ssize_t occ_show_power_1(struct device *dev,
>  		val *= 1000000ULL;
>  		break;
>  	case 2:
> -		val = get_unaligned_be32(&power->update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -425,8 +425,8 @@ static ssize_t occ_show_power_2(struct device *dev,
>  				       &power->update_tag);
>  		break;
>  	case 2:
> -		val = get_unaligned_be32(&power->update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -463,8 +463,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  				       &power->system.update_tag);
>  		break;
>  	case 2:
> -		val = get_unaligned_be32(&power->system.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->system.update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
> @@ -477,8 +477,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  				       &power->proc.update_tag);
>  		break;
>  	case 6:
> -		val = get_unaligned_be32(&power->proc.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 7:
>  		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
> @@ -491,8 +491,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  				       &power->vdd.update_tag);
>  		break;
>  	case 10:
> -		val = get_unaligned_be32(&power->vdd.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 11:
>  		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
> @@ -505,8 +505,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  				       &power->vdn.update_tag);
>  		break;
>  	case 14:
> -		val = get_unaligned_be32(&power->vdn.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
> +			   occ->powr_sample_time_us;
>  		break;
>  	case 15:
>  		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;
