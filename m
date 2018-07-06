Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1198023F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1198023F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934747AbeGFFxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:53:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934657AbeGFFwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:55 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 016E9BA2;
        Fri,  6 Jul 2018 05:52:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 54/61] perf test: "Session topology" dumps core on s390
Date:   Fri,  6 Jul 2018 07:47:18 +0200
Message-Id: <20180706054714.404844466@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit d121109100bda84bbbb199dab97f9d56432ab235 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/topology.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -66,6 +66,27 @@ static int check_cpu_topology(char *path
 	session = perf_session__new(&file, false, NULL);
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
@@ -91,7 +112,7 @@ int test__session_topology(struct test *
 {
 	char path[PATH_MAX];
 	struct cpu_map *map;
-	int ret = -1;
+	int ret = TEST_FAIL;
 
 	TEST_ASSERT_VAL("can't get templ file", !get_temp(path));
 
@@ -106,12 +127,9 @@ int test__session_topology(struct test *
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


