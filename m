Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1579FC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67CE20820
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="coLW0SK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67CE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeKBMKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeKBMKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:10:19 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C39520657;
        Fri,  2 Nov 2018 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541127886;
        bh=5yoh2QqeUskIX0mOuJvCADphgslvrmNqjFp1M6kqTQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=coLW0SK56O9XhxI/Uf/pIwSd+krVlxuXGm1oxDLUkTOJ3VoNglBjeQ2YLtgb0hZ5a
         1pgfeM9pu9LE9gMKvR7YD0Job0rN24O/9XIMNLE1DX4A7i8xvE1OG7rHnCxGJDe56+
         8PEckxDgbEubeLXLLWZK2cBg90k/f420MZe8aY5o=
Date:   Fri, 2 Nov 2018 12:04:41 +0900
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
Message-Id: <20181102120441.d00af1b57e6a739d0e7c7a91@kernel.org>
In-Reply-To: <20181101211343.yooxwqfnoloprb5h@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
        <20181101211343.yooxwqfnoloprb5h@yavin>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 08:13:43 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > Please split the test case as an independent patch.
> 
> Will do. Should the Documentation/ change also be a separate patch?

I think the Documentation change can be coupled with code change
if the change is small. But selftests is different, that can be
backported soon for testing the stable kernels.


> > > new file mode 100644
> > > index 000000000000..03146c6a1a3c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> > > @@ -0,0 +1,25 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +# description: Kretprobe dynamic event with a stacktrace
> > > +
> > > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > > +
> > > +echo 0 > events/enable
> > > +echo 1 > options/stacktrace
> > > +
> > > +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> > > +grep teststackprobe kprobe_events
> > > +test -d events/kprobes/teststackprobe
> > 
> > Hmm, what happen if we have 2 or more kretprobes on same stack?
> > It seems you just save stack in pre_handler, but that stack can already
> > includes another kretprobe's trampline address...
> 
> Yeah, you're quite right...
> 
> My first instinct was to do something awful like iterate over the set of
> "kretprobe_instance"s with ->task == current, and then correct
> kretprobe_trampoline entries using ->ret_addr. (I think this would be
> correct because each task can only be in one context at once, and in
> order to get to a particular kretprobe all of your caller kretprobes
> were inserted before you and any sibling or later kretprobe_instances
> will have been removed. But I might be insanely wrong on this front.)

yeah, you are right. 

> 
> However (as I noted in the other thread), there is a problem where
> kretprobe_trampoline actually stops the unwinder in its tracks and thus
> you only get the first kretprobe_trampoline. This is something I'm going
> to look into some more (despite not having made progress on it last
> time) since now it's something that actually needs to be fixed (and
> as I mentioned in the other thread, show_stack() actually works on x86
> in this context unlike the other stack_trace users).

I should read the unwinder code, but anyway, fixing it up in kretprobe
handler context is not hard. Since each instance is on an hlist, so when
we hit the kretprobe_trampoline, we can search it. However, the problem
is the case where the out of kretprobe handler context. In that context
we need to try to lock the hlist and search the list, which will be a
costful operation.

On the other hand, func-graph tracer introduces a shadow return address
stack for each task (thread), and when we hit its trampoline on the stack,
we can easily search the entry from "current" task without locking the
shadow stack (and we already did it). This may need to pay a cost (1 page)
for each task, but smarter than kretprobe, which makes a system-wide 
hash-table and need to search from hlist which has return addresses
of other context coexist.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
