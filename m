Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968005AbeBOM0q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:26:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967943AbeBOM0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:43 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 3/9] perf tools: Free root_dir in machine__init error path
Date: Thu, 15 Feb 2018 13:26:29 +0100
Message-Id: <20180215122635.24029-4-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing root_dir in machine__init error path.

Link: http://lkml.kernel.org/n/tip-ng92slsanexqw7h1d6sadnj7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b05a67464c03..c976384f9022 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -50,6 +50,8 @@ static void machine__threads_init(struct machine *machine)
 
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 {
+	int err = -ENOMEM;
+
 	memset(machine, 0, sizeof(*machine));
 	map_groups__init(&machine->kmaps, machine);
 	RB_CLEAR_NODE(&machine->rb_node);
@@ -79,7 +81,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 		char comm[64];
 
 		if (thread == NULL)
-			return -ENOMEM;
+			goto out;
 
 		snprintf(comm, sizeof(comm), "[guest/%d]", pid);
 		thread__set_comm(thread, comm, 0);
@@ -87,7 +89,11 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	}
 
 	machine->current_tid = NULL;
+	err = 0;
 
+out:
+	if (err)
+		zfree(&machine->root_dir);
 	return 0;
 }
 
-- 
2.13.6
