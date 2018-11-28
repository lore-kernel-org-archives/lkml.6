Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C1EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BB620660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BB620660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeK1WqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:46:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43357 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1WqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:46:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so25955427wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 03:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XWu89Nc/2SYfZz4S2hx6CGLSjgSESja3A0Hasff6c3U=;
        b=hckayJi6fFVju62DOOySLdKsd3b6+S7cwHIsdFwccBJ8Cn1DKUJvZuJrc5BXhtn/JF
         uYPZlARIiXCm9vO6GDM83v1HQSyZBUmoTUDh7ynjp//th5C/d+kziOqIsJHxTuuaaJeD
         /TB2iqP0xw2RQ8i3U1kp1kORB8tlLnfMKq1ZgCy75fMfJTASfQssCAyv4K0z2ci5lXzb
         A5AiyB6Fh7lqYVub4HfPRUq7CBIm8oATciKNVeywVPpmqcyc+cCfK3JIzlxM9OB5FPc8
         5NlESj3YsszRN/iumc/Qi/z64ZvfbRgX9ZJVF7X1738nR0kYppEv+5vKjLA0I2JLnzPB
         32sA==
X-Gm-Message-State: AA+aEWYo01o9pLOIhv0z0qp26GtgRHQ59DkpXxd6a8dh5BBPrig429nW
        4a5mlMF/bsFRZ6/EGtBXURbUbQ==
X-Google-Smtp-Source: AFSGD/XlCDbncKbaqiBX2HVWjgfwoRw9GbMMOFAQsQ1FcK9Fa2ayaBSs8mZ/BC9Mta/SQGwtflq1OQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr32991155wro.231.1543405498105;
        Wed, 28 Nov 2018 03:44:58 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id h131sm4559270wmd.17.2018.11.28.03.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 03:44:57 -0800 (PST)
Date:   Wed, 28 Nov 2018 12:44:54 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
Message-ID: <20181128114454.GC4271@localhost.localdomain>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 27/11/18 14:24, Daniel Lezcano wrote:
> The mutex protects a per_cpu variable access. The potential race can
> happen only when the cpufreq governor module is loaded and at the same
> time the cpu capacity is changed in the sysfs.
> 
> There is no real interest of using a mutex to protect a variable
> assignation when there is no situation where a task can take the lock
> and block.
> 
> Replace the mutex by READ_ONCE / WRITE_ONCE.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/arch_topology.c  | 7 +------
>  include/linux/arch_topology.h | 2 +-
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index edfcf8d..fd5325b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -31,12 +31,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  		per_cpu(freq_scale, i) = scale;
>  }
>  
> -static DEFINE_MUTEX(cpu_scale_mutex);
>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
> -	per_cpu(cpu_scale, cpu) = capacity;
> +	WRITE_ONCE(per_cpu(cpu_scale, cpu), capacity);
>  }
>  
>  static ssize_t cpu_capacity_show(struct device *dev,
> @@ -71,10 +70,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
>  	if (new_capacity > SCHED_CAPACITY_SCALE)
>  		return -EINVAL;
>  
> -	mutex_lock(&cpu_scale_mutex);
>  	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
>  		topology_set_cpu_scale(i, new_capacity);
> -	mutex_unlock(&cpu_scale_mutex);

IIRC this was meant to ensure atomic updates of all siblings with the new
capacity value. I actually now wonder if readers should not grab the
mutex as well (cpu_capacity_show()). Can't we get into a situation where
a reader might see siblings with intermediate values (while the loop
above is performing an update)?

BTW, please update my email address. :-)

Best,

- Juri
