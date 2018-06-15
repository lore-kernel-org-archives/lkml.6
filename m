Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF86C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E91208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VbRqJK64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E91208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756653AbeFOVGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:06:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45509 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbeFOVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:06:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so4916992pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfG5JNli+hUiVvEM/draKVctF8uP/P8E6BPq+4GfnnE=;
        b=VbRqJK64bG6JRlRc4JEel+cGk5Anya0CJg2twx3NSpjPPudARcr8peis8TLSwIosZW
         2DWCcJmYGYqM7uvZ0yauY7x7fv+MDYZPFA1vJh5oBHVW4vMN2dc/pTzMV7Nw2tKLkbOK
         vCUJvYTx9+EFPMADQAiCg/FDwfmBLg6pUGmXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfG5JNli+hUiVvEM/draKVctF8uP/P8E6BPq+4GfnnE=;
        b=gsrG2GorgIKNQWbXiewcNCE9G9U9LE9YDgSjjtAdrX5VDd4uZO7kH+RtLXQbNsbrMP
         +jHGMekyMQbEwNmPS0htxwGbxsX26omwazZVWMhnGxTLdSfOf0OS+oBxBnqF5zolIVVN
         oMWSC+QbnQMTnszy9C5B3MxNLc9DtFepUp8CPaKEFz1IDwVENLrKFWwHDLiaQIBEnWA0
         n5PQhWq00ximd2l8uJsxCVC2blsSaf+uYL0NSilfXSemP3jBGMZ+DrWRnVhTbUnFqguv
         cdFkyJHuZOKH3smz61OQPjWFUIZAXdf8399JL1LNL3ttUGje6QHETAsUOck0mYLg5fH9
         q5EA==
X-Gm-Message-State: APt69E2IeakNbLaIeBxq3iQNola2sFbIJKU/9R13NEGKDo1CKa8m5t8N
        hmdIt8vHne6AczgV0j+N0t+K3A==
X-Google-Smtp-Source: ADUXVKJDqT694erzF8CZG92SRzSvJnZS8f2MzwWmWyfx60nPQwntJnNGHvvz7xJaddwODq6Cmh18Zw==
X-Received: by 2002:a63:618f:: with SMTP id v137-v6mr3064322pgb.145.1529096784100;
        Fri, 15 Jun 2018 14:06:24 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id w10-v6sm14634717pfa.135.2018.06.15.14.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:06:23 -0700 (PDT)
Date:   Fri, 15 Jun 2018 14:06:21 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/12] PM / devfreq: Init user limits from OPP limits,
 not viceversa
Message-ID: <20180615210619.GA249892@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-2-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 12:47:01PM -0700, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> the devfreq device") introduced the initialization of the user
> limits min/max_freq from the lowest/highest available OPPs. Later
> commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> frequency") added scaling_min/max_freq, which actually represent
> the frequencies of the lowest/highest available OPP. scaling_min/
> max_freq are initialized with the values from min/max_freq, which
> is totally correct in the context, but a bit awkward to read.
> 
> Swap the initialization and assign scaling_min/max_freq with the
> OPP freqs and then the user limts min/max_freq with scaling_min/
> max_freq.
> 
> Needless to say that this change is a NOP, intended to improve
> readability.
> ---

BTW, putting the '---' here means that stuff below it usually gets
dropped when applied (e.g., with git-am). So it'll drop your
Signed-off-by and Reviewed-by. Not a huge problem if the maintainers
look out for that.

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag
> 
>  drivers/devfreq/devfreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..0057ef5b0a98 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> -	devfreq->min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->min_freq) {
> +	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> +	if (!devfreq->scaling_min_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_min_freq = devfreq->min_freq;
> +	devfreq->min_freq = devfreq->scaling_min_freq;
>  
> -	devfreq->max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->max_freq) {
> +	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> +	if (!devfreq->scaling_max_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_max_freq = devfreq->max_freq;
> +	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
