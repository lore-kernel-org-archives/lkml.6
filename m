Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A89C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CCC204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CCC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeKEQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:15:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:59787 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbeKEQPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:15:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 22:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="88611274"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2018 22:57:19 -0800
Date:   Mon, 5 Nov 2018 14:54:31 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, chao.p.peng@intel.com,
        chao.gao@intel.com, isaku.yamahata@intel.com,
        michael.h.kelley@microsoft.com, tianyu.lan@microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181105065431.GF15378@yi.y.sun>
References: <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
 <20181023093328.GA15378@yi.y.sun>
 <20181031015417.GC15378@yi.y.sun>
 <20181031141030.GB13219@hirez.programming.kicks-ass.net>
 <fc0bf563-b1ae-4d4b-1341-11c44b759b8a@redhat.com>
 <20181031171538.GC13219@hirez.programming.kicks-ass.net>
 <20181101032020.GE15378@yi.y.sun>
 <a6f6590e-bc46-f8d7-f6dc-5464e37a8f52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6f6590e-bc46-f8d7-f6dc-5464e37a8f52@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-01 08:59:08, Waiman Long wrote:
> On 10/31/2018 11:20 PM, Yi Sun wrote:
> > On 18-10-31 18:15:39, Peter Zijlstra wrote:
> >> On Wed, Oct 31, 2018 at 11:07:22AM -0400, Waiman Long wrote:
> >>> On 10/31/2018 10:10 AM, Peter Zijlstra wrote:
> >>>> On Wed, Oct 31, 2018 at 09:54:17AM +0800, Yi Sun wrote:
> >>>>> On 18-10-23 17:33:28, Yi Sun wrote:
> >>>>>> On 18-10-23 10:51:27, Peter Zijlstra wrote:
> >>>>>>> Can you try and explain why vcpu_is_preempted() doesn't work for you?
> >>>>>> I thought HvSpinWaitInfo is used to notify hypervisor the spin number
> >>>>>> which is different with vcpu_is_preempted. So I did not consider
> >>>>>> vcpu_is_preempted.
> >>>>>>
> >>>>>> But HvSpinWaitInfo is a quite simple function and could be combined
> >>>>>> with vcpu_is_preempted together. So I think it is OK to use
> >>>>>> vcpu_is_preempted to make codes clean. I will have a try.
> >>>>> After checking codes, there is one issue to call vcpu_is_preempted.
> >>>>> There are two spin loops in qspinlock_paravirt.h. One loop in
> >>>>> 'pv_wait_node' calls vcpu_is_preempted. But another loop in
> >>>>> 'pv_wait_head_or_lock' does not call vcpu_is_preempted. It also does
> >>>>> not call any other ops of 'pv_lock_ops' in the loop. So I am afraid
> >>>>> we have to add one more ops in 'pv_lock_ops' to do this.
> >>>> Why? Would not something like the below cure that? Waiman, can you have
> >>>> a look at this; I always forget how that paravirt crud works.
> >>> There are two major reasons why the vcpu_is_preempt() test isn't done at
> >>> pv_wait_head_or_lock(). First of all, we may not have a valid prev
> >>> pointer after all if it is the first one to enter the queue while the
> >>> lock is busy. Secondly, because of lock stealing, the cpu number pointed
> >>> by a valid prev pointer may not be the actual cpu that is currently
> >>> holding the lock. Another minor reason is that we want to minimize the
> >>> lock transfer latency and so don't want to sleep too early while waiting
> >>> at the queue head.
> >> So Yi, are you actually seeing a problem? If so, can you give details?
> > Where does the patch come from? I cannot find it through google.
> >
> > Per Waiman's comment, it seems not suitable to call vcpu_is_preempted()
> > in pv_wait_head_or_lock(). So, we cannot make HvSpinWaitInfo notification
> > through vcpu_is_preempted() for such case. Based on that, I suggest to
> > add one more callback function in pv_lock_ops.
> 
> I am hesitant to add any additional check at the spinning loop in
> pv_wait_head_or_lock() especially one that is a hypercall or a callback
> that will take time to execute. The testing that I had done in the past
> indicated that it would slow down locking performance especially if the
> VM wasn't overcommitted at all.
> 
> Any additional slack in pv_wait_node() can be mitigated by the lock
> stealing that can happen. Slack in pv_wait_head_or_lock(), on the other
> hand, will certainly increase the lock transfer latency and impact
> performance. So you need performance data to show that it is worthwhile
> to do so.
> 
Ok, I will make performance test to show if it is worthwhile to call
SpinWaitInfo in pv_wait_head_or_lock.

> As for performance test, the kernel has a builtin locktorture test if
> you configured it in. So show us the performance data with and without
> the patch.

Thank you! I will make performance test for whole patch.

> 
> Cheers,
> Longman
