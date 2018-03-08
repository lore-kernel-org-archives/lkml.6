Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeCHT4p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbeCHTwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A73205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/54] perf record: Move machine variable down the function
Date: Thu,  8 Mar 2018 16:50:17 -0300
Message-Id: <20180308195029.14991-43-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It's used far more down to be declared on the top of the __cmd_record.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 753ffcecf254..31d4d70e2f6a 100644
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
2.14.3
