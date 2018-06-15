Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EBB29C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A0C20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A0C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965425AbeFOCGz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:06:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:44523 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965159AbeFOCGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:06:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237603997"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2018 19:06:51 -0700
Date:   Thu, 14 Jun 2018 19:03:14 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
Message-ID: <20180615020314.GA11625@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> >  		kick_timer(hdata);
> >  
> > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> 
> Eeew.

If you don't mind me asking. What is the problem with this error message?
> 
> >  /**
> > + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> > + * @val:	Attribute associated with the NMI. Not used.
> > + * @regs:	Register values as seen when the NMI was asserted
> > + *
> > + * When an NMI is issued, look for hardlockups. If the timer is not periodic,
> > + * kick it. The interrupt is always handled when if delivered via the
> > + * Front-Side Bus.
> > + *
> > + * Returns:
> > + *
> > + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> > + * otherwise.
> > + */
> > +static int hardlockup_detector_nmi_handler(unsigned int val,
> > +					   struct pt_regs *regs)
> > +{
> > +	struct hpet_hld_data *hdata = hld_data;
> > +	unsigned int use_fsb;
> > +
> > +	/*
> > +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> > +	 * edge-triggered and there is no need to check the ISR register.
> > +	 */
> > +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
> > +
> > +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
> > +		return NMI_DONE;
> 
> So for 'use_fsb == True' every single NMI will fall through into the
> watchdog code below.
> 
> > +	inspect_for_hardlockups(regs);
> > +
> > +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > +		kick_timer(hdata);
> 
> And in case that the HPET does not support periodic mode this reprogramms
> the timer on every NMI which means that while perf is running the watchdog
> will never ever detect anything.

Yes. I see that this is wrong. With MSI interrupts, as far as I can
see, there is not a way to make sure that the HPET timer caused the NMI
perhaps the only option is to use an IO APIC interrupt and read the
interrupt status register.

> 
> Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> access is horribly slow, so any high frequency perf monitoring will take a
> massive performance hit.

If an IO APIC interrupt is used, only HPET register (the status register)
would need to be read for every NMI. Would that be more acceptable? Otherwise,
there is no way to determine if the HPET cause the NMI.

Alternatively, there could be a counter that skips reading the HPET status
register (and the detection of hardlockups) for every X NMIs. This would
reduce the overall frequency of HPET register reads.

Is that more acceptable?

Thanks and BR,
Ricardo
