Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8AAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A7B208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A7B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeH0UCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0UCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:02:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B045208AF;
        Mon, 27 Aug 2018 16:15:31 +0000 (UTC)
Date:   Mon, 27 Aug 2018 12:15:30 -0400
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
Message-ID: <20180827121530.525299e3@gandalf.local.home>
In-Reply-To: <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
        <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
        <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
        <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 12:54:07 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:


> Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not 
> sure why and how it is filtered out because I do not see any notrace 
> flag in those functions, maybe that whole directory is filtered out.
> So adding this functionality to ftrace would mean removing the notrace 
> for these functions i.e., something like using 
> __raw{read,write}{b,l,w,q}() as the available filter functions. Also 
> pstore ftrace does not filter functions to trace I suppose?

It's not traced because it is inlined. Simply make the __raw_read
function a normal function and it will be traced. And then you could
use ftrace to read the function.

If this has to be per arch, you can register your callback with the
REGS flags, and pt_regs will be passed to your callback function you
attached to __raw_read*() as if you inserted a break point at that
location, and you can get any reg data you want there.


> 
> Coming to the reason as to why it would be good to keep this separate 
> from ftrace would be:
> * Ftrace can get ip and parent ip, but suppose we need extra data (field 
> data) as in above sample output we would not be able to get through ftrace.

As mentioned above, you can get regs (and ftrace is being expanded now
to get parameters of functions).

> 
> * Although this patch is for tracing register read/write, we can easily
> add more functionality since we have dynamic_rtb api which can be hooked 
> to functions and start tracing events(IRQ, Context ID) something similar 
> to tracepoints.
> Initially thought of having tracepoints for logging register read/write 
> but I do not know if we can export tracepoint data to pstore since the 
> main usecase is to debug unknown resets and hangs.

I don't know why not? We have read/write tracepoints for
read/write_msr() calls in x86.

Anything can add a hook to the callback of the tracepoints, and use
that infrastructure instead of creating yet another dynamic code
modification infrastructure.


> 
> * This can be something similar to mmiotrace in x86 and kept seperate 
> from function tracer.


mmiotrace is separate because it faults on writes so that we can
capture any reads and writes to the system that a binary driver does.

-- Steve
