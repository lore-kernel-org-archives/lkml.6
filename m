Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCMPPC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:15:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeCMPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:15:00 -0400
Date: Tue, 13 Mar 2018 08:14:13 -0700
From: tip-bot for Milind Chabbi <tipbot@zytor.com>
Message-ID: <tip-32ff77e8cc9e66cc4fb38098f64fd54cc8f54573@git.kernel.org>
Cc: chabbi.milind@gmail.com, namhyung@kernel.org, mpe@ellerman.id.au,
        will.deacon@arm.com, mingo@kernel.org, peterz@infradead.org,
        fweisbec@gmail.com, dsahern@gmail.com, sukadev@linux.vnet.ibm.com,
        kan.liang@intel.com, jolsa@kernel.org, hbathini@linux.vnet.ibm.com,
        acme@redhat.com, onestero@redhat.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, onestero@redhat.com,
        acme@redhat.com, hbathini@linux.vnet.ibm.com, kan.liang@intel.com,
        jolsa@kernel.org, mingo@kernel.org, peterz@infradead.org,
        fweisbec@gmail.com, sukadev@linux.vnet.ibm.com, dsahern@gmail.com,
        mpe@ellerman.id.au, will.deacon@arm.com, chabbi.milind@gmail.com,
        namhyung@kernel.org
In-Reply-To: <20180312134548.31532-8-jolsa@kernel.org>
References: <20180312134548.31532-8-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Implement fast breakpoint modification
 via _IOC_MODIFY_ATTRIBUTES
Git-Commit-ID: 32ff77e8cc9e66cc4fb38098f64fd54cc8f54573
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  32ff77e8cc9e66cc4fb38098f64fd54cc8f54573
Gitweb:     https://git.kernel.org/tip/32ff77e8cc9e66cc4fb38098f64fd54cc8f54573
Author:     Milind Chabbi <chabbi.milind@gmail.com>
AuthorDate: Mon, 12 Mar 2018 14:45:47 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 15:24:02 +0100

perf/core: Implement fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES

Problem and motivation: Once a breakpoint perf event (PERF_TYPE_BREAKPOINT)
is created, there is no flexibility to change the breakpoint type
(bp_type), breakpoint address (bp_addr), or breakpoint length (bp_len). The
only option is to close the perf event and configure a new breakpoint
event. This inflexibility has a significant performance overhead. For
example, sampling-based, lightweight performance profilers (and also
concurrency bug detection tools),  monitor different addresses for a short
duration using PERF_TYPE_BREAKPOINT and change the address (bp_addr) to
another address or change the kind of breakpoint (bp_type) from  "write" to
a "read" or vice-versa or change the length (bp_len) of the address being
monitored. The cost of these modifications is prohibitive since it involves
unmapping the circular buffer associated with the perf event, closing the
perf event, opening another perf event and mmaping another circular buffer.

Solution: The new ioctl flag for perf events,
PERF_EVENT_IOC_MODIFY_ATTRIBUTES, introduced in this patch takes a pointer
to a struct perf_event_attr as an argument to update an old breakpoint
event with new address, type, and size. This facility allows retaining a
previous mmaped perf events ring buffer and avoids having to close and
reopen another perf event.

This patch supports only changing PERF_TYPE_BREAKPOINT event type; future
implementations can extend this feature. The patch replicates some of its
functionality of modify_user_hw_breakpoint() in
kernel/events/hw_breakpoint.c. modify_user_hw_breakpoint cannot be called
directly since perf_event_ctx_lock() is already held in _perf_ioctl().

Evidence: Experiments show that the baseline (not able to modify an already
created breakpoint) costs an order of magnitude (~10x) more than the
suggested optimization (having the ability to dynamically modifying a
configured breakpoint via ioctl). When the breakpoints typically do not
trap, the speedup due to the suggested optimization is ~10x; even when the
breakpoints always trap, the speedup is ~4x due to the suggested
optimization.

Testing: tests posted at
https://github.com/linux-contrib/perf_event_modify_bp demonstrate the
performance significance of this patch. Tests also check the functional
correctness of the patch.

Signed-off-by: Milind Chabbi <chabbi.milind@gmail.com>
[ Using modify_user_hw_breakpoint_check function. ]
[ Reformated PERF_EVENT_IOC_*, so the values are all in one column. ]
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <onestero@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180312134548.31532-8-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/hw_breakpoint.h         |  7 +++++
 include/uapi/linux/perf_event.h       | 23 +++++++++--------
 kernel/events/core.c                  | 48 +++++++++++++++++++++++++++++++++++
 kernel/events/hw_breakpoint.c         |  2 +-
 tools/include/uapi/linux/perf_event.h | 23 +++++++++--------
 5 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index cf045885a499..6058c3844a76 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -53,6 +53,9 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 /* FIXME: only change from the attr, and don't unregister */
 extern int
 modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr);
+extern int
+modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
+				bool check);
 
 /*
  * Kernel breakpoints are not associated with any particular thread.
@@ -97,6 +100,10 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 static inline int
 modify_user_hw_breakpoint(struct perf_event *bp,
 			  struct perf_event_attr *attr)	{ return -ENOSYS; }
+static inline int
+modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
+				bool check)	{ return -ENOSYS; }
+
 static inline struct perf_event *
 register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
 				perf_overflow_handler_t	 triggered,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 6f873503552d..912b85b52344 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -448,17 +448,18 @@ struct perf_event_query_bpf {
 /*
  * Ioctls that can be done on a perf event fd:
  */
-#define PERF_EVENT_IOC_ENABLE		_IO ('$', 0)
-#define PERF_EVENT_IOC_DISABLE		_IO ('$', 1)
-#define PERF_EVENT_IOC_REFRESH		_IO ('$', 2)
-#define PERF_EVENT_IOC_RESET		_IO ('$', 3)
-#define PERF_EVENT_IOC_PERIOD		_IOW('$', 4, __u64)
-#define PERF_EVENT_IOC_SET_OUTPUT	_IO ('$', 5)
-#define PERF_EVENT_IOC_SET_FILTER	_IOW('$', 6, char *)
-#define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
-#define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
-#define PERF_EVENT_IOC_PAUSE_OUTPUT	_IOW('$', 9, __u32)
-#define PERF_EVENT_IOC_QUERY_BPF	_IOWR('$', 10, struct perf_event_query_bpf *)
+#define PERF_EVENT_IOC_ENABLE			_IO ('$', 0)
+#define PERF_EVENT_IOC_DISABLE			_IO ('$', 1)
+#define PERF_EVENT_IOC_REFRESH			_IO ('$', 2)
+#define PERF_EVENT_IOC_RESET			_IO ('$', 3)
+#define PERF_EVENT_IOC_PERIOD			_IOW('$', 4, __u64)
+#define PERF_EVENT_IOC_SET_OUTPUT		_IO ('$', 5)
+#define PERF_EVENT_IOC_SET_FILTER		_IOW('$', 6, char *)
+#define PERF_EVENT_IOC_ID			_IOR('$', 7, __u64 *)
+#define PERF_EVENT_IOC_SET_BPF			_IOW('$', 8, __u32)
+#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
+#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ee145bdee6ed..3b4c7792a6ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2846,6 +2846,41 @@ int perf_event_refresh(struct perf_event *event, int refresh)
 }
 EXPORT_SYMBOL_GPL(perf_event_refresh);
 
+static int perf_event_modify_breakpoint(struct perf_event *bp,
+					 struct perf_event_attr *attr)
+{
+	int err;
+
+	_perf_event_disable(bp);
+
+	err = modify_user_hw_breakpoint_check(bp, attr, true);
+	if (err) {
+		if (!bp->attr.disabled)
+			_perf_event_enable(bp);
+
+		return err;
+	}
+
+	if (!attr->disabled)
+		_perf_event_enable(bp);
+	return 0;
+}
+
+static int perf_event_modify_attr(struct perf_event *event,
+				  struct perf_event_attr *attr)
+{
+	if (event->attr.type != attr->type)
+		return -EINVAL;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_BREAKPOINT:
+		return perf_event_modify_breakpoint(event, attr);
+	default:
+		/* Place holder for future additions. */
+		return -EOPNOTSUPP;
+	}
+}
+
 static void ctx_sched_out(struct perf_event_context *ctx,
 			  struct perf_cpu_context *cpuctx,
 			  enum event_type_t event_type)
@@ -4952,6 +4987,8 @@ static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
+static int perf_copy_attr(struct perf_event_attr __user *uattr,
+			  struct perf_event_attr *attr);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -5024,6 +5061,17 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 	case PERF_EVENT_IOC_QUERY_BPF:
 		return perf_event_query_prog_array(event, (void __user *)arg);
+
+	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
+		struct perf_event_attr new_attr;
+		int err = perf_copy_attr((struct perf_event_attr __user *)arg,
+					 &new_attr);
+
+		if (err)
+			return err;
+
+		return perf_event_modify_attr(event,  &new_attr);
+	}
 	default:
 		return -ENOTTY;
 	}
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 0c82663395f7..6253d5519cd8 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -456,7 +456,7 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
-static int
+int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 6f873503552d..912b85b52344 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -448,17 +448,18 @@ struct perf_event_query_bpf {
 /*
  * Ioctls that can be done on a perf event fd:
  */
-#define PERF_EVENT_IOC_ENABLE		_IO ('$', 0)
-#define PERF_EVENT_IOC_DISABLE		_IO ('$', 1)
-#define PERF_EVENT_IOC_REFRESH		_IO ('$', 2)
-#define PERF_EVENT_IOC_RESET		_IO ('$', 3)
-#define PERF_EVENT_IOC_PERIOD		_IOW('$', 4, __u64)
-#define PERF_EVENT_IOC_SET_OUTPUT	_IO ('$', 5)
-#define PERF_EVENT_IOC_SET_FILTER	_IOW('$', 6, char *)
-#define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
-#define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
-#define PERF_EVENT_IOC_PAUSE_OUTPUT	_IOW('$', 9, __u32)
-#define PERF_EVENT_IOC_QUERY_BPF	_IOWR('$', 10, struct perf_event_query_bpf *)
+#define PERF_EVENT_IOC_ENABLE			_IO ('$', 0)
+#define PERF_EVENT_IOC_DISABLE			_IO ('$', 1)
+#define PERF_EVENT_IOC_REFRESH			_IO ('$', 2)
+#define PERF_EVENT_IOC_RESET			_IO ('$', 3)
+#define PERF_EVENT_IOC_PERIOD			_IOW('$', 4, __u64)
+#define PERF_EVENT_IOC_SET_OUTPUT		_IO ('$', 5)
+#define PERF_EVENT_IOC_SET_FILTER		_IOW('$', 6, char *)
+#define PERF_EVENT_IOC_ID			_IOR('$', 7, __u64 *)
+#define PERF_EVENT_IOC_SET_BPF			_IOW('$', 8, __u32)
+#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
+#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
