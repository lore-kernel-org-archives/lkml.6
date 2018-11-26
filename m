Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB689C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9C2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8QlBzvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE9C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeKZUqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:46:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKZUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:46:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so18151224wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G7p27rePNqiCFY3KVFZ3ftmIVArR7WdXGvdqeI4YKNo=;
        b=A8QlBzvA0cr4sAgzWZHyk7EB67jC8YUKYnyCo3VUd56SqIts9v2iE9oFZNKlvdvtGC
         BJChgEYNKyzM6b4RxYGgqmeqjLEbExz8qa7QPe9sbSw4IEkbwCembnnmtyDSe292Y0C2
         lVU03jeyQWtS5Jlcx7bKAUJoBbe9AB8EtebF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G7p27rePNqiCFY3KVFZ3ftmIVArR7WdXGvdqeI4YKNo=;
        b=gJ30s6cmJY3adBQ7EWozqD1NA/ueMK1y+NLTP4thUiML0hJYCRW6cbITL9SEd3kYzi
         V0i8YlMwl50Hp1QryrJ/g0Wic7+0xt6JES4ML6X3YrNqW/W6lNgJK1miUcm6qnHt0dny
         YYLJufaj1OSSdaEZrHQFPi6k8y6DnhmTIdwvKw32OlT7+ZQhLgsDqUlUE4LVJrCWHjYw
         iUEq8chKHI7asVdEO5n15BvK8bufHzyEoM8ZhY/hkFU/ViEbCS/ISSBJ5vh3ZwHZ+M+t
         zhK/k5nVRdwr1rgK/MxLtZJBYzD8lsdIAjZ6lmvuycpNM5qaeeP3wyd4iryYzkDjevqk
         xY8Q==
X-Gm-Message-State: AA+aEWb0RQrQrh9muzL2yCAjjGTZvTrShMdVcajPEO/CLDjfVc69Xuhi
        odvhQCC6z9ehjDn4cKqa8xK4Qg==
X-Google-Smtp-Source: AFSGD/X1GWC7YKv+m6W3qkDBl6AMiRacv3GH1ecyHS2l61gvYubA2+rk0C4/Dc60lB0mt+1C5pAc3A==
X-Received: by 2002:adf:f848:: with SMTP id d8mr24500200wrq.178.1543225946827;
        Mon, 26 Nov 2018 01:52:26 -0800 (PST)
Received: from queper01-ThinkPad-T460s ([217.140.96.141])
        by smtp.gmail.com with ESMTPSA id x136sm407276wme.0.2018.11.26.01.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 01:52:26 -0800 (PST)
Date:   Mon, 26 Nov 2018 09:52:24 +0000
From:   Quentin Perret <quentin.perret@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Nov 2018 at 09:44:21 (+0100), Daniel Lezcano wrote:
> In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> In order to fix this situation, allocate 'raw_capacity' so the pointer
> is set and the init_cpu_capacity_callback() function can be called.
> 
> This was tested on db820c:
>  - specified values in the DT (correct results)
>  - partial values defined in the DT (error + fallback to defaults)
>  - no specified values in the DT (correct results)
> 
> correct results are:
>   cat /sys/devices/system/cpu/cpu*/cpu_capacity
>    758
>    758
>   1024
>   1024
> 
>   ... respectively for CPU0, CPU1, CPU2 and CPU3.
> 
> That reflects the capacity for the max frequencies 1593600 and 2150400.
> 
> Cc: Chris Redpath <chris.redpath@linaro.org>
> Cc: Quentin Perret <quentin.perret@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/arch_topology.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index fd5325b..e0c5b60 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
>  	 * until we have the necessary code to parse the cpu capacity, so
>  	 * skip registering cpufreq notifier.
>  	 */
> -	if (!acpi_disabled || !raw_capacity)
> +	if (!acpi_disabled)
>  		return -EINVAL;
>  
> +	if (!raw_capacity) {
> +
> +		pr_info("cpu_capacity: No capacity defined in DT, set default "
> +		       "values to %ld\n", SCHED_CAPACITY_SCALE);
> +
> +		raw_capacity = kmalloc_array(num_possible_cpus(),
> +					     sizeof(*raw_capacity), GFP_KERNEL);
> +		if (!raw_capacity)
> +			return -ENOMEM;
> +	}
> +
>  	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
>  		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
>  		return -ENOMEM;
> -- 
> 2.7.4

With this, if the DT is partially filled, we will still do the frequency
scaling thing now right ?

I'm not sure if this is the expected behaviour. If the DT is partially
filled, we probably want to have 1024 of capacity for all CPUs to match
the doc.

Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
top of topology_parse_cpu_capacity() ?

Thanks,
Quentin
