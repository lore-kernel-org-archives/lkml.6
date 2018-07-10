Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F820870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51F820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeGJSqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:46:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:49770 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGJSqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:46:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 11:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="73722475"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2018 11:46:04 -0700
Date:   Tue, 10 Jul 2018 11:45:07 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split
 locked access feature
Message-ID: <20180710184506.GA37857@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-2-git-send-email-fenghua.yu@intel.com>
 <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com>
 <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
 <20180704200742.GD7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704200742.GD7451@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 05:07:42PM -0300, Eduardo Habkost wrote:
> On Fri, Jun 29, 2018 at 06:23:35PM +0200, Thomas Gleixner wrote:
> > On Fri, 29 Jun 2018, Dave Hansen wrote:
> > > On 06/29/2018 07:33 AM, Fenghua Yu wrote:
> > > > +/* Detect feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
> > > > +void detect_ac_split_lock(void)
> > > > +{
> > > > +	u64 val, orig_val;
> > > > +	int ret;
> > > > +
> > > > +	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
> > > > +	ret = rdmsrl_safe(MSR_TEST_CTL, &val);
> > > > +	if (ret)
> > > > +		return;
> > > 
> > > This is a bit fast and loose with how the feature is detected, which
> > > might be OK, but can we call out why we are doing this, please?
> > > 
> > > Is this MSR not really model-specific?  Is it OK to go poking at it on
> > > all x86 variants?  Or, do we at _least_ need a check for Intel cpus in here?
> > 
> > That definitely needs a vendor check. Also the whole code needs to be
> > compiled out if CONFIG_INTEL=n.
> > 
> > Aside of that this wants to be enumerated. CPUID or MISC_FEATURES and not
> > this guess work detection logic. Why do I have to ask for that for every
> > other new feature thingy?
> 
> Yes, please.  KVM hosts normally expect guests to not touch MSRs
> unless we explicitly tell them the MSR is available (normally
> through CPUID).  This is important to ensure live migration
> between different host kernel versions works reliably.

The problem is the hardware design for the feature is complete. The
hardware designer cannot change the feature enumeration to CPUID or
MISC_FEATURES. In the future, the designer will put future model-
specific feature bits in a processor feature MSR and hopefully we will
have a nice standard enumeration way for all future model specific
features. But split lock is too late (or too early) to be in the feature
MSR.

Considering the current situation, can we do split lock as following?

By default, #AC for split lock is not enabled by kernel. It's disabled
by BIOS by default (bit29=0). Kernel doesn't clear bit 29.

For IOT/real time users, they know the feature is in the processor and
they know the consequence of enabling the feature (e.g. some apps will
be killed because of split lock issues). They want to enable #AC for
split lock by kernel parameter "split_lock_detect=on". Kernel calls
wrmsr_safe(), which can fail on processor not supporting
the feature, to enable the feature.

There is no enumeration and no flag in /proc/cpuinfo flag for the feature.

Is this a right way to go? Please advise.

Thanks.

-Fenghua
