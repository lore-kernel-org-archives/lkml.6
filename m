Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030582AbeBPNSU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030435AbeBPNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:18:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FBF21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 16 Feb 2018 10:18:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH v4 2/2] perf stat: Add support to print counts after a
 period of time
Message-ID: <20180216131815.GB24436@kernel.org>
References: <1517217923-8302-1-git-send-email-ufo19890607@gmail.com>
 <1517217923-8302-3-git-send-email-ufo19890607@gmail.com>
 <20180215133921.GC22818@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215133921.GC22818@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 15, 2018 at 10:39:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 29, 2018 at 10:25:23AM +0100, ufo19890607 escreveu:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > Introduce a new option to print counts after N milliseconds
> 
> This doesn't just print counts after N ms, it _stops_ the workload after
> that time _and_ prints the counts, right?
> 
> Can you please send a followup patch fixing the description and
> documentation?
> 
> I've applied this already, but clarifying what this option does is in
> demand.

So, this fails to build on centos:5 and centos:6 and similar systems
where the use of 'time' for a variable name breaks the build:

  CC       /tmp/build/perf/builtin-stat.o
cc1: warnings being treated as errors
builtin-stat.c: In function '__run_perf_stat':
builtin-stat.c:576: warning: declaration of 'time' shadows a global declaration
/usr/include/time.h:187: warning: shadowed declaration is here
builtin-stat.c: In function 'cmd_stat':
builtin-stat.c:2710: warning: declaration of 'time' shadows a global declaration
/usr/include/time.h:187: warning: shadowed declaration is here
mv: cannot stat `/tmp/build/perf/.builtin-stat.o.tmp': No such file or directory
make[3]: *** [/tmp/build/perf/builtin-stat.o] Error 1
make[3]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/evsel_fprintf.o
make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....

So since I had to rename that I replaced it with 'timeout', so that it
gets clear that when you specify this option you are setting a timeout
period that if hit will stop the 'perf stat' session and then print the
specified counters.

Please let us know if you have any strong objection to this,

- Arnaldo
