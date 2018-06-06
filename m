Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lm4+gAbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C2D260764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFFPW6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:22:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34058 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbeFFPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:22:57 -0400
Date: Wed, 6 Jun 2018 17:22:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Kohli, Gaurav" <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180606152245.GH12180@hirez.programming.kicks-ass.net>
References: <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
 <20180605152212.GY12180@hirez.programming.kicks-ass.net>
 <20180605154053.GB12235@hirez.programming.kicks-ass.net>
 <20180605163515.GB24053@redhat.com>
 <20180605201316.GZ12198@hirez.programming.kicks-ass.net>
 <20180606135115.GA4609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606135115.GA4609@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:51:16PM +0200, Oleg Nesterov wrote:
> On 06/05, Peter Zijlstra wrote:
> >
> > Also, I think we still need TASK_PARKED as a special state for that.
> 
> I think it would be nice to kill the TASK_PARKED state altogether. But I don't
> know how. I'll try to look at this code later, but I am not sure I will find a
> way to cleanup it...

So the nice thing about having TASK_PARKED is that it guarantees no
spurious wakeups. You know the thread will not wake up while it's CPU is
gone.

We could possibly re-purpose TASK_STOPPED (because kernel threads don't
do that) but that seems dodgy at best.
