Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCLNrA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:47:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932311AbeCLNqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:46:08 -0400
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
Subject: [PATCH 6/8] perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr
Date: Mon, 12 Mar 2018 14:45:46 +0100
Message-Id: <20180312134548.31532-7-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving sample_max_stack check and setup into perf_copy_attr,
so we have all perf_event_attr initial setup in one place
and can easily compare attrs in the new ioctl introduced
in following change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57898102847f..bd61b4d68a25 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9834,6 +9834,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			ret = -EINVAL;
 	}
 
+	if (!attr->sample_max_stack)
+		attr->sample_max_stack = sysctl_perf_event_max_stack;
+
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		ret = perf_reg_validate(attr->sample_regs_intr);
 out:
@@ -10047,9 +10050,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (!attr.sample_max_stack)
-		attr.sample_max_stack = sysctl_perf_event_max_stack;
-
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
-- 
2.13.6
