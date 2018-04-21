Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeDUHxm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:53:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDUHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:53:40 -0400
Date: Sat, 21 Apr 2018 00:53:24 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-44xk0ycdzrfzx1o9rklf5itl@git.kernel.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, rostedt@goodmis.org, linux@dominikbrodowski.net,
        acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        linux@dominikbrodowski.net, rostedt@goodmis.org, wangnan0@huawei.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests mmap: Show which tracepoint is failing
Git-Commit-ID: 518c6021e9b82696819b380cd173e76cac55a01e
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

Commit-ID:  518c6021e9b82696819b380cd173e76cac55a01e
Gitweb:     https://git.kernel.org/tip/518c6021e9b82696819b380cd173e76cac55a01e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 17 Apr 2018 14:47:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:52 -0300

perf tests mmap: Show which tracepoint is failing

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
 
