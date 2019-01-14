Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A193C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E7220656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfANWEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfANWEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A66C205C9;
        Mon, 14 Jan 2019 22:04:05 +0000 (UTC)
Date:   Mon, 14 Jan 2019 17:04:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Perf: event wakeup discards sched_waking events
Message-ID: <20190114170403.344f7247@gandalf.local.home>
In-Reply-To: <615183542.671.1547501819850.JavaMail.zimbra@efficios.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
        <20190110110839.7daeef3d@gandalf.local.home>
        <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com>
        <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
        <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com>
        <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com>
        <20190114130957.GA10486@hirez.programming.kicks-ass.net>
        <615183542.671.1547501819850.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 16:36:59 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Can ftrace end up in the same situation through rb_wake_up_waiters() ? I suspect
> the tail recursion would be hard to trigger if the wakeup only happens once per
> page though, unless the events generated end up filling up a page.

And only events from the irq work that was caused by the ftrace wakeup,
which is highly unlikely.

Note, the lastest kernel only wakes up after half the buffer is full
(by default, but that can be changed), as I found that it gives the
best performance to keeping up with traces. I can actually trace small
loads and get all events now. Before, the waking of the tracer would
cause its own events to fill up the buffer and not be able to keep up
even on simple loads.

> 
> FWIW, LTTng avoids this entire issue by using a timer-based polling mechanism
> to ensure the tracing code does not call into the scheduler wakeup.

Does your timer stop if the system is idle and tracing is enabled?

-- Steve
