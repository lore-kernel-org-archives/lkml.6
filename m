Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA88C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECF820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECF820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbeGXPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbeGXPaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:30:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A19920880;
        Tue, 24 Jul 2018 14:23:18 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:23:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace global trace_pipe_raw
Message-ID: <20180724102316.41cdb8a1@gandalf.local.home>
In-Reply-To: <7dfce43c-afd3-52ee-4c58-ef6a3b1be5fd@gliwa.com>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
        <20180709113257.79152dd0@gandalf.local.home>
        <7dfce43c-afd3-52ee-4c58-ef6a3b1be5fd@gliwa.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 11:58:18 +0200
Claudio <claudio.fontana@gliwa.com> wrote:

> Hello Steven,
> 
> I am doing correlation of linux sched events, following all tasks between cpus,
> and one thing that would be really convenient would be to have a global
> trace_pipe_raw, in addition to the per-cpu ones, with already sorted events.
> 
> I would imagine the core functionality is already available, since trace_pipe
> in the tracing directory already shows all events regardless of CPU, and so
> it would be a matter of doing the same for trace_pipe_raw.

The difference between trace_pipe and trace_pipe_raw is that trace_pipe
is post processed, and reads the per CPU buffers and interleaves them
one event at a time. The trace_pipe_raw just sends you the raw
unprocessed data directly from the buffers, which are grouped per CPU.

> 
> But is there a good reason why trace_pipe_raw is available only per-cpu?

Yes, because it maps the ring buffers themselves without any post
processing.

> 
> Would work in the direction of adding a global trace_pipe_raw be considered
> for inclusion?

The design of the lockless ring buffer requires not to be preempted,
and that the data cannot be written to from more than one location. To
do so, we make a per CPU buffer, and disable preemption when writing.
This means that we have only one writer at a time. It can handle
interrupts and NMIs, because they will finish before they return and
this doesn't break the algorithm. But having writers from multiple CPUs
would require locking or other heaving synchronization operations that
will greatly reduce the speed of writing to the buffers (not to mention
the cache thrashing).

-- Steve
