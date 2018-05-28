Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeE1HhK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:37:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753612AbeE1HhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:37:08 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test 39 (Session topology) dumps core on s390
Date: Mon, 28 May 2018 09:36:57 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18052807-0040-0000-0000-0000043E773F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052807-0041-0000-0000-00002643C056
Message-Id: <20180528073657.11743-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test 39 fails with core dump on s390. The root cause
is a NULL pointer reference in function check_cpu_topology()
line 76 (or line 82 without -v).
The session->header.env.cpu variable is NULL because on s390
function process_cpu_topology() returns with error:
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

---
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
-- 
2.14.3
