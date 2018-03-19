Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970746AbeCSTC4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970828AbeCSTC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954F8217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/14] perf tests bp_account: Fix build with clang-6
Date: Mon, 19 Mar 2018 16:01:36 -0300
Message-Id: <20180319190136.7441-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
