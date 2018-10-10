Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23522C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87582087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87582087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJKDAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:00:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EF72085B;
        Wed, 10 Oct 2018 19:37:14 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:37:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>, tsoni@codeaurora.org,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Jason Baron <jbaron@akamai.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-team@android.com, Colin Cross <ccross@android.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
Message-ID: <20181010153712.4e3a16d7@gandalf.local.home>
In-Reply-To: <174a465d-aedd-6561-e4e5-1f97ca4d0b0a@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
        <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
        <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
        <20181008103659.5bc14b28@gandalf.local.home>
        <20181008224056.GA213420@joelaf.mtv.corp.google.com>
        <174a465d-aedd-6561-e4e5-1f97ca4d0b0a@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 23:52:14 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> >>> Also regarding the warning on "event_call->event.funcs->trace()" call,
> >>> I see it everytime without spinlock. Also we see output_printk using
> >>> spinlock when making this call. I could not find a way to pass event
> >>> buffer size and allocate in pstore. Steven can give some hints with this
> >>> I guess.  
> > 
> > The spinlock warning you're talking about is this one correct?
> > 
> > [    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 trace_raw_output_prep+0x18/0xa0
> > [    1.389416] Modules linked in:
> > which you reported here:
> > https://lkml.org/lkml/2018/9/22/319
> > 
> > This warning happens I think because you're trying to format the events while
> > the trace events are being generated. You said you got this warning when you
> > didn't use the spinlock. I believe the spinlocking prevents such races, but
> > if you didn't need to format the events into text into text in the first
> > place, then you wouldn't need such locking at all.
> > 
> > I believe ftrace doesn't have such issues because such locking is taken care
> > off when the trace events are formatted from the trace buffer and displayed,
> > but I could be wrong about that.. I'll let Steven provide more inputs about
> > how this warning can occur.  
> Yes Steven would have more insight on this warning.

Correct. Formatting should not be done at the location of recording
(it's way too much overhead). Even trace_printk() doesn't format string
at the execution path, but does so at the presentation path (reading
the buffer, via reads of the trace file, or in trace-cmd post
processing of the trace.dat file).

trace_printk() uses vbin_printf() which doesn't do printf()
conversions, but instead only saves the format string and the raw
values into the buffer. Then in uses bstr_printf() that takes the
format string and raw values to produce the "printf()" output you know
and love.

-- Steve
