Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D312080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQozo8Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D312080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJ3RvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:51:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3RvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:51:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so5482081pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZM/SFg4Knl1OGfZXZQiGDeitPhUmraDyd+79sffCSI=;
        b=eQozo8CczMsRameLaDPrGC3Z2UhTnJFHN5msyrf5QFTm8ADCNCWUa8hdWiKJqUTJ/o
         5rZDqTtDC1y9TbZ0hm7+iJD07m3PjFKhHUwZ0vk4ByWmc9IdbJHmctfNthLVNBJH4625
         M/ARmhBA0A6OrOT0XZA24L1/DsqMCa/A7QkpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZM/SFg4Knl1OGfZXZQiGDeitPhUmraDyd+79sffCSI=;
        b=YXSM415Un6I0DpZGxfJjBRgUyh0WdGyyA+trhb5Uiyeb9At0ZVKgo1jtVUAAUEphi5
         Ut4AfmDGMCk3KlRqcY1OmU9vQ5+BtxgRAeeumX9S8nnaYg1ay47vRj39FazDFlGHJbwu
         En90mzd0iloku9EwdyAl1P27QFOiqRQbNmbXd9LYiFcxqCPlsWZ3cKknhbyM+9CzttrH
         QewnYneb/8i3lH3lg75YLhPevxfu8rWyo7mpeESGCMrl1qr+oRXlBK21/OYBilque/0S
         BX2kpMzPjFCIx0p+GUVzRwLpnJGdS2CMfc7Yzi0NDEGhMHJ/7BkfWEWQweQnfhpU7O6s
         ffjA==
X-Gm-Message-State: AGRZ1gIMacZ9/VIu7Q/ZWye3vLCrSibGFsF5Fkri+g/actHDBjHOI4Gj
        eUTigliLaj0DDsMa13X1mMp1wg==
X-Google-Smtp-Source: AJdET5fEk3W+tJ8eGEkauKdi5vYdOSJ7kTxajFcBhl7f2F2VKXqq0pqAkZ70eWSB5DSyMzZdxkCAfg==
X-Received: by 2002:a62:4bd2:: with SMTP id d79-v6mr2063417pfj.38.1540889928468;
        Tue, 30 Oct 2018 01:58:48 -0700 (PDT)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id t3-v6sm12495156pfk.59.2018.10.30.01.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:58:47 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:28:45 +0530
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
Message-ID: <20181030085845.az2dstibnrcl7im4@vireshk-i7>
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

s/dmpis/dmips/ in $subject

On 29-10-18, 17:23, Daniel Lezcano wrote:
> In the case of assymetric SoC with the same micro-architecture, we

                 asymmetric ?

> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity comutation triggered, so we need to write

           computation

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
> +	if (!raw_capacity)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu)
> +		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;

This isn't actually required as the value of raw_capacity isn't used
anymore after this point in code. Rather it is forcefully updated in
init_cpu_capacity_callback():

raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
                    policy->cpuinfo.max_freq / 1000UL;

Maybe it is better to allocate raw_capacity once at boot and use
another global variable as flag (raw_capacity is used as a flag right
now at many places).

-- 
viresh
