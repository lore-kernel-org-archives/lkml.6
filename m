Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0311C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A431720863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCuqKikf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A431720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633008AbeKXDOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632988AbeKXDOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:14:00 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B30320861;
        Fri, 23 Nov 2018 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542990545;
        bh=40989pHUYTCw5HrMvW8esAir5ek4aapLAgyJveJrmAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCuqKikfagbcaabwtjbjrmmsFYxW89Q3KI22R2UZSwnx89+DkRhpVqV0aKiYw/APR
         Xy+whcBH9AwIYMWQbgfUg/ELwpBDmWQM5myNnk0CbQsVlm8ggH02z6MsbASC++e+vH
         wzvCOV6PzS6EqCwUlmSkKsuCU9iRtChRvOFlpHJw=
Date:   Fri, 23 Nov 2018 17:29:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20181123162900.GA4855@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <20180917122538.GT24124@hirez.programming.kicks-ass.net>
 <648176de-9ad4-a4b3-c542-bbaf250cd8cb@amazon.de>
 <ca9fed2f-b15d-b148-2e3a-02da827faf18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca9fed2f-b15d-b148-2e3a-02da827faf18@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:36:34AM -0700, Subhra Mazumdar wrote:
> 
> 
> On 09/26/2018 02:58 AM, Jan H. Schönherr wrote:
> >On 09/17/2018 02:25 PM, Peter Zijlstra wrote:
> >>On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
> >>
> >>>Assuming, there is a cgroup-less solution that can prevent simultaneous
> >>>execution of tasks on a core, when they're not supposed to. How would you
> >>>tell the scheduler, which tasks these are?
> >>Specifically for L1TF I hooked into/extended KVM's preempt_notifier
> >>registration interface, which tells us which tasks are VCPUs and to
> >>which VM they belong.
> >>
> >>But if we want to actually expose this to userspace, we can either do a
> >>prctl() or extend struct sched_attr.
> >Both, Peter and Subhra, seem to prefer an interface different than cgroups
> >to specify what to coschedule.
> >
> >Can you provide some extra motivation for me, why you feel that way?
> >(ignoring the current scalability issues with the cpu group controller)
> >
> >
> >After all, cgroups where designed to create arbitrary groups of tasks and
> >to attach functionality to those groups.
> >
> >If we were to introduce a different interface to control that, we'd need to
> >introduce a whole new group concept, so that you make tasks part of some
> >group while at the same time preventing unauthorized tasks from joining a
> >group.
> >
> >
> >I currently don't see any wins, just a loss in flexibility.
> >
> >Regards
> >Jan
> I think cgroups will the get the job done for any use case. But we have,
> e.g. affinity control via both sched_setaffinity and cgroup cpusets. It
> will be good to have an alternative way to specify co-scheduling too for
> those who don't want to use cgroup for some reason. It can be added later
> on though, only how one will override the other will need to be sorted out.

I kind of agree with Jan here that this is just going to add yet another task
group mechanism, very similar to the existing one, with runqueues inside and all.

Can you imagine kernel/sched/fair.c now dealing with both groups implementations?
What happens when cgroup task groups and cosched sched groups don't match wrt.
their tasks, their priorities, etc...

I understand cgroup task group has become infamous. But it may be a better idea
in the long run to fix it.
