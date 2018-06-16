Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BEEC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8999208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8999208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936484AbeFPAyq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:54:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:9343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756675AbeFPAyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:54:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 17:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="67414042"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2018 17:54:43 -0700
Date:   Fri, 15 Jun 2018 17:51:03 -0700
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
Message-ID: <20180616005103.GC6659@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> > > >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > > >  		kick_timer(hdata);
> > > >  
> > > > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> > > 
> > > Eeew.
> > 
> > If you don't mind me asking. What is the problem with this error message?
> 
> The problem is not the error message. The problem is the abuse of
> request_irq() and the fact that this irq handler function exists in the
> first place for something which is NMI based.

I wanted to add this handler in case the interrupt was not configured correctly
to be delivered as NMI (e.g., not supported by the hardware). I see your point.
Perhaps this is not needed. There is code in place to complain when an interrupt
that nobody was expecting happens.

> 
> > > And in case that the HPET does not support periodic mode this reprogramms
> > > the timer on every NMI which means that while perf is running the watchdog
> > > will never ever detect anything.
> > 
> > Yes. I see that this is wrong. With MSI interrupts, as far as I can
> > see, there is not a way to make sure that the HPET timer caused the NMI
> > perhaps the only option is to use an IO APIC interrupt and read the
> > interrupt status register.
> > 
> > > Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> > > access is horribly slow, so any high frequency perf monitoring will take a
> > > massive performance hit.
> > 
> > If an IO APIC interrupt is used, only HPET register (the status register)
> > would need to be read for every NMI. Would that be more acceptable? Otherwise,
> > there is no way to determine if the HPET cause the NMI.
> 
> You need level trigger for the HPET status register to be useful at all
> because in edge mode the interrupt status bits read always 0.

Indeed.

> 
> That means you have to fiddle with the IOAPIC acknowledge magic from NMI
> context. Brilliant idea. If the NMI hits in the middle of a regular
> io_apic_read() then the interrupted code will endup with the wrong index
> register. Not to talk about the fun which the affinity rotation from NMI
> context would bring.
> 
> Do not even think about using IOAPIC and level for this.

OK. I will stay away of it and focus on MSI.
> 
> > Alternatively, there could be a counter that skips reading the HPET status
> > register (and the detection of hardlockups) for every X NMIs. This would
> > reduce the overall frequency of HPET register reads.
> 
> Great plan. So if the watchdog is the only NMI (because perf is off) then
> you delay the watchdog detection by that count.

OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
register per NMI just to check in the status register if the HPET timer
caused the NMI?

Thanks and BR,
Ricardo
