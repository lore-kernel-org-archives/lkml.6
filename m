Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCMGVx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:21:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeCMGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:21:51 -0400
Date: Mon, 12 Mar 2018 23:21:13 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5f970521d3279d99adcdebf329631e36cb9f0deb@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, yao.jin@linux.intel.com,
        namhyung@kernel.org, mpe@ellerman.id.au,
        alexander.shishkin@linux.intel.com, hbathini@linux.vnet.ibm.com,
        hpa@zytor.com, kan.liang@intel.com, dsahern@gmail.com,
        sukadev@linux.vnet.ibm.com, fweisbec@gmail.com,
        chabbi.milind@gmail.com, acme@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, onestero@redhat.com,
        a.p.zijlstra@chello.nl, jolsa@kernel.org
Reply-To: mpe@ellerman.id.au, alexander.shishkin@linux.intel.com,
        hbathini@linux.vnet.ibm.com, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, onestero@redhat.com,
        a.p.zijlstra@chello.nl, jolsa@kernel.org, fweisbec@gmail.com,
        sukadev@linux.vnet.ibm.com, kan.liang@intel.com, dsahern@gmail.com,
        chabbi.milind@gmail.com, acme@redhat.com
In-Reply-To: <20180312134548.31532-7-jolsa@kernel.org>
References: <20180312134548.31532-7-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Move perf_event_attr::sample_max_stack
 into perf_copy_attr()
Git-Commit-ID: 5f970521d3279d99adcdebf329631e36cb9f0deb
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

Commit-ID:  5f970521d3279d99adcdebf329631e36cb9f0deb
Gitweb:     https://git.kernel.org/tip/5f970521d3279d99adcdebf329631e36cb9f0deb
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:08 +0100

perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr()

Move the sample_max_stack check and setup into perf_copy_attr(),
so we have all perf_event_attr initial setup in one place
and can easily compare attrs in the new ioctl introduced
in following change.

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
Link: http://lkml.kernel.org/r/20180312134548.31532-7-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 969f865f9f1c..ee145bdee6ed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10125,6 +10125,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			ret = -EINVAL;
 	}
 
+	if (!attr->sample_max_stack)
+		attr->sample_max_stack = sysctl_perf_event_max_stack;
+
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		ret = perf_reg_validate(attr->sample_regs_intr);
 out:
@@ -10338,9 +10341,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (!attr.sample_max_stack)
-		attr.sample_max_stack = sysctl_perf_event_max_stack;
-
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
