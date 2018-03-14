Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeCNJpb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:45:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:45:29 -0400
Date: Wed, 14 Mar 2018 10:45:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180314094519.GD4082@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com>
 <20180312082741.GD4064@hirez.programming.kicks-ass.net>
 <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:45:45PM +0000, Jason Vas Dias wrote:
> On 12/03/2018, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Mar 12, 2018 at 07:01:20AM +0000, Jason Vas Dias wrote:
> >>   Sometimes, particularly when correlating elapsed time to performance
> >>   counter values,
> >
> > So what actual problem are you tring to solve here? Perf can already
> > give you sample time in various clocks, including MONOTONIC_RAW.
> >
> >
> 
> Yes, I am sampling perf counters,

You're not in fact sampling, you're just reading the counters.

> including CPU_CYCLES , INSTRUCTIONS,
> CPU_CLOCK, TASK_CLOCK, etc, in a Group FD I open with
> perf_event_open() , for the current thread on the current CPU -
> I am doing this for 4 threads , on Intel & ARM cpus.
> 
> Reading performance counters does involve  2 ioctls and a read() ,
> which takes time that  already far exceeds the time required to read
> the TSC or CNTPCT in the VDSO .

So you can avoid the whole ioctl(ENABLE), ioctl(DISABLE) nonsense and
just let them run and do:

	read(group_fd, &buf_pre, size);
	/* your code section */
	read(group_fd, &buf_post, size);

	/* compute buf_post - buf_pre */

Which is only 2 system calls, not 4.

Also, a while back there was the proposal to extend the mmap()
self-monitoring interface to groups, see:

 https://lkml.kernel.org/r/20170530172555.5ya3ilfw3sowokjz@hirez.programming.kicks-ass.net

I never did get around to writing the actual code for it, but it
shouldn't be too hard.

> The CPU_CLOCK software counter should give the converted TSC cycles
> seen between the ioctl( grp_fd, PERF_EVENT_IOC_ENABLE , ...)
> and the  ioctl( grp_fd, PERF_EVENT_IOC_DISABLE ), and the
> difference between the event->time_running and time_enabled
> should also measure elapsed time .

While CPU_CLOCK is TSC based, there is no guarantee it has any
correlation to CLOCK_MONOTONIC_RAW (even if that is also TSC based).

(although, I think I might have fixed that recently and it might just
work, but it's very much not guaranteed).

If you want to correlate to CLOCK_MONOTONIC_RAW you have to read
CLOCK_MONOTONIC_RAW and not some random other clock value.

> This gives the "inner" elapsed time, from the perpective of the kernel,
> while the measured code section had the counters enabled.
> 
> But unless the user-space program  also has a way of measuring elapsed
> time from the CPU's perspective , ie. without being subject to
> operator or NTP / PTP adjustment, it has no way of correlating this
> inner elapsed time with any "outer"

You could read the time using the group_fd's mmap() page. That actually
includes the TSC mult,shift,offset as used by perf clocks.

> Currently, users must parse the log file or use gdb / objdump to
> inspect /proc/kcore to get the TSC calibration and exact
> mult+shift values for the TSC value conversion.

Which ;-) there's multiple floating around..

> Intel does not publish, nor does the CPU come with in ROM or firmware,
> the actual precise TSC frequency - this must be calibrated against the
> other clocks , according to a complicated procedure in section 18.2 of
> the SDM . My TSC has a "rated" / nominal TSC frequency , which one
> can compute from CPUID leaves, of 2.3ghz, but the "Refined TSC frequency"
> is 2.8333ghz .

You might want to look at commit:

  b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake Xeon")

There is no such thing as a precise TSC frequency, there's a reason we
have NTP/PTP.

> Hence I think Linux should export this calibrated frequency somehow ;
> its "calibration" is expressed as the raw clocksource 'mult' and 'shift'
> values, and is exported to the VDSO .
> 
> I think the VDSO should read the TSC and use the calibration
> to render the raw, unadjusted time from the CPU's perspective.
> 
> Hence, the patch I am preparing , which is again attached.

I have no objection to adding CLOCK_MONOTONIC_RAW support to the VDSO,
but you seem to be rather confused on how things work.

Now, if you wanted to actually have CLOCK_MONOTONIC_RAW times from perf
you'd need something like the below patch.

You'd need to create your events with:

	attr.use_clockid = 1;
	attr.clockid = CLOCK_MONOTONIC_RAW;
	attr.read_format |= PERF_FORMAT_TIME;

But whatever you do, you really have to stop mixing clocks, that's
broken, even if it magically works for now.

---
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 912b85b52344..e210c9a97f2b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -271,9 +271,11 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		time;         } && PERF_FORMAT_TIME
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
+ *	  { u64         time;         } && PERF_FORMAT_TIME
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
@@ -287,8 +289,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_TIME			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c87decf03757..4298b4a39bc0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1707,6 +1707,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 		size += sizeof(u64);
 	}
 
+	if (event->attr.read_format & PERF_FORMAT_TIME)
+		size += sizeof(u64);
+
 	size += entry * nr;
 	event->read_size = size;
 }
@@ -4685,6 +4688,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 	int n = 1; /* skip @nr */
 	int ret;
 
+	if (read_format & PERF_FORMAT_TIME)
+		n++; /* skip @time */
+
 	ret = perf_event_read(leader, true);
 	if (ret)
 		return ret;
@@ -4739,6 +4745,9 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
+	if (read_format & PERF_FORMAT_TIME)
+		values[1] = perf_event_clock(event);
+
 	/*
 	 * By locking the child_mutex of the leader we effectively
 	 * lock the child list of all siblings.. XXX explain how.
@@ -4773,7 +4782,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -4783,6 +4792,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_TIME)
+		values[n++] = perf_event_clock(event)
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6034,7 +6045,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6049,6 +6060,9 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
 
+	if (read_format & PERF_FORMAT_TIME)
+		values[n++] = perf_event_clock(event);
+
 	__output_copy(handle, values, n * sizeof(u64));
 }
 
@@ -6058,11 +6072,14 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
 
+	if (read_format & PERF_FORMAT_TIME)
+		values[n++] = perf_event_clock(event);
+
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		values[n++] = enabled;
 
