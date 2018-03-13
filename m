Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCMGVk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:21:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeCMGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:21:38 -0400
Date: Mon, 12 Mar 2018 23:20:47 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-705feaf321c37e4dca3637fd5cb3b275f17a06c9@git.kernel.org>
Cc: hbathini@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, hpa@zytor.com,
        kan.liang@intel.com, onestero@redhat.com, mpe@ellerman.id.au,
        peterz@infradead.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, will.deacon@arm.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, namhyung@kernel.org, acme@redhat.com,
        dsahern@gmail.com, tglx@linutronix.de, chabbi.milind@gmail.com,
        sukadev@linux.vnet.ibm.com, yao.jin@linux.intel.com,
        fweisbec@gmail.com
Reply-To: alexander.shishkin@linux.intel.com, mingo@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        jolsa@redhat.com, mpe@ellerman.id.au, peterz@infradead.org,
        hpa@zytor.com, kan.liang@intel.com, a.p.zijlstra@chello.nl,
        onestero@redhat.com, hbathini@linux.vnet.ibm.com,
        yao.jin@linux.intel.com, fweisbec@gmail.com,
        sukadev@linux.vnet.ibm.com, chabbi.milind@gmail.com,
        tglx@linutronix.de, dsahern@gmail.com, acme@redhat.com,
        namhyung@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180312134548.31532-6-jolsa@kernel.org>
References: <20180312134548.31532-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] hw_breakpoint: Add perf_event_attr fields check in
 __modify_user_hw_breakpoint()
Git-Commit-ID: 705feaf321c37e4dca3637fd5cb3b275f17a06c9
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

Commit-ID:  705feaf321c37e4dca3637fd5cb3b275f17a06c9
Gitweb:     https://git.kernel.org/tip/705feaf321c37e4dca3637fd5cb3b275f17a06c9
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:08 +0100

hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint()

And rename it to modify_user_hw_breakpoint_check().

We are about to use modify_user_hw_breakpoint_check() for user space
breakpoints modification, we must be very strict to check only the
fields we can change have changed. As Peter explained:

 "Suppose someone does:

        attr = malloc(sizeof(*attr)); // uninitialized memory
        attr->type = BP;
        attr->bp_addr = new_addr;
        attr->bp_type = bp_type;
        attr->bp_len = bp_len;
        ioctl(fd, PERF_IOC_MOD_ATTR, &attr);

  And feeds absolute shite for the rest of the fields.
  Then we later want to extend IOC_MOD_ATTR to allow changing
  attr::sample_type but we can't, because that would break the
  above application."

I'm making this check optional because we already export
modify_user_hw_breakpoint() and with this check we could
break existing users.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
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
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <onestero@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180312134548.31532-6-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
