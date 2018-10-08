Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61FBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D8320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7k+TYBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D8320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJIDhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:37:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIDhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:37:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so8321483pgm.7;
        Mon, 08 Oct 2018 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wBEyPiY0tb/FG3rRiXF4B43R1OWW8Wq+0elDJxeiWtI=;
        b=b7k+TYBexuWY3TclWyLkws7JtrB4Ioob7ve1TZrr2vF8fPOTTty6oNGgJmMyR38sjx
         ocS+cD6Sl2UubchCz42WMHoogz2l7yoT/Ztnyjjxj7z7KvVnPVdlbmeVp9ndRAREZ9je
         1TGDFo0BcUibBLbqeTNST5hIeNN0eQ/nlAaKkBieG26pRWZ7lv49WTFPoF2I4am+F8Ji
         cgjX7OAE6JPvhRh1Mop02Sb7OFmu/p7EQd8J6vnypOamUhis2dFqWxHNWC0G1jiDwEIA
         /Gs93yBcf0ON5YrqQoKk+ospwrEZFKCAzyZk/nUwfSwlKYhiJ9sWV8dCgJj21lM6tFVw
         FAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wBEyPiY0tb/FG3rRiXF4B43R1OWW8Wq+0elDJxeiWtI=;
        b=e3nfH3XL6X4IaOjqDetpseeZVCCHB+JucnStCOSWFDYrd/R6ruNrkSUpMJo8uhckd6
         paPpMHbJaEayjjNe6xn0+8/ByzRZTqK0vRltQWY8rgOAOe2V9u9OUnMyt3UVTL7H62t1
         uccJM0iPx1e7cEbzsJjBMysm/KddovQRdISsQrkBv8NdSahA1Y09leKn4OSXaAodyZyC
         pZCtFmyjT+waCY1us2N8VooJTRskBjrtdRse7XXlMgP2YWDtS4JWFCXZCDt0zj1SIZvZ
         bO1it2hvUTrdxEHF0zWS1flzjeI8CsOVEa3i/GxkgRxszvcAtMsn4qIKnfWEXbYEUvPI
         XaSA==
X-Gm-Message-State: ABuFfoj/RLtUQ7vV6F46HFtxwEGIx5PGaqdKky9xevr0Q/wtITXlNX77
        UHcyzK0KRfCy3NQLtxV1SA4=
X-Google-Smtp-Source: ACcGV62O9F+Fbov+2ey2vt8cg5iKC9xsF58M1gzt4zm0XfZTPZR/vbB564GouOAoIa1+5VPa5g3VOw==
X-Received: by 2002:a62:5d0c:: with SMTP id r12-v6mr27016099pfb.123.1539030244543;
        Mon, 08 Oct 2018 13:24:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m11-v6sm21011429pgn.39.2018.10.08.13.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 13:24:03 -0700 (PDT)
Date:   Mon, 8 Oct 2018 13:24:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Clamp shunt resistor value from DT
Message-ID: <20181008202402.GA27003@roeck-us.net>
References: <20181008200537.22062-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008200537.22062-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 01:05:37PM -0700, Nicolin Chen wrote:
> The input->shunt_resistor is int type while the value from DT is
> unsigned int. Meanwhile, a divide-by-zero error would happen if
> the value is 0. So this patch just simply clamps the value.
> 

I think it would be better to validate the numbers here instead of 
silently accepting bad values, and return -EINVAL if the property value
is bad.

Thanks,
Guenter

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/ina3221.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index c3a497aed345..ce8f0a8c4982 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -536,8 +536,10 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  	of_property_read_string(child, "label", &input->label);
>  
>  	/* Overwrite default shunt resistor value optionally */
> -	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
> +	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
> +		val = clamp_val(val, 1, INT_MAX);
>  		input->shunt_resistor = val;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
