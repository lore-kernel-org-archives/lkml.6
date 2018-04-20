Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755408AbeDTOdn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755377AbeDTOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1377217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/17] perf tests mmap: Show which tracepoint is failing
Date: Fri, 20 Apr 2018 11:32:25 -0300
Message-Id: <20180420143227.16030-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In the 'perf test "mmap interface"' we try creating events for several
tracepoints, but when perf_evsel__new() fails we're not showing which
one is failing, fix that to help diagnosing problems, such as the
syscall tracepoints ones being found and fixes in this merge window.

Now the failing tests shows:

  # perf test -v "mmap interface"
 4: Read samples using the mmap interface                 :
  --- start ---
  test child forked, pid 14311
  <SNIP>
  perf_evsel__new(sys_enter_getppid)
  test child finished with -1
  ---- end ----
  Read samples using the mmap interface: FAILED!
  #

Now to check why the syscalls:sys_enter_getppid is failing...

  # ls -la /sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid
  ls: cannot access '/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid': No such file or directory
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-44xk0ycdzrfzx1o9rklf5itl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index bb8e6bcb0d96..0919b0793e5b 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -75,7 +75,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		snprintf(name, sizeof(name), "sys_enter_%s", syscall_names[i]);
 		evsels[i] = perf_evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
-			pr_debug("perf_evsel__new\n");
+			pr_debug("perf_evsel__new(%s)\n", name);
 			goto out_delete_evlist;
 		}
 
-- 
2.14.3
