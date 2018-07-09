Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F874208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F874208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeGIPLj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933353AbeGIPLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:11:37 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2702086A;
        Mon,  9 Jul 2018 15:11:36 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:11:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace performance (sched events): cyclictest shows 25% more
 latency
Message-ID: <20180709111134.08f57ac5@gandalf.local.home>
In-Reply-To: <cfb0a25b-7236-5866-6c33-838425da8d06@gliwa.com>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
        <20180706172428.30aeef91@gandalf.local.home>
        <f5624adb-6fc3-bf17-d58f-b98ed8c69b7e@gliwa.com>
        <cfb0a25b-7236-5866-6c33-838425da8d06@gliwa.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 16:53:52 +0200
Claudio <claudio.fontana@gliwa.com> wrote:

> 
> One additional data point, based on brute force again:
> 
> I applied this change, in order to understand if it was the
> 
> trace_event_raw_event_* (I suppose primarily trace_event_raw_event_switch)
> 
> that contained the latency "offenders":
> 
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 4ecdfe2..969467d 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -704,6 +704,8 @@ trace_event_raw_event_##call(void *__data, proto)           
>         struct trace_event_raw_##call *entry;                           \
>         int __data_size;                                                \
>                                                                         \
> +       return;                                                         \
> +                                                                       \
>         if (trace_trigger_soft_disabled(trace_file))                    \
>                 return;                                                 \
>                                                                         \
> 
> 
> This reduces the latency overhead to 6% down from 25%.
> 
> Maybe obvious? Wanted to share in case it helps, and will dig further.

I noticed that just disabling tracing "echo 0 > tracing_on" is very
similar. I'm now recording timings of various parts of the code. But at
most I've seen is a 12us, which should not add the overhead. So it's
triggering something else.

I'll be going on PTO next week, and there's things I must do this week,
thus I may not have much more time to look into this until I get back
from PTO (July 23rd).

-- Steve
