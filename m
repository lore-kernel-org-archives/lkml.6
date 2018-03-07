Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934158AbeCGRjf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:39:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeCGRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:39:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 07 Mar 2018 12:39:29 -0500
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
In-Reply-To: <20180307160224.GN3701@kernel.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
Message-ID: <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-07 11:02, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 06, 2018 at 09:04:42AM -0500, Agustin Vega-Frias escreveu:

[snip]

> This breaks the build in at least Alpine Linux 3.4, 3.5 and 3.6 and
> android-ndk:r15c-arm
> 
> Alpine 3.6 build failure:
> 
>   CC       /tmp/build/perf/util/parse-events-bison.o
> util/parse-events.y: In function 'parse_events_parse':
> util/parse-events.y:244:37: error: 'FNM_EXTMATCH' undeclared (first
> use in this function)
>     if (!fnmatch(pattern, pmu->name, FNM_EXTMATCH)) {
>                                      ^~~~~~~~~~~~
> util/parse-events.y:244:37: note: each undeclared identifier is
> reported only once for each function it appears in
>   CC       /tmp/build/perf/bench/mem-functions.o
> mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No
> such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:96:
> /tmp/build/perf/util/parse-events-bison.o] Error 1
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:623: /tmp/build/perf/libperf-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> Android NDK r15c ARM, cross built from, IIRC, Fedora 24:
> 
>  CC       /tmp/build/perf/util/parse-events-bison.o
> util/parse-events.y: In function 'parse_events_parse':
> util/parse-events.y:244:37: error: 'FNM_EXTMATCH' undeclared (first
> use in this function)
>     if (!fnmatch(pattern, pmu->name, FNM_EXTMATCH)) {
>                                      ^
> util/parse-events.y:244:37: note: each undeclared identifier is
> reported only once for each function it appears in
> mv: cannot stat '/tmp/build/perf/util/.parse-events-bison.o.tmp': No
> such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:96:
> /tmp/build/perf/util/parse-events-bison.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC       /tmp/build/perf/builtin-kmem.o
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:623: /tmp/build/perf/libperf-in.o] Error 2
> 
> 
> Probably others, I'll investigate later, feel free to do it if you have
> the time now :-)
> 

Sorry about that. That's probably because FNM_EXTMATCH is a GNU 
extension,
not POSIX, and the Alpine and Android runtimes likely don't implement 
that...
I'll send a fix reverting back to the strncmp to ignore the uncore_ 
prefix,
and dropping that extension.

Agustín

> Extra info:
> 
> 
>    1    46.29 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 
> 5.3.0
>    2    53.37 alpine:3.5                    : FAIL gcc (Alpine 6.2.1)
> 6.2.1 20160822
>    3    48.42 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 
> 6.3.0
>    4    35.88 alpine:edge                   : FAIL gcc (Alpine 6.4.0) 
> 6.4.0
>    5    96.79 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5
> 20150623 (Red Hat 4.8.5-11)
>    6   116.40 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1
> 20170915 (Red Hat 7.2.1-2)
>    7    34.30 android-ndk:r12b-arm          : FAIL
> arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>    8    33.69 android-ndk:r15c-arm          : FAIL
> arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>    9    60.50 centos:5                      : Ok   gcc (GCC) 4.1.2
> 20080704 (Red Hat 4.1.2-55)
>   10    88.54 centos:6                      : Ok   gcc (GCC) 4.4.7
> 20120313 (Red Hat 4.4.7-18)
>   11   108.89 centos:7                      : Ok   gcc (GCC) 4.8.5
> 20150623 (Red Hat 4.8.5-16)
> 
> 
> The builds are still ongoing.
> 
> - Arnaldo

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
