Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeCNIpT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:45:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCNIpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:45:17 -0400
Date: Wed, 14 Mar 2018 09:45:13 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH] hw_breakpoint: Fix build for disabled
 CONFIG_HAVE_HW_BREAKPOINT
Message-ID: <20180314084513.GA9216@krava>
References: <20180312134548.31532-1-jolsa@kernel.org>
 <20180313063747.b4bw2j25cvtgjk5b@gmail.com>
 <20180313092801.GB16389@krava>
 <20180313095045.GC16389@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313095045.GC16389@krava>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:50:45AM +0100, Jiri Olsa wrote:
> On Tue, Mar 13, 2018 at 10:28:01AM +0100, Jiri Olsa wrote:
> > On Tue, Mar 13, 2018 at 07:37:47AM +0100, Ingo Molnar wrote:
> > > 
> > > * Jiri Olsa <jolsa@kernel.org> wrote:
> > > 
> > > > Jiri Olsa (7):
> > > >       hw_breakpoint: Pass bp_type directly as find_slot_idx argument
> > > >       hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot
> > > >       hw_breakpoint: Add modify_bp_slot function
> > > >       hw_breakpoint: Factor out __modify_user_hw_breakpoint function
> > > >       hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint
> > > >       perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr
> > > >       perf tests: Add breakpoint accounting/modify test
> > > > 
> > > > Milind Chabbi (1):
> > > >       perf/core: fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES.
> > > > 
> > > >  include/linux/hw_breakpoint.h         |   7 +++++
> > > >  include/uapi/linux/perf_event.h       |  23 ++++++++-------
> > > >  kernel/events/core.c                  |  54 ++++++++++++++++++++++++++++++++--
> > > >  kernel/events/hw_breakpoint.c         | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
> > > >  tools/include/uapi/linux/perf_event.h |  23 ++++++++-------
> > > >  tools/perf/tests/Build                |   1 +
> > > >  tools/perf/tests/bp_account.c         | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tools/perf/tests/builtin-test.c       |   4 +++
> > > >  tools/perf/tests/tests.h              |   1 +
> > > >  9 files changed, 365 insertions(+), 58 deletions(-)
> > > >  create mode 100644 tools/perf/tests/bp_account.c
> > > 
> > > Note, there's a new PARISC build failure:
> > > 
> > >  home/mingo/tip/kernel/events/core.c:2858:2: error: implicit declaration of function 'modify_user_hw_breakpoint_check' [-Werror=implicit-function-declaration]
> > >    err = modify_user_hw_breakpoint_check(bp, attr, true);
> > > 
> > > will only be able to push it out to -next once this is fixed.
> > 
> > ok, checking on that
> 
> should be this one.. I'm checking on s390 which is also
> without breakpoint support, I'll send full patch after

and here it is

thanks,
jirka


---
We're missing stub for modify_user_hw_breakpoint_check function
when option CONFIG_HAVE_HW_BREAKPOINT is disabled. It was mixed
up in recent changes.

Fixes: f30b09b7f8ae ("perf/core: Implement fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/hw_breakpoint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index abeba094f080..6058c3844a76 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -101,8 +101,8 @@ static inline int
 modify_user_hw_breakpoint(struct perf_event *bp,
 			  struct perf_event_attr *attr)	{ return -ENOSYS; }
 static inline int
-__modify_user_hw_breakpoint(struct perf_event *bp,
-			    struct perf_event_attr *attr) { return -ENOSYS; }
+modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
+				bool check)	{ return -ENOSYS; }
 
 static inline struct perf_event *
 register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
-- 
2.13.6
