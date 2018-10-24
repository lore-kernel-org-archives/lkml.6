Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB2C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C882082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C882082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJXS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:59:03 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:47797 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbeJXS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:59:03 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id C7B261C2A50
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:31:27 +0100 (IST)
Received: (qmail 7177 invoked from network); 24 Oct 2018 10:31:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Oct 2018 10:31:27 -0000
Date:   Wed, 24 Oct 2018 11:31:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181024103126.GC23537@techsingularity.net>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024085636.GB23537@techsingularity.net>
 <20181024094646.GA18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181024094646.GA18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:16:46PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2018-10-24 09:56:36]:
> 
> > On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> > It would certainly be a bit odd because the
> > application is asking for some protection but no guarantees are given
> > and the application is not made aware via an error code that there is a
> > problem. Asking the application to parse dmesg hoping to find the right
> > error message is going to be fragile.
> 
> Its a actually a good question.
> What should we be doing if a mix of isolcpus and housekeeping (aka
> non-isolcpus) is given in the mask.
> 
> Right now as you pointed, there is no easy way for the application to know
> which are the non-isolcpus to set its affinity. cpusets effective_cpus and
> cpus_allowed both will contain isolcpus too.
> 

While it's tangential to your patch, that sounds like a fairly big hole in
the API. Now, sure enough, it just puts the burden on the administrator
to figure it out but the silent "appears to work" is unfortunate. It's a
question on whether application owners or sysadmins are displined enough
to ensure that the kernel command line and scheduler affinities always
match properly.

> > Would it be more appropriate to fail sched_setaffinity when there is a
> > mix of isolated and housekeeping CPUs? In that case, an info message in
> > dmesg may be appropriate as it'll likely be a once-off configuration
> > error that's obvious due to an application failure.
> 
> I was looking at option of returning an error in that case. However our
> own perf bench numa cant handle it. We can be sure that there will other
> tools who could have coded that way and may start failing. So I am not sure
> if thats a good option. Previously they would *seem* to be working.
> 

I'm going to throw it out there -- should we do it anyway as it's a
sensible configuration and see what breaks? At the end of the day, it
would be a revert if we get caught by the "you never break userspace"
rule and get overruled on the defense "what the application asks for is
only being partially granted and it is vunerable to interference when it
thinks the kernel has promised isolation". It could even be a patch on top
of the one you have so that even if it does get reverted, there still is
a warning left over. Of course, it would instantly break the perf bench
numa case and open the question on whether that should be fixed too.

> Thats why I have taken an option of correcting within the kernel.
> 

FWIW, I'm not going to nak the patch on that basis as the warning is
beneficial in itself and an improvement of the current state. There are
others on the cc that have a greater awareness of how much interference
an isolated process is willing to tolerate and what sort of promises
we've given them in the past.

> > Alternatively,
> > should NUMA balancing ignore isolated CPUs? The latter seems unusual as
> > the application has specified a mask that allows those CPUs and it's not
> > clear why NUMA balancing should ignore them. If anything, an application
> > that wants to avoid all interference should also be using memory policies
> > to bind to nodes so it behaves predictably with respect to access latencies
> > (presumably if an application cannot tolerate kernel threads interfering
> > then it also cannot tolerate remote access latencies) or disabling NUMA
> > balancing entirely to avoid incurring minor faults.
> > 
> 
> The numa balancing is doing the right thing because if the application has
> the mask specified, then we should allow the application to run.
> 

This is what I thought.

> The problem happens when the unbound application starts to run on the isolcpu,
> regular load balancing will no more work. If another task is bound on the
> isolcpu, and other cpus in the node are free, this task will still contend
> with task bound to the isolcpus. (Unless numa affinity of the unbound thread
> changes).
> 

Which is bad.

> Also isocpus are suppose to run only those tasks that are bound to it.
> So we are kind of breaking that rule.
> 

Indeed so the warning has use in itself and it's a question on whether
others think we should be more strict about misleading (or broken if it's
critical enough) configurations.

As the patch at least highlights a problem and my suggestions are additional
work that may or may not be useful;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

But further opinions on whether there should be a patch on top that are
more strict would be welcome.

-- 
Mel Gorman
SUSE Labs
