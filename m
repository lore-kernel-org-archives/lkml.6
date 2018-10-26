Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751362082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751362082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeJZSEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:04:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45644 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:04:10 -0400
Received: from 79.184.255.63.ipv4.supernova.orange.pl (79.184.255.63) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 85f490d602700fa3; Fri, 26 Oct 2018 11:27:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date:   Fri, 26 Oct 2018 11:24:25 +0200
Message-ID: <32781963.NEgFcAD2pt@aspire.rjw.lan>
In-Reply-To: <af0dac7535332ecedeab9f04654fbb1d5a21e1a2.camel@linux.intel.com>
References: <20181023185429.GA6756@light.dominikbrodowski.net> <20181023195403.GA3094@light.dominikbrodowski.net> <af0dac7535332ecedeab9f04654fbb1d5a21e1a2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 23, 2018 11:52:12 PM CEST Srinivas Pandruvada wrote:
> On Tue, 2018-10-23 at 21:54 +0200, Dominik Brodowski wrote:
> > While at it, add a few comments which config options #ifdef
> > and #else statements refer to.
> > 
> > Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> > attribute")
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 49c0abf2d48f..9578312e43f2 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int
> > cpu)
> >  	return cppc_perf.guaranteed_perf;
> >  }
> >  
> > -#else
> > +#else /* CONFIG_ACPI_CPPC_LIB */
> >  static void intel_pstate_set_itmt_prio(int cpu)
> >  {
> >  }
> > -
> > -static int intel_pstate_get_cppc_guranteed(int cpu)
> > -{
> > -	return -ENOTSUPP;
> > -}
> > -#endif
> > +#endif /* CONFIG_ACPI_CPPC_LIB */
> >  
> >  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy
> > *policy)
> >  {
> > @@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct
> > cpufreq_policy *policy)
> >  
> >  	acpi_processor_unregister_performance(policy->cpu);
> >  }
> > -#else
> > +#else /* CONFIG_ACPI */
> >  static inline void intel_pstate_init_acpi_perf_limits(struct
> > cpufreq_policy *policy)
> >  {
> >  }
> > @@ -490,7 +485,14 @@ static inline bool
> > intel_pstate_acpi_pm_profile_server(void)
> >  {
> >  	return false;
> >  }
> > -#endif
> > +#endif /* CONFIG_ACPI */
> > +
> > +#ifndef CONFIG_ACPI_CPPC_LIB
> > +static int intel_pstate_get_cppc_guranteed(int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +#endif /* CONFIG_ACPI_CPPC_LIB */
> >  
> >  static inline void update_turbo_state(void)
> >  {
> 
> 

Patch applied, thanks!

