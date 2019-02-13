Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38821B68
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfBMDqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfBMDqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:46:45 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144F221B1A;
        Wed, 13 Feb 2019 03:46:44 +0000 (UTC)
Date:   Tue, 12 Feb 2019 22:46:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in event_function_local
Message-ID: <20190212224642.6a0a5360@vmware.local.home>
In-Reply-To: <CAGXu5j+Z=ns37DdNU-mYtfio1cW4c25jyAGwFx74YFXKM5SD1A@mail.gmail.com>
References: <001a1140589435c9b60563c76e3f@google.com>
        <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
        <CAGXu5jJ-+P+p_SsO1X-LJ43RbEG2cYbiV_EYubWoh3mUVRBK9A@mail.gmail.com>
        <20190212211449.5f48bee1@gandalf.local.home>
        <CAGXu5j+Z=ns37DdNU-mYtfio1cW4c25jyAGwFx74YFXKM5SD1A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 19:40:12 -0800
Kees Cook <keescook@chromium.org> wrote:

 
> > > Steve, what could possibly be happening here? Just adding more
> > > tracepoints causes some kind of race where the task vs current test
> > > trips in event_function_local():
> > >
> > >                         if (WARN_ON_ONCE(task != current))
> > >                                 goto unlock;  
> >
> > That's perf code. How are you getting there? What's special about this
> > run? You have perf running?  
> 
> Yes, the reproducer is in an 8-way parallel tight loop, doing:
> 
>   fd = syscall(__NR_perf_event_open, 0x20000140, 0, 0, -1, 0);
>   syscall(__NR_ioctl, fd, 0x2402, 0x100000001);
> 
> I haven't decoded the structures that are passed in, but I'm at a loss
> for how changing how many trace entries there are could impact the
> race timing... O_o
> 
> > > Is this maybe just an unlucky condition with the event loop running in
> > > an IRQ? Should the WARN be expected, or is running under an IRQ
> > > unexpected?  
> 
> Is perf expected to fire during an IRQ? The task == current test seems
> suspicious if so...
> 

That's a question for Peter.

-- Steve
