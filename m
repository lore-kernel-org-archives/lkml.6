Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCTGhY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:37:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeCTGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:37:21 -0400
Date: Mon, 19 Mar 2018 23:37:11 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a3jnkzh4xam0l954de5tn66d@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        mingo@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
        dsahern@gmail.com, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests bp_account: Fix build with clang-6
Git-Commit-ID: 1cd618838b9703eabe4a75badf433382b12f6bef
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

Commit-ID:  1cd618838b9703eabe4a75badf433382b12f6bef
Gitweb:     https://git.kernel.org/tip/1cd618838b9703eabe4a75badf433382b12f6bef
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Mar 2018 10:51:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:51:54 -0300

perf tests bp_account: Fix build with clang-6

To shut up this compiler warning:

    CC       /tmp/build/perf/tests/bp_account.o
    CC       /tmp/build/perf/tests/task-exit.o
    CC       /tmp/build/perf/tests/sw-clock.o
  tests/bp_account.c:106:20: error: pointer type mismatch ('int (*)(void)' and 'void *') [-Werror,-Wpointer-type-mismatch]
          void *addr = is_x ? test_function : (void *) &the_var;
                            ^ ~~~~~~~~~~~~~   ~~~~~~~~~~~~~~~~~
  1 error generated.

Noticed with clang 6 on fedora rawhide.

  [perfbuilder@44490f0e7241 perf]$ clang -v
  clang version 6.0.0 (tags/RELEASE_600/final)
  Target: x86_64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin
  Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/8
  Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/8
  Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/8
  Candidate multilib: .;@m64
  Candidate multilib: 32;@m32
  Selected multilib: .;@m64
  [perfbuilder@44490f0e7241 perf]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
Link: https://lkml.kernel.org/n/tip-a3jnkzh4xam0l954de5tn66d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 9e88d7608951..a20cbc445426 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -103,7 +103,7 @@ static int bp_accounting(int wp_cnt, int share)
 static int detect_cnt(bool is_x)
 {
 	struct perf_event_attr attr;
-	void *addr = is_x ? test_function : (void *) &the_var;
+	void *addr = is_x ? (void *)test_function : (void *)&the_var;
 	int fd[100], cnt = 0, i;
 
 	while (1) {
