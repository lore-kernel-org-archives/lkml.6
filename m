Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1233C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D2120869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTCtil6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D2120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeKSJE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:04:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:04:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so9485373pga.9;
        Sun, 18 Nov 2018 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjjUkrI4nt4MuuTjW2iCnMSISdBPB6QR1Xk6cRw0ATs=;
        b=cTCtil6OqE9cCoTnE1IVHTxATU8AiGsYBTJEDfubyAxOA+HnLLcgl2QK6iEolCqDZB
         lHQauOfdncGpf6oQXDCFzcTv/oQfS+fx/8AbUW0z1Gxr6R7xTLLIBUa5ruJAP6hQvANi
         sAcvwr0JzVJ2E2wKuWP2IAe+uvnjcc5WagA4To5nqmv9580e16VLKaEe47pIi0lgR/lo
         QRSoycwCN4uABOlPg++LpFxDv5iabC/GoBD3QVfAZndv5wvrRGVIIop4p9s8xVoMavDW
         LJUY71TsCLwv+VUjp9j+kH3Fs6B5htfeZqDH5ifPvroVCMuaf/AsRweK4RM03zmktpQr
         ySDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjjUkrI4nt4MuuTjW2iCnMSISdBPB6QR1Xk6cRw0ATs=;
        b=QO1tUpIQhUQoaGwjhpV3dJdkWeyD8JGlQ7ZD6VEEAWuon2RqsYL/nft5xtXhjt17Tr
         6Uq8Vgh4Lp1GY/D9vv0MiEImDhNZQea9pIR3aaH11iknkfsJBm8E2Y410VwUIix6HDN2
         SgPiiTlWpThNlB1gVMmzMMWY/0Yui+8T1T066Qnf9k4HE8YnOLF692Mh3NDsAbLiiW92
         ak/eHgaoa/CRBdwV8GXzuRIME3N3OC1iUjbX3HtKyUBBNd3a1H250pduqx+RO8yMchsO
         +XG0MaCM891uioaUrA4VKXGOxUtpdDOWkP7a1EB/gBverckbkR43jXspbBmfNnh3Ridb
         OG6g==
X-Gm-Message-State: AGRZ1gJcYI+7a60PIN15rb2Gv0Fz6Up++W70tnpgRB+pS1YcXPiC/6u+
        tn9nNY1k0jHHKHd6tsihse0=
X-Google-Smtp-Source: AJdET5fg2l98d59mY8mOadTTWWXsCfCgE2vmRhuFQ+oOSgJeHMLCFlzfT1q744ocCmNbABcaS3Odng==
X-Received: by 2002:a63:4706:: with SMTP id u6mr17026064pga.95.1542581001594;
        Sun, 18 Nov 2018 14:43:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c23-v6sm41446325pfn.95.2018.11.18.14.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:43:21 -0800 (PST)
Date:   Sun, 18 Nov 2018 14:43:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: ina3221: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181118224320.GA949@roeck-us.net>
References: <20181116220540.17222-1-robh@kernel.org>
 <20181116220540.17222-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116220540.17222-2-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:05:38PM -0600, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index d61688f04594..27abbc5b9d46 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -469,10 +469,10 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  
>  	ret = of_property_read_u32(child, "reg", &val);
>  	if (ret) {
> -		dev_err(dev, "missing reg property of %s\n", child->name);
> +		dev_err(dev, "missing reg property of %pOFn\n", child);
>  		return ret;
>  	} else if (val > INA3221_CHANNEL3) {
> -		dev_err(dev, "invalid reg %d of %s\n", val, child->name);
> +		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
>  		return ret;
>  	}
>  
> @@ -490,8 +490,8 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  	/* Overwrite default shunt resistor value optionally */
>  	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
>  		if (val < 1 || val > INT_MAX) {
> -			dev_err(dev, "invalid shunt resistor value %u of %s\n",
> -				val, child->name);
> +			dev_err(dev, "invalid shunt resistor value %u of %pOFn\n",
> +				val, child);
>  			return -EINVAL;
>  		}
>  		input->shunt_resistor = val;
