Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeCUPn3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752324AbeCUPnR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:43:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF16217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Mar 2018 12:43:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
Message-ID: <20180321154315.GD24312@kernel.org>
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
 <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
 <20180321153807.GA2707@krava>
 <20180321154035.GC24312@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321154035.GC24312@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 21, 2018 at 12:40:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 21, 2018 at 04:38:07PM +0100, Jiri Olsa escreveu:
> > On Wed, Mar 21, 2018 at 10:11:10AM +0800, Jin, Yao wrote:
> > > Hi Jiri,
> > > 
> > > I'm still thinking it's worth displaying the warning when perf missing some
> > > libraries.
> > > 
> > > Somebody just told me that perf didn't work well. While after some
> > > investigations, I found it's just missing some libraries when building the
> > > perf.
> > > 
> > > But I have spent some time on getting the root cause. If with this patch, it
> > > should be very easily to know that.
> > 
> > true.. Arnaldo, any feedback on this one?
> 
> Lemme re-read the thread...

Well, how about we make it harder to build without key libraries? I.e.
if we detect that what we consider a core set of libraries isn't found
in the system, then we stop the build, warn about it and ask the user to
confirm that the build should proceed by passing some explicit
-DI_KNOW_WHAT_I_AM_DOING___PROCEED=doit

?

- Arnaldo
 
>  
> > > > I just think it'd better provide some hints to user. For example,
> > > > "symbol is disabled and you need to install libelf/xxx", say something
> > > > like that.
> > > > 
> > > > But it looks the column can't contain too much information (i.e. no more
> > > > space to contain the entire hints).
> > > > 
> > > > Any idea? Or just add this warning in verbose mode?
> > > > 
> > > > > also your change does not affect tui mode
> > > > > 
> > > > > annotation for some reason does not start at all.. could be
> > > > > little more verbose ;-)
> > > > > 
> > > > > jirka
> > > > > 
> > > > 
> > > > Yes, it doesn't affect tui mode.
> > > > 
> > > > Or we just add this warning in verbose mode?
> > > > 
> > > > e.g. perf report -v?
> > 
> > how about displaying libraries separately with -vv output,
> > that would mimic the build message, like:
> > 
> >   $ ./perf -vv
> >   perf version 4.16.rc6.g18fd48
> > 
> >                    dwarf: [ on  ]
> >       dwarf_getlocations: [ on  ]
> >                    glibc: [ on  ]
> >                     gtk2: [ on  ]
> >                 libaudit: [ on  ]
> >                   libbfd: [ on  ]
> >                   libelf: [ on  ]
> >                  libnuma: [ on  ]
> >   numa_num_possible_cpus: [ on  ]
> >                  libperl: [ on  ]
> >                libpython: [ on  ]
> >                 libslang: [ on  ]
> >                libcrypto: [ on  ]
> >                libunwind: [ on  ]
> >       libdw-dwarf-unwind: [ on  ]
> >                     zlib: [ on  ]
> >                     lzma: [ on  ]
> >                get_cpuid: [ on  ]
> >                      bpf: [ on  ]
> > 
> > and perf -vvv could display the 'make VF=1' info
> > 
> > jirka
