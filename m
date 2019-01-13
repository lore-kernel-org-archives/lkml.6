Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F8C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B2020879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547389409;
	bh=1e+RLWNPAan2nk+hM4EKqEIL9x06MppQCoV5oOs/aEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RFogkXYhv6Lx1sXbZ0XxhyMcBoKMdZoMPGT1yswL8yYUTOKfmUkWLZENoTDmzpUkt
	 yhdD6Q5g1GgXRStQJX+aFBPXTuHp4VnweT22bSyNGWS7rsQxcH2HwsnM++d4vLDODL
	 3DmTh1G057PiGdPratiUSu3iGFqMEvGHzjaMDmW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfAMOXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 09:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfAMOXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 09:23:17 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DFA2084C;
        Sun, 13 Jan 2019 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547389396;
        bh=1e+RLWNPAan2nk+hM4EKqEIL9x06MppQCoV5oOs/aEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R+Drnj8Q/fiLvKCk2ZdZn0q/UDo4RlGthmNzxBA4AzEQbRUQGyMLHeQQNxwVpdowq
         M/aCcShS7gS4mmzaZScerxk12c4lImdifaQX7V4tS9iR3tAwHNVxvwgtuqg8b4+yNF
         ZYk9cqe6FnPDI7mrsgppxdJprwb6Hzr4TriNOUSQ=
Date:   Sun, 13 Jan 2019 23:23:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-Id: <20190113232313.33c2dd41b93eaf57a23ffbc2@kernel.org>
In-Reply-To: <20190112133324.GA2009@xps-13>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
        <20190112133324.GA2009@xps-13>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019 14:33:24 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Sat, Jan 12, 2019 at 11:25:40AM +0900, Masami Hiramatsu wrote:
> ...
> > And I found several functions which must be blacklisted.
> >  - optprobe template code, which is just a template code and
> >    never be executed. Moreover, since it can be copied and
> >    reused, if we probe it, it modifies the template code and
> >    can cause a crash. ([1/9][2/9])
> >  - functions which is called before kprobe_int3_handler()
> >    handles kprobes. This can cause a breakpoint recursion. ([3/9])
> >  - IRQ entry text, which should not be probed since register/pagetable
> >    status has not been stable at that point. ([4/9])
> >  - Suffixed symbols, like .constprop, .part etc. Those suffixed
> >    symbols never be blacklisted even if the non-suffixed version
> >    has been blacklisted. ([5/9])
> >  - hardirq tracer also works before int3 handling. ([6/9])
> >  - preempt_check debug function also is involved in int3 handling.
> >    ([7/9])
> >  - RCU debug routine is also called before kprobe_int3_handler().
> >    ([8/9])
> >  - Some lockdep functions are also involved in int3 handling.
> >    ([9/9])
> > 
> > Of course there still may be some functions which can be called
> > by configuration change, I'll continue to test it.
> 
> Hi Masami,
> 
> I think I've found another recursion problem. Could you include also
> this one?

Yeah, if I will make new version, but basically please feel free to
send such blacklist update patch to LKML, me and Ingo :)

> 
> Thanks,
> 
> From: Andrea Righi <righi.andrea@gmail.com>
> Subject: [PATCH] kprobes: prohibit probing on bsearch()
> 
> Since kprobe breakpoing handler is using bsearch(), probing on this
> routine can cause recursive breakpoint problem.
> 
> int3
>  ->do_int3()
>    ->ftrace_int3_handler()
>      ->ftrace_location()
>        ->ftrace_location_range()
>          ->bsearch() -> int3
> 
> Prohibit probing on bsearch().
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> ---
>  lib/bsearch.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/bsearch.c b/lib/bsearch.c
> index 18b445b010c3..82512fe7b33c 100644
> --- a/lib/bsearch.c
> +++ b/lib/bsearch.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/bsearch.h>
> +#include <linux/kprobes.h>
>  
>  /*
>   * bsearch - binary search an array of elements
> @@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
>  	return NULL;
>  }
>  EXPORT_SYMBOL(bsearch);
> +NOKPROBE_SYMBOL(bsearch);
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
