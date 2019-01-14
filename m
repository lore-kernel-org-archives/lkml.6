Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfANLD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:03:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbfANLD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:03:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F403C070E1E;
        Mon, 14 Jan 2019 11:03:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0C9419C7C;
        Mon, 14 Jan 2019 11:03:25 +0000 (UTC)
Date:   Mon, 14 Jan 2019 12:03:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190114110325.GB22336@krava>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
 <20190109172843.GE19455@krava>
 <b1df6115-e03c-47f4-bdb8-29f1980763f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1df6115-e03c-47f4-bdb8-29f1980763f0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 14 Jan 2019 11:03:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:43:31AM +0300, Alexey Budankov wrote:
> Hi,
> On 09.01.2019 20:28, Jiri Olsa wrote:
> > On Mon, Dec 24, 2018 at 04:21:33PM +0300, Alexey Budankov wrote:
> >>
> >> The patch set implements runtime record trace compression accompanied by 
> >> trace file decompression implemented in the tool report mode. Zstandard 
> >> library API [1] is used for compression/decompression of data that come 
> >> from perf_events kernel data buffers.
> >>
> >> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
> >> size reduction on the tested workloads what significantly saves user's 
> >> storage space on larger server systems where trace file size can easily 
> >> reach several tens or even hundreds of GiBs, especially when profiling 
> >> with stacks for later dwarf unwinding, context-switches tracing and etc.
> >>
> >> The option is effective jointly with asynchronous trace writing because 
> >> compression requires auxiliary memory buffers to operate on and memory 
> >> buffers for asynchronous trace writing serve that purpose.
> > 
> > I dont like that it's onlt for aio only, I can't really see why it's
> 
> For serial streaming, on CPU bound codes, under full system utilization it 
> can induce more runtime overhead and increase data loss because amount of 
> code on performance critical path grows, of course size of written data 
> reduces but still. Feeding kernel buffer content by user space code to a 
> syscall is extended with intermediate copying to user space memory with 
> doing some math on it in the middle.
> 
> > a problem for normal data.. can't we just have one layer before and
> > stream the data to the compress function instead of the file (or aio
> > buffers).. and that compress functions would spit out 64K size COMPRESSED
> > events, which would go to file (or aio buffers)
> 
> It is already almost like that. Compression could be bridged using AIO 
> buffers but then still streamed to file serially using record__pushfn() 
> and that would make some sense for moderate profiling cases on systems 
> without AIO support and trace streaming based on it.
> 
> > 
> > the report side would process them (decompress) on the session layer
> > before the tool callbacks are called
> 
> It is already pretty similar to that.

hum, AFAICS you do that in report code not in on the session layer

jirka
