Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCWOuy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbeCWOux (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:50:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE842168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 23 Mar 2018 11:50:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
Message-ID: <20180323145049.GF4229@kernel.org>
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
 <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
 <20180321153807.GA2707@krava>
 <e02a4bff-78e3-67b4-29b4-e0c7c4cd8ea2@linux.intel.com>
 <20180322085147.GI2707@krava>
 <5f7ae627-572d-fc02-e9ea-ec56b640c636@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7ae627-572d-fc02-e9ea-ec56b640c636@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 23, 2018 at 11:09:03AM +0800, Jin, Yao escreveu:
> On 3/22/2018 4:51 PM, Jiri Olsa wrote:
> > On Thu, Mar 22, 2018 at 09:04:10AM +0800, Jin, Yao wrote:
> > > On 3/21/2018 11:38 PM, Jiri Olsa wrote:
> > > > On Wed, Mar 21, 2018 at 10:11:10AM +0800, Jin, Yao wrote:
> > > > > Hi Jiri,
> > > > > 
> > > > > I'm still thinking it's worth displaying the warning when perf missing some
> > > > > libraries.
> > > > > 
> > > > > Somebody just told me that perf didn't work well. While after some
> > > > > investigations, I found it's just missing some libraries when building the
> > > > > perf.
> > > > > 
> > > > > But I have spent some time on getting the root cause. If with this patch, it
> > > > > should be very easily to know that.
> > > > 
> > > > true.. Arnaldo, any feedback on this one?
> > > > 
> > > > > > I just think it'd better provide some hints to user. For example,
> > > > > > "symbol is disabled and you need to install libelf/xxx", say something
> > > > > > like that.
> > > > > > 
> > > > > > But it looks the column can't contain too much information (i.e. no more
> > > > > > space to contain the entire hints).
> > > > > > 
> > > > > > Any idea? Or just add this warning in verbose mode?
> > > > > > 
> > > > > > > also your change does not affect tui mode
> > > > > > > 
> > > > > > > annotation for some reason does not start at all.. could be
> > > > > > > little more verbose ;-)
> > > > > > > 
> > > > > > > jirka
> > > > > > > 
> > > > > > 
> > > > > > Yes, it doesn't affect tui mode.
> > > > > > 
> > > > > > Or we just add this warning in verbose mode?
> > > > > > 
> > > > > > e.g. perf report -v?
> > > > 
> > > > how about displaying libraries separately with -vv output,
> > > > that would mimic the build message, like:
> > > > 
> > > >     $ ./perf -vv
> > > >     perf version 4.16.rc6.g18fd48
> > > > 
> > > >                      dwarf: [ on  ]
> > > >         dwarf_getlocations: [ on  ]
> > > >                      glibc: [ on  ]
> > > >                       gtk2: [ on  ]
> > > >                   libaudit: [ on  ]
> > > >                     libbfd: [ on  ]
> > > >                     libelf: [ on  ]
> > > >                    libnuma: [ on  ]
> > > >     numa_num_possible_cpus: [ on  ]
> > > >                    libperl: [ on  ]
> > > >                  libpython: [ on  ]
> > > >                   libslang: [ on  ]
> > > >                  libcrypto: [ on  ]
> > > >                  libunwind: [ on  ]
> > > >         libdw-dwarf-unwind: [ on  ]
> > > >                       zlib: [ on  ]
> > > >                       lzma: [ on  ]
> > > >                  get_cpuid: [ on  ]
> > > >                        bpf: [ on  ]
> > > > 
> > > > and perf -vvv could display the 'make VF=1' info
> > > > 
> > > > jirka
> > > > 
> > > 
> > > I'm just afraid that the newbie will not check the -vv on his own when he
> > > gets trouble in using perf.
> > > 
> > > In other words, if a user is experienced and he knows -vv yet, I may assume
> > > that he should know installing all libraries before building the perf.
> > > 
> > > This patch is specific for the perf newbie. It will directly shows the
> > > error/warning when the user launches the perf binary. It will have a little
> > > bit helps, I guess. :)
> > 
> > I just don't like the idea that when you run perf report,
> > or annotate it spits out lines for every missing feature
> > 
> > maybe we could detect missing features for given command
> > and display line about missing features and say something
> > like:
> > 
> > 'Warning: symbol,dwarf support not compiled in (for more details run perf -vv)'
> > 
> > or somwthing like that.. ;-)
> > 
> > jirka
> > 
> 
> Hi Jiri,
> 
> I think your idea is very good!
> 
> I guess following it's just an example copied from perf building process,
> right?
> 
> $ ./perf -vv
> perf version 4.16.rc6.g18fd48
> 
>                  dwarf: [ on  ]
>     dwarf_getlocations: [ on  ]
>                  glibc: [ on  ]
>                   gtk2: [ on  ]
>               libaudit: [ on  ]
>                 libbfd: [ on  ]
>                 libelf: [ on  ]
>                libnuma: [ on  ]
> numa_num_possible_cpus: [ on  ]
>                libperl: [ on  ]
>              libpython: [ on  ]
>               libslang: [ on  ]
>              libcrypto: [ on  ]
>              libunwind: [ on  ]
>     libdw-dwarf-unwind: [ on  ]
>                   zlib: [ on  ]
>                   lzma: [ on  ]
>              get_cpuid: [ on  ]
>                    bpf: [ on  ]
> 
> We can check some CFLAGS like "#ifdef HAVE_XXX" in perf code to determine if
> some libraries are compiled in.
> 
> For example,
> 
> #ifdef HAVE_LIBNUMA_SUPPORT
> 	printf("libnuma: [ on  ]");
> #endif
> 
> For some features, such as "numa_num_possible_cpus", which doesn't have
> CFLAGS variables. Maybe we can ignore them in report?
> 
> I'd like to upgrade my patch to support perf -vv.

Please go ahead! :-) We're all on the same page now, I think.

- Arnaldo
