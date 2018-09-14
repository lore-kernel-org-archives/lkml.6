Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61474C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06A520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06A520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeINNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINNgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0565307D85F;
        Fri, 14 Sep 2018 08:23:11 +0000 (UTC)
Received: from krava (unknown [10.40.205.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 592592010D00;
        Fri, 14 Sep 2018 08:23:08 +0000 (UTC)
Date:   Fri, 14 Sep 2018 10:23:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914082307.GF24224@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914022910.GA15146@sejong>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 14 Sep 2018 08:23:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:29:10AM +0900, Namhyung Kim wrote:
> On Thu, Sep 13, 2018 at 07:10:35PM +0300, Alexey Budankov wrote:
> > Hi,
> 
> Hello,
> 
> > 
> > On 13.09.2018 15:54, Jiri Olsa wrote:
> > > hi,
> > > sending *RFC* for threads support in perf record command.
> > > 
> > > In big picture this patchset adds perf record --threads
> > > option that allows to create threads in following modes:
> > > 
> > > 1) single thread mode (current)
> > > 
> > >   $ perf record ...
> > >   $ perf record --threads=1 ...
> > > 
> > >   - all maps are read/stored under process thread
> > > 
> > > 2) mode with specific (X) number of threads
> > > 
> > >   $ perf record --threads=X ...
> > > 
> > >   - maps are spread equaly among threads
> > > 
> > > 3) mode that creates thread for every monitored memory map
> > > 
> > >   $ perf record --threads ...
> > > 
> > >   - which in perf record is equal to number of CPUs, and
> > >     it pins each thread to its map's cpu:
> > > 
> > > 4) TODO - NUMA aware threads/maps separation
> > >    ...
> > > 
> > > The perf.data stays as a single file.
> 
> I'm not sure we really need to keep it as a single file.  As it's a
> kind of big changes, we might consider breaking compatibility and use
> a directory structure.

moving the files into the perf.data at the end is actualy
not a lot code.. and I think it's one of the 'small' things
that make this feature more user friendly

jirka
