Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2315C21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgRvODpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2315C21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbeIXUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeIXUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:25:19 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9609C21480;
        Mon, 24 Sep 2018 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537798976;
        bh=FDCySySy6uws+LvKwvr0GTdUawPPyUK0nh/GKiIrsiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgRvODpXd0sejAbXFPi0Tp6D0cmET5j3IDwLUzdxQ4YwFyuJP98KpPckb8dQ1uT6h
         G0NnOrWb0Kol1Q+FFpmMzD+MXdGhr2D9KOwUwguVNv1HNpw7U8pVq3KRy/YXdDoJcV
         UvvR0ukOL4pCRTxV8OZD6D3nArehFyw3Z+bJYwTQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 359AD1401A1; Mon, 24 Sep 2018 11:22:54 -0300 (-03)
Date:   Mon, 24 Sep 2018 11:22:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 47/48] perf record: Spread maps for --threads option
Message-ID: <20180924142254.GB4640@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-48-jolsa@kernel.org>
 <20180917114048.GF18395@sejong>
 <20180923194432.GH30923@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923194432.GH30923@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 23, 2018 at 09:44:32PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 17, 2018 at 08:40:48PM +0900, Namhyung Kim wrote:
> > On Thu, Sep 13, 2018 at 02:54:49PM +0200, Jiri Olsa wrote:
> > > Currently we assign all maps to main thread. Adding
> > > code that spreads maps for --threads option.
> > > 
> > > For --thread option we create as many threads as there
> > > are memory maps in evlist, which is the number of CPUs
> > > in the system or CPUs we monitor. Each thread gets a
> > > single data mmap to read.
> > > 
> > > In addition we have also same amount of tracking mmaps
> > > for auxiliary events which we don't create special thread
> > > for. Instead we assign the to the main thread, because
> > > there's not much traffic expected there.
> > > 
> > > The assignment is visible from --thread-stats output:
> > > 
> > >           pid      write       poll       skip  maps (size 20K)
> > >     1s   9770       144B          1          0   19K   19K   19K   18K   19K
> > >          9772         0B          1          0   18K
> > >          9773         0B          1          0   19K
> > >          9774         0B          1          0   19K
> > > 
> > > There are 5 maps for thread 9770 (1 data map and 4 auxiliary)
> > > and one data map for every other thread. Each thread writes
> > > data to the separate data file.
> > 
> > Hmm.. not sure it'll work well for large machines with 1000+ cpus.
> > What about giving each thread a data mmap and a tracking mmap?
> 
> well currently we store the tracking data in single file,
> thats why we need just one thread to write them down

I agree with Namhyung, with a slight difference: perhaps we should set
perf_event_attr.mmap on one of the events of the per-cpu mmap, that way
we don't need that dummy event, right?
 
> with the *_time API, we should be able to properly read the
> tracking data separately for each cpu

That may end up making the *_time API not needed (assuming the kernel
keeps the per-cpu mmap events in order, barring that, using the
ordered_events in batches, prior to consuming the events) and would help
with things like 'perf top' and 'perf trace', that want to consume
events right away.

- Arnaldo
