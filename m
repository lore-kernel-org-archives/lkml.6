Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E7ijAu1CGVusAwAAmS7hNA
	; Thu, 07 Jun 2018 14:36:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 94E0B6089E; Thu,  7 Jun 2018 14:36:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E8182601D2;
	Thu,  7 Jun 2018 14:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8182601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeFGOgt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:36:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40423 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933652AbeFGOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zv-Ti; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002j0-BG; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Peter Zijlstra" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Jiri Olsa" <jolsa@redhat.com>, "Ingo Molnar" <mingo@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.266748376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 036/410] perf/hwbp: Simplify the perf-hwbp code, fix
 documentation
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f upstream.

Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
modification of a breakpoint - simplify it and remove the pointless
local variables.

Also update the stale Docbook while at it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/events/hw_breakpoint.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -427,16 +427,9 @@ EXPORT_SYMBOL_GPL(register_user_hw_break
  * modify_user_hw_breakpoint - modify a user-space hardware breakpoint
  * @bp: the breakpoint structure to modify
  * @attr: new breakpoint attributes
- * @triggered: callback to trigger when we hit the breakpoint
- * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	int err = 0;
-
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -451,27 +444,18 @@ int modify_user_hw_breakpoint(struct per
 	bp->attr.bp_addr = attr->bp_addr;
 	bp->attr.bp_type = attr->bp_type;
 	bp->attr.bp_len = attr->bp_len;
+	bp->attr.disabled = 1;
 
-	if (attr->disabled)
-		goto end;
-
-	err = validate_hw_breakpoint(bp);
-	if (!err)
-		perf_event_enable(bp);
+	if (!attr->disabled) {
+		int err = validate_hw_breakpoint(bp);
 
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len = old_len;
-		if (!bp->attr.disabled)
-			perf_event_enable(bp);
+		if (err)
+			return err;
 
-		return err;
+		perf_event_enable(bp);
+		bp->attr.disabled = 0;
 	}
 
-end:
-	bp->attr.disabled = attr->disabled;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
