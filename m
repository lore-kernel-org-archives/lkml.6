Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274C420C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeGQKxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:53:52 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:51418 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGQKxw (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 06:53:52 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 12:21:56 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 11:21:38 +0100
Date:   Tue, 17 Jul 2018 12:21:36 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717102136.snayvzmv2h3dcwiq@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix>
 <3724084.DyflrVPzDS@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3724084.DyflrVPzDS@aspire.rjw.lan>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:09:21PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 17, 2018 11:36:20 AM CEST Andreas Herrmann wrote:
> > On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
> > > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> > > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > > >>
> > > > >> [cut]
> > > > >>
> > > > >> >
> > > > >> > On balance before this commit users could use pcc-cpufreq but had
> > > > >> > already suboptimal performance (compared to say intel_pstate driver
> > > > >> > which can be used changing BIOS options).
> > > > >>
> > > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
> > > > >
> > > > > I think this is because of (in intel_pstate_init()):
> > > > >
> > > > >         /*
> > > > >          * The Intel pstate driver will be ignored if the platform
> > > > >          * firmware has its own power management modes.
> > > > >          */
> > > > >         if (intel_pstate_platform_pwr_mgmt_exists())
> > > > >                 return -ENODEV;
> > > > >
> > > > 
> > > > OK, because of the "Proliant" entry, right?
> > > > 
> > > > So it looks like we have an issue there.  We find the entry and we
> > > > look for _PSS.  It is not there, so we assume that the firmware is
> > > > expected to control performance, which is not the case.
> > 
> > FYI, there is another BIOS setting on those systems. It's called
> > "Collaborative Power Control" (AFAIK enabled by default).
> > 
> > Only if this is disabled, firmware is (alone) in control of
> > performance. (And of course in this case neither pcc-cpufreq nor
> > intel_pstate will be loaded).
> 
> OK, the patch is below.
> 
> First, I hope that if "Collaborative Power Control" is disabled, it will
> simply hide the PCCH object and so intel_pstate will still not load then.

PCCH is hidden in that case.

> The main question basically is what the OS is expected to do if
> "Dynamic Power Savings Mode" is set.  If we are *expected* to use
> the PCC interface then, intel_pstate may not work in that case, but
> I suspect that the PCC interface allows extra energy to be saved
> over what is possible without it.

I'll test it and see what happens.


Andreas

> ---
>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
>  	return true;
>  }
>  
> +static bool __init intel_pstate_no_acpi_pcch(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, "\\_SB", &handle);
> +	if (ACPI_FAILURE(status))
> +		return true;
> +
> +	return !acpi_has_method(handle, "PCCH");
> +}
> +
>  static bool __init intel_pstate_has_acpi_ppc(void)
>  {
>  	int i;
> @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
>  
>  	switch (plat_info[idx].data) {
>  	case PSS:
> -		return intel_pstate_no_acpi_pss();
> +		if (!intel_pstate_no_acpi_pss())
> +			return false;
> +
> +		return intel_pstate_no_acpi_pcch();
>  	case PPC:
>  		return intel_pstate_has_acpi_ppc() && !force_load;
>  	}
> 
> 
