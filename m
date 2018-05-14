Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeENMXu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753270AbeENMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:23:48 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 5/5] perf tools: Add missing newline when parsing empty BPF proggie
Date: Mon, 14 May 2018 09:23:21 -0300
Message-Id: <20180514122321.27304-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is not specific to BPF but was found when parsing a .c BPF proggie
that while valid, had no events attached to tracepoints, kprobes, etc:

Very minimal file that perf's BPF code can compile:

  # cat empty.c
  char _license[] __attribute__((section("license"), used)) = "GPL";
  int _version __attribute__((section("version"), used)) = LINUX_VERSION_CODE;
  #

Before this patch:

  # perf trace -e empty.c
  WARNING: event parser found nothinginvalid or unsupported event: 'empty.c'
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
    #

After:

  # perf trace -e empty.c
  WARNING: event parser found nothing
  invalid or unsupported event: 'empty.c'
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8ysughiz00h6mjpcot04qyjj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2fb0272146d8..b8b8a9558d32 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1715,7 +1715,7 @@ int parse_events(struct perf_evlist *evlist, const char *str,
 		struct perf_evsel *last;
 
 		if (list_empty(&parse_state.list)) {
-			WARN_ONCE(true, "WARNING: event parser found nothing");
+			WARN_ONCE(true, "WARNING: event parser found nothing\n");
 			return -1;
 		}
 
-- 
2.14.3
