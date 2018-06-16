Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD757C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B020896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704B020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966035AbeFPAuO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:50:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:16403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753724AbeFPAuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:50:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 17:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="64551644"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2018 17:50:11 -0700
Date:   Fri, 15 Jun 2018 17:46:31 -0700
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
Subject: Re: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt
 among all monitored CPUs
Message-ID: <20180616004631.GB6659@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de>
 <20180615021629.GD11625@voyager>
 <alpine.DEB.2.21.1806151122070.2079@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806151122070.2079@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:29:06PM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > On Wed, Jun 13, 2018 at 11:48:09AM +0200, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > > +	/* There are no CPUs to monitor. */
> > > > +	if (!cpumask_weight(&hdata->monitored_mask))
> > > > +		return NMI_HANDLED;
> > > > +
> > > >  	inspect_for_hardlockups(regs);
> > > >  
> > > > +	/*
> > > > +	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
> > > > +	 * are addded and removed to this mask at cpu_up() and cpu_down(),
> > > > +	 * respectively. Thus, the interrupt should be able to be moved to
> > > > +	 * the next monitored CPU.
> > > > +	 */
> > > > +	spin_lock(&hld_data->lock);
> > > 
> > > Yuck. Taking a spinlock from NMI ...
> > 
> > I am sorry. I will look into other options for locking. Do you think rcu_lock
> > would help in this case? I need this locking because the CPUs being monitored
> > changes as CPUs come online and offline.
> 
> Sure, but you _cannot_ take any locks in NMI context which are also taken
> in !NMI context. And RCU will not help either. How so? The NMI can hit
> exactly before the CPU bit is cleared and then the CPU goes down. So RCU
> _cannot_ protect anything.
> 
> All you can do there is make sure that the TIMn_CONF is only ever accessed
> in !NMI code. Then you can stop the timer _before_ a CPU goes down and make
> sure that the eventually on the fly NMI is finished. After that you can
> fiddle with the CPU mask and restart the timer. Be aware that this is going
> to be more corner case handling that actual functionality.

Thanks for the suggestion. It makes sense to stop the timer when updating the
CPU mask. In this manner the timer will not cause any NMI.
> 
> > > > +	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
> > > > +		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
> > > > +			break;
> > > 
> > > ... and then calling into generic interrupt code which will take even more
> > > locks is completely broken.
> > 
> > I will into reworking how the destination of the interrupt is set.
> 
> You have to consider two cases:
> 
>  1) !remapped mode:
> 
>     That's reasonably simple because you just have to deal with the HPET
>     TIMERn_PROCMSG_ROUT register. But then you need to do this directly and
>     not through any of the existing interrupt facilities.

Indeed, there is no need to use the generic interrupt faciities to set affinity;
I am dealing with an NMI anyways.
> 
>  2) remapped mode:
> 
>     That's way more complex as you _cannot_ ever do anything which touches
>     the IOMMU and the related tables.
> 
>     So you'd need to reserve an IOMMU remapping entry for each CPU upfront,
>     store the resulting value for the HPET TIMERn_PROCMSG_ROUT register in
>     per cpu storage and just modify that one from NMI.
> 
>     Though there might be subtle side effects involved, which are related to
>     the acknowledge part. You need to talk to the IOMMU wizards first.

I see. I will look into the code and prototype something that makes sense for
the IOMMU maintainers.

> 
> All in all, the idea itself is interesting, but the envisioned approach of
> round robin and no fast accessible NMI reason detection is going to create
> more problems than it solves.

I see it more clearly now.

Thanks and BR,
Ricardo
