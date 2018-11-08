Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD6F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYZCBrVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD6F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeKHXUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeKHXUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:20:38 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA2220825;
        Thu,  8 Nov 2018 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541684704;
        bh=ROj+ZL+d4mDvNAoRK4w+YlUCWvUL5IWBf/602BMNBh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYZCBrVMRdyeA9RETAGGYZ1kFlgni6j7IVro1KpsHo8IEUZzoc7wI6yBXrvYC0Xd5
         74MRKFzPke3R/ixf0owKZC/S1GaBjE4wxIiJDVV0fjdMhWKZU69IIp5T9bCx5m0Tz4
         xfztxeCOXeLJkYTYxkqud7ZjTsMdqrwU3YieSXoc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id EFA0D142D3F; Thu,  8 Nov 2018 10:45:00 -0300 (-03)
Date:   Thu, 8 Nov 2018 10:45:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181108134500.GA15568@kernel.org>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
 <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
 <20181106191325.GM7077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106191325.GM7077@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 06, 2018 at 04:13:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 06, 2018 at 10:23:49AM -0800, Davidlohr Bueso escreveu:
> > Mind this fixlet for using et/oneshot and the multiq option.
> 
> Yes sir, applied the fixup to the first patch in the series, applied the
> second, tested, merged.

So, one of these two is making the build to fail in all the Alpine Linux
(3.4 -- 3.8 and edge) and also on some others

On Alpine the error is:

  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/bench/epoll-wait.o
bench/epoll-wait.c: In function 'do_threads':
bench/epoll-wait.c:345:10: error: implicit declaration of function 'pthread_attr_setaffinity_np' [-Werror=implicit-function-declaration]
    ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
          ^
bench/epoll-wait.c:345:4: error: nested extern declaration of 'pthread_attr_setaffinity_np' [-Werror=nested-externs]
    ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
    ^
bench/epoll-wait.c: In function 'bench_epoll_wait':
bench/epoll-wait.c:462:12: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'rlim_t {aka long long unsigned int}' [-Werror=format=]
  printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n", prevrl.rlim_max, rl.rlim_max);
            ^
bench/epoll-wait.c:85:31: note: in definition of macro 'printinfo'
  do { if (__verbose) { printf(fmt, ## arg); fflush(stdout); } } while (0)
                               ^
bench/epoll-wait.c:462:12: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'rlim_t {aka long long unsigned int}' [-Werror=format=]
  printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n", prevrl.rlim_max, rl.rlim_max);
            ^
bench/epoll-wait.c:85:31: note: in definition of macro 'printinfo'
  do { if (__verbose) { printf(fmt, ## arg); fflush(stdout); } } while (0)
                               ^
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/perf.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/bench/.epoll-wait.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/bench/epoll-wait.o' failed
make[4]: *** [/tmp/build/perf/bench/epoll-wait.o] Error 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'bench' failed
make[3]: *** [bench] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/trace-event-scripting.o


On AmazonLinux 1 and 2, oops, these are mine:

  LINK     /tmp/build/perf/perf
/tmp/build/perf/perf-in.o: In function `bpf_map__set_filter_pids':
/git/linux/tools/perf/builtin-trace.c:2573: undefined reference to `bpf_map(float, double)'
/tmp/build/perf/perf-in.o: In function `cmd_trace':
(.text+0x4c71e): undefined reference to `bpf_map_update_elem'
/tmp/build/perf/perf-in.o: In function `cmd_trace':
(.text+0x4cab6): undefined reference to `bpf_map(float, double)'
/tmp/build/perf/perf-in.o: In function `cmd_trace':
(.text+0x4cae8): undefined reference to `bpf_map_update_elem'
collect2: error: ld returned 1 exit status
make[2]: *** [/tmp/build/perf/perf] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/git/linux/tools/perf'
[root@seventh ~]# 

I need to do that conditionally, i.e. it seems libbpf is not being built
in that distro...

centos:5 is about perf bench:

  CC       /tmp/build/perf/bench/epoll-wait.o
bench/epoll-wait.c:74:25: error: sys/eventfd.h: No such file or directory
cc1: warnings being treated as errors
bench/epoll-wait.c: In function 'do_threads':
bench/epoll-wait.c:328: warning: implicit declaration of function 'eventfd'
bench/epoll-wait.c:328: warning: nested extern declaration of 'eventfd'
bench/epoll-wait.c:328: error: 'EFD_NONBLOCK' undeclared (first use in this function)
bench/epoll-wait.c:328: error: (Each undeclared identifier is reported only once
bench/epoll-wait.c:328: error: for each function it appears in.)
mv: cannot stat `/tmp/build/perf/bench/.epoll-wait.o.tmp': No such file or directory
make[4]: *** [/tmp/build/perf/bench/epoll-wait.o] Error 1
make[3]: *** [bench] Error 2
make[3]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/tests/


centos:6 and 7 are ok with perf bench, not so much with my bpf changes :-\

  LINK     /tmp/build/perf/libperf-gtk.so
/tmp/build/perf/perf-in.o: In function `bpf_map__set_filter_pids':
/git/linux/tools/perf/builtin-trace.c:2573: undefined reference to `bpf_map(float, double)'
/git/linux/tools/perf/builtin-trace.c:2577: undefined reference to `bpf_map_update_elem'
/git/linux/tools/perf/builtin-trace.c:2573: undefined reference to `bpf_map(float, double)'
/git/linux/tools/perf/builtin-trace.c:2577: undefined reference to `bpf_map_update_elem'
collect2: ld returned 1 exit status
make[2]: *** [/tmp/build/perf/perf] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/git/linux/tools/perf'
[root@seventh ~]# 
[root@seventh ~]#

- Arnaldo
 
> - Arnaldo
>  
> > diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> > index c4c5ef60feb4..4e4efc5cfe22 100644
> > --- a/tools/perf/bench/epoll-wait.c
> > +++ b/tools/perf/bench/epoll-wait.c
> > @@ -215,13 +215,13 @@ static void *workerfn(void *arg)
> > 
> > 		if (et) {
> > 			ev.events = EPOLLIN | EPOLLET;
> > -			ret = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
> > +			ret = epoll_ctl(efd, EPOLL_CTL_ADD, fd, &ev);
> > 		}
> > 
> > 		if (oneshot) {
> > 			/* rearm the file descriptor with a new event mask */
> > 			ev.events |= EPOLLIN | EPOLLONESHOT;
> > -			ret = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
> > +			ret = epoll_ctl(efd, EPOLL_CTL_MOD, fd, &ev);
> > 		}
> > 
> > 		ops++;
> > @@ -249,7 +249,7 @@ static void nest_epollfd(struct worker *w)
> > 
> > 	for (i = 0; i < nested; i++) {
> > 		epollfdp[i] = epoll_create(1);
> > -		if (epollfd < 0)
> > +		if (epollfdp[i] < 0)
> > 			err(EXIT_FAILURE, "epoll_create");
> > 	}
> > 
