Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED76C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A870218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfADSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:05:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:05:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A87FC37EE0;
        Fri,  4 Jan 2019 18:05:54 +0000 (UTC)
Received: from localhost (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F81A1001F3C;
        Fri,  4 Jan 2019 18:05:51 +0000 (UTC)
Date:   Fri, 4 Jan 2019 19:05:44 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
Message-ID: <20190104190544.4b0bfaee@redhat.com>
In-Reply-To: <CACT4Y+bq+X6UFTWmbGz1V0GAjPXizxfk_pLqcq8KkDkp3K-ERg@mail.gmail.com>
References: <000000000000513fb7057e8d7013@google.com>
        <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
        <20190103210743.6518841e@redhat.com>
        <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
        <20190103225404.66b0ec9f@redhat.com>
        <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
        <20190104115435.478b4b4a@redhat.com>
        <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
        <20190104181424.5ad4b1de@redhat.com>
        <CACT4Y+bq+X6UFTWmbGz1V0GAjPXizxfk_pLqcq8KkDkp3K-ERg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 04 Jan 2019 18:05:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 18:26:16 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Fri, Jan 4, 2019 at 6:14 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Fri, 4 Jan 2019 12:05:04 +0100
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > I've added these as tests:
> > >
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/341
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/342
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/343
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/344
> > >
> > > Will try to figure out how to distinguish them from true corrupted
> > > reports. Usually when Call Trace does not have any frames, it's a sign
> > > of a corrupted report, and in other crashes we see the same report but
> > > with a stack trace. But some stack-corruption-related reliably don't
> > > have stack traces (not corrupted). But then some other
> > > stack-corruption-related crashes do have stack traces, and for these
> > > no stack trace again means a corrupted kernel output. Amusingly this
> > > is one of the most complex parts of syzkaller.  
> >
> > I'm not sure how complicated that would be, but what about some metric
> > based on valid symbol names being reported?  
> 
> Please elaborate. What do you mean by "valid symbol names"?

I mean a symbol name listed in /proc/kallsyms on the running system.

This is usually my minimum threshold for "I can do something with this
report" -- which doesn't mean it's necessarily valid, but well, if you
have that, it means that at least something worked in the reporting,
and you can at least start having a look at a specific function.

> Note that corrupted output detection solves 2 problems:
> 1. Do we think the output is truncated to the point of being not useful?
> E.g. sometimes kernel produces just 1 line:
> 
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> 
> This is sure a crash, but it's not too useful to report.

Sure. In those tests above you have:
- 341: udp6_lib_lookup2+0x622, handle_irq+0x2cb
- 342: __sanitizer_cov_trace_pc+0x8, handle_irq+0x2cb
- 343: __udp6_lib_err, etc.
- 344: __udp6_lib_lookup+0x1d, etc.

and this makes all those reports at least minimally useful.

> 2. Do we have any reasons to think we extracted bogus crash identity?
> E.g. crash intermixed with output from another thread so that we say
> "something-bad in function foo", when in fact function foo come from
> output of the second non-crashing thread.

Okay, this looks way more complicated :)

-- 
Stefano
