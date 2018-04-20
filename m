Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeDTSTa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:19:30 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35848 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbeDTST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:19:27 -0400
X-Google-Smtp-Source: AIpwx4+1ItbuUdIszMK9OHZi/HwDgE7GI5wvM1VidldxAs2uEggnu3kykRZF75q5HmDeHfS07s1Lq+x56zfxJXERldw=
MIME-Version: 1.0
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
 <20180417062010.GA2052@krava> <alpine.DEB.2.21.1804181109100.1587@macbook-air>
 <20180420083607.GG4064@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1804201015250.22578@macbook-air>
 <alpine.DEB.2.21.1804201247050.28907@macbook-air>
In-Reply-To: <alpine.DEB.2.21.1804201247050.28907@macbook-air>
From: Stephane Eranian <eranian@google.com>
Date: Fri, 20 Apr 2018 18:19:13 +0000
Message-ID: <CABPqkBSA8-kvMtiPfWZ6bJCqL9TSJP=d3mLxd4MNOQyd1Kd-rg@mail.gmail.com>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 9:51 AM Vince Weaver <vincent.weaver@maine.edu>
wrote:

> On Fri, 20 Apr 2018, Vince Weaver wrote:

> > > AFAICT it works on Power and possibly ARM.
> >
> > at least some ARMs are a bit more honest about it than x86
> >
> > ivybridge:
> >       Performance counter stats for '/bin/ls':
> >       1,368,162      instructions
> >       1,368,162      instructions:I
> >
> > pi2/ARM cortex-A7
> >       Performance counter stats for '/bin/ls':
> >       1,910,083      instructions
> >       <not supported>      instructions:I
> >
> > I'd fire up my Power8 machine to see but not sure it's worth the hassle
> > and/or having to get out the ear protection.

> I did power up the Power8 machine in the end:

> power8:
>          perf stat -e cycles,cycles:I sleep 5
>          Performance counter stats for 'sleep 5':
>          14,271,273      cycles
>          14,271,273      cycles:I

> ???

> But then if I try again on power8

>          perf stat -a -e cycles,cycles:I sleep 5
>           Performance counter stats for 'system wide':
>          1,238,772,322,327      cycles
>          1,238,674,771,713      cycles:I

> there is a difference.

> But then on ivybridge

>          perf stat -a -e cycles,cycles:I sleep 5
>          Performance counter stats for 'system wide':
>          589,598,104      cycles
>          589,537,190      cycles:I

This may be noise.

The way the flag is named leads me to believe its goal is to not count when
executing in the context of the idle task (pid 0 on each CPU).
However, it does not seem to be implemented that way. If you were to
implement this, then in system wide mode you'd have to check
the incoming task on ctxsw, very much like we do in cgroup monitoring. So
it would not be totally free. One can argue, in sampling mode
you can eliminate the samples coming from PID=0 in the tool. But there
would be nothing to cover counting mode.

Interestingly, there is also code in perf tool to exclude known idle
routines from reporting. But this is targeted to only some routines that the
idle task may end up executing. so it is not quite the same.


> So maybe exclude_idle does do something on x86?  Or am I completely
> misunderstanding what the flag is supposed to be indicating?

> Vince
