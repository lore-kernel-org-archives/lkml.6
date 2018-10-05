Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A88C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA7121480
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA7121480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJENLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:11:45 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46766 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726732AbeJENLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:11:45 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 5 Oct 2018 15:14:30 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 5 Oct 2018 15:14:30 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 5 Oct 2018 15:14:30 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20181005061430.GA3768@sejong>
References: <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava>
 <20180914082858.GH24224@krava>
 <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
 <4f63c3d5-2a33-28ed-4e45-086045e9ab50@linux.intel.com>
 <20180923193001.GD30923@krava>
 <15042139-23ee-3bb7-4307-276e505a4607@linux.intel.com>
 <c37d1c7d-9f98-4aed-e621-6b3b76d3d3d9@linux.intel.com>
 <20180924142927.GA22809@krava>
 <5ac85264-50a5-8e70-0c12-7cb0da433a42@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ac85264-50a5-8e70-0c12-7cb0da433a42@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for late..

On Mon, Sep 24, 2018 at 09:32:11PM +0300, Alexey Budankov wrote:
> On 24.09.2018 17:29, Jiri Olsa wrote:
> > On Mon, Sep 24, 2018 at 04:09:09PM +0300, Alexey Budankov wrote:
> >> Command:
> >>
> >> /usr/bin/time ./perf.thr record --threads=T \
> >> 	-N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
> >> 	-e cpu/period=P,event=0x3c/Duk,\
> >> 	   cpu/period=P,umask=0x3/Duk,\
> >> 	   cpu/period=P,event=0xc0/Duk,\
> >> 	   cpu/period=0xaae61,event=0xc2,umask=0x10/uk,\
> >> 	   cpu/period=0x11171,event=0xc2,umask=0x20/uk,\
> >> 	   cpu/period=0x11171,event=0xc2,umask=0x40/uk \
> >> 	--clockid=monotonic_raw -- ./matrix.gcc
> >>
> >> Workload: matrix multiplication in 128 threads
> >>
> >> T : 272
> >> 	P (period, ms)       : 0.35 
> >> 	runtime overhead (%) : 13x ~ 87.73 / 6.81
> >> 	data loss (%)        : 0
> >> 	LOST events          : 36
> >> 	SAMPLE events        : 8048542
> >>    perf.data size (GiB) : 10
> > 
> > any idea why does it have some much more samples?
> 
> Presumably, this is because period is 350us and this is the smallest 
> one that perf.thr manages to capture data without data loss (=0) when T=272.
> However, during collection, I get message that max sampling frequency 
> is lowered to 3KHz.

And it took much longer than AIO:  87.73 vs 22.34  (N=272)

Thanks,
Namhyung
