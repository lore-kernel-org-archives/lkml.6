Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7EFC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C7920832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeK2IDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:03:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeK2IDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:03:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475F12081C;
        Wed, 28 Nov 2018 21:00:23 +0000 (UTC)
Date:   Wed, 28 Nov 2018 16:00:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Message-ID: <20181128160021.09acd1af@gandalf.local.home>
In-Reply-To: <20181128203931.ym2rkya7a6agzzy3@redhat.com>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 15:39:31 -0500
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Hi Steve,
> 
> With your ftrace/urgent branch linked above, if I try a quick
> function_graph test like the following:
> 
>   SYSFS=/sys/kernel/debug/tracing
> 
>   echo 0 > "$SYSFS/tracing_on"
>   echo cmdline_proc_show > "$SYSFS/set_graph_function"
>   echo function_graph > "$SYSFS/current_tracer"
>   echo 1 > "$SYSFS/tracing_on"
> 
> I see a bunch of scheduler interrupt functions in the trace/trace_pipe
> without even invoking cmdline_proc_show().
> 
> This tests works as expected with Linux 4.20-rc3 though:
> 
>   % cat /sys/kernel/debug/tracing/trace_pipe
>    2)               |  cmdline_proc_show() {
>    2)   0.320 us    |    seq_puts();
>    2)   0.030 us    |    seq_putc();
>    2)   1.352 us    |  }
> 
> Operator error, or did the patchset break something?

Nope, that does seem to be a bug :-/

-- Steve
