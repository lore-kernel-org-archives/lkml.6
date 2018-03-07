Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbeCGP5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:57:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933904AbeCGPua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:30 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 03/19] perf record: Move machine variable down the function
Date: Wed,  7 Mar 2018 16:50:04 +0100
Message-Id: <20180307155020.32613-4-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used far more down to be declared on the top of the __cmd_record.

Link: http://lkml.kernel.org/n/tip-rs69dbto34xcqcwtwexuteie@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 14d82f0fe5cc..b2ebd9b3feba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -854,7 +854,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int status = 0;
 	unsigned long waking = 0;
 	const bool forks = argc > 0;
-	struct machine *machine;
 	struct perf_tool *tool = &rec->tool;
 	struct record_opts *opts = &rec->opts;
 	struct perf_data *data = &rec->data;
@@ -959,8 +958,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	machine = &session->machines.host;
-
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -988,6 +985,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * Let the child rip
 	 */
 	if (forks) {
+		struct machine *machine = &session->machines.host;
 		union perf_event *event;
 		pid_t tgid;
 
-- 
2.13.6
