Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40123C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D724B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D724B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeGIPdB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933322AbeGIPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:33:00 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D032089B;
        Mon,  9 Jul 2018 15:32:59 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:32:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace performance (sched events): cyclictest shows 25% more
 latency
Message-ID: <20180709113257.79152dd0@gandalf.local.home>
In-Reply-To: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 08:22:01 +0200
Claudio <claudio.fontana@gliwa.com> wrote:

> Hello all,
> 
> I have been experimenting with the idea of leaving ftrace enabled, with sched events,
> on production systems.
> 
> The main concern that I am having at the moment is about the impact on the system.
> Enabling the sched events that I currently need for the tracing application
> seems to slow down context-switches considerably, and make the system less responsive.
> 
> I have tested with cyclictest on the mainline kernel, and noticed an increase of min, avg latencies of around 25%.
> 
> Is this expected?
> 
> Some initial investigation into ftrace seems to point at the reservation and commit of the events into the ring buffer
> as the highest sources of overhead, while event parameters copying, including COMM, does not seem to have any noticeable effect
> relative to those costs.
> 
> I have been running 20 times the following test, and thrown away the first results:
> 
> $ sudo ./cyclictest --smp -p95 -m -s -N -l 100000 -q

OK, I just noticed that you are using -N which means all numbers are in
nanoseconds.

> 
> $ uname -a
> Linux claudio-HP-ProBook-470-G5 4.18.0-rc3+ #3 SMP Tue Jul 3 15:50:30 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> For brevity, this is a comparison of one test's results. All other test results show the same ~25% increase.
> 
> On the left side, the run without ftrace sched events, on the right side with ftrace sched events enabled.
> 
> CPU    Count      Min       Act        Avg        Max        Count      Min-ftrace Act-ftrace Avg-ftrace Max-ftrace
> 0     100000      2339       2936       2841     139478     100000       2900       3182       3566      93056
> 1      66742      2365       3386       2874      93639      66750       2959       3786       3646     154074
> 2      50080      2376       3058       2910     196221      50097       2997       4209       3655      18707
> 3      40076      2394       3461       2931      17914      40091       3006       4417       3750      17159
> 4      33404      2371       3612       2834      15336      33419       2997       3836       3594      23172
> 5      28635      2387       3313       2885      25863      28649       2995       3795       3647       9956
> 6      25058      2384       3428       2968      12162      25071       3051       4366       3719      18151
> 7      22275      2381       2859       2982      10706      22287       3046       5078       3825      10781
> 
> I would be thankful for any advice or comments on this,
> especially with the goal in mind to lower as much as possible the runtime impact on the system.

Thus, the tracing is causing the wakeup time to be an average of 0.8us
longer.

Yes that is expected.

-- Steve
