Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5755B2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550114051;
	bh=FMmo8rh0PrcLNHxEfXdnNbaGdV4M5uPU3KmvCIYj/ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O5E79pWYEhd3EJbJ1Ej9qyAb4+2Bw8kLUcjCCRWSTuD/K1Hvetm2WrJYzu10+s30j
	 hEVBJsBAXvV9MjlOiN1/3N+BghC4qf9C9RH4nL4Vy9zeL9Ifbo6Nkkp4UpGNuVS8Ld
	 tKMoIxcE9z3C1u0btsfjiWFSepypFekIrwkYTf7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405030AbfBNDOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:14:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfBNDOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:14:02 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325262070C;
        Thu, 14 Feb 2019 03:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550114040;
        bh=FMmo8rh0PrcLNHxEfXdnNbaGdV4M5uPU3KmvCIYj/ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMQIacbAJxTvHCJ/O0RWG1lqd3p3Bj3TCgb6av5ymK6BwDubsZF4IzCdTkVsgK0Vi
         r09Twi4AcfnGfxXnd+3YI55SJoke6muit0xiegXKvuzWOqBMncZWJPAgAAlTER0XF5
         or0rGiK2ZzILd6ywe5+oDb6vpvKHLIuGwO82QmjA=
Date:   Thu, 14 Feb 2019 12:13:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] tracing: common error_log for ftrace
Message-Id: <20190214121357.727a0f34246b51e6660354bc@kernel.org>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thank you for your great work!

On Wed, 13 Feb 2019 12:17:51 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Last April, I posted an RFC patchset [1] implementing a common
> error_log interface as suggested by Masami [2].  We were supposed to
> discuss it at Plumbers but that never happened, and Steve recently
> asked about patches for a follow-on discussion [3], so here they are.
> 
> I incorporated comments from the previous discussion, the most
> important of which are:
> 
>  - Incorporated Steve's suggestion of using static strings as in the
>    existing trace event filter code, along with err_info indexing into
>    the string arrays and a position for the error caret.
> 
>  - Converted all the hist trigger errors and the existing trace event
>    filter parse errors to use the new interface.
> 
>  - Converted a few kprobe_event errors to the new interface as
>    examples, but these will require more work - I didn't spend much
>    time figuring out how to get the full kprobe command into the error
>    info, for instance.
> 
>  - Got rid of the custom single-page ring buffer and used standard
>    lists instead.
> 
> For now, this is implemented on top of the latest 'hist trigger
> snapshot and onchange additions' patchset [4].
> 
> Below is an example session of a few failed commands and the
> corresponding error_log contents:
> 
>   # echo > /sys/kernel/debug/tracing/error_log
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
> 
>   # echo 'hist:key=comm:p=prio:onchange($q).snapshot()' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
> 
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: File exists
> 
>   # echo 'comm="cyclictest"' > /sys/kernel/debug/tracing/events/sched/sched_wakeup/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
> 
>   # echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > /sys/kernel/debug/tracing/events/signal/signal_generate/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   hist:sched:sched_wakeup: error: Variable already defined
>   Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                     ^
>   hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
>   event filter parse error: error: Field not found
>     Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
>                                               ^  

I like this very much! One point I would like to comment is to add a kind of
entry number tag, so that user distinguish the error message, e.g.

  # cat /sys/kernel/debug/tracing/error_log
  [1] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                    ^
  [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  [3] hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  ...

What would you think?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
