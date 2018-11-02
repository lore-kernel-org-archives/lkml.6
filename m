Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB51C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217A2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4217A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeKCAvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeKCAvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90267394D3C;
        Fri,  2 Nov 2018 15:43:31 +0000 (UTC)
Received: from treble (ovpn-123-155.rdu2.redhat.com [10.10.123.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 187F860BF1;
        Fri,  2 Nov 2018 15:43:27 +0000 (UTC)
Date:   Fri, 2 Nov 2018 10:43:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20181102154325.bt6xoysl4xdl33wd@treble>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102091658.1bc979a4@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 02 Nov 2018 15:43:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 09:16:58AM -0400, Steven Rostedt wrote:
> On Fri, 2 Nov 2018 17:59:32 +1100
> Aleksa Sarai <cyphar@cyphar.com> wrote:
> 
> > As an aside, I just tested with the frame unwinder and it isn't thrown
> > off-course by kretprobe_trampoline (though obviously the stack is still
> > wrong). So I think we just need to hook into the ORC unwinder to get it
> > to continue skipping up the stack, as well as add the rewriting code for
> > the stack traces (for all unwinders I guess -- though ideally we should
> 
> I agree that this is the right solution.

Sounds good to me.

However, it would be *really* nice if function graph and kretprobes
shared the same infrastructure, like they do for function entry.
There's a lot of duplicated effort there.

> > do this without having to add the same code to every architecture).
> 
> True, and there's an art to consolidating the code between
> architectures.
> 
> I'm currently looking at function graph and seeing if I can consolidate
> it too. And I'm also trying to get multiple uses to hook into its
> infrastructure. I think I finally figured out a way to do so.
> 
> The reason it is difficult, is that you need to maintain state between
> the entry of a function and the exit for each task and callback that is
> registered. Hence, it's a 3x tuple (function stack, task, callbacks).
> And this must be maintained with preemption. A task may sleep for
> minutes, and the state needs to be retained.
> 
> The only state that must be retained is the function stack with the
> task, because if that gets out of sync, the system crashes. But the
> callback state can be removed.
> 
> Here's what is there now:
> 
>  When something is registered with the function graph tracer, every
>  task gets a shadowed stack. A hook is added to fork to add shadow
>  stacks to new tasks. Once a shadow stack is added to a task, that
>  shadow stack is never removed until the task exits.
> 
>  When the function is entered, the real return code is stored in the
>  shadow stack and the trampoline address is put in its place.
> 
>  On return, the trampoline is called, and it will pop off the return
>  code from the shadow stack and return to that.
> 
> The issue with multiple users, is that different users may want to
> trace different functions. On entry, the user could say it doesn't want
> to trace the current function, and the return part must not be called
> on exit. Keeping track of which user needs the return called is the
> tricky part.
> 
> Here's what I plan on implementing:
> 
>  Along with a shadow stack, I was going to add a 4096 byte (one page)
>  array that holds 64 8 byte masks to every task as well. This will allow
>  64 simultaneous users (which is rather extreme). If we need to support
>  more, we could allocate another page for all tasks. The 8 byte mask
>  will represent each depth (allowing to do this for 64 function call
>  stack depth, which should also be enough).
> 
>  Each user will be assigned one of the masks. Each bit in the mask
>  represents the depth of the shadow stack. When a function is called,
>  each user registered with the function graph tracer will get called
>  (if they asked to be called for this function, via the ftrace_ops
>  hashes) and if they want to trace the function, then the bit is set in
>  the mask for that stack depth.
> 
>  When the function exits the function and we pop off the return code
>  from the shadow stack, we then look at all the bits set for the
>  corresponding users, and call their return callbacks, and ignore
>  anything that is not set.
> 
> 
> When a user is unregistered, it the corresponding bits that represent
> it are cleared, and it the return callback will not be called. But the
> tasks being traced will still have their shadow stack to allow it to
> get back to normal.
> 
> I'll hopefully have a prototype ready by plumbers.

Why do we need multiple users?  It would be a lot simpler if we could
just enforce a single user per fgraphed/kretprobed function (and return
-EBUSY if it's already being traced/probed).

> And this too will require each architecture to probably change. As a
> side project to this, I'm going to try to consolidate the function
> graph code among all the architectures as well. Not an easy task.

Do you mean implementing HAVE_FUNCTION_GRAPH_RET_ADDR_PTR for all the
arches?  If so, I think have an old crusty patch which attempted to
that.  I could try to dig it up if you're interested.

-- 
Josh
