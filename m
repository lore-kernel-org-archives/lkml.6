Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F4EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2732080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOgWn50h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2732080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeKACOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:14:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKACOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B7KdEnxBUq3ii7jZp5HTJbBVHv7VRaLUdPsX+lr56Kw=; b=AOgWn50hpZlEFFnKwbbC7K4iD
        itrBUcWXDvY/6tYpwvgHj4nfwy7hhOvHlgdTr4Z+WuSCkBW78prAyKwbaDMQPZ3P0/q8DW6BfUZPw
        G9VxJ9L2roEM3DuSrzzTeFSZHNf7pvsUWhTrG4ZL3R2Wce+lVKj1HLIT4UgXanmndzCN42qzStaRK
        xngVlEC54Iih6J6dDWiIXko3Mh1DzIrsKZMGQYAavU29xKKy20unTqCrH58tLeKoGu87Xvd7AUSgj
        89dCwOp1/Sz1VNO+i2TXT4uZYN/mnY4PsBi50XfPdFUm/OLAs7I32HwkFntZGK7KrLZcoAwoXfQ+G
        Q5uaR+lnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHu5m-0005Zi-Es; Wed, 31 Oct 2018 17:15:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B4C52029F87F; Wed, 31 Oct 2018 18:15:39 +0100 (CET)
Date:   Wed, 31 Oct 2018 18:15:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yi Sun <yi.y.sun@linux.intel.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181031171538.GC13219@hirez.programming.kicks-ass.net>
References: <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
 <20181023093328.GA15378@yi.y.sun>
 <20181031015417.GC15378@yi.y.sun>
 <20181031141030.GB13219@hirez.programming.kicks-ass.net>
 <fc0bf563-b1ae-4d4b-1341-11c44b759b8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0bf563-b1ae-4d4b-1341-11c44b759b8a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:07:22AM -0400, Waiman Long wrote:
> On 10/31/2018 10:10 AM, Peter Zijlstra wrote:
> > On Wed, Oct 31, 2018 at 09:54:17AM +0800, Yi Sun wrote:
> >> On 18-10-23 17:33:28, Yi Sun wrote:
> >>> On 18-10-23 10:51:27, Peter Zijlstra wrote:
> >>>> Can you try and explain why vcpu_is_preempted() doesn't work for you?
> >>> I thought HvSpinWaitInfo is used to notify hypervisor the spin number
> >>> which is different with vcpu_is_preempted. So I did not consider
> >>> vcpu_is_preempted.
> >>>
> >>> But HvSpinWaitInfo is a quite simple function and could be combined
> >>> with vcpu_is_preempted together. So I think it is OK to use
> >>> vcpu_is_preempted to make codes clean. I will have a try.
> >> After checking codes, there is one issue to call vcpu_is_preempted.
> >> There are two spin loops in qspinlock_paravirt.h. One loop in
> >> 'pv_wait_node' calls vcpu_is_preempted. But another loop in
> >> 'pv_wait_head_or_lock' does not call vcpu_is_preempted. It also does
> >> not call any other ops of 'pv_lock_ops' in the loop. So I am afraid
> >> we have to add one more ops in 'pv_lock_ops' to do this.
> > Why? Would not something like the below cure that? Waiman, can you have
> > a look at this; I always forget how that paravirt crud works.
> 
> There are two major reasons why the vcpu_is_preempt() test isn't done at
> pv_wait_head_or_lock(). First of all, we may not have a valid prev
> pointer after all if it is the first one to enter the queue while the
> lock is busy. Secondly, because of lock stealing, the cpu number pointed
> by a valid prev pointer may not be the actual cpu that is currently
> holding the lock. Another minor reason is that we want to minimize the
> lock transfer latency and so don't want to sleep too early while waiting
> at the queue head.

So Yi, are you actually seeing a problem? If so, can you give details?
