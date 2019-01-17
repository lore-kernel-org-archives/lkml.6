Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A420855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfAQJS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:18:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfAQJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:18:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8873AB655;
        Thu, 17 Jan 2019 09:18:26 +0000 (UTC)
Received: from krava (ovpn-204-223.brq.redhat.com [10.40.204.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id D5F2860F8A;
        Thu, 17 Jan 2019 09:18:24 +0000 (UTC)
Date:   Thu, 17 Jan 2019 10:18:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, acme@kernel.org
Subject: Re: perf segfault in in ordered_events__free()
Message-ID: <20190117091823.GB16366@krava>
References: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
 <20190116213425.GA16366@krava>
 <CAPhsuW6g9FOXvWA=9_Ab7Qo2B=DHraTPCT_ekmywF8soZz90=A@mail.gmail.com>
 <CAPhsuW7AktPKcw6KG7kRm-5Jm_TnhdPczT_G8fP3c49jT0DqWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7AktPKcw6KG7kRm-5Jm_TnhdPczT_G8fP3c49jT0DqWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 09:18:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:33:55PM -0800, Song Liu wrote:
> On Wed, Jan 16, 2019 at 1:53 PM Song Liu <liu.song.a23@gmail.com> wrote:
> >
> > Thanks Jiri!
> >
> > On Wed, Jan 16, 2019 at 1:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 10:57:49AM -0800, Song Liu wrote:
> > > > Hi,
> > > >
> > > > We are debugging a segfault of perf in ordered_events__free().
> > >
> > > hi,
> > > any backtrace or info on how to reproduce it?
> >
> > Here is the backtrace:
> >
> > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
> > #1  0x0000000000500196 in ordered_events.reinit ()
> > #2  0x00000000004fe413 in perf_session.process_events ()
> > #3  0x0000000000440431 in cmd_record ()
> > #4  0x00000000004a439f in run_builtin ()
> > #5  0x000000000042b3e5 in main ()"
> >
> > >
> > > > Disassemble shows the segfault was caused by oe->buff == NULL
> > > > in the following line:
> > > >
> > > >         /*
> > > >          * Current buffer might not have all the events allocated
> > > >          * yet, we need to free only allocated ones ...
> > > >          */
> > > >         list_del(&oe->buffer->list);
> > > >
> > > > After poking around the code, I suspect it is caused by the following
> > > > condition in alloc_event():
> > > >
> > > >         } else if (oe->buffer) {
> > > >                 new = &oe->buffer->event[oe->buffer_idx];
> > > >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> > > >                         oe->buffer = NULL;
> > >
> > >
> > > argh.. yea, we need to check oe->buffer in ordered_events__free
> > >
> > > would attached change fix it for you?
> >
> > Let me try roll a fixed version to confirm.
> 
> Yes, the patch fixes this segfault. Please CC me on the official patch to
> back port the official version.

thanks for testing, will post it today

jirka
