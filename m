Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeEPNkH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeEPNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:38:38 -0400
Message-Id: <20180516133836.671203800@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 09:36:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH RT 4/5] tracing: Uninitialized variable in create_tracing_map_fields()
References: <20180516133642.521479369@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-tracing-Uninitialized-variable-in-create_tracing_map.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.40-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ commit b28d7b2dc27f0eef1ae608b49d6860f2463910f1 ]

Smatch complains that idx can be used uninitialized when we check if
(idx < 0).  It has to be the first iteration through the loop and the
HIST_FIELD_FL_STACKTRACE bit has to be clear and the HIST_FIELD_FL_VAR
bit has to be set to reach the bug.

Link: http://lkml.kernel.org/r/20180328114815.GC29050@mwanda

Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4745ed588607..b3808969ac92 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4459,7 +4459,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	struct tracing_map *map = hist_data->map;
 	struct ftrace_event_field *field;
 	struct hist_field *hist_field;
-	int i, idx;
+	int i, idx = 0;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-- 
2.17.0
