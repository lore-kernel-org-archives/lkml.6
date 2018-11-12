Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4551FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E414B22506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E414B22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeKMGPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeKMGPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:15:30 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CC7224E0;
        Mon, 12 Nov 2018 20:20:41 +0000 (UTC)
Date:   Mon, 12 Nov 2018 15:20:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Message-ID: <20181112152037.451d8b10@vmware.local.home>
In-Reply-To: <20181112181741.GA3097@worktop.psav.com>
References: <20181111194104.GA4787@linux.ibm.com>
        <20181111194410.6368-23-paulmck@linux.ibm.com>
        <20181112001233.GC3056@worktop>
        <20181112004528.GA4170@linux.ibm.com>
        <20181112005329.GG3056@worktop>
        <20181112014736.GB4170@linux.ibm.com>
        <20181112020710.GJ3056@worktop>
        <20181112022455.GD4170@linux.ibm.com>
        <20181112090047.GN3056@worktop>
        <20181112132852.GH4170@linux.ibm.com>
        <20181112181741.GA3097@worktop.psav.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 19:17:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Nov 12, 2018 at 05:28:52AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 12, 2018 at 10:00:47AM +0100, Peter Zijlstra wrote:  
> 
> > > Still, better safe than sorry. It was a rather big change in behaviour,
> > > so it wouldn't have been strange to call that out.  
> > 
> > This guy:
> > 
> > 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> > 
> > Has a commit log that says:
> > 
> > 	Now that RCU-preempt knows about preemption disabling, its
> > 	implementation of synchronize_rcu() works for synchronize_sched(),
> > 	and likewise for the other RCU-sched update-side API members.
> > 	This commit therefore confines the RCU-sched update-side code
> > 	to CONFIG_PREEMPT=n builds, and defines RCU-sched's update-side
> > 	API members in terms of those of RCU-preempt.
> > 
> > That last phrase seems pretty explicit.  What am I missing here?  
> 
> That does not explicitly state that because RCU-preempt
> synchornize_rcu() can take _much_ longer, the new synchronize_sched()
> can now take _much_ longer too.

I'm curious. Are there measurements to see how much longer they can
take? Saying "_much_ longer" would require that one has done the
timings to see what the actual impact is.

> 
> So when someone bisects a problem to this commit; and he reads the
> Changelog, he might get the impression that was unexpected.

It may well be unexpected. What is the timing differences between a
normal synchronize_rcu and a synchronize_sched. Of course, 99% of users
wont see any difference as 99% don't run CONFIG_PREEMPT.

-- Steve
