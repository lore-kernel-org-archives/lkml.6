Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3320843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3zMe6zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C3320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeICKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:42:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43436 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeICKmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:42:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so8210675pfi.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MaDjgc3GK/Kc/7d3E4rKbwOeV9W2wEl2YtI9tWjgF8k=;
        b=d3zMe6zgZK6WrJP4eHYQnTAjhDKvMDCk5JJm3OSdY7v2DP6CWFOcZi1tDvlSKjTPAF
         LokCDdvvbrH6JS4cDl+mGzoK3JQtByLqZLdQM5ZkcudXRNU92Cf/t6TecbFAdQH4nUcr
         tLdPi2S6CIgPxQggrPhuhMna+mhCr/fVTM8Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MaDjgc3GK/Kc/7d3E4rKbwOeV9W2wEl2YtI9tWjgF8k=;
        b=TGWcGLT+/NOLKZ6ODzXR5MW+GJ4813p+cjNDO+7aMXqCAPTwaGCHRGzagefnUQPatO
         226xRPeoLUILCya0oyzt1vTu076PT9g+2HC37hgLQ0vyyLIo6FXqvN1MbSzA/LAtkiVH
         X2S5A6+naU5DlXGbk9Cehu2tPpP+2PWMiU/hZvKHfHWRqeLlinsf2+/8dyjTaCVdkkXN
         VbLfTamIANGkL/fJxDRa7AAnh3Rfb/3spweZzOW0PleyoFkMPlJbYkcrNls+OYc0QCtj
         Q+OHDMF0ROS0vE2BrzmPb7YOvjWs9UlXaXh/sucKGT/dBTB2j3LgrEfwFUaTbgG1Mu0E
         VAzA==
X-Gm-Message-State: APzg51Dsbb/isM8qhWmHxogoEsozS2xpCBWVVUZ6F3FGmJf5VvjvAWtS
        mzfu2KdWVhh/WaA5ccupN5y9DQ==
X-Google-Smtp-Source: ANB0VdYuqH329rF2dwHr0v1N2hsO/wIyuzWNX3witH6HS6mX7T4/l/07QIBv4jQO88O0+sbnXBZ3yw==
X-Received: by 2002:a63:4b1f:: with SMTP id y31-v6mr24685723pga.14.1535955831268;
        Sun, 02 Sep 2018 23:23:51 -0700 (PDT)
Received: from localhost ([122.171.76.41])
        by smtp.gmail.com with ESMTPSA id v2-v6sm19859995pgf.58.2018.09.02.23.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 23:23:50 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:53:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] thermal: core: Fix use-after-free in
 thermal_cooling_device_destroy_sysfs
Message-ID: <20180903062348.e3qadikukr7d4yi7@vireshk-i7>
References: <20180813171400.15345-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171400.15345-1-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-18, 20:14, Dmitry Osipenko wrote:
> This patch fixes use-after-free that was detected by KASAN. The bug is
> triggered on a CPUFreq driver module unload by freeing 'cdev' on device
> unregister and then using the freed structure during of the cdev's sysfs
> data destruction. The solution is to unregister the sysfs at first, then
> destroy sysfs data and finally release the cooling device.
> 
> Cc: <stable@vger.kernel.org> # v4.17+
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a..441778100887 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>  	mutex_unlock(&thermal_list_lock);
>  
>  	ida_simple_remove(&thermal_cdev_ida, cdev->id);
> -	device_unregister(&cdev->device);
> +	device_del(&cdev->device);
>  	thermal_cooling_device_destroy_sysfs(cdev);
> +	put_device(&cdev->device);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
