Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92513C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1320693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E1320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeFUA3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:29:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:32529 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754183AbeFUA3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:29:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 17:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="49334208"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2018 17:29:09 -0700
Date:   Wed, 20 Jun 2018 17:25:18 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
Message-ID: <20180621002518.GA16266@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
 <20180616005103.GC6659@voyager>
 <alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
 <20180620001535.GA27531@voyager>
 <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:25:09PM -0700, Randy Dunlap wrote:
> On 06/19/2018 05:15 PM, Ricardo Neri wrote:
> > On Sat, Jun 16, 2018 at 03:24:49PM +0200, Thomas Gleixner wrote:
> >> On Fri, 15 Jun 2018, Ricardo Neri wrote:
> >>> On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> >>>> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> >>>>> Alternatively, there could be a counter that skips reading the HPET status
> >>>>> register (and the detection of hardlockups) for every X NMIs. This would
> >>>>> reduce the overall frequency of HPET register reads.
> >>>>
> >>>> Great plan. So if the watchdog is the only NMI (because perf is off) then
> >>>> you delay the watchdog detection by that count.
> >>>
> >>> OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
> >>> register per NMI just to check in the status register if the HPET timer
> >>> caused the NMI?
> >>
> >> The status register is useless in case of MSI. MSI is edge triggered ....
> >>
> >> The only register which gives you proper information is the counter
> >> register itself. That adds an massive overhead to each NMI, because the
> >> counter register access is synchronized to the HPET clock with hardware
> >> magic. Plus on larger systems, the HPET access is cross node and even
> >> slower.
> > 
> > It starts to sound that the HPET is too slow to drive the hardlockup detector.
> > 
> > Would it be possible to envision a variant of this implementation? In this
> > variant, the HPET only targets a single CPU. The actual hardlockup detector
> > is implemented by this single CPU sending interprocessor interrupts to the
> > rest of the CPUs.
> > 
> > In this manner only one CPU has to deal with the slowness of the HPET; the
> > rest of the CPUs don't have to read or write any HPET registers. A sysfs
> > entry could be added to configure which CPU will have to deal with the HPET
> > timer. However, profiling could not be done accurately on such CPU.
> 
> Please forgive my simple question:
> 
> What happens when this one CPU is the one that locks up?

I think that in this particular case this one CPU would check for hardlockups
on itself when it receives the NMI from the HPET timer. It would also issue
NMIs to the other monitored processors.

Thanks and BR,
Ricardo
