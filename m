Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fezhFOzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437163AbfBNHG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:06:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40083 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389635AbfBNHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:06:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so2647859plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B0JpBEP/kqdEJ6A0qCpZeMb+CbuKfKtosIH8fe0qiac=;
        b=fezhFOzkHiwPJE231UQzta+6JF/xyB7x5/krCqqQwrDGhIexBTBW3/yaXR39/GrRup
         B0M2wM7px+PlQrmx0FgiL4oZD8L7TU7RwUSv9OnfkPBwmApCoyv6PyvT27S94H9oFiqA
         7G9DxmT+4ur6yLVZ9YV7qDz/t5iWL2W1JypJuub9pyWvZhhgt9LFVj6Ab+QctM2nExGh
         3Km2JoWu38oVhmMNEnEEoZPj+IKPA4bZLM330C1vIZlkPkUMRXwyYaVDUugf1kSeKVOk
         Z+lEYkkC9ee/yrKXS5pHDiXbKsVVQ2gLlJLgS29i/2mb8Wfhedvta2mSSvBANG405gPV
         7Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B0JpBEP/kqdEJ6A0qCpZeMb+CbuKfKtosIH8fe0qiac=;
        b=Mi3/H8Oqk1br4JCBjrgmCICjZL1rRPZzGu9yHq0gNFaPoERBUoxDCkAw/sM4hi7Faz
         YFFPRGUq+YBwoM+zWg0shyppJwwOkV1DqHionEgoHc0XPBx5w2PlVqqd96Pcvm2MegkG
         oooAhKlRpTVRXHJjiEzgDsdzNqghZ+qMbjO4LuxMge9sP21gJXGPiH30ABgpNOBURm4q
         duVP4NZ9tcPslk/z30cvOsC446ZccBtWeH5DLmvaI+KHDxHrGngmR0c5EyhzKZZlXVnj
         eVbdU8HyNDWvraOwvvMJQ7jiRDDW2F7s82bgxAATmACKKnWwC+fV5GiCuiTavxIsOwtg
         SphA==
X-Gm-Message-State: AHQUAuZfugfx3Tuf+VNFNH+xJ7i5W75sguP4rgE1UFXVSa0JRIUUWRii
        tvLZQYfpEEfKhhdCMk0nVaf3aw==
X-Google-Smtp-Source: AHgI3IbfhKUq448Rt0yIi5dNUJKI8Xg00ExD07UrKZVotpevqKaYxER82u984TueB3MapbK2lk+8UQ==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr2541850plb.239.1550128014900;
        Wed, 13 Feb 2019 23:06:54 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h128sm1591040pgc.15.2019.02.13.23.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 23:06:53 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:36:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast  _PPC to all online CPUs
Message-ID: <20190214070648.pvsavc46iivub4hy@vireshk-i7>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <20190211103307.rccddkso3f5s3yko@vireshk-i7>
 <20190213165538.GB30385@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213165538.GB30385@chenyu-office.sh.intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 00:55, Yu Chen wrote:
> Hi Viresh,
> On Mon, Feb 11, 2019 at 04:03:07PM +0530, Viresh Kumar wrote:
> > On 09-02-19, 20:02, Chen Yu wrote:
> > > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > > the power source changes), the maximum frequency of the
> > > CPU is not updated accordingly. This is due to the policy's
> > > cpuinfo.max is not updated when _PPC notifier fires.
> > > 
> > > Fix this problem by updating the policy's cpuinfo.max
> > > and broadcast the _PPC notifier to all online CPUs.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> > >  drivers/cpufreq/cpufreq.c        |  2 ++
> > >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> > >  3 files changed, 30 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > > index a303fd0e108c..737dbf5aa7f7 100644
> > > --- a/drivers/acpi/processor_perflib.c
> > > +++ b/drivers/acpi/processor_perflib.c
> > > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> > >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > >  		 "limited by BIOS, this should help");
> > >  
> > > +static int broadcast_ppc;
> > > +module_param(broadcast_ppc, int, 0644);
> > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > +
> > >  #define PPC_REGISTERED   1
> > >  #define PPC_IN_USE       2
> > >  
> > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > >  		else
> > >  			acpi_processor_ppc_ost(pr->handle, 0);
> > >  	}
> > > -	if (ret >= 0)
> > > -		cpufreq_update_policy(pr->id);
> > > +	if (ret >= 0) {
> > > +		if (broadcast_ppc) {
> > > +			int cpu;
> > > +
> > > +			for_each_possible_cpu(cpu)
> > > +				cpufreq_update_policy(cpu);
> > > +		} else {
> > > +			cpufreq_update_policy(pr->id);
> > > +		}
> > > +	}
> > >  }
> > >  
> > >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bc..95e08816b512 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >  
> > >  	policy->min = new_policy->min;
> > >  	policy->max = new_policy->max;
> > > +	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > > +	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> > >  	trace_cpu_frequency_limits(policy);
> > >  
> > >  	policy->cached_target_freq = UINT_MAX;
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index dd66decf2087..e1881313c396 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> > >  
> > >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> > >  {
> > > +	int max_freq;
> > >  	struct cpudata *cpu = all_cpu_data[policy->cpu];
> > >  
> > >  	update_turbo_state();
> > > +	max_freq = intel_pstate_get_max_freq(cpu);
> > > +
> > > +	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > 
> > Why do have this check for policy->max here ?
> >
> Thanks for looking at this change, I've replied to another email in detail of
> the scenario that, this is due to corner case that if the system boots
> with battery and plug the AC after boot up, the cpufreq max limit will not
> increase even the turbo has been enabled after the AC plugged.

Yeah, but I asked a different question I believe, why is this
comparison necessary ?

policy->max == policy->cpuinfo.max_freq

-- 
viresh
