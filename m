Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A833C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A0220866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A0220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeINNkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:40:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6F4588304;
        Fri, 14 Sep 2018 08:26:56 +0000 (UTC)
Received: from krava (unknown [10.40.205.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B07C30912F4;
        Fri, 14 Sep 2018 08:26:54 +0000 (UTC)
Date:   Fri, 14 Sep 2018 10:26:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914082653.GG24224@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 14 Sep 2018 08:26:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 07:10:35PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 13.09.2018 15:54, Jiri Olsa wrote:
> > hi,
> > sending *RFC* for threads support in perf record command.
> > 
> > In big picture this patchset adds perf record --threads
> > option that allows to create threads in following modes:
> > 
> > 1) single thread mode (current)
> > 
> >   $ perf record ...
> >   $ perf record --threads=1 ...
> > 
> >   - all maps are read/stored under process thread
> > 
> > 2) mode with specific (X) number of threads
> > 
> >   $ perf record --threads=X ...
> > 
> >   - maps are spread equaly among threads
> > 
> > 3) mode that creates thread for every monitored memory map
> > 
> >   $ perf record --threads ...
> > 
> >   - which in perf record is equal to number of CPUs, and
> >     it pins each thread to its map's cpu:
> > 
> > 4) TODO - NUMA aware threads/maps separation
> >    ...
> > 
> > The perf.data stays as a single file.
> > 
> > v2 changes:
> >   - rebased to current Arnaldo's perf/core
> >     (also based on few fixes from my perf/core, see the branch details below)
> > 
> > This patchset contains lot of preparation changes to make
> > threaded record possible:
> > 
> >   - Namhyung's changes to create multiple data streams in
> >     perf data file, which allows having each thread data
> >     being stored in separate files and merged into single
> >     perf data after
> > 
> >   - Namhyung's changes to create track mmaps for auxiliary
> >     events
> > 
> >   - Namhyung's changes to search for threads/mmaps/comms
> >     using the time. This is needed because we have now
> >     multiple data streams which are processed separately,
> >     but they all need access to complete auxiliary events
> >     data (threads/mmaps/comms). That's also a reason why
> >     the auxiliary events are stored into separate data
> >     stream, which is processed before real data.
> > 
> >   - the rest of the code that adds threads abstraction into
> >     record command allows to create them and distribute maps
> >     among them
> > 
> >   - other preparational changes
> > 
> > The threaded monitoring currently can't monitor backward maps
> > and there are probably more limitations which I haven't spotted
> > yet.
> > 
> > So far I tested on laptop:
> >   http://people.redhat.com/~jolsa/record_threads/test-4CPU.txt
> > 
> > and a one bigger server:
> >   http://people.redhat.com/~jolsa/record_threads/test-208CPU.txt
> > 
> > I can see decrease in recorded LOST events, but both the benchmark
> > and the monitoring must be carefully configured wrt:
> >   - number of events (frequency)
> >   - size of the memory maps
> >   - size of events (callchains)
> >   - final perf.data size
> > 
> > It's also available in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/record_threads
> > 
> > thoughts? ;-) thanks
> > jirka
> 
> It is preferable to split into smaller pieces that bring 
> some improvement proved by metrics numbers and ready for 
> merging and upstream. Do we have more metrics than the 
> data loss from trace AIO patches?

well the primary focus is to get more events in,
so the LOST metric is the main one

> 
> There is usage of Posix threading API but there is no 
> its implementation in the patch series, to avoid dependency 
> on externally coded designs in the core of the tool.

well, we use pthreads in here, bt it's really not that
much code.. we could make that generic in future if needed

jirka
