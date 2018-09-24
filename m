Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3767B21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3767B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeIXUby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeIXUby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09BF4307D851;
        Mon, 24 Sep 2018 14:29:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1EBE18426;
        Mon, 24 Sep 2018 14:29:27 +0000 (UTC)
Date:   Mon, 24 Sep 2018 16:29:27 +0200
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
Message-ID: <20180924142927.GA22809@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava>
 <20180914082858.GH24224@krava>
 <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
 <4f63c3d5-2a33-28ed-4e45-086045e9ab50@linux.intel.com>
 <20180923193001.GD30923@krava>
 <15042139-23ee-3bb7-4307-276e505a4607@linux.intel.com>
 <c37d1c7d-9f98-4aed-e621-6b3b76d3d3d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37d1c7d-9f98-4aed-e621-6b3b76d3d3d9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 24 Sep 2018 14:29:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:09:09PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 24.09.2018 10:02, Alexey Budankov wrote:
> > Hi,
> > 
> > On 23.09.2018 22:30, Jiri Olsa wrote:
> >> On Fri, Sep 21, 2018 at 09:13:08AM +0300, Alexey Budankov wrote:
> >>
> >> SNIP
> >>
> >>> Events:
> >>> cpu/period=P,event=0x3c/Duk;CPU_CLK_UNHALTED.THREAD
> >>> cpu/period=P,umask=0x3/Duk;CPU_CLK_UNHALTED.REF_TSC
> >>> cpu/period=P,event=0xc0/Duk;INST_RETIRED.ANY
> >>> cpu/period=0xaae61,event=0xc2,umask=0x10/uk;UOPS_RETIRED.ALL
> >>> cpu/period=0x11171,event=0xc2,umask=0x20/uk;UOPS_RETIRED.SCALAR_SIMD
> >>> cpu/period=0x11171,event=0xc2,umask=0x40/uk;UOPS_RETIRED.PACKED_SIMD
> >>>
> >>> =================================================
> >>>
> >>> Command:
> >>> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf.thr record --threads=T \
> >>> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
> >>>         -e cpu/period=P,event=0x3c/Duk,\
> >>>            cpu/period=P,umask=0x3/Duk,\
> >>>            cpu/period=P,event=0xc0/Duk,\
> >>>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
> >>>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
> >>>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
> >>>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
> >>
> >> hum, so I guess the results suck because of the -a option,
> >> getting extra samples for all the perf record threads
> >>
> >> could you try without the -a? you monitor only user events,
> >> so you're interested only in ./matrix.* samples, right?
> > 
> > Ok, trying without -a, in per-process mode. 
> 
> Command:
> 
> /usr/bin/time ./perf.thr record --threads=T \
> 	-N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
> 	-e cpu/period=P,event=0x3c/Duk,\
> 	   cpu/period=P,umask=0x3/Duk,\
> 	   cpu/period=P,event=0xc0/Duk,\
> 	   cpu/period=0xaae61,event=0xc2,umask=0x10/uk,\
> 	   cpu/period=0x11171,event=0xc2,umask=0x20/uk,\
> 	   cpu/period=0x11171,event=0xc2,umask=0x40/uk \
> 	--clockid=monotonic_raw -- ./matrix.gcc
> 
> Workload: matrix multiplication in 128 threads
> 
> T : 272
> 	P (period, ms)       : 0.35 
> 	runtime overhead (%) : 13x ~ 87.73 / 6.81

how do you meassure this?

> 	data loss (%)        : 0
> 	LOST events          : 36
> 	SAMPLE events        : 8048542
>         perf.data size (GiB) : 10

any idea why does it have some much more samples?

thanks,
jirka
