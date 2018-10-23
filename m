Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6143C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FC520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeJWR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:58:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:8558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbeJWR6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:58:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 02:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="102519580"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2018 02:36:12 -0700
Date:   Tue, 23 Oct 2018 17:33:28 +0800
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
Message-ID: <20181023093328.GA15378@yi.y.sun>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023085127.GG3109@worktop.c.hoisthospitality.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-23 10:51:27, Peter Zijlstra wrote:
> On Tue, Oct 23, 2018 at 10:57:40AM +0800, Yi Sun wrote:
> > On 18-10-22 19:15:16, Peter Zijlstra wrote:
> 
> > > > >>>> +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
> > > > >>>> +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
> > > > >>>> +				break;
> > > > >>>> +#endif
> > > 
> > > Secondly; how come you thought that was acceptable in any way shape or
> > > form?
> > > 
> > Sorry for that. Will try another way.
> 
> Can you try and explain why vcpu_is_preempted() doesn't work for you?

I thought HvSpinWaitInfo is used to notify hypervisor the spin number
which is different with vcpu_is_preempted. So I did not consider
vcpu_is_preempted.

But HvSpinWaitInfo is a quite simple function and could be combined
with vcpu_is_preempted together. So I think it is OK to use
vcpu_is_preempted to make codes clean. I will have a try.
