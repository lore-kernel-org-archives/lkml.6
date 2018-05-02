Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEBRps (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:45:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeEBRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:45:44 -0400
Date: Wed, 2 May 2018 10:45:35 -0700
From: tip-bot for Hendrik Brueckner <tipbot@zytor.com>
Message-ID: <tip-efb74jw7x2xs2bucp5hf4ilu@git.kernel.org>
Cc: mpetlan@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        brueckner@linux.ibm.com, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, tmricht@linux.ibm.com
Reply-To: brueckner@linux.ibm.com, mingo@kernel.org, mpetlan@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tmricht@linux.ibm.com, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Let 'perf test list' display subtests
Git-Commit-ID: ea40b6d3222e5feef178d9b49baead28e9b5fe20
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

Commit-ID:  ea40b6d3222e5feef178d9b49baead28e9b5fe20
Gitweb:     https://git.kernel.org/tip/ea40b6d3222e5feef178d9b49baead28e9b5fe20
Author:     Hendrik Brueckner <brueckner@linux.ibm.com>
AuthorDate: Fri, 13 Apr 2018 09:42:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:07 -0300

perf tests: Let 'perf test list' display subtests

The output of perf test and perf test list differ because perf test list
does not display subtests.  Correct this behavior and also let perf test
list report subtests.

For example:

	$ ./perf test 2>&1 |wc -l
	65

Without this commit:
	$ ./perf test list 2>&1 |wc -l
	57

With this commit:
	$ ./perf test list 2>&1 |wc -l
	65

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1523605343-11970-1-git-send-email-brueckner@linux.ibm.com
Link: https://lkml.kernel.org/n/tip-efb74jw7x2xs2bucp5hf4ilu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cac8f8889bc3..2bde505e2e7e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -654,6 +654,15 @@ static int perf_test__list(int argc, const char **argv)
 			continue;
 
 		pr_info("%2d: %s\n", i, t->desc);
+
+		if (t->subtest.get_nr) {
+			int subn = t->subtest.get_nr();
+			int subi;
+
+			for (subi = 0; subi < subn; subi++)
+				pr_info("%2d:%1d: %s\n", i, subi + 1,
+					t->subtest.get_desc(subi));
+		}
 	}
 
 	perf_test__list_shell(argc, argv, i);
