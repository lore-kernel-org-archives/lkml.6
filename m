Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeEaKno (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:43:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeEaKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:43:40 -0400
Date: Thu, 31 May 2018 03:43:28 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-d121109100bda84bbbb199dab97f9d56432ab235@git.kernel.org>
Cc: acme@redhat.com, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, tmricht@linux.ibm.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com
In-Reply-To: <20180528073657.11743-1-tmricht@linux.ibm.com>
References: <20180528073657.11743-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: "Session topology" dumps core on s390
Git-Commit-ID: d121109100bda84bbbb199dab97f9d56432ab235
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

Commit-ID:  d121109100bda84bbbb199dab97f9d56432ab235
Gitweb:     https://git.kernel.org/tip/d121109100bda84bbbb199dab97f9d56432ab235
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 28 May 2018 09:36:57 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 30 May 2018 11:43:58 -0300

perf test: "Session topology" dumps core on s390

The "perf test Session topology" entry fails with core dump on s390. The root
cause is a NULL pointer dereference in function check_cpu_topology() line 76
(or line 82 without -v).

The session->header.env.cpu variable is NULL because on s390 function
process_cpu_topology() returns with error:

    socket_id number is too big.
    You may need to upgrade the perf tool.

and releases the env.cpu variable via zfree() and sets it to NULL.

Here is the gdb output:
(gdb) n
76                      pr_debug("CPU %d, core %d, socket %d\n", i,
(gdb) n

Program received signal SIGSEGV, Segmentation fault.
0x00000000010f4d9e in check_cpu_topology (path=0x3ffffffd6c8
	"/tmp/perf-test-J6CHMa", map=0x14a1740) at tests/topology.c:76
76  pr_debug("CPU %d, core %d, socket %d\n", i,
(gdb)

Make sure the env.cpu variable is not used when its NULL.
Test for NULL pointer and return TEST_SKIP if so.

Output before:

  [root@p23lp27 perf]# ./perf test -F 39
  39: Session topology  :Segmentation fault (core dumped)
  [root@p23lp27 perf]#

Output after:

  [root@p23lp27 perf]# ./perf test -vF 39
  39: Session topology                                      :
  --- start ---
  templ file: /tmp/perf-test-Ajx59D
  socket_id number is too big.You may need to upgrade the perf tool.
  ---- end ----
  Session topology: Skip
  [root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180528073657.11743-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/topology.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 17cb1bb3448c..40e30a26b23c 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -70,6 +70,27 @@ static int check_cpu_topology(char *path, struct cpu_map *map)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", session);
 
+	/* On platforms with large numbers of CPUs process_cpu_topology()
+	 * might issue an error while reading the perf.data file section
+	 * HEADER_CPU_TOPOLOGY and the cpu_topology_map pointed to by member
+	 * cpu is a NULL pointer.
+	 * Example: On s390
+	 *   CPU 0 is on core_id 0 and physical_package_id 6
+	 *   CPU 1 is on core_id 1 and physical_package_id 3
+	 *
+	 *   Core_id and physical_package_id are platform and architecture
+	 *   dependend and might have higher numbers than the CPU id.
+	 *   This actually depends on the configuration.
+	 *
+	 *  In this case process_cpu_topology() prints error message:
+	 *  "socket_id number is too big. You may need to upgrade the
+	 *  perf tool."
+	 *
+	 *  This is the reason why this test might be skipped.
+	 */
+	if (!session->header.env.cpu)
+		return TEST_SKIP;
+
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
 		if (!cpu_map__has(map, i))
 			continue;
@@ -95,7 +116,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 {
 	char path[PATH_MAX];
 	struct cpu_map *map;
-	int ret = -1;
+	int ret = TEST_FAIL;
 
 	TEST_ASSERT_VAL("can't get templ file", !get_temp(path));
 
@@ -110,12 +131,9 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 		goto free_path;
 	}
 
-	if (check_cpu_topology(path, map))
-		goto free_map;
-	ret = 0;
-
-free_map:
+	ret = check_cpu_topology(path, map);
 	cpu_map__put(map);
+
 free_path:
 	unlink(path);
 	return ret;
