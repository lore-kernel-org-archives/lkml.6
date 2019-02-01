Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D9214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0Y1Olg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBAWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:37:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45781 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBAWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:37:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so3575619pgc.12;
        Fri, 01 Feb 2019 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZ+dslQGXf/qAdEB8AMBUIWtGdSDV/YSGPZ7JBovFzw=;
        b=gt0Y1Olg0pv/KnAYqxASo7ANjdPPQJ527fBk55P2VfpEd9T384CPW7484J/WJAkFC0
         X6dp+6b/SWj15+aIMlgELbByolWZBDfPJnEoPrnw8wOitmEhv4j6LT+DD45Lgnj6aJH2
         PPGbOgR9SafduhGDHBtRCAGieVMTVIwwELjK3xlheBBT3kocQ0QB7xJz20D8y6HhLiqa
         TFMC3bsu0l6YjfFmUbhNROWfxcIae5qByLOpZUioAo7W0+5XtXAZSGo/TQTWTbqxnZ1V
         LpLrNs4GJ5ij8kdj8QayRl/X6GDo5yPfpcmk8fJjWRK3hFRe15fOy/wbTviSU1vH0gFG
         9U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZ+dslQGXf/qAdEB8AMBUIWtGdSDV/YSGPZ7JBovFzw=;
        b=Q+N65yijp1FExNRDcl9OV51RyuF1QsyhByCd0rXV3mbNhDOWRRhg3FoDPWnwaW4CCk
         fwa2I8dokMepztFIX5LQg93Cj9nXwsZ+9IqkjX7BRK/eyfI9RQpzuUxQTamW6pNDLydM
         chhletDf6q6VMDiL6bbEY5dngnM6zZmQo+B8g77Exqk1ltTa7g/SIgfsPG0+XedrMd9U
         f4Nip7wOP6Q6wxyIhTsZkcC/gIBgXtHv8TyiDqxyyVpUrN2rJNae+l+f1pGIRzczIFlH
         NeLBLI3TbXgic1PuhSbAYsBqZSUG+LlU244OK/LTdK3AqC+SjWDgnGhYSbYWmP13lH8X
         zB5g==
X-Gm-Message-State: AJcUukcw/QRJsOmz1RGRMY0aszoAqHwBgEo4RxhBLrb8u5p6eZ+MXoLr
        MbNKQEUERNA/KDsNlnPQJKQdMkkp
X-Google-Smtp-Source: ALg8bN6dXew8vM5K1cZRZhnk9/65LtMSV2GUSVF6fQK7Gq+xgvljukNIdboHaZitzSXk1ICeRDYT6Q==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr42084272pfc.159.1549060668928;
        Fri, 01 Feb 2019 14:37:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h185sm14324946pfg.143.2019.02.01.14.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:37:47 -0800 (PST)
Date:   Fri, 1 Feb 2019 14:37:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (lm85) add support for LM96000 high
 frequencies
Message-ID: <20190201223746.GA16166@roeck-us.net>
References: <20190131220617.15223-1-jgebben@sweptlaser.com>
 <20190131220617.15223-4-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131220617.15223-4-jgebben@sweptlaser.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:06:17PM -0700, Jeremy Gebben wrote:
> This chip expands the freqency field from 3 to 4 bits, to
> add more frequencies in the 22.5 to 30 kHz ranges.
> 
"This chip" -> LM96000

> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
> ---
>  Documentation/hwmon/lm85 | 3 +++
>  drivers/hwmon/lm85.c     | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
> index 9f3a945d1..264874f09 100644
> --- a/Documentation/hwmon/lm85
> +++ b/Documentation/hwmon/lm85
> @@ -140,6 +140,9 @@ of voltage and temperature channels.
>  SMSC EMC6D103S is similar to EMC6D103, but does not support pwm#_auto_pwm_minctl
>  and temp#_auto_temp_off.
>  
> +The LM96000 supports additional high frequency PWM modes (22.5 kHz, 24 kHz,
> +25.7 kHz, 27.7 kHz and 30 kHz), which can be configured on a per-PWM basis.
> +
>  Hardware Configurations
>  -----------------------
>  
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 4b15193d1..88f08f4bc 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -202,6 +202,11 @@ static const int lm85_freq_map[] = { /* 1 Hz */
>  	10, 15, 23, 30, 38, 47, 61, 94
>  };
>  
> +static const int lm85_high_freq_map[] = { /* 1 Hz */
> +	10, 15, 23, 30, 38, 47, 61, 94,
> +	22500, 24000, 25700, 25700, 27700, 27700, 30000, 30000
> +};

Should be lm96000_freq_map.

> +
>  static const int adm1027_freq_map[] = { /* 1 Hz */
>  	11, 15, 22, 29, 35, 44, 59, 88
>  };
> @@ -1574,6 +1579,10 @@ static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		data->freq_map = adm1027_freq_map;
>  		data->freq_map_size = ARRAY_SIZE(adm1027_freq_map);
>  		break;
> +	case lm85:
> +		data->freq_map = lm85_high_freq_map;
> +		data->freq_map_size = ARRAY_SIZE(lm85_high_freq_map);
> +		break;

This is too generic. You'll have to introduce a 'lm96000' type
and use it. That should be straightforward since the lm96000 
is already detected (and for some reason handled as lm85).

>  	default:
>  		data->freq_map = lm85_freq_map;
>  		data->freq_map_size = ARRAY_SIZE(lm85_freq_map);
> -- 
> 2.17.1
> 
