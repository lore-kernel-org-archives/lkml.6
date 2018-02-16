Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966835AbeBPMgZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:36:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966628AbeBPMgY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:36:24 -0500
Date: Fri, 16 Feb 2018 13:36:19 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: [PATCH] perf report: Fix memory corruption in --branch-history mode
 --branch-history
Message-ID: <20180216123619.GA9945@krava>
References: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
 <20180213094551.GA26936@krava>
 <2bfe35a5-f671-90dc-4753-75c8b2215f30@linux.intel.com>
 <9b3483ae-a612-9d69-9671-4ddfea2c440e@linux.intel.com>
 <20180216075303.GD14831@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180216075303.GD14831@krava>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 08:53:04AM +0100, Jiri Olsa wrote:
> On Fri, Feb 16, 2018 at 10:25:31AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
> > >  From my opinion, the option '--max-stack' in perf report looks not very
> > > necessary. While it's just my personal opinion, need to hear from more
> > > people. :)
> > > 
> > > Thanks
> > > Jin Yao
> > > 
> > > > thanks,
> > > > jirka
> > > > 
> > > > 
> > > > ---
> > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > index b6140950301e..b50b7b70dcca 100644
> > > > --- a/tools/perf/util/hist.c
> > > > +++ b/tools/perf/util/hist.c
> > > > @@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct
> > > > hist_entry_iter *iter,
> > > >        * cumulated only one time to prevent entries more than 100%
> > > >        * overhead.
> > > >        */
> > > > -    he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
> > > > +    he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
> > > >       if (he_cache == NULL)
> > > >           return -ENOMEM;
> > > > 
> > 
> > Hi Jiri,
> > 
> > I guess you will post this patch, right?
> 
> yep, later today

here it is.. I think we want this change now to fix the crash, and
some more fixes later to ensure that the branch stack code follows
properly the logic of --max-stack, which is not the case now

thanks,
jirka


---
Jin Yao reported memory corrupton in perf report with
branch info used for stack trace:

> Following command lines will cause perf crash.

> perf record -j call -g -a <application>
> perf report --branch-history
>
> *** Error in `perf': double free or corruption (!prev): 0x00000000104aa040 ***
> ======= Backtrace: =========
> /lib/x86_64-linux-gnu/libc.so.6(+0x77725)[0x7f6b37254725]
> /lib/x86_64-linux-gnu/libc.so.6(+0x7ff4a)[0x7f6b3725cf4a]
> /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f6b37260abc]
> perf[0x51b914]
> perf(hist_entry_iter__add+0x1e5)[0x51f305]
> perf[0x43cf01]
> perf[0x4fa3bf]
> perf[0x4fa923]
> perf[0x4fd396]
> perf[0x4f9614]
> perf(perf_session__process_events+0x89e)[0x4fc38e]
> perf(cmd_report+0x15d2)[0x43f202]
> perf[0x4a059f]
> perf(main+0x631)[0x427b71]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f6b371fd830]
> perf(_start+0x29)[0x427d89]

For the cumulative output, we allocate he_cache array based
on the --max-stack option value and populate it with data
from callchain_cursor.

The --max-stack option value does not ensure now the limit
for number of callchain_cursor nodes, so the cumulative
iter code will allocate smaller array than it's actually
needed and cause above corruption.

I think the --max-stack limit does not apply here anyway,
because we add callchain data as normal hist entries,
while the --max-stack control the limit of single entry
callchain depth.

Using the callchain_cursor.nr as he_cache array count
to fix this. Also removing struct hist_entry_iter::max_stack,
because there's no longer any use for it.

We need more fixes to ensure that the branch stack code
follows properly the logic of --max-stack, which is not
the case at the moment.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Original-patch-by: Jin Yao <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-qj1kdpvyu25ac6w22lhmy7m2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 4 +---
 tools/perf/util/hist.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b6140950301e..44a8456cea10 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	 * cumulated only one time to prevent entries more than 100%
 	 * overhead.
 	 */
-	he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
+	he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
 	if (he_cache == NULL)
 		return -ENOMEM;
 
@@ -1045,8 +1045,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (err)
 		return err;
 
-	iter->max_stack = max_stack_depth;
-
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
 		goto out;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 02721b579746..e869cad4d89f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -107,7 +107,6 @@ struct hist_entry_iter {
 	int curr;
 
 	bool hide_unresolved;
-	int max_stack;
 
 	struct perf_evsel *evsel;
 	struct perf_sample *sample;
-- 
2.13.6
