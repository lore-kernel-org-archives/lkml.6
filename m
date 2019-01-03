Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838102073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H46QzjC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfACC3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:29:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40177 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfACC3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:29:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so35542230qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 18:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BOCxujPQqSYNW7EN8vihehSI7jwqabnkraHEDNVAbAg=;
        b=H46QzjC6NxE3D5FJGQieQHjJtaxcXaenJ36GuhPCpx0NRlpkFEqMhNuMtZk2VzhW0c
         6aUOBiH7PQS1S+OgxBjKPKYvmK+YU4MT9cjX6oZ1I7MkOIXkW+tFJEzki7wOHe0hmYNz
         rDR2zkzCqxnuU3KbrbzI6VHWVU8Si2bRT3lR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BOCxujPQqSYNW7EN8vihehSI7jwqabnkraHEDNVAbAg=;
        b=QBo6+5WoafidAlrQwi28T/G0i4QRJjZlGMx1+LvDOs2PnGcbQwU+QcAAYx5FApjfHJ
         ycIHIAiF79Fq79GZHQlJ4w8PZuPb5OuKfyCXk/l0JWL2PV56s35YGGcBiXbLbszY8OKa
         fOW9HtfCUUYanE6RPnlYRZ7tQYZHbD/e50X7r3jdWEgAPYdP+oawxIz0ULuPfvI9dqkF
         YtLXG3NF68dV7t/EDNUnhPFTerPzzdU3SBKjJ2+8LZrKsAlUrbSp40HjiSbIECCaPJC8
         jCyh6QivDBpllafuIliKV5amPn8Pej9GLGxlmg+R3dEn8yY7NVmOjdioB6pU+pw62tA2
         3JFg==
X-Gm-Message-State: AA+aEWaWAYfbnDD55QkC6Es4V/Muz9LQRQL/7lbCQSomwN0CBQLPRCxF
        RrB+eW7w+Z0sFfLzmGgX2isDZGRK/3E=
X-Google-Smtp-Source: AFSGD/X1TkdmvEhipDOH8iO5D9+YdtWhF/bdEE86+26TYJ9zhF830blCATAjSKBFiXdqQO6/WIm7Ew==
X-Received: by 2002:ac8:674b:: with SMTP id n11mr43712546qtp.104.1546482552553;
        Wed, 02 Jan 2019 18:29:12 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id v1sm25458220qtj.68.2019.01.02.18.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 18:29:11 -0800 (PST)
Subject: Re: [PATCH V2] thermal: Fix locking in cooling device sysfs update
 cur_state
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
References: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5C2D7376.3010408@linaro.org>
Date:   Wed, 2 Jan 2019 21:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 05:43 PM, Thara Gopinath wrote:
> Sysfs interface to update cooling device cur_state does not
> currently holding cooling device lock sometimes leading to
> stale values in cur_state if getting updated simultanelously
> from user space and thermal framework. Adding the proper locking
> code fixes this issue.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> V1->V2: Rearranged the code as per Daniel's  review comment 

Hi Eduardo, Daniel

Any comments on this ?

Regards
Thara

> 
>  drivers/thermal/thermal_sysfs.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 2241cea..aa99edb 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>  	if ((long)state < 0)
>  		return -EINVAL;
>  
> +	mutex_lock(&cdev->lock);
> +
>  	result = cdev->ops->set_cur_state(cdev, state);
> -	if (result)
> -		return result;
> -	thermal_cooling_device_stats_update(cdev, state);
> -	return count;
> +	if (!result)
> +		thermal_cooling_device_stats_update(cdev, state);
> +
> +	mutex_unlock(&cdev->lock);
> +	return result ? result : count;
>  }
>  
>  static struct device_attribute
> 



