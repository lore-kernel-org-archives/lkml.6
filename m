Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCTGcJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:32:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeCTGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:32:04 -0400
Date: Mon, 19 Mar 2018 23:31:41 -0700
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-66790bc8e1f51831d73691954ae0b430bde614ad@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        colin.king@canonical.com, hpa@zytor.com, acme@redhat.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, jolsa@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180314173354.11250-1-colin.king@canonical.com>
References: <20180314173354.11250-1-colin.king@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix out of bounds access on array fd
 when cnt is 100
Git-Commit-ID: 66790bc8e1f51831d73691954ae0b430bde614ad
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

Commit-ID:  66790bc8e1f51831d73691954ae0b430bde614ad
Gitweb:     https://git.kernel.org/tip/66790bc8e1f51831d73691954ae0b430bde614ad
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Wed, 14 Mar 2018 17:33:54 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:44 -0300

perf tests: Fix out of bounds access on array fd when cnt is 100

Currently when cnt is 100 an array bounds overflow occurs on the
assignment of fd[cnt]. Fix this by performing the bounds check on cnt
before writing to fd.

Detected by cppcheck:

tools/perf/tests/bp_account.c:115: (warning) Either the condition
'cnt==100' is redundant or the array 'fd[100]' is accessed at index 100,
which is out of bounds.

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
Link: http://lkml.kernel.org/r/20180314173354.11250-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 2f75fa0c4fef..9e88d7608951 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -107,16 +107,14 @@ static int detect_cnt(bool is_x)
 	int fd[100], cnt = 0, i;
 
 	while (1) {
-		fd[cnt] = __event(is_x, addr, &attr);
-
-		if (fd[cnt] < 0)
-			break;
-
 		if (cnt == 100) {
 			pr_debug("way too many debug registers, fix the test\n");
 			return 0;
 		}
+		fd[cnt] = __event(is_x, addr, &attr);
 
+		if (fd[cnt] < 0)
+			break;
 		cnt++;
 	}
 
