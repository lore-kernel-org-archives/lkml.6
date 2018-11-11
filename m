Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE109C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80490214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J64yGNIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80490214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeKLDXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLDXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:23:06 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA717214E0;
        Sun, 11 Nov 2018 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541957636;
        bh=8jcXviMpCQaAatUTW1ff0jkfsH91C+3E+uxaE0FVOiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J64yGNIUZCAoxVHXcWVqKyvoXjI40QwDbmoZZtn8CbrtKX+U+/1VVYV5ynGo2GJAD
         4IID4d/B8rxsXpROJqJOfy8xDvTa/gcoY+8YHzEZDRQIbyybPj3k3946D2JnOJDnaA
         y7A6MUY9ooMfAE4bVicq+jW7dAOe46Sq4g9FpQFE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9006E1443D0; Sun, 11 Nov 2018 09:33:51 -0800 (PST)
Date:   Sun, 11 Nov 2018 09:33:51 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181111173351.GC1111@kernel.org>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
 <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
 <20181106191325.GM7077@kernel.org>
 <20181108134500.GA15568@kernel.org>
 <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 09, 2018 at 01:07:19PM -0800, Davidlohr Bueso escreveu:
> On Thu, 08 Nov 2018, Arnaldo Carvalho de Melo wrote:
> 
> > Em Tue, Nov 06, 2018 at 04:13:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> >  CC       /tmp/build/perf/bench/futex-lock-pi.o
> >  CC       /tmp/build/perf/bench/epoll-wait.o
> > bench/epoll-wait.c: In function 'do_threads':
> > bench/epoll-wait.c:345:10: error: implicit declaration of function 'pthread_attr_setaffinity_np' [-Werror=implicit-function-declaration]
> >    ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
> 
> Ah, yes, how about the following?

Gets it a bit further, then we get this, which I think should be fixed
using some PRIu64, etc. I'll try to do that at some point, but in short
vacations now, then plumbers :-)

  CC       /tmp/build/perf/bench/epoll-wait.o
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
  CC       /tmp/build/perf/bench/epoll-ctl.o
bench/epoll-ctl.c: In function 'bench_epoll_ctl':
bench/epoll-ctl.c:343:12: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'rlim_t {aka long long unsigned int}' [-Werror=format=]
  printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n",
            ^
bench/epoll-ctl.c:31:29: note: in definition of macro 'printinfo'
  do { if (__verbose) printf(fmt, ## arg); } while (0)
                             ^
bench/epoll-ctl.c:343:12: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'rlim_t {aka long long unsigned int}' [-Werror=format=]
  printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n",
            ^
bench/epoll-ctl.c:31:29: note: in definition of macro 'printinfo'
  do { if (__verbose) printf(fmt, ## arg); } while (0)
                             ^
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/bench/.epoll-wait.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/bench/epoll-wait.o' failed
make[4]: *** [/tmp/build/perf/bench/epoll-wait.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/perf.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/bench/.epoll-ctl.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/bench/epoll-ctl.o' failed
make[4]: *** [/tmp/build/perf/bench/epoll-ctl.o] Error 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'bench' failed
make[3]: *** [bench] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/util/map.o

 
> -----8<-----------------------------------------------------
> perf-bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
> 
> Both futex and epoll need this call, and can cause build failure
> on systems that don't have it pthread_attr_setaffinity_np().
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> tools/perf/bench/bench.h | 11 +++++++++++
> tools/perf/bench/futex.h | 12 ------------
> 2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 0e415464931b..fddb3ced9db6 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -51,4 +51,15 @@ int bench_epoll_ctl(int argc, const char **argv);
> extern int bench_format;
> extern unsigned int bench_repeat;
> 
> +#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
> +#include <pthread.h>
> +#include <linux/compiler.h>
> +static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
> +					      size_t cpusetsize __maybe_unused,
> +					      cpu_set_t *cpuset __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
> #endif
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index db4853f209c7..31b53cc7d5bc 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -86,16 +86,4 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
> 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
> 		 val, opflags);
> }
> -
> -#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
> -#include <pthread.h>
> -#include <linux/compiler.h>
> -static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
> -					      size_t cpusetsize __maybe_unused,
> -					      cpu_set_t *cpuset __maybe_unused)
> -{
> -	return 0;
> -}
> -#endif
> -
> #endif /* _FUTEX_H */
> -- 
> 2.16.4
