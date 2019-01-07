Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD699C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973EC2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfAGT1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfAGT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:27:52 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC3A2085A;
        Mon,  7 Jan 2019 19:27:50 +0000 (UTC)
Date:   Mon, 7 Jan 2019 14:27:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107142749.34231bb6@gandalf.local.home>
In-Reply-To: <20190107183444.GA5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <20190107183444.GA5966@xps-13>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 19:34:44 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Mon, Jan 07, 2019 at 10:31:34PM +0900, Masami Hiramatsu wrote:
> ...
> > BTW, this is not all of issues. To remove CONFIG_KPROBE_EVENTS_ON_NOTRACE
> > I'm trying to find out other notrace functions which can cause
> > kernel crash by probing. Mostly done on x86, so I'll post it
> > after this series.  
> 
> Not sure if you found it already, but it looks like some of the
> _raw_spin_lock/unlock* functions (when they're not inlined) are causing
> the same problem (or something similar), I can deadlock the system by
> doing this for example:
> 
>  echo "r:event_1 __fdget" >> kprobe_events
>  echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
>  echo 1 > events/kprobes/enable
>  [DEADLOCK]
> 
> Sending the following just in case...
>

Ug, kretprobe calls spinlocks in the callback? I wonder if we can
remove them.

I'm guessing this is a different issue than the one that this patch
fixes. This sounds like we are calling kretprobe from kretprobe?

-- Steve
