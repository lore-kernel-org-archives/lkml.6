Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeCLNqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:46:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbeCLNqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:46:05 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5/8] hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint
Date: Mon, 12 Mar 2018 14:45:45 +0100
Message-Id: <20180312134548.31532-6-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And rename it to modify_user_hw_breakpoint_check.

We are about to use modify_user_hw_breakpoint_check for user space
breakpoints modification, we must be very strict to check only the
fields we can change have changed. As Peter explained:

  Suppose someone does:
        attr = malloc(sizeof(*attr)); // uninitialized memory
        attr->type = BP;
        attr->bp_addr = new_addr;
        attr->bp_type = bp_type;
        attr->bp_len = bp_len;
        ioctl(fd, PERF_IOC_MOD_ATTR, &attr);

  And feeds absolute shite for the rest of the fields.
  Then we later want to extend IOC_MOD_ATTR to allow changing
  attr::sample_type but we can't, because that would break the
  above application.

I'm making this check optional because we already export
modify_user_hw_breakpoint and with this check we could
break existing users.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a556aba223da..0c82663395f7 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -456,7 +456,9 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
-static int __modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
+static int
+modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
+			        bool check)
 {
 	u64 old_addr = bp->attr.bp_addr;
 	u64 old_len  = bp->attr.bp_len;
@@ -468,6 +470,9 @@ static int __modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_
 	bp->attr.bp_type = attr->bp_type;
 	bp->attr.bp_len  = attr->bp_len;
 
+	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
+		return -EINVAL;
+
 	err = validate_hw_breakpoint(bp);
 	if (!err && modify)
 		err = modify_bp_slot(bp, old_type);
@@ -505,7 +510,7 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	else
 		perf_event_disable(bp);
 
-	err = __modify_user_hw_breakpoint(bp, attr);
+	err = modify_user_hw_breakpoint_check(bp, attr, false);
 
 	if (err) {
 		if (!bp->attr.disabled)
-- 
2.13.6
