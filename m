Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeBFS1M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:27:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753060AbeBFS1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:04 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 09/17] perf tools: Don't search for active kernel start in __machine__create_kernel_maps
Date: Tue,  6 Feb 2018 19:18:05 +0100
Message-Id: <20180206181813.10943-10-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not search for kernel start address in
__machine__create_kernel_maps function, because it's being
used in 'report' code path, where we are interested in kernel
MMAP data address instead of in current kernel address

The __machine__create_kernel_maps serves purely for creating
the machines kernel maps and setting up the kmap group. The
report code path then sets the address based on the data from
kernel MMAP event in machine__set_kernel_mmap function.

The kallsyms search address logic is used for test code, that
calls machine__create_kernel_maps to get current maps and calls
machine__get_running_kernel_start to get kernel starting address.

Also making __machine__create_kernel_maps static, because there's
no external user.

Link: http://lkml.kernel.org/n/tip-37lmdjzh8dwq03golnk7hgkd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 6 ++----
 tools/perf/util/machine.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 447f10e1323e..f5c79110f0d1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -856,14 +856,12 @@ static int machine__get_running_kernel_start(struct machine *machine,
 	return 0;
 }
 
-int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
+static int
+__machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
 	int type;
 	u64 start = 0;
 
-	if (machine__get_running_kernel_start(machine, NULL, &start))
-		return -1;
-
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index cb0a20f3a96b..50d587d34459 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -238,7 +238,6 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm);
 
 void machine__destroy_kernel_maps(struct machine *machine);
-int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel);
 int machine__create_kernel_maps(struct machine *machine);
 
 int machines__create_kernel_maps(struct machines *machines, pid_t pid);
-- 
2.13.6
