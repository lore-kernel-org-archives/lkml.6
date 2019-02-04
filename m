Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A481C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449132175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549308447;
	bh=GtjHPFhh9HvUOhV7g4JedWXXeo95wqLFwxk+LwOvsvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ntW60KqRXkcxk+btfm/OqpwP7N23YP3c0N8vFnLnOdY67U/W+FrvFb/54ixfm2uhV
	 ofgUk1N9Ldo/ggJ1Iyg+t+V0+g2kZ3NO7FvGTjqh1OxfwTCDqZs8DxmI9u846oHoOz
	 oGrXw09FXQ0weRCmnpVlb/biE6PvwmZ3WnMDNxTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfBDT1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfBDT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:27:25 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147DC20821;
        Mon,  4 Feb 2019 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549308444;
        bh=GtjHPFhh9HvUOhV7g4JedWXXeo95wqLFwxk+LwOvsvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4HwyPPIRXt+kctW/SHK+8jM4YbZe+5JnOk9cxlobny4kLkDtonHn+O2nwa1M8GmS
         ME1Z+KFo7gQLDNnd6CeUUhImmktfWUsP0sENEX/ek5Xb3jh0Ht9ZbuE47YyJfR9GEp
         vNHTE957W+0ImKMJCS60Bl4GjHRiiDSEQemmidRo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1F2634034F; Mon,  4 Feb 2019 16:27:21 -0300 (-03)
Date:   Mon, 4 Feb 2019 16:27:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
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
Message-ID: <20190204192721.GI5593@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava>
 <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 04, 2019 at 10:56:05AM -0800, Stephane Eranian escreveu:
> On Mon, Feb 4, 2019 at 3:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Feb 04, 2019 at 02:29:56PM +0300, Alexey Budankov wrote:
> > > On 04.02.2019 13:36, Jiri Olsa wrote:
> > > > On Mon, Feb 04, 2019 at 01:12:11PM +0300, Alexey Budankov wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> On 03.02.2019 18:30, Jiri Olsa wrote:
> > > >>> hi,
> > > >>> this patchset adds the --dir option to record command (and all
> > > >>> the other record command that overload cmd_record) that allows
> > > >>> the data to be stored in directory with multiple data files.
> > > >>>
> > > >>> It's next step for multiple threads implementation in record.
> > > >>> It's now possible to make directory data via --dir option, like:
> > > >>>
> > > >>>   $ perf record --dir perf bench sched messaging
> > > >>
> > > >> Is it possible to name data directory differently from perf.data
> > > >> e.g. using --output option, like this?
> > > >>
> > > >>   $ perf record --output result_1 --dir perf bench sched messaging
> > > >
> > > >
> > > > yep, it's taken into account:
> > > >
> > > > [jolsa@krava perf]$ ./perf record --output result_1 --dir ./perf bench sched messaging
> > > > Couldn't synthesize bpf events.
> > > > # Running 'sched/messaging' benchmark:
> > > > # 20 sender and receiver processes per group
> > > > # 10 groups == 400 processes run
> > > >
> > > >      Total time: 0.177 [sec]
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.316 MB result_1 (7225 samples) ]
> > > >
> > > > [jolsa@krava perf]$ ll result_1/
> > > > total 348
> > > > -rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
> > > > -rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
> > > > -rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
> > > > -rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
> > > > -rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
> > > > -rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
> > > > -rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
> > > > -rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
> > > > -rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header
> > >
> > > Awesome. What do you think about having it like this:
> > >
> > >   $ perf record --output result_1.data ... - writes data to a file
> > >
> > >   $ perf record --dir result_1 ... - or even
> > >   $ perf record --output_dir result_1 ... - writes data into a directory
> > >
> > > IMHO, this interface is simpler for a user.
> >
> > yep, seems more convenient.. I'll add it
> >
> But what happens if you do: perf record -o foo --output_dir foo.d?

Should fail, i.e. either you use single-file or directory output, I
think.

- Arnaldo
