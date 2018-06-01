Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeFAOdZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752828AbeFAOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:33:21 -0400
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
Subject: [PATCH 12/12] perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()
Date: Fri,  1 Jun 2018 16:32:05 +0200
Message-Id: <1527863526-32677-13-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dance around old and new attributes. Just don't modify the
previous breakpoint at all until we have verified everything.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Original-patch-by: Andy Lutomirski <luto@kernel.org>
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
 kernel/events/hw_breakpoint.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7138770..b3814fc 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -461,37 +461,43 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
+static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
+				    struct perf_event_attr *from)
+{
+	to->bp_addr = from->bp_addr;
+	to->bp_type = from->bp_type;
+	to->bp_len  = from->bp_len;
+	to->disabled = from->disabled;
+}
+
 int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len  = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	bool modify  = attr->bp_type != old_type;
 	struct arch_hw_breakpoint hw;
-	int err = 0;
-
-	bp->attr.bp_addr = attr->bp_addr;
-	bp->attr.bp_type = attr->bp_type;
-	bp->attr.bp_len  = attr->bp_len;
-
-	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
-		return -EINVAL;
+	int err;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
-	if (!err && modify)
-		err = modify_bp_slot(bp, old_type, bp->attr.bp_type);
-
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len  = old_len;
+	if (err)
 		return err;
+
+	if (check) {
+		struct perf_event_attr old_attr;
+
+		old_attr = bp->attr;
+		hw_breakpoint_copy_attr(&old_attr, attr);
+		if (memcmp(&old_attr, attr, sizeof(*attr)))
+			return -EINVAL;
+	}
+
+	if (bp->attr.bp_type != attr->bp_type) {
+		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
+		if (err)
+			return err;
 	}
 
+	hw_breakpoint_copy_attr(&bp->attr, attr);
 	bp->hw.info = hw;
-	bp->attr.disabled = attr->disabled;
 
 	return 0;
 }
-- 
2.7.4
