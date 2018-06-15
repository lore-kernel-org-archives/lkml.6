Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1295C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F4D20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F4D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965503AbeFOCLT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:11:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:11565 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965463AbeFOCLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:11:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="47887654"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2018 19:11:16 -0700
Date:   Thu, 14 Jun 2018 19:07:38 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20180615020738.GB11625@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613090720.GV12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613090720.GV12258@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:07:20AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 05:57:37PM -0700, Ricardo Neri wrote:
> 
> +static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
> +{
> +       unsigned long this_isr;
> +       unsigned int lvl_trig;
> +
> +       this_isr = hpet_readl(HPET_STATUS) & BIT(hdata->num);
> +
> +       lvl_trig = hpet_readl(HPET_Tn_CFG(hdata->num)) & HPET_TN_LEVEL;
> +
> +       if (lvl_trig && this_isr)
> +               return true;
> +
> +       return false;
> +}
> 
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
> 
> Please do explain.. That FSB thing basically means MSI. But there's only
> a single NMI vector. How do we know this NMI came from the HPET?

Indeed, I see now that this is wrong. There is no way to know. The only way
is to use an IO APIC interrupt and read the HPET status register.

> 
> > +
> > +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
> 
> So you add _2_ HPET reads for every single NMI that gets triggered...
> and IIRC HPET reads are _sllooooowwwwww_.


Since the trigger mode of the HPET timer is not expected to change, 
perhaps is_hpet_wdt_interrupt() can only need the interrupt status
register. This would reduce the reads to one. Furthermore, the hardlockup
detector can skip an X number of NMIs and reduce further the frequency
of reads. Does this make sense?

> 
> > +		return NMI_DONE;
> > +
> > +	inspect_for_hardlockups(regs);
> > +
> > +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > +		kick_timer(hdata);
> > +
> > +	/* Acknowledge interrupt if in level-triggered mode */
> > +	if (!use_fsb)
> > +		hpet_writel(BIT(hdata->num), HPET_STATUS);
> > +
> > +	return NMI_HANDLED;
> 
> So if I read this right, when in FSB/MSI mode, we'll basically _always_
> claim every single NMI as handled?
> 
> That's broken.

Yes, this is not correct. I will drop the functionality to use
FSB/MSI mode.

Thanks and BR,
Ricardo
