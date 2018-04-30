Date: Mon, 30 Apr 2018 10:20:08 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	David Carrillo-Cisneros <davidcc@google.com>,
	He Kuang <hekuang@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Mackerras <paulus@samba.org>, Paul Turner <pjt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Simon Que <sque@chromium.org>,
	Stephane Eranian <eranian@google.com>,
	Wang Nan <wangnan0@huawei.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf session: Fix undeclared 'oe'
Message-ID: <20180430172008.GA4266@kroah.com>
References: <20180411184135.27664-1-muriloo@linux.ibm.com>
 <20180411193353.GA5656@kroah.com>
 <82d8f577-bbbb-0419-bf41-057522eb3f30@linux.ibm.com>
 <81025fb9-bab8-58ff-8f82-b1da9a1202ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81025fb9-bab8-58ff-8f82-b1da9a1202ec@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:11:55PM -0300, Murilo Opsfelder Araujo wrote:
> On 04/11/2018 05:21 PM, Murilo Opsfelder Araújo wrote:
> > On 04/11/2018 04:33 PM, Greg Kroah-Hartman wrote:
> >> On Wed, Apr 11, 2018 at 03:41:35PM -0300, Murilo Opsfelder Araujo wrote:
> >>> Using linux-3.18.y branch, perf build fails with the following:
> >>>
> >>>     $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
> >>>     [...]
> >>>     util/session.c: In function ‘__perf_session__process_pipe_events’:
> >>>     util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
> >>>       ordered_events__set_copy_on_queue(oe, true);
> >>>                                         ^
> >>>     util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in
> >>>
> >>> This patch fixes it for linux-3.18.y branch.
> >>
> >> Why is this failing now?  Has it always been broken?  Is there an
> >> upstream patch that fixed this instead?
> >>
> > 
> > Hi, Greg.
> > 
> > We've caught this build issue this week. I'm not sure since when it's
> > failing.
> > 
> > The upstream patch that fixes this is:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d
> > 
> > commit fa713a4eb9cebe5dec71b1bd11429603e17d841d
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Tue Mar 3 11:48:12 2015 -0300
> > 
> >     perf ordered_events: Untangle from perf_session
> > 
> > But it doesn't apply straightforwardly.  At
> > fa713a4eb9cebe5dec71b1bd11429603e17d841d, perf API and perf_evlist
> > struct are slightly different from linux-3.18.y.
> > 
> > A list of upstream patches for a clean backport (I think) would be:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54245fdc357613633954bfd38cffb71cb9def067
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75be989a7a18e9666efd92b846ee48bed79e8086
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=313e53b08e99b1dacf9ea2b0fbe97890db1ea95f
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fa8727aa4d98d35ca50ef9cd8a50c6468af921d
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d
> > 
> > Do you prefer all above patches backported to linux-3.18.y or just the
> > one-line fix I sent?
> > 
> >>> Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")
> >>
> >> Was this just a bad backport?
> > 
> > Some patches were left behind, I guess.
> > 
> >>
> >> thanks,
> >>
> >> greg k-h
> 
> Hi, Greg.
> 
> I've realized that perf build on v3.18.107 is still broken, actually, it
> got a bit worse than v3.18.104.
> 
> After applying my patch to fix the undeclared 'oe', perf build fails
> with the following errors:
> 
> $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1
> HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1
> prefix=/usr DESTDIR=/tmp/builddir/build all
> [...]
> tests/code-reading.c: In function ‘read_object_code’:
> tests/code-reading.c:145:19: error: ‘KMOD_DECOMP_LEN’ undeclared (first
> use in this function)
>   char decomp_name[KMOD_DECOMP_LEN];
>                    ^
> tests/code-reading.c:145:19: note: each undeclared identifier is
> reported only once for each function it appears in
> tests/code-reading.c:208:2: warning: implicit declaration of function
> ‘dso__needs_decompress’ [-Wimplicit-function-declaration]
>   if (dso__needs_decompress(al.map->dso)) {
>   ^
> tests/code-reading.c:208:2: warning: nested extern declaration of
> ‘dso__needs_decompress’ [-Wnested-externs]
> tests/code-reading.c:209:3: warning: implicit declaration of function
> ‘dso__decompress_kmodule_path’ [-Wimplicit-function-declaration]
>    if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
>    ^
> tests/code-reading.c:209:3: warning: nested extern declaration of
> ‘dso__decompress_kmodule_path’ [-Wnested-externs]
> tests/code-reading.c:145:7: warning: unused variable ‘decomp_name’
> [-Wunused-variable]
>   char decomp_name[KMOD_DECOMP_LEN];
>        ^
> 
> Apparently, this was introduced by commit
> 091b3b4ba55daf8b28f40794aefdaa0bdb5af7a1:
> 
> commit 091b3b4ba55daf8b28f40794aefdaa0bdb5af7a1
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Thu Jun 8 16:31:07 2017 +0900
> 
>     perf tests: Decompress kernel module before objdump
> 
> 
> Namhyung, are you fixing this?

Ugh, I can fix this, I just did so on 4.4.y...

greg k-h
