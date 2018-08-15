Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4643CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FC21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI88NGOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233FC21545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeHOXg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:36:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38698 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeHOXgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:36:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so999622pgq.5;
        Wed, 15 Aug 2018 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+wJRTodUh7NWsDIrwCgqXsoZBqLUzThqW90zF52s3s=;
        b=FI88NGOufjlPtrWo0PWE+3hJXXqTVeOZ/LfnMU3QZc8lYvAUMKQjTHo6+LYQqh/uii
         5+GqzolVNnnDcePurcnJZFQds+QD1sbmNruQ2enn/fAspV+atk4KHgwdEIMihIT8wLfv
         qgBcwtKqKvY7VDvJ6f9GvDMryZzwC5GBkxzE7v22EzpqyhlGjTR+dgyLYm5mqL11N4gb
         oscH92Cq5qRuoL6KZ6W3mw8u63p196Zhzn1wjbyV7OI2gM8ivFNtcaiiJYr4ipXQ0bTc
         Xr8BRwNsgpwkTWsG2xZBSstGAx/ctX2oMhDuvPXjlsVWzLAX5E9AUUITfpbw4vk7t/9H
         romA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+wJRTodUh7NWsDIrwCgqXsoZBqLUzThqW90zF52s3s=;
        b=ZW7kQgiZx28UDdlrJ5d8MMd/fxg152BzVBrknXciAWaG+SkMB/rb2NMNZbwtQGeFHM
         7uFMlZ8tbiGEbcHhJDWlFJMbNrOUuGllwpowzilNxo2jJHYOpPO1FGKe2nXS5e4RL9Vi
         Fv6SeGqWY9bKwMl5cb2AHVk3q7VtIW+lL8vqhEjhAhg1gp68//0odRHPkB7l06YAZn7g
         nT9EloKZP9y+PlY0lhfCLsHvUMnh/dh9Bbk2SOqrePKui+ifkYDmJQPOJhLiZVhfPWU4
         iX23LwbmHFrw2yyKEN83N6Hgh7ZIwRkGj1uZh/9jnINjdsjVJm4lZ9lzM7AOSEN5kvZC
         SKhQ==
X-Gm-Message-State: AOUpUlHqG8xAFyXKkmkOJQLsH3GGBp13e2l+Jxk87ygVh6u+ZVilM/pK
        sSUKaNvrjoPTyEXiLBut4HI=
X-Google-Smtp-Source: AA+uWPzwYEVpK1Z8IwRK/CRrShDKxURIURJWw15f5kuqcaYTj0fHo6dfiUHkOkDgoGdFTrWC4RjW6w==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr29362415pfk.90.1534365789876;
        Wed, 15 Aug 2018 13:43:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f19-v6sm37706800pfd.147.2018.08.15.13.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:43:09 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:43:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) Fix potential Spectre v1
Message-ID: <20180815204308.GC18407@roeck-us.net>
References: <20180815131437.GA25639@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815131437.GA25639@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:14:37AM -0500, Gustavo A. R. Silva wrote:
> val can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> vers/hwmon/nct6775.c:2698 store_pwm_weight_temp_sel() warn: potential
> spectre issue 'data->temp_src' [r]
> 
> Fix this by sanitizing val before using it to index data->temp_src
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index c6bd61e..944f5b6 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -63,6 +63,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dmi.h>
>  #include <linux/io.h>
> +#include <linux/nospec.h>
>  #include "lm75.h"
>  
>  #define USE_ALTERNATE
> @@ -2689,6 +2690,7 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
>  		return err;
>  	if (val > NUM_TEMP)
>  		return -EINVAL;
> +	val = array_index_nospec(val, NUM_TEMP + 1);
>  	if (val && (!(data->have_temp & BIT(val - 1)) ||
>  		    !data->temp_src[val - 1]))
>  		return -EINVAL;
> -- 
> 2.7.4
> 
