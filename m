Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59813C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E95208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xl6jytFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E95208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeGaT2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:28:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34604 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeGaT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:28:11 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so13782720ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xJeOYL3BXF6TIv3IemtbsQwe9f6MDwAvR23Hx8VlEIY=;
        b=Xl6jytFUi6GfhHKHfXSSCa0pY63iiRUDXCZc8HmPx00RwsvU7tJbs4xvPV5pqdMACA
         aUZMZPFFQ8hK7oTW8Ut4kDcUNCEI99cJFLTqN3uWd3q3DZVSSG4PGQKIklEzOFomuNyu
         keqQj0ZLmgfO+qXY4Jl7OS6jw45W4Vtz7sQXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJeOYL3BXF6TIv3IemtbsQwe9f6MDwAvR23Hx8VlEIY=;
        b=lttNBz+wy5ZTvLSLYoruvT4bsVwu0r8Mui7Rawt2vvJCJs87jJwJvfw/rA83j3thDn
         68q/lOgCrcy+0P+hllrEf0SDx9V7SBkAbNep+s3klygnKgJZz1OeSRE51RGOYnAnel3n
         utlGNTcTQ+jNrDLk9x0ybqAyeGBoPzwZNVFxEwuJnYGtf3BzYGrVnkEVygjXll8ev+Ih
         xgTMKQyumsNR56pikJ853l/zXYHHKLBmRblpIo/5vD+5A7cCBLcJg6X4AIiHxoi1tPkG
         RTyns9yheu+14bCbKcp3/u72F0vK27vmw0fcHN0Ujo8NydN49soczlI4dKwTWXwqMjR2
         CbZA==
X-Gm-Message-State: AOUpUlF81OWOvujHx6UFpdIGxVfuc4dQmM4RKrVbK5Yin0TyBl2Z7SYV
        vc5mEbTs5KmFIscXz7IKqGkwRQ==
X-Google-Smtp-Source: AAOMgpc7hpY/NdYzuEXZ5mF7rrRXmTmkAMvSAR+aqtQUk+V4KaYDbFv1QBOymXVgj5SAyiu9teODhw==
X-Received: by 2002:a6b:6607:: with SMTP id a7-v6mr630579ioc.145.1533059207018;
        Tue, 31 Jul 2018 10:46:47 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c141-v6sm2101673itc.42.2018.07.31.10.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:46:45 -0700 (PDT)
Date:   Tue, 31 Jul 2018 11:46:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v3 05/13] coresight: perf: Allow tracing on hotplugged
 CPUs
Message-ID: <20180731174643.GB11692@xps15>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532609691-16863-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 01:54:43PM +0100, Suzuki K Poulose wrote:
> At the moment, if there is no CPU specified for a given
> event, we use cpu_online_mask and try to build path for
> each of the CPUs in the mask. This could prevent any CPU
> that is turned online later to be used for the tracing.
> 
> This patch changes to use the cpu_present_mask and tries
> to build path for as much CPUs as possible ignoring the
> failures in building path for some of the CPUs. If ever
> we try to trace on those CPUs, we fail the operation.
> 
> Based on a patch from Mathieu Poirier.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 46 +++++++++++++++---------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 6beb662..afe7e7f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -127,11 +127,9 @@ static void free_event_data(struct work_struct *work)
>  
>  	event_data = container_of(work, struct etm_event_data, work);
>  	mask = &event_data->mask;
> -	/*
> -	 * First deal with the sink configuration.  See comment in
> -	 * etm_setup_aux() about why we take the first available path.
> -	 */
> -	if (event_data->snk_config) {
> +
> +	/* Free the sink buffers, if there are any */
> +	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {

I'm not sure the WARN_ON() is required.

Here @mask can't be empty since you've added a check in setup_aux().  So if
@mask does end up being empty something has trampled the memory and we have
far bigger problems.  


>  		cpu = cpumask_first(mask);
>  		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
>  		if (sink_ops(sink)->free_buffer)
> @@ -166,7 +164,7 @@ static void *alloc_event_data(int cpu)
>  	if (cpu != -1)
>  		cpumask_set_cpu(cpu, mask);
>  	else
> -		cpumask_copy(mask, cpu_online_mask);
> +		cpumask_copy(mask, cpu_present_mask);
>  
>  	/*
>  	 * Each CPU has a single path between source and destination.  As such
> @@ -218,19 +216,32 @@ static void *etm_setup_aux(int event_cpu, void **pages,
>  	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
>  	 */
>  	sink = coresight_get_enabled_sink(true);
> -	if (!sink)
> +	if (!sink || !sink_ops(sink)->alloc_buffer)
>  		goto err;
>  
>  	mask = &event_data->mask;
>  
> -	/* Setup the path for each CPU in a trace session */
> +	/*
> +	 * Setup the path for each CPU in a trace session. We try to build
> +	 * trace path for each CPU in the mask. If we don't find an ETM
> +	 * for the CPU or fail to build a path, we clear the CPU from the
> +	 * mask and continue with the rest. If ever we try to trace on those
> +	 * CPUs, we can handle it and fail the session.
> +	 */
>  	for_each_cpu(cpu, mask) {
>  		struct list_head *path;
>  		struct coresight_device *csdev;
>  
>  		csdev = per_cpu(csdev_src, cpu);
> -		if (!csdev)
> -			goto err;
> +		/*
> +		 * If there is no ETM associated with this CPU clear it from
> +		 * the mask and continue with the rest. If ever we try to trace
> +		 * on this CPU, we handle it accordingly.
> +		 */
> +		if (!csdev) {
> +			cpumask_clear_cpu(cpu, mask);
> +			continue;
> +		}
>  
>  		/*
>  		 * Building a path doesn't enable it, it simply builds a
> @@ -238,17 +249,20 @@ static void *etm_setup_aux(int event_cpu, void **pages,
>  		 * referenced later when the path is actually needed.
>  		 */
>  		path = coresight_build_path(csdev, sink);
> -		if (IS_ERR(path))
> -			goto err;
> +		if (IS_ERR(path)) {
> +			cpumask_clear_cpu(cpu, mask);
> +			continue;
> +		}
>  
>  		*etm_event_cpu_path_ptr(event_data, cpu) = path;
>  	}
>  
> -	if (!sink_ops(sink)->alloc_buffer)
> -		goto err;
> -
> +	/* If we don't have any CPUs ready for tracing, abort */
>  	cpu = cpumask_first(mask);
> -	/* Get the AUX specific data from the sink buffer */
> +	if (cpu >= nr_cpu_ids)
> +		goto err;
> +
> +	/* Allocate the sink buffer for this session */
>  	event_data->snk_config =
>  			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
>  						     nr_pages, overwrite);
> -- 
> 2.7.4
> 
