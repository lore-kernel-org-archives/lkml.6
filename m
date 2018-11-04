Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF5C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FC82081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4dADvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FC82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeKDLuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeKDLuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:50:05 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6A02081F;
        Sun,  4 Nov 2018 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541298310;
        bh=VJ3VKhlb5KgdksOoXIjrH1tkpm9CsEhQgLyeG7IOMrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vB4dADvnSqfK+qgK/TRc/A2hleCGkMeMqB/NpqLzqSa4uyQXBVn6nS9HuH2l07H0P
         rDGJTRCPBWiRxt5thctkI/1aDnNd0HOutJNQJj9LkTbYNYs8wrnI2YbHBK4Y+PnXnK
         0cJ9SQLm8bFG+oOzuKf19gR1kFlRLemVL6k5jD7U=
Date:   Sun, 4 Nov 2018 11:25:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181104112506.77464e6750a1517865a29c9f@kernel.org>
In-Reply-To: <20181103133021.6676708c@vmware.local.home>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181102154325.bt6xoysl4xdl33wd@treble>
        <20181102121307.32e99414@gandalf.local.home>
        <20181103220012.55ecd97e671c43e4959c8b62@kernel.org>
        <20181103091341.3d32683e@vmware.local.home>
        <20181104013430.9d3e91b8ebbae7dcb6860ef1@kernel.org>
        <20181103133021.6676708c@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 13:30:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 4 Nov 2018 01:34:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > I was thinking of a bitmask that represents the handlers, and use that
> > > to map which handler gets called for which shadow entry for a
> > > particular task.  
> > 
> > Hmm, I doubt that is too complicated and not scalable. I rather like to see
> > the open shadow entry...
> 
> It can scale and not too complex (I already played a little with it).
> But that said, I'm not committed to it, and using the shadow stack is
> also an interesting idea.
> 
> > 
> > entry: [[original_retaddr][function][modified_retaddr]]
> > 
> > So if there are many users on same function, the entries will be like this 
> > 
> > [[original_return_address][function][trampoline_A]]
> > [[trampline_A][function][trampoline_B]]
> > [[trampline_B][function][trampoline_C]]
> > 
> > And on the top of the stack, there is trampline_C instead of original_return_address.
> > In this case, return to trampoline_C(), it jumps back to trampline_B() and then
> > it jumps back to trampline_A(). And eventually it jumps back to
> > original_return_address.
> 
> Where are trampolines A, B, and C made? Do we also need to dynamically
> create them? If I register multiple function tracing ones, each one
> will need its own trampoline?
> 

No, I think tramplines are very limited. currently we will only have ftrace
and kretprobe trampolines.


> > This way, we don't need allocate another bitmap/pages for the shadow stack.
> > We only need a shadow stack for each task.
> > Also, unwinder can easily find the trampline_C from the shadow stack and restores
> > original_return_address. (of course trampline_A,B,C must be registered so that
> > search function can skip it.)
> 
> What I was thinking was to store a count and the functions to be called:
> 
> 
> 	[original_return_address]
> 	[function_A]
> 	[function_B]
> 	[function_C]
> 	[ 3 ]
> 
> Then the trampoline that processes the return codes for ftrace (and
> kretprobes and everyone else) can simply do:
> 
> 	count = pop_shadow_stack();
> 	for (i = 0; i < count; i++) {
> 		func = pop_shadow_stack();
> 		func(...);
> 	}
> 	return_address = pop_shadow_stack();

Ah, that's a good idea. I think we also have to store the called function
entry address with the number header, but basically I agree with you.

If we have a space to store a data with the function address, that is also
good to kretprobe. systemtap heavily uses "entry data" for saving some data
at function entry for exit handler.

> That way we only need to register a function to the return handler and
> it will be called, without worrying about making trampolines. There
> will just be a single trampoline that handles all the work.

OK, and could you make it independent from func graph tracer, so that
CONFIG_KPROBES=y but CONFIG_FUNCTION_GRAPH_TRACER=n kernel can support
kretprobes too.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
