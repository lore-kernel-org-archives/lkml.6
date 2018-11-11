Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A41CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB22E20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB22E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeKLFyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51750 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731170AbeKLFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000oG-Nb; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Th-By; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Song Liu" <songliubraving@fb.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "" <kernel-team@fb.com>, "Jiri Olsa" <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        "Stephane Eranian" <eranian@google.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.386572546@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 087/366] perf/core: Fix group scheduling with mixed
 hw and sw events
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>

commit a1150c202207cc8501bebc45b63c264f91959260 upstream.

When hw and sw events are mixed in the same group, they are all attached
to the hw perf_event_context. This sometimes requires moving group of
perf_event to a different context.

We found a bug in how the kernel handles this, for example if we do:

   perf stat -e '{faults,ref-cycles,faults}'  -I 1000

     1.005591180              1,297      faults
     1.005591180        457,476,576      ref-cycles
     1.005591180    <not supported>      faults

First, sw event "faults" is attached to the sw context, and becomes the
group leader. Then, hw event "ref-cycles" is attached, so both events
are moved to the hw context. Last, another sw "faults" tries to attach,
but it fails because of mismatch between the new target ctx (from sw
pmu) and the group_leader's ctx (hw context, same as ref-cycles).

The broken condition is:
   group_leader is sw event;
   group_leader is on hw context;
   add a sw event to the group.

Fix this scenario by checking group_leader's context (instead of just
event type). If group_leader is on hw context, use the ->pmu of this
context to look up context for the new event.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: b04243ef7006 ("perf: Complete software pmu grouping")
Link: http://lkml.kernel.org/r/20180503194716.162815-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/perf_event.h |  8 ++++++++
 kernel/events/core.c       | 21 +++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -640,6 +640,14 @@ static inline int is_software_event(stru
 	return event->pmu->task_ctx_nr == perf_sw_context;
 }
 
+/*
+ * Return 1 for event in sw context, 0 for event in hw context
+ */
+static inline int in_software_context(struct perf_event *event)
+{
+	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
+}
+
 extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
 extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7502,19 +7502,20 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 	pmu = event->pmu;
 
-	if (group_leader &&
-	    (is_software_event(event) != is_software_event(group_leader))) {
-		if (is_software_event(event)) {
+	if (group_leader) {
+		if (is_software_event(event) &&
+		    !in_software_context(group_leader)) {
 			/*
-			 * If event and group_leader are not both a software
-			 * event, and event is, then group leader is not.
+			 * If the event is a sw event, but the group_leader
+			 * is on hw context.
 			 *
-			 * Allow the addition of software events to !software
-			 * groups, this is safe because software events never
-			 * fail to schedule.
+			 * Allow the addition of software events to hw
+			 * groups, this is safe because software events
+			 * never fail to schedule.
 			 */
-			pmu = group_leader->pmu;
-		} else if (is_software_event(group_leader) &&
+			pmu = group_leader->ctx->pmu;
+		} else if (!is_software_event(event) &&
+			   is_software_event(group_leader) &&
 			   (group_leader->group_flags & PERF_GROUP_SOFTWARE)) {
 			/*
 			 * In case the group is a pure software group, and we

