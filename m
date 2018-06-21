Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE3C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1FE22460
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1FE22460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeFUWAe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:00:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:29546 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933705AbeFUWAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:00:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 15:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="68973792"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2018 15:00:32 -0700
Date:   Thu, 21 Jun 2018 15:00:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621220003.GD114883@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:32:57PM +0200, Thomas Gleixner wrote:
> On Thu, 21 Jun 2018, Fenghua Yu wrote:
> > On Thu, Jun 21, 2018 at 09:37:38PM +0200, Peter Zijlstra wrote:
> > > On Sun, May 27, 2018 at 08:45:49AM -0700, Fenghua Yu wrote:
> > > > Currently we can trace split lock event counter for debug purpose. But
> > > 
> > > How? A while ago I actually tried that, but I could not find a suitable
> > > perf event.
> > 
> > The event name is called sq_misc.split_lock. It's been supported in perf
> > already.
> 
> So the obvious question is why not simply use that counter and capture the
> IP which triggers the event?
> 

The sq_misc.split_lock event is AFTER the fact and insufficient to
capture split lock before the instruction is executed for system deployed
in the field. #AC for split lock is triggered BEFORE the instruction is
executed.

For example, on a consolidated real-time machine, some cores are running
hard real time workloads while the rest of cores are running "untrusted"
user processes. One untrusted user process may execute an instruction that
accesses split locked data and causes bus locking on the whole machine to
block real time workloads to access memory. In this case, capturing split
lock perf event won't immediately help the real time workloads. With #AC
for split lock, the split lock is detected before the instruction hurts
hard real time workloads and the untrusted process can be killed or system
admin gets warning depending on policy. Without #AC for split lock feature,
such consolidated real-time design is impossible.

Another example, in a public cloud deployed in the field, a user process
in a guest can execute an instruction with split lock to slow down overall
performance of other guests and host. This process could be a misdesigned
process or a malware. #AC for split lock can kill the process or provide
warning before harm. On the other hand, the perf event needs perf to run
to monitor the event on the public cloud and doesn't really prevent the
split lock from hurting system performance.

And perf cannot count split lock events in firmware. In real time, even
split lock in firmware (reboot, run time services, etc) may not be tolerant
and need to be detected and prevented.

Do the examples make sense?

> I can see that this wont cover the early boot process, but there it's
> enough to catch #AC once, yell loudly and then disable the thing. I'm not
> seing the value of adding 1000 lines of code with lots of control knobs.
> 
> I might be missing something though and am happy to be educated.
>

Right. Code won't cover the early boot process. It only covers boot process
after the feature is enabled.

After disabling #AC split lock after catching #AC once, any future split
lock will not generate #AC any more.

The control knobs allow sysadmin to handle #AC for split lock in different
scenarios and usages.

The control knob for kernel is to choose re-executing the faulting
instruction (default) or kernel panic. Kernel panic may be useful in hard
real time which has less tolerant to bad performance.

The control knob for user is to choose killing the process (default) or
re-executing the faulting instruction without blocking the process.
Re-executing the instruction maybe be useful in platforms that run
well controlled apps with less split locks.

The control knob for firmware is to choose continuing firmware execution
by disabling #AC split lock (default) or stopping firmware execution
by enabling #AC for split lock. Stopping firmware execution may be useful
in hard real time system to identify any split lock issue on the platform.

So the control knobs may be useful for different scenarios, right?

Thanks.

-Fenghua


