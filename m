Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeFAOdU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeFAOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:33:15 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 11/12] perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
Date: Fri,  1 Jun 2018 16:32:04 +0200
Message-Id: <1527863526-32677-12-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We soon won't be able to rely on bp->attr anymore to get the new
type of the modifying breakpoint because the new attributes are going
to be copied only once we successfully modified the breakpoint slot.

This will fix the current misdesigned layout where the new attr are
copied to the modifying breakpoint before we actually know if the
modification will be validated.

In order to prepare for that, allow modify_breakpoint_slot() to take
the new breakpoint type.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 kernel/events/hw_breakpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index e7bc8d0..7138770 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -345,13 +345,13 @@ void release_bp_slot(struct perf_event *bp)
 	mutex_unlock(&nr_bp_mutex);
 }
 
-static int __modify_bp_slot(struct perf_event *bp, u64 old_type)
+static int __modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int err;
 
 	__release_bp_slot(bp, old_type);
 
-	err = __reserve_bp_slot(bp, bp->attr.bp_type);
+	err = __reserve_bp_slot(bp, new_type);
 	if (err) {
 		/*
 		 * Reserve the old_type slot back in case
@@ -367,12 +367,12 @@ static int __modify_bp_slot(struct perf_event *bp, u64 old_type)
 	return err;
 }
 
-static int modify_bp_slot(struct perf_event *bp, u64 old_type)
+static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int ret;
 
 	mutex_lock(&nr_bp_mutex);
-	ret = __modify_bp_slot(bp, old_type);
+	ret = __modify_bp_slot(bp, old_type, new_type);
 	mutex_unlock(&nr_bp_mutex);
 	return ret;
 }
@@ -481,7 +481,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
 	if (!err && modify)
-		err = modify_bp_slot(bp, old_type);
+		err = modify_bp_slot(bp, old_type, bp->attr.bp_type);
 
 	if (err) {
 		bp->attr.bp_addr = old_addr;
-- 
2.7.4
