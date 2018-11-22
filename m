Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0EBNcgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B0320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeKVPGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:06:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40861 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeKVPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:06:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so8531649pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 20:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4nw5M9Oe/7Bapgmwf+i+8kAMrpYfx4OlpPCt53oyBIc=;
        b=J0EBNcgKK3n4y2gXW9kfwfp1jGlaBSWbCGRGhXc7eHQw4ikx1Rg6p57b7J8LuO1LF8
         5UMSzUhzH8MkTYcKfWZH6Cm90tbWNI7VtWie5IdxPkV1al4RoO3yKJzdCWsCQGl2CyHC
         FxfdyEoNHuYKuwT7L6vmgAVc6IRRLpNYwI8s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4nw5M9Oe/7Bapgmwf+i+8kAMrpYfx4OlpPCt53oyBIc=;
        b=j23d17p9TiVLCZ6Yz4S0JxNAmj8VaGDCAXpCnL3UkXmGrykPDJulBpDDBWwnIWRHvz
         I47F/iioG7fJk2+T9N8DgpapZ7uRTmh5/Av+oI1cXwKbh5YExRww0ib5wy5etWN7dKJE
         w9sRBoDe8Tjq8wHrjsJeCFrnGFhDyjiP7RKREqSEXxRchGoooNNOfe7V9wU9X0b6XTwq
         htiwEvcyJBLIXgFq/3WXpEfV+U43D7VfXk1CFOQrqHCq3sHIVmrh51EMPIDQnvY81Zzq
         oRA/BY4Q/sMuzP+HTgatsCPOBfS1Gk9U4hokVFa2dqn+TCRxZxMFWAvFPi2Su/GlhdRn
         fhcg==
X-Gm-Message-State: AA+aEWaDVj8BuYvkL1+V0qYppq5+dvOL29nf0M4EjbE6cpe25a45JQ2s
        d0Rxmf7WU7Wss3H1XpZ+zDVlFYPwyUg=
X-Google-Smtp-Source: AFSGD/VLB5nulyCfOjXAJy78cAN73vt/5467x9rF2/gi7b6rZ/oYpNhLp82RlvUh8mWPmNUMtuoMDQ==
X-Received: by 2002:a17:902:28c1:: with SMTP id f59mr9697356plb.37.1542860946062;
        Wed, 21 Nov 2018 20:29:06 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id n2sm4624155pgp.75.2018.11.21.20.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 20:29:05 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:59:00 +0530
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
Message-ID: <20181122042900.u6eefkbw32vvi6xm@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030085845.az2dstibnrcl7im4@vireshk-i7>
 <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 23:12, Daniel Lezcano wrote:
> On 30/10/2018 09:58, Viresh Kumar wrote:
> > s/dmpis/dmips/ in $subject
> > 
> > On 29-10-18, 17:23, Daniel Lezcano wrote:
> >> In the case of assymetric SoC with the same micro-architecture, we
> > 
> >                  asymmetric ?
> > 
> >> have a group of CPUs with smaller OPPs than the other group. One
> >> example is the 96boards dragonboard 820c. There is no dmips/MHz
> >> difference between both groups, so no need to specify the values in
> >> the DT. Unfortunately, without these defined, there is no scaling
> >> capacity comutation triggered, so we need to write
> > 
> >            computation
> > 
> >> 'capacity-dmips-mhz' for each CPU with the same value in order to
> >> force the scaled capacity computation.
> >>
> >> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
> >> 'capacity-dmips-mhz' is defined in the DT.
> >>
> >> This was tested on db820c:
> >>  - specified values in the DT (correct results)
> >>  - partial values defined in the DT (error + fallback to defaults)
> >>  - no specified values in the DT (correct results)
> >>
> >> correct results are:
> >>   cat /sys/devices/system/cpu/cpu*/cpu_capacity
> >>    758
> >>    758
> >>   1024
> >>   1024
> >>
> >>   ... respectively for CPU0, CPU1, CPU2 and CPU3.
> >>
> >> That reflects the capacity for the max frequencies 1593600 and 2150400.
> >>
> >> Cc: Chris Redpath <chris.redpath@linaro.org>
> >> Cc: Quentin Perret <quentin.perret@linaro.org>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> >> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> >> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/base/arch_topology.c | 27 ++++++++++++++++++++++++++-
> >>  1 file changed, 26 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> >> index 7311641..7d594a6 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -205,6 +205,21 @@ static struct notifier_block init_cpu_capacity_notifier = {
> >>  	.notifier_call = init_cpu_capacity_callback,
> >>  };
> >>  
> >> +static int topology_set_default_capacity(void)
> >> +{
> >> +	int cpu;
> >> +
> >> +	raw_capacity = kzalloc(num_possible_cpus() * sizeof(*raw_capacity),
> >> +			       GFP_KERNEL);
> >> +	if (!raw_capacity)
> >> +		return -ENOMEM;
> >> +
> >> +	for_each_possible_cpu(cpu)
> >> +		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;
> > 
> > This isn't actually required as the value of raw_capacity isn't used
> > anymore after this point in code. Rather it is forcefully updated in
> > init_cpu_capacity_callback():
> > 
> > raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
> >                     policy->cpuinfo.max_freq / 1000UL;
> > 
> > Maybe it is better to allocate raw_capacity once at boot and use
> > another global variable as flag (raw_capacity is used as a flag right
> > now at many places).
> 
> Can we keep the proposed change as is to simply fix the default value?
> 
> I want to do a separate change with a raw_capacity rewrite and remove
> the workqueue freeing it.

Sure. But you still don't need to update raw_capacity[cpu] above as I pointed
out earlier. You can drop those lines at least.

-- 
viresh
