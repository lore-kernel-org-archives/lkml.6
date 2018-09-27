Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE93C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA2E216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2E216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeI0WVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbeI0WVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:21:01 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A33F300295C;
        Thu, 27 Sep 2018 16:02:05 +0000 (UTC)
Received: from krava (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id 78EA220155E2;
        Thu, 27 Sep 2018 16:02:00 +0000 (UTC)
Date:   Thu, 27 Sep 2018 18:01:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 47/48] perf record: Spread maps for --threads option
Message-ID: <20180927160158.GE6916@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-48-jolsa@kernel.org>
 <20180917114048.GF18395@sejong>
 <20180923194432.GH30923@krava>
 <20180924142254.GB4640@kernel.org>
 <20180926062317.GA8610@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926062317.GA8610@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 27 Sep 2018 16:02:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:23:17AM +0200, Jiri Olsa wrote:

SNIP

> > I agree with Namhyung, with a slight difference: perhaps we should set
> > perf_event_attr.mmap on one of the events of the per-cpu mmap, that way
> > we don't need that dummy event, right?
> 
> currently it's all based on having tracking data separated
> in single file which is read/processed first, so when we
> read the sample data files, we can read them separately,
> because we have the tracking data ready
> 
> >  
> > > with the *_time API, we should be able to properly read the
> > > tracking data separately for each cpu
> > 
> > That may end up making the *_time API not needed (assuming the kernel
> > keeps the per-cpu mmap events in order, barring that, using the
> > ordered_events in batches, prior to consuming the events) and would help
> > with things like 'perf top' and 'perf trace', that want to consume
> > events right away.
> 
> if we dont want to use *_by_time API, we need to find a way
> to sort evevrything out before we start processing.. and that
> seems too costly to me

actualy we might try to read all the streams at simultaneously
and sort the samples on the fly with some reasonable sorting
window time frame.. this way we could have just single file
for thread and would skip the *by_time api, hopefuly :-\

I'll try to prepare something

jirka
