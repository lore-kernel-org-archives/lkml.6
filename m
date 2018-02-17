Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeBQLfv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:35:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeBQLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:35:49 -0500
Date: Sat, 17 Feb 2018 03:25:27 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-81f981d7ec43ed93901c12b6521d39b06f1ed3d3@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, mingo@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, acme@redhat.com,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org
In-Reply-To: <20180215122635.24029-4-jolsa@kernel.org>
References: <20180215122635.24029-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Free root_dir in machine__init()
 error path
Git-Commit-ID: 81f981d7ec43ed93901c12b6521d39b06f1ed3d3
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

Commit-ID:  81f981d7ec43ed93901c12b6521d39b06f1ed3d3
Gitweb:     https://git.kernel.org/tip/81f981d7ec43ed93901c12b6521d39b06f1ed3d3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:29 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:56 -0300

perf machine: Free root_dir in machine__init() error path

Free root_dir in machine__init() error path.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b05a674..c976384 100644
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
 
