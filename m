Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8DC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C6220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJWLVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:21:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:36021 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJWLVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:21:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 20:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,414,1534834800"; 
   d="scan'208";a="83353089"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2018 20:00:24 -0700
Date:   Tue, 23 Oct 2018 10:57:40 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181023025740.GL11769@yi.y.sun>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022171516.GH3117@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-22 19:15:16, Peter Zijlstra wrote:
> 
> Firstly, who come a patch that is grubbing around in kernel/locking/ has
> an x86/hyperv subject and isn't Cc'ed to the locking maintainers?
> 
I am sorry. That is my fault to forget to add locking maintainers.

> On Mon, Oct 22, 2018 at 12:31:45PM -0400, Waiman Long wrote:
> > On 10/22/2018 03:32 AM, Juergen Gross wrote:
> > > On 22/10/2018 03:53, Yi Sun wrote:
> > >> On 18-10-19 16:20:52, Juergen Gross wrote:
> > >>> On 19/10/2018 15:13, Yi Sun wrote:
> > >> [...]
> > >>
> > >>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> > >>>> index 0130e48..9e88c7e 100644
> > >>>> --- a/kernel/locking/qspinlock_paravirt.h
> > >>>> +++ b/kernel/locking/qspinlock_paravirt.h
> > >>>> @@ -7,6 +7,8 @@
> > >>>>  #include <linux/bootmem.h>
> > >>>>  #include <linux/debug_locks.h>
> > >>>>  
> > >>>> +#include <asm/mshyperv.h>
> > >>>> +
> > >>>>  /*
> > >>>>   * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
> > >>>>   * of spinning them.
> > >>>> @@ -305,6 +307,10 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
> > >>>>  				wait_early = true;
> > >>>>  				break;
> > >>>>  			}
> > >>>> +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
> > >>>> +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
> > >>>> +				break;
> > >>>> +#endif
> 
> Secondly; how come you thought that was acceptable in any way shape or
> form?
> 
Sorry for that. Will try another way.

> > > vcpu_is_preempted() is already part of this loop. And this is a paravirt
> > > hook. Can't you make use of that? This might require adding another
> > > parameter to this hook, but I'd prefer that over another pv-spinlock
> > > hook.
> 
> > I agree with Juergen on that. I would suggest rename the
> > vcpu_is_preempted hook into a more generic vcpu_stop_spinning, perhaps,
> > so different hypervisors can act on the information accordingly. Adding
> > an extra parameter is fine.
> 
> No; no extra parameters. vcpu_is_preempted() is a simple and intuitive
> interface. Why would we want to make it complicated?
