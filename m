Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E8CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44ED21564
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHG+RvmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44ED21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJJH4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:56:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39569 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJJH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:56:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so1637933pgv.6;
        Tue, 09 Oct 2018 17:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hJ8qpQWqSXMQ1NYdk6JL67oCPJH+veZL23dJOIvDTY=;
        b=DHG+RvmE+U/1b5dzKrzzmmG6l/UHyX9W6ok+5Qq3rB94Z40rZcb2WQXHydnQKJRcTH
         KSB2tny5ql086WFomH7vvrCrgdV+8JNNWAvRVOWShsGtTi8WKC6qAwaLxD9GuW6moLc3
         r34NIAF8RdT1TnzGxo7PKTHhND1cKyQz4J6UPFvLWj519mmSaEsPwL82pX3/uEMZ/VEj
         NpWDoCv+8H8KxXeuCMd0QSQ2WzTj0NnsnlbB0VOzFHHkQ7LHTo7bunafqXYNErKr0aIL
         7COp5DrV7GdMBVLaYoeFtqiBYWuzBWcOKyXCkcN3WCC02X5elLY8BlgQopieBXyd7LeM
         BfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hJ8qpQWqSXMQ1NYdk6JL67oCPJH+veZL23dJOIvDTY=;
        b=EYmCnNYmR93YJ3f/RjOPRPSq+gb1QEM5PeC5SwccGxJjDcoZsAmaBxleq/Md4cz8st
         +4UL+tbzjD5ucUbVVKnwMrlFokgseE60pSAPnp5biRjpuQlJCBNm8GMj8oRjinXL+slD
         qBCee/msAHNd/d7sQ3SqmtV5GsYjadjGyRbtL/8YJAFfaClci+BxUhz1FHbDYcYUT0Fe
         EgF7ruWuNpIxI6eGqrmcomC3jk/iFWfTwlPn8LOI+hz8hWrnYDE12cO9Kf98hYGuYUpn
         6UTwLYFHZDXqkgsMHjK5RI1ZfgjHDMgcgzi2AtoQDA+mNcvaOWURGQTKL9Mx3Y73JVqZ
         FuCA==
X-Gm-Message-State: ABuFfogqX+ZSJVo+Q1wV/Sb1laIfApI+VkLcYRYB1hfx8Og1/GxOs2IY
        ZD9hE8wiQKpDMnWTDxFc7gw=
X-Google-Smtp-Source: ACcGV6243OCdpPHI6dtHo6pCeo/O0DrYZ+F5y2PJXdhtTYsYKQdBdhXkVE9DinRFQ7NSaBce+LGgEA==
X-Received: by 2002:a63:4a64:: with SMTP id j36-v6mr27716954pgl.168.1539131837368;
        Tue, 09 Oct 2018 17:37:17 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm47423935pfd.99.2018.10.09.17.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 17:37:16 -0700 (PDT)
Date:   Tue, 9 Oct 2018 17:37:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ina3221) Validate shunt resistor value from DT
Message-ID: <20181010003715.GA21748@roeck-us.net>
References: <20181008212451.18637-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008212451.18637-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:24:51PM -0700, Nicolin Chen wrote:
> The input->shunt_resistor is int type while the value from DT is
> unsigned int. Meanwhile, a divide-by-zero error would happen if
> the value is 0. So this patch just simply validates the value.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied.

Thanks,
Guenter

> ---
> Changelog
> v1->v2:
>  * Validate the value and error out
> 
>  drivers/hwmon/ina3221.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index c3a497aed345..4f3ed24efe8e 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -536,8 +536,14 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  	of_property_read_string(child, "label", &input->label);
>  
>  	/* Overwrite default shunt resistor value optionally */
> -	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
> +	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
> +		if (val < 1 || val > INT_MAX) {
> +			dev_err(dev, "invalid shunt resistor value %u of %s\n",
> +				val, child->name);
> +			return -EINVAL;
> +		}
>  		input->shunt_resistor = val;
> +	}
>  
>  	return 0;
>  }
