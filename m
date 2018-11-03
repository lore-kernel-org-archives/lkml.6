Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9605C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4B20843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLCrB8lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D4B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeKDBqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeKDBqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:46:21 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4042082E;
        Sat,  3 Nov 2018 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541262874;
        bh=Iy6FmRR8ErwQkljBCA7TBtflb5SxeaOb6vsXk6FDi34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLCrB8lzfGqQ2SYSgHANtGqeAfb4/8MTo+6N5ETzqvfOY4MZgS8HeLazuYtOQxiHK
         t0tUeAOARqX+eUlXF3epNQjyBmtzesKHmi0eYO0tdc0LKyJugoH8a2bJgfTQeitY0y
         P4aCr0WRlaVSe2HvK8c4DqU41bPujqsafadIgQDM=
Date:   Sun, 4 Nov 2018 01:34:30 +0900
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
Message-Id: <20181104013430.9d3e91b8ebbae7dcb6860ef1@kernel.org>
In-Reply-To: <20181103091341.3d32683e@vmware.local.home>
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
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 09:13:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 3 Nov 2018 22:00:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 2 Nov 2018 12:13:07 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> 
> > > Because that means if function graph tracer is active, then you can't
> > > do a kretprobe, and vice versa. I'd really like to have it working for
> > > multiple users, then we could trace different graph functions and store
> > > them in different buffers. It would also allow for perf to use function
> > > graph tracer too.  
> > 
> > Steve, how woul you allow multiple users on it? Something like this?
> > 
> > ret_trampoline_multiple(){
> >    list_for_each(handler, &shadow_entry[i].handlers, list)
> > 	handler(shadow_entry[i]);
> >    restore_retval_and_jump_to(shadow_entry[i].orig);
> > }
> >
> 
> Something like that. But since it's not a single mapping between shadow
> entries and handlers, that is we have multiple tasks with multiple
> shadow entries and multiple handlers, we can't use a link list (two
> different parents per handler).

Yes, I understand it.

> I was thinking of a bitmask that represents the handlers, and use that
> to map which handler gets called for which shadow entry for a
> particular task.

Hmm, I doubt that is too complicated and not scalable. I rather like to see
the open shadow entry...

entry: [[original_retaddr][function][modified_retaddr]]

So if there are many users on same function, the entries will be like this 

[[original_return_address][function][trampoline_A]]
[[trampline_A][function][trampoline_B]]
[[trampline_B][function][trampoline_C]]

And on the top of the stack, there is trampline_C instead of original_return_address.
In this case, return to trampoline_C(), it jumps back to trampline_B() and then
it jumps back to trampline_A(). And eventually it jumps back to
original_return_address.

This way, we don't need allocate another bitmap/pages for the shadow stack.
We only need a shadow stack for each task.
Also, unwinder can easily find the trampline_C from the shadow stack and restores
original_return_address. (of course trampline_A,B,C must be registered so that
search function can skip it.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
