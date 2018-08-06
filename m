Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D91D21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D91D21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbeHFXp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:45:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:58351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHFXp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:45:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 14:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="73227899"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2018 14:33:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E7A93300FB0; Mon,  6 Aug 2018 14:33:23 -0700 (PDT)
Date:   Mon, 6 Aug 2018 14:33:23 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI handler
Message-ID: <20180806213323.GK4238@tassilo.jf.intel.com>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
 <20180806183515.GR2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806183515.GR2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 08:35:15PM +0200, Peter Zijlstra wrote:
> > +static bool disable_counter_freezing;
> > +module_param(disable_counter_freezing, bool, 0444);
> > +MODULE_PARM_DESC(disable_counter_freezing, "Disable counter freezing feature."
> > +		"The PMI handler will fall back to generic handler."
> > +		"Default is false (enable counter freezing feature).");
> 
> Why?

See the description. Counter freezing took some time to stabilize,
so it seemed better to have a knob to ask users to try in case
there are more problems.
> 
> > +	/*
> > +	 * Ack the PMU late after the APIC.  This avoids bogus
> 
> > +	 * freezing on Skylake CPUs.  The acking unfreezes the PMU
> > +	 */
> That doesn't make sense. PMU and APIC do not have order.> 

It makes a difference for the hardware.

> > +	/*
> > +	 * For arch perfmon 4 use counter freezing to avoid
> > +	 * several MSR accesses in the PMI.
> > +	 */
> > +	if (x86_pmu.counter_freezing) {
> > +		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
> > +		pr_cont("counter freezing, ");
> > +	}
> 
> Lets not print the counter freezing, we already print v4, right?

I find it useful to see that the kernel has the support, otherwise
you would need to look at the version number, but it gets difficult
with backports. This is another paranoia bit, in case there
are problems.

> > @@ -561,6 +566,7 @@ struct x86_pmu {
> >  	struct x86_pmu_quirk *quirks;
> >  	int		perfctr_second_write;
> >  	bool		late_ack;
> > +	bool		counter_freezing;
> 
> Please make the both of them int or something.

That would make them bigger for no reason?

-Andi

