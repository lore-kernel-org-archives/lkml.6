Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeCIIyp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:54:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbeCIIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:54:44 -0500
Date: Fri, 9 Mar 2018 00:54:22 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5cedb413a63d452356aa634e0d4ffcc24f7dbcb5@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        peterz@infradead.org, acme@redhat.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180307155020.32613-7-jolsa@kernel.org>
References: <20180307155020.32613-7-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c: Use mem_info refcnt logic
Git-Commit-ID: 5cedb413a63d452356aa634e0d4ffcc24f7dbcb5
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

Commit-ID:  5cedb413a63d452356aa634e0d4ffcc24f7dbcb5
Gitweb:     https://git.kernel.org/tip/5cedb413a63d452356aa634e0d4ffcc24f7dbcb5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:07 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:45 -0300

perf c2c: Use mem_info refcnt logic

Switch to refcnt logic instead of duplicating mem_info objects. No
functional change, just saving some memory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 539c3d460158..98d243fa0c06 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -237,9 +237,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	if (mi == NULL)
 		return -ENOMEM;
 
-	mi_dup = memdup(mi, sizeof(*mi));
-	if (!mi_dup)
-		goto free_mi;
+	/*
+	 * The mi object is released in hists__add_entry_ops,
+	 * if it gets sorted out into existing data, so we need
+	 * to take the copy now.
+	 */
+	mi_dup = mem_info__get(mi);
 
 	c2c_decode_stats(&stats, mi);
 
@@ -247,7 +250,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 				  &al, NULL, NULL, mi,
 				  sample, true);
 	if (he == NULL)
-		goto free_mi_dup;
+		goto free_mi;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_add_stats(&c2c_he->stats, &stats);
@@ -272,19 +275,15 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 
 		mi = mi_dup;
 
-		mi_dup = memdup(mi, sizeof(*mi));
-		if (!mi_dup)
-			goto free_mi;
-
 		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2);
 		if (!c2c_hists)
-			goto free_mi_dup;
+			goto free_mi;
 
 		he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 					  &al, NULL, NULL, mi,
 					  sample, true);
 		if (he == NULL)
-			goto free_mi_dup;
+			goto free_mi;
 
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		c2c_add_stats(&c2c_he->stats, &stats);
@@ -303,10 +302,9 @@ out:
 	addr_location__put(&al);
 	return ret;
 
-free_mi_dup:
-	free(mi_dup);
 free_mi:
-	free(mi);
+	mem_info__put(mi_dup);
+	mem_info__put(mi);
 	ret = -ENOMEM;
 	goto out;
 }
