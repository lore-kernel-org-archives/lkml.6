Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69FC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B5A20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ6CWLla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B5A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeKCV61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeKCV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:58:26 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3852082D;
        Sat,  3 Nov 2018 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541249231;
        bh=4kFZzstXsgMX52crfgr2SgLTE8nfWAMQovMaHqknhgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pQ6CWLlaPBTJN0lKH1VrA1UN8MLf+pHsK2Q3pigQfLerq3qQZ2gZYSCQGVQD+Boro
         PK8j1k0G4ClvNJY1l/WRWBDhANkcDImJjv9t+PgsFBF4h/ggnmlOglXDFVHDjDyt1c
         XwNOBPc97nsOpciOk+u9qkO0egnXYfhOc3gueBmU=
Date:   Sat, 3 Nov 2018 21:47:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181103214707.e31f45fd5c87a2adab5857ae@kernel.org>
In-Reply-To: <20181102043733.qqimup5vuevjua5w@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
        <20181101211343.yooxwqfnoloprb5h@yavin>
        <20181102120441.d00af1b57e6a739d0e7c7a91@kernel.org>
        <20181102043733.qqimup5vuevjua5w@yavin>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 15:37:33 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Fri, 2 Nov 2018 08:13:43 +1100
> > Aleksa Sarai <cyphar@cyphar.com> wrote:
> > 
> > > On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > Please split the test case as an independent patch.
> > > 
> > > Will do. Should the Documentation/ change also be a separate patch?
> > 
> > I think the Documentation change can be coupled with code change
> > if the change is small. But selftests is different, that can be
> > backported soon for testing the stable kernels.
> > 
> > 
> > > > > new file mode 100644
> > > > > index 000000000000..03146c6a1a3c
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> > > > > @@ -0,0 +1,25 @@
> > > > > +#!/bin/sh
> > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > +# description: Kretprobe dynamic event with a stacktrace
> > > > > +
> > > > > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > > > > +
> > > > > +echo 0 > events/enable
> > > > > +echo 1 > options/stacktrace
> > > > > +
> > > > > +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> > > > > +grep teststackprobe kprobe_events
> > > > > +test -d events/kprobes/teststackprobe
> > > > 
> > > > Hmm, what happen if we have 2 or more kretprobes on same stack?
> > > > It seems you just save stack in pre_handler, but that stack can already
> > > > includes another kretprobe's trampline address...
> > > 
> > > Yeah, you're quite right...
> > > 
> > > My first instinct was to do something awful like iterate over the set of
> > > "kretprobe_instance"s with ->task == current, and then correct
> > > kretprobe_trampoline entries using ->ret_addr. (I think this would be
> > > correct because each task can only be in one context at once, and in
> > > order to get to a particular kretprobe all of your caller kretprobes
> > > were inserted before you and any sibling or later kretprobe_instances
> > > will have been removed. But I might be insanely wrong on this front.)
> > 
> > yeah, you are right. 
> > 
> > > 
> > > However (as I noted in the other thread), there is a problem where
> > > kretprobe_trampoline actually stops the unwinder in its tracks and thus
> > > you only get the first kretprobe_trampoline. This is something I'm going
> > > to look into some more (despite not having made progress on it last
> > > time) since now it's something that actually needs to be fixed (and
> > > as I mentioned in the other thread, show_stack() actually works on x86
> > > in this context unlike the other stack_trace users).
> > 
> > I should read the unwinder code, but anyway, fixing it up in kretprobe
> > handler context is not hard. Since each instance is on an hlist, so when
> > we hit the kretprobe_trampoline, we can search it.
> 
> As in, find the stored stack and merge the two? Interesting idea, though
> Steven has shot this down because of the associated cost (I was
> considering making it a kprobe flag, but that felt far too dirty).

I think we don't need the flag, we just need to register a trampoline and
the trampoline must restore(just pop) the original address from shadow
stack.
Also the stack unwinder query restored address from the stack if it
hits the unfamilier address (or registered address).

> > However, the problem is the case where the out of kretprobe handler
> > context. In that context we need to try to lock the hlist and search
> > the list, which will be a costful operation.
> 
> I think the best solution would be to unify all of the kretprobe-like
> things so that we don't need to handle non-kretprobe contexts for
> basically the same underlying idea. If we wanted to do it like this.

Yes, anyway, current kretprobe instance idea is not good, it requires
locks, and user must specify "enough amount of instances" for each
kretprobe.

> I think a potentially better option would be to just fix the unwinder to
> correctly handle kretprobes (like it handles ftrace today).

I think both can be fixed by same way.

> 
> > On the other hand, func-graph tracer introduces a shadow return address
> > stack for each task (thread), and when we hit its trampoline on the stack,
> > we can easily search the entry from "current" task without locking the
> > shadow stack (and we already did it). This may need to pay a cost (1 page)
> > for each task, but smarter than kretprobe, which makes a system-wide 
> > hash-table and need to search from hlist which has return addresses
> > of other context coexist.
> 
> Probably a silly question (I've been staring at the function_graph code
> trying to understand how it handles return addresses -- and I'm really
> struggling), is this what ->ret_stack (and ->curr_ret_stack) do?

Yes.

> 
> Can you explain how the .retp handling works, because I'm really missing
> how the core arch/ hooks know to pass the correct retp value.

Sure, the current->ret_stack can be an hidden stack array, it will save the original
return address, function address and the modified address for each entry.
(Kretprobe can be searched by function address.)

Stack unwinder will check the unwinded stack entry on comparing with
current->ret_stack[i].retp and if it is same, it can find the original return
address from ret_stack[i].ret.

This should make things simpler and solve in generic way.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
