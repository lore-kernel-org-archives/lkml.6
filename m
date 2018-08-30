Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA63C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C51205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C51205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH3Ec4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:32:56 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:57138 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725760AbeH3Ec4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:32:56 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 30 Aug 2018 09:33:27 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 30 Aug 2018 09:33:27 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Thu, 30 Aug 2018 09:33:27 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@lge.com
Subject: Re: [RFC] perf script: callchain handling is not useful
Message-ID: <20180830003327.GA3164@sejong>
References: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
 <20180829135440.GA25381@kernel.org>
 <CABPqkBQ1iTg3bkovUykg86r0kj6jaVbb_f=BCVHrLN+=S5jVZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPqkBQ1iTg3bkovUykg86r0kj6jaVbb_f=BCVHrLN+=S5jVZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 29, 2018 at 08:14:12AM -0700, Stephane Eranian wrote:
> On Wed, Aug 29, 2018 at 6:54 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Aug 28, 2018 at 07:41:31PM -0700, Stephane Eranian escreveu:
> > > Hi,
> > >
> > > I am doing the following simple collection with callchain and load profiling:
> > >
> > > $ perf record -g -d -e cpu/event=0xd0,umask=0x81/pp  my_test_program
> > >
> > > But when I type:
> > > $ perf script -F ip,addr
> > > ffff9d4821346878
> > >         ffffffff9d58df25
> > >         ffffffff9d58e054
> > >         ffffffff9d5965bb
> > >         ffffffff9d640650
> > >         ffffffff9d697d06
> > >         ffffffff9d63ec60
> > >         ffffffff9d640322
> > >         ffffffff9d64070c
> > >         ffffffff9d455a60
> > >                   7030c7
> > >
> > > ffff9d4638ba84a0
> > >         ffffffff9d5df447
> > >         ffffffff9d5eaf4a
> > >         ffffffff9d63e165
> > >         ffffffff9d63e439
> > >         ffffffff9d697d98
> > >         ffffffff9d63ec60
> > >         ffffffff9d640322
> > >         ffffffff9d64070c
> > >         ffffffff9d455a60
> > >                   7030c7
> > > I also see the callchain and it is not clear which is the IP. Further
> > > more parsing becomes more difficult because of multiple lines per
> > > sample. I understand that multiline is likely because of
> > > symbolization. But if I don't want symbolization, it should be
> > > possible to print all in one line.
> >
> > Humm, to have this not break possibly existing scripts, perhaps we can
> > have something like:
> >
> >   $ perf script -F ip,-callchain,addr
> >
> > ?
> >
> > And if asked explicitely for the callchain, then it gets added in the
> > same line?
> >
> Yeah, that should do it.
> Thanks.

I found this:

  $ perf script -h |& grep -A1 hide
      -G, --hide-call-graph
                            When printing symbols do not display call chain

Thanks,
Namhyung
