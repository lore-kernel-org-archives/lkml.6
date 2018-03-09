Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCIT3Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932069AbeCIT3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:29:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8719205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 16:29:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Martin Vuille <jpmv27@aim.com>
Cc: Kim Phillips <kim.phillips@arm.com>, Jiri Olsa <jolsa@kernel.org>,
        "Christian Hansen (chansen3)" <chansen3@cisco.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support
 for ARM64
Message-ID: <20180309192919.GC25111@kernel.org>
References: <A5E405FE-1BA3-46FC-9A43-CF19A4B369C5@cisco.com>
 <20180226142726.cd413c792d0782f77b60a23e@arm.com>
 <20180226174040.6998bd3c0a79b2f19c491e4d@arm.com>
 <9B701F46-6AEA-48D8-9103-71D35C83776D@cisco.com>
 <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
 <20180309150627.GB8347@kernel.org>
 <20180309120720.9358515dbff3b1d1fdf70cc8@arm.com>
 <20180309182440.GA25111@kernel.org>
 <cde0e6f4-155f-3d7e-8d84-fd482f729976@aim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde0e6f4-155f-3d7e-8d84-fd482f729976@aim.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 09, 2018 at 01:49:50PM -0500, Martin Vuille escreveu:
> Hi,
> 
> I made two other submissions that may also have been overlooked:
> 
> https://patchwork.kernel.org/patch/10211401/ -- This one has the S-o-B

Ok, replied to that one, I can't see where is it that the symfs is being
first appended, please clarify that in the patch commit log message.
 
> https://patchwork.kernel.org/patch/10211473/ -- RFC, was looking for comments, has the S-o-B

[RFC,1/1] perf annotate: Don't prepend symfs path to vmlinux path

So, lemme try to provide the precise steps to reproduce this problem:

[root@jouet ~]# perf record -F 10000 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB perf.data (11 samples) ]
[root@jouet ~]# perf buildid-list
44d954246227536955cb1ecbe9ef2a05665876b6 /lib/modules/4.16.0-rc4/build/vmlinux
87ae276466bc68e958c9817f11d5e09f14510585 [vdso]
3113881229974f02113945e92c1a4d4f146e061c /usr/lib64/libc-2.26.so
[root@jouet ~]#

then we go on and remove that buildid from the cache:

[root@jouet ~]# perf record -F 10000 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB perf.data (10 samples) ]
[root@jouet ~]# perf report --dso \[kernel.vmlinux\] | grep -v ^# | head -5
    38.00%  sleep    [k] filemap_map_pages
    19.68%  sleep    [k] elf_map
     2.69%  perf     [k] perf_iterate_ctx
     0.29%  perf     [k] end_repeat_nmi
     0.04%  perf     [k] native_sched_clock
[root@jouet ~]#
[root@jouet ~]# perf buildid-list
44d954246227536955cb1ecbe9ef2a05665876b6 /lib/modules/4.16.0-rc4/build/vmlinux
87ae276466bc68e958c9817f11d5e09f14510585 [vdso]
3113881229974f02113945e92c1a4d4f146e061c /usr/lib64/libc-2.26.so
[root@jouet ~]# ls -la ~/.debug/.build-id/44/d954246227536955cb1ecbe9ef2a05665876b6
lrwxrwxrwx. 1 root root 77 Mar  9 16:14 /root/.debug/.build-id/44/d954246227536955cb1ecbe9ef2a05665876b6 -> ../../home/build/v4.16.0-rc4/vmlinux/44d954246227536955cb1ecbe9ef2a05665876b6
[root@jouet ~]# ls -la ~/.debug/home/build/v4.16.0-rc4/vmlinux/44d954246227536955cb1ecbe9ef2a05665876b6/
total 510840
drwxr-xr-x. 2 root root      4096 Mar  9 16:14 .
drwxr-xr-x. 3 root root      4096 Mar  6 11:35 ..
-rwxr-xr-x. 1 root root 523085744 Mar  6 11:35 elf
-rw-r--r--. 1 root root         0 Mar  9 16:14 probes
[root@jouet ~]# perf buildid-cache --remove /lib/modules/4.16.0-rc4/build/vmlinux
[root@jouet ~]# ls -la ~/.debug/.build-id/44/d954246227536955cb1ecbe9ef2a05665876b6
ls: cannot access '/root/.debug/.build-id/44/d954246227536955cb1ecbe9ef2a05665876b6': No such file or directory
[root@jouet ~]# ls -la ~/.debug/home/build/v4.16.0-rc4/vmlinux/44d954246227536955cb1ecbe9ef2a05665876b6/
ls: cannot access '/root/.debug/home/build/v4.16.0-rc4/vmlinux/44d954246227536955cb1ecbe9ef2a05665876b6/': No such file or directory
[root@jouet ~]#

Ok, so now I do:

[root@jouet ~]# perf annotate --stdio --vmlinux /lib/modules/4.16.0-rc4/build/vmlinux filemap_map_pages
Failed to open [kernel.kallsyms]_text, continuing without symbols
Error:
The perf.data file has no samples!
[root@jouet ~]# 


But I ran out of time today, this one needs a bit more investigation, I
couldn't get to that dso__disassemble_filename() in the above case :-\
 
> For https://patchwork.kernel.org/patch/10211483/, I'm not sure how to go about doing a reply to all.

So, no need for that, just state here that you provide your Signed-off-by: to
it and I'll add it, which is what I'm doing now since this seems to be your
intent, right?

I'll just add another Link: tag pointing to your reply to -this- message,
if it comes with a S-o-B for https://patchwork.kernel.org/patch/10211483/, ok?

- Arnaldo
 
> I had some email problems and was cut-off from the list for a while.
> 
> MV
> 
> 
> On 03/09/18 13:24, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 09, 2018 at 12:07:20PM -0600, Kim Phillips escreveu:
> > > On Fri, 9 Mar 2018 12:06:27 -0300
> > > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > 
> > > Hi Arnaldo,
> > > 
> > > > Em Thu, Mar 08, 2018 at 09:10:30PM -0600, Kim Phillips escreveu:
> > > > > Based on prior work:
> > > > > 
> > > > > https://lkml.org/lkml/2014/5/6/395
> > > > Thanks, looks good, applying.
> > > > 
> > > > Jean, is everything ok with you on this?
> > > By now your email to Jean should have bounced with "The email account
> > > that you tried to reach does not exist."  Removing Jean from Cc.
> > > 
> > > It seems like you're applying patches.  There are a couple that have
> > > slipped through the cracks: Can you please take a look at applying them?
> > > 
> > > - "perf tools: Fixing uninitialised variable"
> > >    https://patchwork.kernel.org/patch/10179381/
> > [acme@jouet perf]$ git tag --contains d2785de15f1bd42d613d56bbac5a007e7293b874
> > perf-core-for-mingo-4.17-20180216
> > 
> > commit d2785de15f1bd42d613d56bbac5a007e7293b874
> > Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
> > AuthorDate: Mon Feb 12 13:32:37 2018 -0700
> > Commit:     Arnaldo Carvalho de Melo <acme@redhat.com>
> > CommitDate: Fri Feb 16 14:55:40 2018 -0300
> > 
> >      perf auxtrace arm: Fixing uninitialised variable
> >      When working natively on arm64 the compiler gets pesky and complains
> >      that variable 'i' is uninitialised, something that breaks the
> >      compilation.  Here no further checks are needed since variable
> >      'found_spe' can only be true if variable 'i' has been initialised as
> >      part of the for loop.
> >      Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >      Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >      Cc: Jin Yao <yao.jin@linux.intel.com>
> >      Cc: Namhyung Kim <namhyung@kernel.org>
> >      Cc: Peter Zijlstra <peterz@infradead.org>
> >      Cc: linux-arm-kernel@lists.infradead.org
> >      Link: http://lkml.kernel.org/r/1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org
> >      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > index 2323581b157d..fa639e3e52ac 100644
> > --- a/tools/perf/arch/arm/util/auxtrace.c
> > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > @@ -68,7 +68,7 @@ struct auxtrace_record
> >          bool found_spe = false;
> >          static struct perf_pmu **arm_spe_pmus = NULL;
> >          static int nr_spes = 0;
> > -       int i;
> > +       int i = 0;
> > > - "perf unwind: Report error from dwfl_attach_state"
> > >    https://patchwork.kernel.org/patch/10211483/
> > >    [Martin, I guess it would help if you replied-all that patch and
> > >     added your signed-off-by.]
> > Right, the S-o-B is needed
> > > - "perf unwind: Unwind with libdw doesn't take symfs into account"
> > >    https://patchwork.kernel.org/patch/10211599/
> > This one has the S-o-B, applying, Jiri, holler if you disagree,
> > 
> > - Arnaldo
> > > Thanks,
> > > 
> > > Kim
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
