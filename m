Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9831C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DB22403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1xQlhg6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB22403B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeGENm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:42:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeGENmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bvwm6cGrD+353JcOrWu68PkLpub8x8Y6JsoIybI8aR8=; b=1xQlhg6CRetk+8HqW6S7boP8M
        Jq7p8oCjar0X4g3iTFxuSRsjN5koNhdBlyDnP4aVen6jb7VW+qjbBwdfdcFJtDsr/KkMGc2C//lmJ
        26vaCsjW7Ig1Pb/LcUzWHMS4um6cP5HrdQZgE/Nv+ydQVmMNX7gNUJ8ZaEzH4OP3sdcv7+ibLpiqH
        cu17TI8gqzN5DTSdpf8PlZ0RCImcobDRxB5r7frOfkLW/PwCpOujYHXzeRygRjt2lgGT3OTgdC3u0
        eXHA95DzQ7wE8HeP/KCILCI1ZokgHt8txTHCFnVhh1E3Rn7v4jzrtLSpCnEQr/gu2iOMtZrjJLK/b
        ea0SVE+pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb4WX-0007zc-Kj; Thu, 05 Jul 2018 13:42:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 613AD20298BAE; Thu,  5 Jul 2018 15:42:14 +0200 (CEST)
Date:   Thu, 5 Jul 2018 15:42:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Message-ID: <20180705134214.GF2494@hirez.programming.kicks-ass.net>
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
 <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:21:15PM +0800, Xunlei Pang wrote:
> On 7/5/18 6:46 PM, Peter Zijlstra wrote:
> > On Wed, Jun 27, 2018 at 08:22:42PM +0800, Xunlei Pang wrote:
> >> tick-based whole utime is utime_0, tick-based whole stime
> >> is stime_0, scheduler time is rtime_0. 
> > 
> >> For a long time, the process runs mainly in userspace with
> >> run-sleep patterns, and because two different clocks, it
> >> is possible to have the following condition:
> >>   rtime_0 < utime_0 (as with little stime_0)
> > 
> > I don't follow... what?
> > 
> > Why are you, and why do you think it makes sense to, compare rtime_0
> > against utime_0 ?
> > 
> > The [us]time_0 are, per your earlier definition, ticks. They're not an
> > actual measure of time. Do not compare the two, that makes no bloody
> > sense.
> > 
> 
> [us]time_0 is task_struct:utime{stime}, I cited directly from
> cputime_adjust(), both in nanoseconds. I assumed "rtime_0 < utime_0"
> here to simple the following proof to help explain the problem we met.

In the !VIRT_CPU_ACCOUNTING case they (task_struct::[us]time) are not
actual durations. Yes, the happen to be accounted in multiples of
TICK_NSEC and thereby happen to carry a [ns] unit, but they are not
durations, they are samples.

(we just happen to store them in a [ns] unit because for
VIRT_CPU_ACCOUNTING they are in fact durations)

If 'rtime < utime' is not a valid assumption to build a problem on for
!VIRT_CPU_ACCOUNTING.


So please try again, so far you're not making any sense.
