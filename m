Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2A92173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2A92173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeI1Mrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:47:47 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:56599 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Mrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:47:46 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 28 Sep 2018 15:25:35 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 28 Sep 2018 15:25:35 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 28 Sep 2018 15:25:35 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 47/48] perf record: Spread maps for --threads option
Message-ID: <20180928062535.GA25037@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-48-jolsa@kernel.org>
 <20180917114048.GF18395@sejong>
 <20180923194432.GH30923@krava>
 <20180924142254.GB4640@kernel.org>
 <20180926062317.GA8610@krava>
 <20180927160158.GE6916@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927160158.GE6916@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo and Jiri,

On Thu, Sep 27, 2018 at 06:01:58PM +0200, Jiri Olsa wrote:
> On Wed, Sep 26, 2018 at 08:23:17AM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
> > > I agree with Namhyung, with a slight difference: perhaps we should set
> > > perf_event_attr.mmap on one of the events of the per-cpu mmap, that way
> > > we don't need that dummy event, right?
> > 
> > currently it's all based on having tracking data separated
> > in single file which is read/processed first, so when we
> > read the sample data files, we can read them separately,
> > because we have the tracking data ready
> > 
> > >  
> > > > with the *_time API, we should be able to properly read the
> > > > tracking data separately for each cpu
> > > 
> > > That may end up making the *_time API not needed (assuming the kernel
> > > keeps the per-cpu mmap events in order, barring that, using the
> > > ordered_events in batches, prior to consuming the events) and would help
> > > with things like 'perf top' and 'perf trace', that want to consume
> > > events right away.
> > 
> > if we dont want to use *_by_time API, we need to find a way
> > to sort evevrything out before we start processing.. and that
> > seems too costly to me
> 
> actualy we might try to read all the streams at simultaneously
> and sort the samples on the fly with some reasonable sorting
> window time frame.. this way we could have just single file
> for thread and would skip the *by_time api, hopefuly :-\

Note that without the *by_time API, it only can see the last state.
For example if a task calls exec() in the middle of the window, all
the samples will be processed to the new one.  It might or might not
matter depending on the length of the window.

Thanks,
Namhyung
