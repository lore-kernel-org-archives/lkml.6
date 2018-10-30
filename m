Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E6FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442C2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSSseLV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1442C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ3QFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:05:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44518 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeJ3QFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:05:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j13-v6so1836145pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5jE7L9oM9steqU8SHsyrPdxft+DWtYgl9nPIJgJ7fM=;
        b=cSSseLV4Sq6B6hzr7fDfhFpB9VnNnyvJrAt/e0PDCqPvQByYGH/MToF1Oee89sXz6H
         xBNDa57KzfSkahL3yseruy5jRU/Q4v+u3/ZBhkW5PGFm853K57HQp6fTWHyRjIXAVlrj
         f1C1idnL9J03FECo8Z2mQJPvijK7EL6FwADj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5jE7L9oM9steqU8SHsyrPdxft+DWtYgl9nPIJgJ7fM=;
        b=jZfkzrg/cwcj0Q24KSLD609cd8cZwG5qA07CuLMQ0DTJu4wdZp7wXIwoNbK91OvCTr
         VJRdcpIcoMLV+tnhF1RIk3c/JihsQqnjSjtcQXdJvYvsZ6DXrN/LMmn5cMAUbjZqlCo6
         cER7+BqVwe9bWi7PVr19C0kXLpBwKS4YUPRyOIedgfJ59/KLWiOvHuGfzHtzYreFi8C8
         3Ms3p0OT7cUkPneJydsIIC9W7U/YYy+pAOqZbonwax7zAfyZi8oNL9c0gCfQhrJoLs9r
         BGiu0XIqOxr0LCgCxsAT9h+HqbdGVzJWZB3kJQ21lUlvlE4WY4K4uU4V3Y9q8iKpMyV+
         GUHw==
X-Gm-Message-State: AGRZ1gJOgym7L61Ra0TakaFHuLwVmajJSCA+cqCx6BbCucJ6bmJcD9rf
        8gMgpjcm3od8lkHi3qsLbhwOOw==
X-Google-Smtp-Source: AJdET5eCFxiieOLoCfPyoJ2+wE/Xt3cs36vlSDieVyBKj8Xn7OFqJ4Qtk45YVO7mWWFszBEuKCH2Tg==
X-Received: by 2002:a65:4783:: with SMTP id e3-v6mr16592572pgs.12.1540883597320;
        Tue, 30 Oct 2018 00:13:17 -0700 (PDT)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id d2-v6sm40314070pfj.122.2018.10.30.00.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 00:13:15 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:43:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
Message-ID: <20181030071313.rq2d4cmfrla5boc7@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-18, 17:23, Daniel Lezcano wrote:
> In the case of assymetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity comutation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
> 'capacity-dmips-mhz' is defined in the DT.
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
>  drivers/base/arch_topology.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 7311641..7d594a6 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -205,6 +205,21 @@ static struct notifier_block init_cpu_capacity_notifier = {
>  	.notifier_call = init_cpu_capacity_callback,
>  };
>  
> +static int topology_set_default_capacity(void)
> +{
> +	int cpu;
> +
> +	raw_capacity = kzalloc(num_possible_cpus() * sizeof(*raw_capacity),
> +			       GFP_KERNEL);

kmalloc ?

> +	if (!raw_capacity)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu)
> +		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;

It makes it look as if it is important to set default values to
SCHED_CAPACITY_SCALE while that is not the case. Maybe add a comment
that all CPUs are assumed to have same capacity now. Maybe initialize
to 1 instead ? Not sure if that would be better or not.

> +
> +	return 0;
> +}
> +
>  static int __init register_cpufreq_notifier(void)
>  {
>  	int ret;
> @@ -214,9 +229,19 @@ static int __init register_cpufreq_notifier(void)
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

So we will end up doing this also for the case where the DT is
partially filled with the capacity info and we already printed error
messages for it. Should we really do that ?

-- 
viresh
