Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeC1ULu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:11:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:46820 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbeC1ULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:11:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="37650443"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/4] tracing: Don't add flag strings when displaying variable references
Date: Wed, 28 Mar 2018 15:10:54 -0500
Message-Id: <913318a5610ef6b24af2522575f671fa6ee19b6b.1522256721.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable references should never have flags appended when displayed -
prevent that from happening.

Before:

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0.usecs:...

After:

  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:...

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fb81447..468e43f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2052,7 +2052,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 	strcat(expr, hist_field_name(field, 0));
 
-	if (field->flags) {
+	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
-- 
1.9.3
