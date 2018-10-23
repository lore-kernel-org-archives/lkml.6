Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4993C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B57420651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B57420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeJXD6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:58:54 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59884 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:58:54 -0400
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id B4D0120093E; Tue, 23 Oct 2018 19:34:05 +0000 (UTC)
Date:   Tue, 23 Oct 2018 21:34:05 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Message-ID: <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
 <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:17:28PM -0700, Srinivas Pandruvada wrote:
> On Tue, 2018-10-23 at 20:54 +0200, Dominik Brodowski wrote:
> > Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> > attribute")
> Thanks for the fix.
> 
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 49c0abf2d48f..50c5699970c5 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -390,11 +390,6 @@ static int intel_pstate_get_cppc_guranteed(int
> > cpu)
> >  static void intel_pstate_set_itmt_prio(int cpu)
> >  {
> >  }
> > -
> > -static int intel_pstate_get_cppc_guranteed(int cpu)
> > -{
> > -	return -ENOTSUPP;
> > -}
> What is ACPI is defined but SCHED_MC_PRIO is not defined?
> Based on
> "select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO"
> 
> So the above is still required. correct?

Seems so, yes. Though that leads to either complicated #ifdefs or code
duplications.

In any case, I'd suggest marking at least nested #else and #endif lines
with comments denoting which #ifdef they relate to, e.g.

	#else	/* CONFIG_ACPI */
	#endif	/* CONFIG_ACPI */

Thanks,
	Dominik
