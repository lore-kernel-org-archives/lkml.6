Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBFSrw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:47:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46782 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeBFSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:47:44 -0500
X-Google-Smtp-Source: AH8x226Fg2FBzuLxPxv5C5I4DEa0zMFsLK/4OzCKVnMXW8iVnT9Ooj6ZR016rLcOt89wLOr5ITFLmw==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf mem: Show perf mem report usage by -h option
Date: Wed,  7 Feb 2018 03:47:27 +0900
Message-Id: <1517942847-40371-1-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When typing 'perf mem report -h', the result showed 'perf report' usage.
So change to show 'perf mem report' usage.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/builtin-mem.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 5065646..311fbed 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -314,6 +314,25 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	return ret;
 }
 
+static int __cmd_report(int argc, const char **argv, struct perf_mem *mem)
+{
+	int argc2;
+	const char *mem_report_usage[] = {
+		"perf mem [<options>] report",
+		NULL
+	};
+	struct option options[] = {
+	OPT_END()
+	};
+
+	argc2 = parse_options(argc, argv, options, mem_report_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc2)
+		usage_with_options(mem_report_usage, options);
+
+	return report_events(argc, argv, mem);
+}
+
 struct mem_mode {
 	const char *name;
 	int mode;
@@ -451,7 +470,7 @@ int cmd_mem(int argc, const char **argv)
 	if (!strncmp(argv[0], "rec", 3))
 		return __cmd_record(argc, argv, &mem);
 	else if (!strncmp(argv[0], "rep", 3))
-		return report_events(argc, argv, &mem);
+		return __cmd_report(argc, argv, &mem);
 	else
 		usage_with_options(mem_usage, mem_options);
 
-- 
2.7.4
