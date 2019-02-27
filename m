Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2108218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551253271;
	bh=BBttdwTTIXFnjU60YriEcQyzD1qTLiLbVhzSA4bURQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UGSAyJJvj14EwoiDC/qSSyVsruxO7En31UhPxIZyAHtxhl9/P0Bl6HVb/IYflcche
	 R7f18jObvXmrF8kL64bIEZstJrvTTUZ6A1uARq/MgHvBCEtggtV2Xkph1uo+S7Mlvm
	 +AYDg4YEosBQ6vzvWBjeEzMHIyfEIy4mjbwOKIZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfB0HlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfB0HlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:41:09 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D887C218CD;
        Wed, 27 Feb 2019 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551253267;
        bh=BBttdwTTIXFnjU60YriEcQyzD1qTLiLbVhzSA4bURQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K434MlMQ69Emiwvxm8W0K7tXkMjo6HeNzYaZ1JXVdT9j2xCoHAchs2kWBq1Je4kC7
         f9KVEHEbV5I3DhCTtwiaENNezy+I5e8sldl75XBGbgnnFGV6DKNiJWQ66o4AvEmuED
         UN0pJR0iPaBWrj+FkWYJY41wEbP87gtbaG8gAc6k=
Date:   Wed, 27 Feb 2019 16:41:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space
 access
Message-Id: <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
In-Reply-To: <20190226213850.GA219025@google.com>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
        <20190226213850.GA219025@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 16:38:50 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Mon, Feb 25, 2019 at 11:04:42PM +0900, Masami Hiramatsu wrote:

> > Note that kprobe event provides these methods, but it doesn't
> > change it from kernel to user automatically because we do not
> > know whether the given address is in userspace or kernel on
> > some arch.
> > Moreover, from perf-probe, at this moment it is not able to
> > switch. Since __user is not for compiler but checker, we have
> > no clue which data structure is in user-space, in debuginfo.
> > 
> > BTW, according to Linus's comment, I implemented probe_user_read()
> > and strncpy_from_unsafe_user() APIs. And since those use
> > "access_ok()" inside it, if CONFIG_DEBUG_ATOMIC_SLEEP=y on x86,
> > it will get a warn message at once. It should be solved before
> > merging this series.
> 
> I was wondering why access_ok() can sleep. In the arm64 and x86
> implementation, I don't see access_ok() itself causing a user pointer
> dereference access that can cause a page fault. It seems to just be checking
> the validity of the ranges.
> 
> Any idea why the access_ok() code has these comments?
> "Context: User context only. This function may sleep if pagefaults are
> enabled."

Because access_ok() is used only for preparing accessing user-space,
and the user-space access may cause page-fault and sleep.

IMHO, checking in access_ok() inside it is reasonable, but as it
commented, it is for "if pagefaults are enabled.". What we need another 
access_ok() for the case when pagefaults are disabled, that is what PeterZ
suggested in below mail.

https://lore.kernel.org/lkml/20190225150603.GE32494@hirez.programming.kicks-ass.net/T/#u


Thank you,

> 
> My _guess_ is this is because whatever calls access_ok() may also call
> something else that *does* fault next, if that's the case then that
> WARN_ON_IN_IRQ() in access_ok() is fine, but at least I guess the comments
> should be more clear that it is not access_ok() itself that sleeps.
> 
> thanks for any help on understanding this,
> 
>  - Joel
> 
> 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >       uaccess: Make sure kernel_uaccess_faults_ok is updated before pagefault
> >       uaccess: Add non-pagefault user-space read functions
> >       tracing/probe: Add ustring type for user-space string
> >       tracing/probe: Support user-space dereference
> > 
> > 
> >  Documentation/trace/kprobetrace.rst  |   13 ++-
> >  Documentation/trace/uprobetracer.rst |    9 +-
> >  fs/namespace.c                       |    2 
> >  include/linux/uaccess.h              |   13 +++
> >  kernel/trace/trace.c                 |    7 +-
> >  kernel/trace/trace_kprobe.c          |   65 ++++++++++++++++
> >  kernel/trace/trace_probe.c           |   39 ++++++++--
> >  kernel/trace/trace_probe.h           |    3 +
> >  kernel/trace/trace_probe_tmpl.h      |   36 +++++++--
> >  kernel/trace/trace_uprobe.c          |   19 +++++
> >  mm/maccess.c                         |  138 ++++++++++++++++++++++++++++++----
> >  11 files changed, 302 insertions(+), 42 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
