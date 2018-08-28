Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D3F20893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D3F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH1Tyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbeH1Tyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:54:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3C52087A;
        Tue, 28 Aug 2018 16:02:26 +0000 (UTC)
Date:   Tue, 28 Aug 2018 12:02:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
Message-ID: <20180828120224.381d406a@gandalf.local.home>
In-Reply-To: <369f384b-c419-99d8-c0a4-3ed38f1dd0f4@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
        <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
        <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
        <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
        <20180827121530.525299e3@gandalf.local.home>
        <369f384b-c419-99d8-c0a4-3ed38f1dd0f4@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 18:47:33 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 8/27/2018 9:45 PM, Steven Rostedt wrote:
> > On Sat, 25 Aug 2018 12:54:07 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> > 
> >   
> >> Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not
> >> sure why and how it is filtered out because I do not see any notrace
> >> flag in those functions, maybe that whole directory is filtered out.
> >> So adding this functionality to ftrace would mean removing the notrace
> >> for these functions i.e., something like using
> >> __raw{read,write}{b,l,w,q}() as the available filter functions. Also
> >> pstore ftrace does not filter functions to trace I suppose?  
> > 
> > It's not traced because it is inlined. Simply make the __raw_read
> > function a normal function and it will be traced. And then you could
> > use ftrace to read the function.
> > 
> > If this has to be per arch, you can register your callback with the
> > REGS flags, and pt_regs will be passed to your callback function you
> > attached to __raw_read*() as if you inserted a break point at that
> > location, and you can get any reg data you want there.
> > 
> >  
> 
> Thank you very much for the information Steven. Ok so we can get 
> function parameters with pt_regs.

Yes.

> 
> >>
> >> Coming to the reason as to why it would be good to keep this separate
> >> from ftrace would be:
> >> * Ftrace can get ip and parent ip, but suppose we need extra data (field
> >> data) as in above sample output we would not be able to get through ftrace.  
> > 
> > As mentioned above, you can get regs (and ftrace is being expanded now
> > to get parameters of functions).
> >   
> You mean there is another way to get parameters other than regs?

No, but you could register a callback function to be called when a
function is hit, and the pt_regs are passed to it. We are working on
getting parameters from the pt_regs (see this patch:
 http://lkml.kernel.org/r/152465885737.26224.2822487520472783854.stgit@devbox)

> 
> >>
> >> * Although this patch is for tracing register read/write, we can easily
> >> add more functionality since we have dynamic_rtb api which can be hooked
> >> to functions and start tracing events(IRQ, Context ID) something similar
> >> to tracepoints.
> >> Initially thought of having tracepoints for logging register read/write
> >> but I do not know if we can export tracepoint data to pstore since the
> >> main usecase is to debug unknown resets and hangs.  
> > 
> > I don't know why not? We have read/write tracepoints for
> > read/write_msr() calls in x86.
> > 
> > Anything can add a hook to the callback of the tracepoints, and use
> > that infrastructure instead of creating yet another dynamic code
> > modification infrastructure.
> >   
> Thanks for pointing out to read/write_msr, I checked it and was able to 
> implement something similar for arm64. But still can we export 
> tracepoint data to pstore because we need to debug reset cases and for 
> that pstore is of real importance?. If so then it would be great to have 
> various events logged into pstore which can be a lot of help for debugging.
> 
> Also with the current dynamic filtering of read/write(PATCH 3/3), it is 
> a lot easier to filter register read/write since we use dynamic debug 
> framework which provides file, function and line level filtering 
> capacity. Maybe if we can add something like this to trace events it 
> would be better?

I would recommend using the tracepoint infrastructure. Note,
tracepoints and trace events are two different things. Trace events use
tracepoints, and you use trace events to create tracepoints, thus they
are tightly coupled. But once a tracepoint exists, anything can connect
to them without needing to use the trace event.

Let's look at the read_msr trace event. Because it is in a header, to
avoid "include hell" we open code some of it:

static inline unsigned long long native_read_msr(unsigned int msr)
{
	unsigned long long val;

	val = __rdmsr(msr);

	if (msr_tracepoint_active(__tracepoint_read_msr))
		do_trace_read_msr(msr, val, 0);

	return val;
}

Where:

#ifdef CONFIG_TRACEPOINTS
#define msr_tracepoint_active(t) static_key_false(&(t).key)
#else 
#define msr_tracepoint_active(t) false
#endif

We have to open code the access to the tracepoint.key because msr.h is
used in a lot of critical headers, we couldn't use the normal
tracepoint.h header here.

The "static_key_false()" is a jump label that is just a nop. When the
static_key is enabled, the nop is converted to a static "jmp" to the
code that calls "do_trace_read_msr()". This is a function call to a
function defined in msr.c (where we can do proper includes), and all
that does is call the tracepoint "trace_read_msr()", which is also a
static key that, when enabled, will iterate over a list of functions it
should call with the defined parameters (msr, val, failed).

When defining the trace event for "read_msr", it creates the tracepoint
"trace_read_msr()" and we place it in this do_trace_read_msr()
function. The TRACE_EVENT() macros creates everything that is needed to
connect the trace event "read_msr" to the tracepoint
"trace_read_msr()", and you can enable this via the tracefs subsystem
or via perf.

But you can also add your own hook to that tracepoint. If you have code
that does:

register_trace_read_msr(func, data);

The "func" gets called when trace_read_msr() is hit. Thus you could
have:

static void my_func(void *data, unsigned msr, u64 val, int failed)
{
	struct my_struct *my_data = data;

	do_something_with(my_data, msr, val, failed);
}

{
	struct my_struct *my_data;

	my_data = kzalloc(sizeof(*my_data)), GFP_KERNEL);

	register_trace_read_msr(my_func, my_data);
}


And then your function "my_func" will be called with any data you
registered with it (you may register "NULL" if you don't need to pass
in data), and it will also get the parameters passed to trace_read_msr()

If you want to have you "my_func" record into pstore, then it will
happen at runtime, and if the system resets, you have your data where
you want it.

-- Steve
