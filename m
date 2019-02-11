Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D23A21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfBKTzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730339AbfBKTze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:55:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35A1218AD;
        Mon, 11 Feb 2019 19:55:33 +0000 (UTC)
Date:   Mon, 11 Feb 2019 14:55:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: print function names instead of just address
Message-ID: <20190211145532.75d82308@gandalf.local.home>
In-Reply-To: <20190209161919.32350-1-changbin.du@gmail.com>
References: <20190209161919.32350-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 00:19:19 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Here is an example for this change.
> 
> $ sudo perf record -e 'ftrace:function' --filter='ip==schedule'
> $ sudo perf report

I took this but changed the subject as it only affects perf (the kernel
doesn't use the format field for output, and trace-cmd has an internal
plugin that overrides it too).

-- Steve

> 
> The output of perf before this patch:
> 
> \# Samples: 100  of event 'ftrace:function'
> \# Event count (approx.): 100
> \#
> \# Overhead  Trace output
> \# ........  ......................................
> \#
>     51.00%   ffffffff81f6aaa0 <-- ffffffff81158e8d
>     29.00%   ffffffff81f6aaa0 <-- ffffffff8116ccb2
>      8.00%   ffffffff81f6aaa0 <-- ffffffff81f6f2ed
>      4.00%   ffffffff81f6aaa0 <-- ffffffff811628db
>      4.00%   ffffffff81f6aaa0 <-- ffffffff81f6ec5b
>      2.00%   ffffffff81f6aaa0 <-- ffffffff81f6f21a
>      1.00%   ffffffff81f6aaa0 <-- ffffffff811b04af
>      1.00%   ffffffff81f6aaa0 <-- ffffffff8143ce17
> 
> After this patch:
> 
> \# Samples: 36  of event 'ftrace:function'
> \# Event count (approx.): 36
> \#
> \# Overhead  Trace output
> \# ........  ............................................
> \#
>     38.89%   schedule <-- schedule_hrtimeout_range_clock
>     27.78%   schedule <-- worker_thread
>     13.89%   schedule <-- schedule_timeout
>     11.11%   schedule <-- smpboot_thread_fn
>      5.56%   schedule <-- rcu_gp_kthread
>      2.78%   schedule <-- exit_to_usermode_loop
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  kernel/trace/trace_entries.h | 41 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> 
