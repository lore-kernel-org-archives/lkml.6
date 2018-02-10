Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBJBp7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:45:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:64223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeBJBp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:45:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,486,1511856000";
   d="scan'208";a="17035877"
From: changbin.du@intel.com
To: rostedt@goodmis.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH] tracing/power: Don't share template for cpu_idle and cpu_frequency
Date: Sat, 10 Feb 2018 09:37:04 +0800
Message-Id: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The type of state is signed int, convert it to unsigned int looks weird.
(-1 become 4294967295)
   932.123 power:cpu_idle:state=1 cpu_id=0)
   932.125 power:cpu_idle:state=4294967295 cpu_id=0)
   932.132 power:cpu_idle:state=1 cpu_id=0)
   932.133 power:cpu_idle:state=4294967295 cpu_id=0)

Similarly for cpu_frequency as "state=%lu cpu_id=%lu". User need to read
the code to understand what 'state' means.

No functional change in this patch.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 include/trace/events/power.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d..39bd6de 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -12,14 +12,14 @@
 
 #define TPS(x)  tracepoint_string(x)
 
-DECLARE_EVENT_CLASS(cpu,
+TRACE_EVENT(cpu_idle,
 
-	TP_PROTO(unsigned int state, unsigned int cpu_id),
+	TP_PROTO(int state, unsigned int cpu_id),
 
 	TP_ARGS(state, cpu_id),
 
 	TP_STRUCT__entry(
-		__field(	u32,		state		)
+		__field(	int,		state		)
 		__field(	u32,		cpu_id		)
 	),
 
@@ -28,17 +28,10 @@ DECLARE_EVENT_CLASS(cpu,
 		__entry->cpu_id = cpu_id;
 	),
 
-	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
+	TP_printk("state=%d cpu_id=%lu", __entry->state,
 		  (unsigned long)__entry->cpu_id)
 );
 
-DEFINE_EVENT(cpu, cpu_idle,
-
-	TP_PROTO(unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(state, cpu_id)
-);
-
 TRACE_EVENT(powernv_throttle,
 
 	TP_PROTO(int chip_id, const char *reason, int pmax),
@@ -141,11 +134,24 @@ TRACE_EVENT(pstate_sample,
 		{ PM_EVENT_RESTORE, "restore" }, \
 		{ PM_EVENT_RECOVER, "recover" })
 
-DEFINE_EVENT(cpu, cpu_frequency,
+TRACE_EVENT(cpu_frequency,
 
 	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
 
-	TP_ARGS(frequency, cpu_id)
+	TP_ARGS(frequency, cpu_id),
+
+	TP_STRUCT__entry(
+		__field(	u32,		frequency	)
+		__field(	u32,		cpu_id		)
+	),
+
+	TP_fast_assign(
+		__entry->frequency = frequency;
+		__entry->cpu_id = cpu_id;
+	),
+
+	TP_printk("frequency=%lu cpu_id=%lu", __entry->frequency,
+		  (unsigned long)__entry->cpu_id)
 );
 
 TRACE_EVENT(device_pm_callback_start,
-- 
2.7.4
