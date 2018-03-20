Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeCTGQf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:16:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTGQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:16:32 -0400
Date: Mon, 19 Mar 2018 23:16:02 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e725920cdb1c79fdc71f2f164f59be8c411cad68@git.kernel.org>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org,
        peterz@infradead.org, acme@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180309101442.9224-2-jolsa@kernel.org>
References: <20180309101442.9224-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf env: Free memory nodes data
Git-Commit-ID: e725920cdb1c79fdc71f2f164f59be8c411cad68
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

Commit-ID:  e725920cdb1c79fdc71f2f164f59be8c411cad68
Gitweb:     https://git.kernel.org/tip/e725920cdb1c79fdc71f2f164f59be8c411cad68
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:52:09 -0300

perf env: Free memory nodes data

Forgot to free env's memory nodes, adding needed code to perf_env__exit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6d311868d850..4c842762e3f2 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -32,6 +32,10 @@ void perf_env__exit(struct perf_env *env)
 	for (i = 0; i < env->caches_cnt; i++)
 		cpu_cache_level__free(&env->caches[i]);
 	zfree(&env->caches);
+
+	for (i = 0; i < env->nr_memory_nodes; i++)
+		free(env->memory_nodes[i].set);
+	zfree(&env->memory_nodes);
 }
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
