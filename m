Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B8EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE2120651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE2120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeJXEAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:00:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:63072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJXEAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:00:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 12:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="100061813"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2018 12:36:02 -0700
Message-ID: <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Oct 2018 12:36:01 -0700
In-Reply-To: <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
         <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
         <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 21:34 +0200, Dominik Brodowski wrote:
> On Tue, Oct 23, 2018 at 12:17:28PM -0700, Srinivas Pandruvada wrote:
> > On Tue, 2018-10-23 at 20:54 +0200, Dominik Brodowski wrote:
> > > Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> > > attribute")
> > 
> > Thanks for the fix.
> > 
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 49c0abf2d48f..50c5699970c5 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -390,11 +390,6 @@ static int
> > > intel_pstate_get_cppc_guranteed(int
> > > cpu)
> > >  static void intel_pstate_set_itmt_prio(int cpu)
> > >  {
> > >  }
> > > -
> > > -static int intel_pstate_get_cppc_guranteed(int cpu)
> > > -{
> > > -	return -ENOTSUPP;
> > > -}
> > 
> > What is ACPI is defined but SCHED_MC_PRIO is not defined?
> > Based on
> > "select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO"
> > 
> > So the above is still required. correct?
> 
> Seems so, yes. Though that leads to either complicated #ifdefs or
> code
> duplications.
> 
> In any case, I'd suggest marking at least nested #else and #endif
> lines
> with comments denoting which #ifdef they relate to, e.g.
> 
> 	#else	/* CONFIG_ACPI */
> 	#endif	/* CONFIG_ACPI */
Will you submit a change?

Thanks,
Srinivas

> 
> Thanks,
> 	Dominik

