Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCIKOt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:14:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751193AbeCIKOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:14:48 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/9] perf tools: Free memory nodes data
Date: Fri,  9 Mar 2018 11:14:34 +0100
Message-Id: <20180309101442.9224-2-jolsa@kernel.org>
In-Reply-To: <20180309101442.9224-1-jolsa@kernel.org>
References: <20180309101442.9224-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to free env's memory nodes, adding
needed code to perf_env__exit.

Link: http://lkml.kernel.org/n/tip-ryyndcxqisxtfhbr6zp54jcy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.13.6
