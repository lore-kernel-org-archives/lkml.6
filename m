Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A62AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603D8218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfADROe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:14:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfADROd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:14:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F201281DE2;
        Fri,  4 Jan 2019 17:14:32 +0000 (UTC)
Received: from localhost (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91CC8101F97D;
        Fri,  4 Jan 2019 17:14:29 +0000 (UTC)
Date:   Fri, 4 Jan 2019 18:14:24 +0100
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
Message-ID: <20190104181424.5ad4b1de@redhat.com>
In-Reply-To: <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
References: <000000000000513fb7057e8d7013@google.com>
        <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
        <20190103210743.6518841e@redhat.com>
        <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
        <20190103225404.66b0ec9f@redhat.com>
        <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
        <20190104115435.478b4b4a@redhat.com>
        <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 04 Jan 2019 17:14:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 12:05:04 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Fri, Jan 4, 2019 at 11:54 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Fri, 4 Jan 2019 11:32:12 +0100
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> >  
> > > On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:  
> > > >
> > > > On Thu, 3 Jan 2019 15:15:06 -0600
> > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > >  
> > > > > syzbot generated stack traces with
> > > > >
> > > > > [  183.517380]  udpv6_err+0x46/0x60
> > > > > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > > > > [  183.525054]  gue6_err_proto_handler+0x199/0x280  
> > > >
> > > > Where? I can't find that in any logs linked from the dashboard at
> > > > https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(  
> > >
> > > Stefano, there are these 4 bugs reported that have similarly looking
> > > reproducers involving udp sockets and that crash modes that looks like
> > > stack corruption/overflow:
> > >
> > > https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> > > https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
> > > https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
> > > https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> > >
> > > Are these the same bug as this?  
> >
> > Judging from the reproducers for the first three, they seem to be.  
> 
> OK, then I will mark them as dups of this one.

syzbot just finished the tests I requested and couldn't reproduce the
first three issues with the fix I posted (fou6: Prevent unbounded
recursion in GUE error handler).

This should prove they are in fact the same issue.

> > I
> > guess I can trigger tests also for those by sending a (sharp)syz
> > test ... e-mail with the patch to the Reported-by: addresses, right?  
> 
> Correct.
> These should be on LKML, but as you noted you can just add the syzbot
> email with tag to TO/CC. That email is available in the Reported-by
> tag (and also shown on the dashboard).

Okay, thanks for confirming.

> > And the three reports you pointed out from the pile of corrupted
> > reports also seem to match, others look unrelated.  
> 
> I've added these as tests:
> 
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/341
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/342
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/343
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/344
> 
> Will try to figure out how to distinguish them from true corrupted
> reports. Usually when Call Trace does not have any frames, it's a sign
> of a corrupted report, and in other crashes we see the same report but
> with a stack trace. But some stack-corruption-related reliably don't
> have stack traces (not corrupted). But then some other
> stack-corruption-related crashes do have stack traces, and for these
> no stack trace again means a corrupted kernel output. Amusingly this
> is one of the most complex parts of syzkaller.

I'm not sure how complicated that would be, but what about some metric
based on valid symbol names being reported?

-- 
Stefano

