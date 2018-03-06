Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeCFGlX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:41:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeCFGlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:41:22 -0500
Date: Mon, 5 Mar 2018 22:41:14 -0800
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-42811d509d6e0b0118918ce6be346be54d8e8801@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        ak@linux.intel.com, acme@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20171006020029.13339-1-andi@firstfloor.org>
References: <20171006020029.13339-1-andi@firstfloor.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use xyarray dimensions to iterate fds
Git-Commit-ID: 42811d509d6e0b0118918ce6be346be54d8e8801
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

Commit-ID:  42811d509d6e0b0118918ce6be346be54d8e8801
Gitweb:     https://git.kernel.org/tip/42811d509d6e0b0118918ce6be346be54d8e8801
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 5 Oct 2017 19:00:28 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Feb 2018 11:36:57 -0300

perf stat: Use xyarray dimensions to iterate fds

Now that the xyarray stores the dimensions we can use those
to iterate over the FDs for a evsel.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171006020029.13339-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2d49eccf98f2..fadcff52cd09 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -508,14 +508,13 @@ static int perf_stat_synthesize_config(bool is_pipe)
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 
-static int __store_counter_ids(struct perf_evsel *counter,
-			       struct cpu_map *cpus,
-			       struct thread_map *threads)
+static int __store_counter_ids(struct perf_evsel *counter)
 {
 	int cpu, thread;
 
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
-		for (thread = 0; thread < threads->nr; thread++) {
+	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(counter->fd);
+		     thread++) {
 			int fd = FD(counter, cpu, thread);
 
 			if (perf_evlist__id_add_fd(evsel_list, counter,
@@ -535,7 +534,7 @@ static int store_counter_ids(struct perf_evsel *counter)
 	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
 		return -ENOMEM;
 
-	return __store_counter_ids(counter, cpus, threads);
+	return __store_counter_ids(counter);
 }
 
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
