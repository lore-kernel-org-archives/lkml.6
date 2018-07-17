Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A04ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9220C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C9220C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbeGQOgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:36:50 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45986 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOgu (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 10:36:50 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 16:03:59 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 15:03:38 +0100
Date:   Tue, 17 Jul 2018 16:03:36 +0200
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
Message-ID: <20180717140336.ayovaz4ksdlak6bb@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix>
 <3724084.DyflrVPzDS@aspire.rjw.lan>
 <20180717102136.snayvzmv2h3dcwiq@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717102136.snayvzmv2h3dcwiq@suselix>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:21:36PM +0200, Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 12:09:21PM +0200, Rafael J. Wysocki wrote:

  ---8<---

> > OK, the patch is below.
> > 
> > First, I hope that if "Collaborative Power Control" is disabled, it will
> > simply hide the PCCH object and so intel_pstate will still not load then.
> 
> PCCH is hidden in that case.
> 
> > The main question basically is what the OS is expected to do if
> > "Dynamic Power Savings Mode" is set.  If we are *expected* to use
> > the PCC interface then, intel_pstate may not work in that case, but
> > I suspect that the PCC interface allows extra energy to be saved
> > over what is possible without it.
> 
> I'll test it and see what happens.

I've tested it on top of v4.18-rc5-36-g30b06abfb92b. intel_pstate now
loads instead of pcc-cpufreq and system looks stable.

When disabling "Collaborative Power Control" no cpufreq driver is loaded
(as expected).

Performance (with kernbench) is as expected (always better than any
brew of pcc-cpufreq + misc modifications to this driver + partial
rollback of commit 554c8aa8ecad).

If you like you can add either Tested-by or
Reviewed-by: Andreas Herrmann <aherrmann@suse.com>

I think this patch should be tagged for 4.17-stable.


Thanks,

Andreas

> > ---
> >  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
> >  	return true;
> >  }
> >  
> > +static bool __init intel_pstate_no_acpi_pcch(void)
> > +{
> > +	acpi_status status;
> > +	acpi_handle handle;
> > +
> > +	status = acpi_get_handle(NULL, "\\_SB", &handle);
> > +	if (ACPI_FAILURE(status))
> > +		return true;
> > +
> > +	return !acpi_has_method(handle, "PCCH");
> > +}
> > +
> >  static bool __init intel_pstate_has_acpi_ppc(void)
> >  {
> >  	int i;
> > @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
> >  
> >  	switch (plat_info[idx].data) {
> >  	case PSS:
> > -		return intel_pstate_no_acpi_pss();
> > +		if (!intel_pstate_no_acpi_pss())
> > +			return false;
> > +
> > +		return intel_pstate_no_acpi_pcch();
> >  	case PPC:
> >  		return intel_pstate_has_acpi_ppc() && !force_load;
> >  	}
> > 
> > 
