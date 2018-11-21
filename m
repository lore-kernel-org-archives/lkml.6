Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24289C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D508F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5ZtuZVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D508F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbeKVILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:11:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54247 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeKVILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:11:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so3717420wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=orftqOueCTFr4QJr3CoLQgk8TbDUoUboQOOl5k5RuXg=;
        b=H5ZtuZVEAbHsYGfD5m7dSZ2BY78wlGgUtJzz1AMLYGr0WmPO9+TLCwhQqnzU1IqmFm
         BXkhjtBgnhDL/e/JXNGnektnXUhqKA1c1P3n+35pgvgRMeKx27ZB3ylER0k/2n+6dEXE
         P1xsNGflQOfltlzzyLGhfNKA4YghUhTmiWYvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=orftqOueCTFr4QJr3CoLQgk8TbDUoUboQOOl5k5RuXg=;
        b=udaqPJvks6fQm4CnaFE6qbQTnt+yJZuCHHX9sJBLqPJ9Xa/csOumvWWdhF6HNCACx2
         AKfmorTcEhxNtdu2nwPJvWwo9sJlC90sSROS0lG66udmeFC95YGKFayZP+CWAXWcxYM0
         FY9eNyW1+bMHVvnuTU9iEfdoMrA5z0IfZ+MlTTJ08/asJZ8mFn47EYw439oTAgLA1VBA
         fRtb6Cna/aOfSEdOn130SrFDyqfltT38d4LbcsXbQZGq08sJDD5afCdOPp+qSMP4COX8
         pVizSj5HqMmIKpWgvI0VF5qi5gQvJxStHoAe30AuTbH5oxHamU3muBZg7Z2iaYlamJvc
         koOA==
X-Gm-Message-State: AGRZ1gKmLGgWl7+9vD3uLu18gIPddrN/TznW1LkhRSPAR82q7tpkt35/
        szV7buo+OwtpVTIaDF15t/4oXR6ceZc=
X-Google-Smtp-Source: AJdET5dhtVAveD2oeQFxhP9BdNGY48ewf/8IyScdewkTMyJmKXTXFuahkL/2JhM0Z/CoWpmkKQ6V8w==
X-Received: by 2002:a1c:8791:: with SMTP id j139mr7124569wmd.86.1542836144400;
        Wed, 21 Nov 2018 13:35:44 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id s9sm197890wrw.26.2018.11.21.13.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 13:35:43 -0800 (PST)
Subject: Re: [PATCH] thermal: Fix locking in cooling device sysfs update
 cur_state
To:     Thara Gopinath <thara.gopinath@linaro.org>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <36669c01-4066-07ef-1fd5-74b1184408c3@linaro.org>
Date:   Wed, 21 Nov 2018 22:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 20:01, Thara Gopinath wrote:
> Sysfs interface to update cooling device cur_state does not
> currently hold cooling device lock, leading to stale values
> in cur_state especially if getting updated simultanelously
> from user space and thermal framework. Adding the proper locking
> code fixes this issue.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 2241cea..1f0c1e2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -712,10 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>  	if ((long)state < 0)
>  		return -EINVAL;
>  
> +	mutex_lock(&cdev->lock);
>  	result = cdev->ops->set_cur_state(cdev, state);
> -	if (result)
> +	if (result) {
> +		mutex_unlock(&cdev->lock);
>  		return result;
> +	}
>  	thermal_cooling_device_stats_update(cdev, state);
> +	mutex_unlock(&cdev->lock);

I suggest to invert the condition:

	mutex_lock(&cdev->lock);
	result = cdev->ops->set_cur_state(cdev, state);
	if (!result)
		thermal_cooling_device_stats_update(cdev, state);
	mutex_unlock(&cdev->lock);

	return result ? result : count;


The same problem is there for the cur_state_show() callback.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

