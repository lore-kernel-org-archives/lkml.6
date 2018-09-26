Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BCDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9F92086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9F92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeIZMep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:34:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeIZMep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:34:45 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12817308A94E;
        Wed, 26 Sep 2018 06:23:26 +0000 (UTC)
Received: from krava (ovpn-204-149.brq.redhat.com [10.40.204.149])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6564C308BE75;
        Wed, 26 Sep 2018 06:23:19 +0000 (UTC)
Date:   Wed, 26 Sep 2018 08:23:17 +0200
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
Message-ID: <20180926062317.GA8610@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-48-jolsa@kernel.org>
 <20180917114048.GF18395@sejong>
 <20180923194432.GH30923@krava>
 <20180924142254.GB4640@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924142254.GB4640@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 26 Sep 2018 06:23:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:22:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Sep 23, 2018 at 09:44:32PM +0200, Jiri Olsa escreveu:
> > On Mon, Sep 17, 2018 at 08:40:48PM +0900, Namhyung Kim wrote:
> > > On Thu, Sep 13, 2018 at 02:54:49PM +0200, Jiri Olsa wrote:
> > > > Currently we assign all maps to main thread. Adding
> > > > code that spreads maps for --threads option.
> > > > 
> > > > For --thread option we create as many threads as there
> > > > are memory maps in evlist, which is the number of CPUs
> > > > in the system or CPUs we monitor. Each thread gets a
> > > > single data mmap to read.
> > > > 
> > > > In addition we have also same amount of tracking mmaps
> > > > for auxiliary events which we don't create special thread
> > > > for. Instead we assign the to the main thread, because
> > > > there's not much traffic expected there.
> > > > 
> > > > The assignment is visible from --thread-stats output:
> > > > 
> > > >           pid      write       poll       skip  maps (size 20K)
> > > >     1s   9770       144B          1          0   19K   19K   19K   18K   19K
> > > >          9772         0B          1          0   18K
> > > >          9773         0B          1          0   19K
> > > >          9774         0B          1          0   19K
> > > > 
> > > > There are 5 maps for thread 9770 (1 data map and 4 auxiliary)
> > > > and one data map for every other thread. Each thread writes
> > > > data to the separate data file.
> > > 
> > > Hmm.. not sure it'll work well for large machines with 1000+ cpus.
> > > What about giving each thread a data mmap and a tracking mmap?
> > 
> > well currently we store the tracking data in single file,
> > thats why we need just one thread to write them down
> 
> I agree with Namhyung, with a slight difference: perhaps we should set
> perf_event_attr.mmap on one of the events of the per-cpu mmap, that way
> we don't need that dummy event, right?

currently it's all based on having tracking data separated
in single file which is read/processed first, so when we
read the sample data files, we can read them separately,
because we have the tracking data ready

>  
> > with the *_time API, we should be able to properly read the
> > tracking data separately for each cpu
> 
> That may end up making the *_time API not needed (assuming the kernel
> keeps the per-cpu mmap events in order, barring that, using the
> ordered_events in batches, prior to consuming the events) and would help
> with things like 'perf top' and 'perf trace', that want to consume
> events right away.

if we dont want to use *_by_time API, we need to find a way
to sort evevrything out before we start processing.. and that
seems too costly to me

jirka
