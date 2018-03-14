Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeCNReG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:34:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59736 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCNReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:34:05 -0400
From: Colin King <colin.king@canonical.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf tests: fix out of bounds access on array fd when cnt is 100
Date: Wed, 14 Mar 2018 17:33:54 +0000
Message-Id: <20180314173354.11250-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when cnt is 100 an array bounds overflow occurs on the assignment
of fd[cnt]. Fix this by performing the bounds check on cnt before writing
to fd.

Detected by cppcheck:
tools/perf/tests/bp_account.c:115: (warning) Either the condition
'cnt==100' is redundant or the array 'fd[100]' is accessed at index 100,
which is out of bounds.

Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
 
-- 
2.15.1
