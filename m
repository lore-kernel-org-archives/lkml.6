Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeCUSwm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeCUSwl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:52:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CE921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Mar 2018 15:52:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
Message-ID: <20180321185237.GF24312@kernel.org>
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
 <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
 <20180321153807.GA2707@krava>
 <20180321154035.GC24312@kernel.org>
 <20180321154315.GD24312@kernel.org>
 <20180321160446.GB2707@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321160446.GB2707@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 21, 2018 at 05:04:46PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 21, 2018 at 12:43:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 21, 2018 at 12:40:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Mar 21, 2018 at 04:38:07PM +0100, Jiri Olsa escreveu:
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

> > > > true.. Arnaldo, any feedback on this one?

> > > Lemme re-read the thread...

> > Well, how about we make it harder to build without key libraries? I.e.
> > if we detect that what we consider a core set of libraries isn't found
> > in the system, then we stop the build, warn about it and ask the user to
> > confirm that the build should proceed by passing some explicit
> > -DI_KNOW_WHAT_I_AM_DOING___PROCEED=doit

> hum, not sure we want to complicate the build even more than it
> is now :-\ and IMO it still won't help much in Jin's problem,
> if user forces the build anyway

Well, if a user _forces_ a build, not taking into consideration a
warning that _is_ emitted and _stops_ the build, about the functionality
it will lose by doing forcing the build, then comes back and complains
that that functionality is not present, then it becomes difficult to
help this user...  :-)

On the other hand, if the user forgets to install an important library,
the warning is emitted but the build proceeds, no explicit action was
performed, just a warning wasn't noticed, and the user complains, then
I'd say: "hey, are you sure library foo devel files were present when
you build it?", i.e. the support back and forth Jin is trying to avoid.

And for users that _saw_ the warning, _knew_ they _didn't_ want that
functionality, to be reminded while running, say 'perf report' that
something they _decided not to have_ isn't present, then that could be
annoying, no?

Lemme try another idea: what if we do something like gcc does and print
the features present when showing the version?

I.e.:

[acme@jouet perf]$ gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/7/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,objc,obj-c++,fortran,ada,go,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --enable-libmpx --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux
Thread model: posix
gcc version 7.3.1 20180303 (Red Hat 7.3.1-5) (GCC) 
[acme@jouet perf]$ 

- Arnaldo
