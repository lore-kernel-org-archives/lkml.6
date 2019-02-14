Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73483C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461802082F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393051AbfBNLe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:34:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfBNLe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:34:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 381BC3D945;
        Thu, 14 Feb 2019 11:34:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21C6060BE7;
        Thu, 14 Feb 2019 11:34:51 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:34:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190214113450.GC26714@krava>
References: <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava>
 <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava>
 <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava>
 <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Feb 2019 11:34:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:43:22PM -0800, Stephane Eranian wrote:
> On Mon, Feb 11, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 04:32:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Feb 11, 2019 at 07:53:06PM +0100, Jiri Olsa escreveu:
> > > > On Mon, Feb 11, 2019 at 10:34:16AM -0800, Stephane Eranian wrote:
> > > > > On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> > > > > > I think all could be added and worked around with exception
> > > > > > of BUILD_ID, which we store at the end (after processing
> > > > > > all data) and we need it early in the report phase
> > >
> > > > > Buildids are injected after the fact via perf inject when in pipe mode.
> > >
> > > > > > maybe it's time to re-think that buildid -> mmap event
> > > > > > association again, because it's pain in current implementation
> > > > > > as well
> > >
> > > > > Sure, but what do you propose?
> > >
> > > > this:
> > > >
> > > > > > looks like bpf code is actualy getting build ids and storing
> > > > > > it for the callchains in kernel.. we can check if we can do
> > > > > > something similar for mmap events
> > >
> > > kernel/bpf/stackmap.c
> > >
> > > /* Parse build ID from 64-bit ELF */
> > > static int stack_map_get_build_id_64(void *page_addr,
> > >                                      unsigned char *build_id)
> > >
> > > yeah, wasn't aware of that, good thing doing backports, huh? :-)
> > >
> > > So do you thing about having a PERF_SAMPLE_BUILDID in sample_type and go
> > > and stash that thing in PERF_RECORD_MMAP2?
> >
> That would be special processing. Normally the sample_type go into
> each RECORD_SAMPLE.
> So I would not recommend this approach.
> 
> > I thought having new MMAP3 event version with buildid field in it
> > if available and/or enabled by bit in perf_event_attr
> >
> I think MMAP3 is a cleaner approach, though it adds yet another MMAP event.

actually I realized this might not help at the end at all

what we do now is that we scan the data (after it's recorded)
to get the list of binaries that got touched during the profile
and store those in .debug cache based on the build ids

we can't just store ALL of the binaries that the session comes
across via mmap events

I can see the build id in mmap helping to resolve the race
issue when some binary change during the profile session and
we have no idea and report on wrong one.. but I dont see
people complaining about this at all

jirka
