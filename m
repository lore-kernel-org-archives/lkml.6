Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeBPTkm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeBPTSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0A217C9
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
Subject: [PATCH 01/41] perf record: Put new line after target override warning
Date: Fri, 16 Feb 2018 16:17:06 -0300
Message-Id: <20180216191746.11095-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no new-line after target-override warning, now:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

with patch:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 16ad2ffb822c ("perf tools: Introduce perf_target__strerror()")
Link: http://lkml.kernel.org/r/20180206181813.10943-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca749d1ac..907267206973 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1803,7 +1803,7 @@ int cmd_record(int argc, const char **argv)
 	err = target__validate(&rec->opts.target);
 	if (err) {
 		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__warning("%s", errbuf);
+		ui__warning("%s\n", errbuf);
 	}
 
 	err = target__parse_uid(&rec->opts.target);
-- 
2.14.3
