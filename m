Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCDE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCDE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGRKcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:32:10 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33950 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeGRKcK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 18 Jul 2018 06:32:10 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 11:35:01 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 10:34:49 +0100
Date:   Wed, 18 Jul 2018 11:34:47 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Message-ID: <20180718093447.p6iog3bgpyxyj2w5@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan>
 <20180717201323.6rwb4yklq46cmtom@suselix>
 <20180718082352.GQ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718082352.GQ2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:23:52AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 10:13:23PM +0200, Andreas Herrmann wrote:
> > On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The firmware interface used by the pcc-cpufreq driver is
> > > fundamentally not scalable and using it for dynamic CPU performance
> > > scaling on systems with many CPUs leads to degraded performance.
> > > 
> > > For this reason, disable dynamic CPU performance scaling on systems
> > > with pcc-cpufreq where the number of CPUs present at the driver init
> > > time is greater than 4.  Also make the driver print corresponding
> > > complaints to the kernel log.
> > > 
> > > Reported-by: Andreas Herrmann <aherrmann@suse.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > > 
> > > -> v2: Rework the messages printed in the problematic case.
> > 
> > I've tested this patch. Effect is as expected: driver loads but use of
> > ondemand governor is not allowed. Sample output:
> > 
> > [   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
> > [   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
> > [   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings
> 
> BTW, Andreas, is that BIOS option available through the normal BIOS
> settings, or it is in the "secret" BIOS menu that HP has? If it is in
> the "secret" one (^A IIRC) then we might want to explicitly mention
> that.

The relevant options are not in a secret section (so far I was not
even aware of a secret section). But on those systems some stuff is
available via iLO interface (browser) and some only via "BIOS/Platform
Configuration (RBSU)". The iLO interface has a couple of options that
are only visible with an advanced ILO license.

The options affecting Linux cpufreq subsystem are

(a) available only via "BIOS/Platform Configuration (RBSU)"

  [Power Management]->
    [Advanced Power Options]->
      [Collaborative Power Control] == "enabled" | "disabled"

 If set to "disabled": No cpufreq driver will load and platform is
 solely responsible for CPU frequency adaptions (whatever that means).

(b) available via "BIOS/Platform Configuration (RBSU)" and iLO interface

  [Power Management]->
    [Power Regulator] == "Dynamic Power Savings Mode" | "OS Control Mode" |
                         "Static Low Power Mode" | "Static High Performance Mode"

 "Dynamic Power Savings Mode" allows pcc-cpufreq to load and "OS
 Control Mode" allows intel-pstate to be loaded. We now change it such
 that also with "Dynamic Power Savings Mode" intel-pstate is loaded
 (if available; if not, pcc-cpufreq will still be loaded but it now
 emits a warning and disallows use of ondemand governor if too many
 CPUs are in use).

 AFAIK the other (static) modes have no real meaning when
 "Collaborative Power Control" is enabled because as soon as a cpufreq
 driver is loaded frequency will be adapted by OS. I can't remember
 which one (pcc-cpufreq or intel-pstate) would be loaded, I've just
 tried it once or twice.

Note that the above is valid for a DL580 Gen8 with Intel CPUs. It
might be slightly different on Gen9/Gen10 and/or other models. Ie. for
models based on AMD CPUs we just have added a new warning in
pcc-cpufreq and disabled use of ondemand governor when the system has
more than 4 CPUs.


Andreas
