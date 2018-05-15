Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeEOGl6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:41:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:41:57 -0400
Date: Mon, 14 May 2018 23:41:44 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8ysughiz00h6mjpcot04qyjj@git.kernel.org>
Cc: adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, dsahern@gmail.com
Reply-To: dsahern@gmail.com, mingo@kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add missing newline when parsing
 empty BPF proggie
Git-Commit-ID: c23080a6e4e853cff2834436e3cf33eae7723900
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

Commit-ID:  c23080a6e4e853cff2834436e3cf33eae7723900
Gitweb:     https://git.kernel.org/tip/c23080a6e4e853cff2834436e3cf33eae7723900
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 3 May 2018 15:59:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 11 May 2018 12:10:02 -0300

perf tools: Add missing newline when parsing empty BPF proggie

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
 
