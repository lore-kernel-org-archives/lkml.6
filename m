Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7492C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740CF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740CF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeG0I1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:27:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729426AbeG0I1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2480340216E6;
        Fri, 27 Jul 2018 07:06:30 +0000 (UTC)
Received: from krava (unknown [10.40.205.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id F29347C49;
        Fri, 27 Jul 2018 07:06:25 +0000 (UTC)
Date:   Fri, 27 Jul 2018 09:06:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     rodia@autistici.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf c2c report: Fix crash for empty browser
Message-ID: <20180727070623.GA24770@krava>
References: <20180724062008.26126-1-jolsa@kernel.org>
 <20180726193046.GC20438@kernel.org>
 <c5cb64016f7da6c2abdef4a05ea74425@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5cb64016f7da6c2abdef4a05ea74425@autistici.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 07:06:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 07:06:30 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:31:34PM +0000, rodia@autistici.org wrote:
> On 2018-07-26 19:30, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 24, 2018 at 08:20:08AM +0200, Jiri Olsa escreveu:
> > > Do not try to display entry details if there's
> > > not any. Currently this ends up in crash:
> > >   $ perf c2c report
> > >   perf: Segmentation fault
> > 
> > How to replicate this?
> > 
> > I tried:
> > 
> > $ perf record sleep 1
> > $ perf c2c report
> > 
> > But it didn't segfault
> 
> Similarly I have tried :
> $ perf record sleep 1
> $ perf c2c report
> Then Press `d` to show the cache-line contents.

yep, sry I forgot to mention you need to press the 'd' to show details


> This replies the segfault on my machine (4.17.8-1).
> The patch mentioned above should solve it, even tough I am not sure as I
> haven't been able to recompile the kernel.

no need to recompile kernel

> 
> The segfault by itself seems to be due to the report logic, as it did not
> expect to report on an empty browser.
> What has stepped me back is that application which I have been testing with
> rely on multiple threads instantiated through pthread, which should be
> counted in user-level threads right? But they still seem to return an empty
> browser.

right, c2c scans read/write accesses and tries to find false sharing
cases maybe there was nothing to be found

> When instead c2c is runned system-wide, with an application running on
> multiple threads like firefox or julia, cache hits are measured and also
> they are traced back in the source code.

I got a cache line (attached) for 'perf bench sched messaging'
NOT being traced system wide and just for user (you'll get plenty
of detected cachelines in kernel space):

jirka


---
[root@krava perf]# ./perf c2c record --all-user -- ./perf bench sched messaging -l 100000
[root@krava perf]# ./perf c2c report --stdio

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----  ---- Store Reference ----  --- Load Dram ----      LLC    Total  ----- Core Load Hit -----  -- LLC Load Hit --
# Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss    Loads       FB       L1       L2       Llc       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  .......  ........  ........
#
      0      0x7fff5b729cc0     0       1       44  100.00%        1        1        0       21       21        0         2         0        2       23        0        0        9        11         0

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                               ---------- cycles ----------    Total       cpu                               Shared                             
#   Num      Rmt      Lcl   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid        Code address  rmt hitm  lcl hitm      load  records       cnt           Symbol              Object            Source:Line  Node
# .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ........  ........  ........  .......  ........  ...............  ..................  .....................  ....
#
  -------------------------------------------------------------
      0        0        1       21        0      0x7fff5b729cc0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     0       1    17356      0x7febaf7e1a46         0       142       101       23         4  [.] __libc_read  libpthread-2.27.so  read.c:28               0
           0.00%    0.00%  100.00%    0.00%                0x38     0       1    17356            0x494e4e         0         0         0       21         4  [.] receiver     perf                sched-messaging.c:129   0

