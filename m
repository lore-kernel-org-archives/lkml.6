Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C944C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8E20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeIMNIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeIMNIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BCC0310E9B6;
        Thu, 13 Sep 2018 08:00:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id B3ED4104255A;
        Thu, 13 Sep 2018 08:00:27 +0000 (UTC)
Date:   Thu, 13 Sep 2018 10:00:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180913080026.GD15173@krava>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
 <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
 <20180911063512.GA130116@gmail.com>
 <74e64322-1f79-d072-cc0e-8d1d09d4ab89@linux.intel.com>
 <20180911083417.GA22188@krava>
 <b495ee6c-84f3-0bec-4c7b-dd7730e17076@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b495ee6c-84f3-0bec-4c7b-dd7730e17076@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 08:00:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:42:09PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 11.09.2018 11:34, Jiri Olsa wrote:
> > On Tue, Sep 11, 2018 at 11:16:45AM +0300, Alexey Budankov wrote:
> >>
> >> Hi Ingo,
> >>
> >> On 11.09.2018 9:35, Ingo Molnar wrote:
> >>>
> >>> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> >>>
> >>>> It may sound too optimistic but glibc API is expected to be backward compatible 
> >>>> and for POSIX AIO API part too. Internal implementation also tends to evolve to 
> >>>> better option overtime, more probably basing on modern kernel capabilities 
> >>>> mentioned here: http://man7.org/linux/man-pages/man2/io_submit.2.html
> >>>
> >>> I'm not talking about compatibility, and I'm not just talking about glibc, perf works under 
> >>> other libcs as well - and let me phrase it in another way: basic event handling, threading, 
> >>> scheduling internals should be a *core competency* of a tracing/profiling tool.
> >>
> >> Well, the requirement of independence from some specific libc implementation 
> >> as well as *core competency* design approach clarify a lot. Thanks!
> >>
> >>>
> >>> I.e. we might end up using the exact same per event fd thread pool design that glibc uses 
> >>> currently. Or not. Having that internal and open coded to perf, like Jiri has started 
> >>> implementing it, allows people to experiment with it.
> >>
> >> My point here is that following some standardized programming models and APIs 
> >> (like POSIX) in the tool code, even if the tool itself provides internal open 
> >> coded implementation for the APIs, would simplify experimenting with the tool 
> >> as well as lower barriers for new comers. Perf project could benefit from that.
> >>
> >>>
> >>> This isn't some GUI toolkit, this is at the essence of perf, and we are not very good on large 
> >>> systems right now, and I think the design should be open-coded threading, not relying on an 
> >>> (perf-)external AIO library to get it right.
> >>>
> >>> The glibc thread pool implementation of POSIX AIO is basically a fall-back 
> >>> implementation, for the case where there's no native KAIO interface to rely on.
> >>>
> >>>> Well, explicit threading in the tool for AIO, in the simplest case, means 
> >>>> incorporating some POSIX API implementation into the tool, avoiding 
> >>>> code reuse in the first place. That tends to be error prone and costly.
> >>>
> >>> It's a core competency, we better do it right and not outsource it.
> >>
> >> Yep, makes sense.
> > 
> > on the other hand, we are already trying to tie this up under perf_mmap
> > object, which is what the threaded patchset operates on.. so I'm quite
> > confident that with little effort we could make those 2 things live next
> > to each other and let the user to decide which one to take and compare
> > 
> > possibilities would be like: (not sure yet the last one makes sense, but still..)
> > 
> >   # perf record --threads=...  ...
> >   # perf record --aio ...
> >   # perf record --threads=... --aio ...
> > 
> > how about that?
> 
> That might be an option. What is the semantics of --threads?

that's my latest post on this:
  https://marc.info/?l=linux-kernel&m=151551213322861&w=2

working on repost ;-)

jirka

> 
> Be aware that when experimenting with serial trace writing on an 8-core 
> client machines running an HPC benchmark heavily utilizing all 8 cores 
> we noticed that single Perf tool thread contended with the benchmark 
> threads.
> 
> That manifested like libiomp.so (Intel OpenMP implementation) functions 
> appearing among the top hotspots functions and this was indication of 
> imbalance induced by the tool during profiling.
> 
> That's why we decided to first go with AIO approach, as it is posted,
> and benefit from it the most thru multi AIO, prior turning to more 
> resource consuming multi-threading alternative. 
> 
> > 
> > I just rebased the thread patchset, will make some tests (it's been few months,
> > so it needs some kicking/checking) and post it out hopefuly this week> 
> > jirka
> > 
