Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C6ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A69520831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A69520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJ1RSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:18:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeJ1RSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:18:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id n5-v6so5314027wrw.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 01:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILCb/eJh1SVgF/PZMp29WCxb/WlQZWxjcUY/KIBpTVk=;
        b=XCCR3dyYn2WP074IOSJwtkcrS8Wq60OCeql5RBTJW+qSaUgGH8aepsvk1dQko3Je/p
         rhnWKEMBqxaAZELCKYxLzUlL1/z7IWoo2+7+aExO7gkOlT5ZoklJmGWAO11RjxqhIBP8
         smQWVqE4epKhMY6SuIkCWMxIOyV7tj2QbKz+95QMPwrUrRB3TGK76lS3tahXkdBgDHkz
         DJaWWwcVPDLqp8WGd7ZNVOb9K5PpAEEpw1oQAVBy/GdBs+G2vFDF3iUNZwr7JPxIm1Ih
         GS9pQxIboG3kzx6ywr0cp1s9mSUi/z0fHrx3fWr0aSUf+tY6JquGFf0TLnl6TGGYS44V
         XxTA==
X-Gm-Message-State: AGRZ1gIvL7IGFjamWWgoPVyt6WPah4pW3Ef60vbLgN/kLZVptB52Ergq
        VG7lyvRsYIFbHgaB0nJANJsqKQ==
X-Google-Smtp-Source: AJdET5dxHKeh9gTGp0GijX2TnvX3+rOK1YMYn9bGYFrVE/c19izlm9tPb2ciZGFPf1t+Do6FMruXeA==
X-Received: by 2002:adf:8304:: with SMTP id 4-v6mr10722487wrd.285.1540715642118;
        Sun, 28 Oct 2018 01:34:02 -0700 (PDT)
Received: from localhost.localdomain ([151.35.247.48])
        by smtp.gmail.com with ESMTPSA id c9-v6sm11942692wrh.50.2018.10.28.01.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 01:34:01 -0700 (PDT)
Date:   Sun, 28 Oct 2018 09:33:55 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nstange@suse.de,
        syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181028083355.GA30631@localhost.localdomain>
References: <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <CACT4Y+Y3uvX+Zb9nG_sYfbRXoxD1XR-1PLyitwm-UQyjGv5r1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y3uvX+Zb9nG_sYfbRXoxD1XR-1PLyitwm-UQyjGv5r1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/18 12:16, Dmitry Vyukov wrote:
> On Wed, Oct 24, 2018 at 1:03 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > On 19/10/18 22:50, luca abeni wrote:
> > > On Fri, 19 Oct 2018 13:39:42 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > On Thu, Oct 18, 2018 at 01:08:11PM +0200, luca abeni wrote:
> > > > > Ok, I see the issue now: the problem is that the "while
> > > > > (dl_se->runtime <= 0)" loop is executed at replenishment time, but
> > > > > the deadline should be postponed at enforcement time.
> > > > >
> > > > > I mean: in update_curr_dl() we do:
> > > > >   dl_se->runtime -= scaled_delta_exec;
> > > > >   if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > > >           ...
> > > > >           enqueue replenishment timer at dl_next_period(dl_se)
> > > > > But dl_next_period() is based on a "wrong" deadline!
> > > > >
> > > > >
> > > > > I think that inserting a
> > > > >         while (dl_se->runtime <= -pi_se->dl_runtime) {
> > > > >                 dl_se->deadline += pi_se->dl_period;
> > > > >                 dl_se->runtime += pi_se->dl_runtime;
> > > > >         }
> > > > > immediately after "dl_se->runtime -= scaled_delta_exec;" would fix
> > > > > the problem, no?
> > > >
> > > > That certainly makes sense to me.
> > >
> > > Good; I'll try to work on this idea in the weekend.
> >
> > So, we (me and Luca) managed to spend some more time on this and found a
> > few more things worth sharing. I'll try to summarize what we have got so
> > far (including what already discussed) because impression is that each
> > point might deserve a fix or at least consideration (just amazing how a
> > simple random fuzzer thing can highlight all that :).
> 
> 1. Fuzzing finds bugs in any code. Always.
> If a code wasn't fuzzed, there are bugs.
> 
> 2. This fuzzer is not so simple ;)

Indeed! I meant that it's amazing how the fuzzer was able to forge a
relatively simple reproducer that highlighted the problem.
