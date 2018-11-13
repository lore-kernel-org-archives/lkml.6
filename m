Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC76C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976A5224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0420tbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976A5224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeKMO1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:27:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36229 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:27:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so5077855pgv.3;
        Mon, 12 Nov 2018 20:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAdb5ULgmF6PRD2iWSOnSfqN5wEOlcOmJI3KVEm8qkU=;
        b=H0420tbw89YBwj3Mliaq5Yx/xd44sk/ZskWLrV2ZJsXNvupXvP1zqXbNFJtxdj4xiW
         HPRq0kI5UaTM/yyjzcJEPJULfQ0bIVVXEjzN4Egk0IQCx3Y/8kvw60wlES9EFZ395WBO
         XVagORFAM/0cMxxwlGwPDOty2/RoYuDeRbICkbfWvxEs7ll4WXzJjbzOiG41JAqISmI4
         WZBTh5WsNfFVu1yF/EGQgzCpoB1rI2uPt8f4AHfFotwFNeJI45CkcLJhCenRbQPgQgeB
         SL+QT4Z7h3qh0SYRtxgfSRp1Im6P7/L/QUdjPmFvp4kaF/no65YCKPPCNQeUr0/hi8Nv
         V3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAdb5ULgmF6PRD2iWSOnSfqN5wEOlcOmJI3KVEm8qkU=;
        b=rySk0EQUXcQvDoLsxp8FsRrovXEy0A2K/7iTy2L7wg6s02K107VOOrNoZcd/Mo318i
         9btrfZw2G+K/aqTtz9XGIYpI09So+59PLPEFzemepU5bDTXa9ArUvwBmgmE+ndBJ2dQm
         RtuBqZla5+ebDmzyF35GWL4TEboYz9CWGwQZL2F9jKzHuDk+fe5cHozvUNLHYaLOGAlN
         MrpMhEQlhhL+6qf8Z9/YPF9d6YyzkO4t2XmdeoATD3Y3+RG8htc0DB9jSouOici4tTqK
         wksXKzn/SuhQ1KXeCy+cMgQM92bjs6AyyLY6uvMi+XsVZf6DmxodO2mG7GVmMNNW4mTD
         sKKg==
X-Gm-Message-State: AGRZ1gItYor5Vqt8pJk3qwwGffSxHqaGa/+J6dnrDn6iHKAI5ZqyjkPJ
        Yk1mjUNq3Wdzr6Pgf6Ot55Q=
X-Google-Smtp-Source: AJdET5f6jWujWwTQX94V7MiesSv/6EATVlxKoff3cwCD8tG25TlH3ZXwNo+y40yPDxjPktLwP6Nbng==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr3412322pgc.3.1542083485512;
        Mon, 12 Nov 2018 20:31:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r12sm12547189pgv.83.2018.11.12.20.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:31:24 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:31:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add mutex lock to shunt nodes
Message-ID: <20181113043122.GA11205@roeck-us.net>
References: <20181113042324.852-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113042324.852-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:23:24PM -0800, Nicolin Chen wrote:
> The shunt resistor values are used to calculate shunt voltages
> and currents. As a part of sysfs nodes, it would be better to
> get protected with the same mutex too as other sysfs ABI nodes,
> although this is not very critical because the mutex was added
> to mainly protect register access.
> 
> So this patch adds the mutex lock to protect the shunt node.
> 

I am missing something here. I don't see the point of this mutex.
It just reads a variable and reports the result. When setting,
it just writes a value. Protecting the conversion of the passed
value with a mutex is pointless. Protecting writing the value
against reading it is just as pointless.

Guenter

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/ina3221.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 86281afd2619..f7a09ab6c440 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -532,8 +532,15 @@ static ssize_t ina3221_show_shunt(struct device *dev,
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	unsigned int channel = sd_attr->index;
>  	struct ina3221_input *input = &ina->inputs[channel];
> +	ssize_t ret;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
> +	mutex_lock(&ina->lock);
> +
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
> +
> +	mutex_unlock(&ina->lock);
> +
> +	return ret;
>  }
>  
>  static ssize_t ina3221_set_shunt(struct device *dev,
> @@ -547,14 +554,20 @@ static ssize_t ina3221_set_shunt(struct device *dev,
>  	int val;
>  	int ret;
>  
> +	mutex_lock(&ina->lock);
> +
>  	ret = kstrtoint(buf, 0, &val);
> -	if (ret)
> +	if (ret) {
> +		mutex_unlock(&ina->lock);
>  		return ret;
> +	}
>  
>  	val = clamp_val(val, 1, INT_MAX);
>  
>  	input->shunt_resistor = val;
>  
> +	mutex_unlock(&ina->lock);
> +
>  	return count;
>  }
>  
> -- 
> 2.17.1
> 
