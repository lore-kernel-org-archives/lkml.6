Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7F1C1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1E220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeFOK3e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:29:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965585AbeFOK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:29:32 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTlyd-0005UW-35; Fri, 15 Jun 2018 12:29:07 +0200
Date:   Fri, 15 Jun 2018 12:29:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
In-Reply-To: <20180615021629.GD11625@voyager>
Message-ID: <alpine.DEB.2.21.1806151122070.2079@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de> <20180615021629.GD11625@voyager>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Ricardo Neri wrote:
> On Wed, Jun 13, 2018 at 11:48:09AM +0200, Thomas Gleixner wrote:
> > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > +	/* There are no CPUs to monitor. */
> > > +	if (!cpumask_weight(&hdata->monitored_mask))
> > > +		return NMI_HANDLED;
> > > +
> > >  	inspect_for_hardlockups(regs);
> > >  
> > > +	/*
> > > +	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
> > > +	 * are addded and removed to this mask at cpu_up() and cpu_down(),
> > > +	 * respectively. Thus, the interrupt should be able to be moved to
> > > +	 * the next monitored CPU.
> > > +	 */
> > > +	spin_lock(&hld_data->lock);
> > 
> > Yuck. Taking a spinlock from NMI ...
> 
> I am sorry. I will look into other options for locking. Do you think rcu_lock
> would help in this case? I need this locking because the CPUs being monitored
> changes as CPUs come online and offline.

Sure, but you _cannot_ take any locks in NMI context which are also taken
in !NMI context. And RCU will not help either. How so? The NMI can hit
exactly before the CPU bit is cleared and then the CPU goes down. So RCU
_cannot_ protect anything.

All you can do there is make sure that the TIMn_CONF is only ever accessed
in !NMI code. Then you can stop the timer _before_ a CPU goes down and make
sure that the eventually on the fly NMI is finished. After that you can
fiddle with the CPU mask and restart the timer. Be aware that this is going
to be more corner case handling that actual functionality.

> > > +	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
> > > +		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
> > > +			break;
> > 
> > ... and then calling into generic interrupt code which will take even more
> > locks is completely broken.
> 
> I will into reworking how the destination of the interrupt is set.

You have to consider two cases:

 1) !remapped mode:

    That's reasonably simple because you just have to deal with the HPET
    TIMERn_PROCMSG_ROUT register. But then you need to do this directly and
    not through any of the existing interrupt facilities.

 2) remapped mode:

    That's way more complex as you _cannot_ ever do anything which touches
    the IOMMU and the related tables.

    So you'd need to reserve an IOMMU remapping entry for each CPU upfront,
    store the resulting value for the HPET TIMERn_PROCMSG_ROUT register in
    per cpu storage and just modify that one from NMI.

    Though there might be subtle side effects involved, which are related to
    the acknowledge part. You need to talk to the IOMMU wizards first.

All in all, the idea itself is interesting, but the envisioned approach of
round robin and no fast accessible NMI reason detection is going to create
more problems than it solves.

This all could have been avoided if Intel hadn't decided to reuse the APIC
timer registers for the TSC deadline timer. If both would be available we'd
have a CPU local fast accessible watchdog timer when TSC deadline is used
for general timer purposes. But why am I complaining? I've resigned to the
fact that timers are designed^Wcobbled together by janitors long ago.

Thanks,

	tglx
