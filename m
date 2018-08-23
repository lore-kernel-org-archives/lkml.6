Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1902147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1902147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeHWMIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbeHWMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 263268B1;
        Thu, 23 Aug 2018 08:40:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 031/324] selftests: vm: return Kselftest Skip code for skipped tests
Date:   Thu, 23 Aug 2018 09:51:37 +0200
Message-Id: <20180823074957.414943992@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit a4d7537789724985cafbc9260a31ca4f2b7cf123 ]

When vm test is skipped because of unmet dependencies and/or unsupported
configuration, it exits with error which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the
test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/vm/compaction_test.c |    4 +++-
 tools/testing/selftests/vm/mlock2-tests.c    |   12 +++++++-----
 tools/testing/selftests/vm/run_vmtests       |    5 ++++-
 tools/testing/selftests/vm/userfaultfd.c     |    4 +++-
 4 files changed, 17 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -16,6 +16,8 @@
 #include <unistd.h>
 #include <string.h>
 
+#include "../kselftest.h"
+
 #define MAP_SIZE 1048576
 
 struct map_list {
@@ -169,7 +171,7 @@ int main(int argc, char **argv)
 		printf("Either the sysctl compact_unevictable_allowed is not\n"
 		       "set to 1 or couldn't read the proc file.\n"
 		       "Skipping the test\n");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	lim.rlim_cur = RLIM_INFINITY;
--- a/tools/testing/selftests/vm/mlock2-tests.c
+++ b/tools/testing/selftests/vm/mlock2-tests.c
@@ -9,6 +9,8 @@
 #include <stdbool.h>
 #include "mlock2.h"
 
+#include "../kselftest.h"
+
 struct vm_boundaries {
 	unsigned long start;
 	unsigned long end;
@@ -303,7 +305,7 @@ static int test_mlock_lock()
 	if (mlock2_(map, 2 * page_size, 0)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(0)");
 		goto unmap;
@@ -412,7 +414,7 @@ static int test_mlock_onfault()
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(MLOCK_ONFAULT)");
 		goto unmap;
@@ -425,7 +427,7 @@ static int test_mlock_onfault()
 	if (munlock(map, 2 * page_size)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("munlock()");
 		goto unmap;
@@ -457,7 +459,7 @@ static int test_lock_onfault_of_present(
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(MLOCK_ONFAULT)");
 		goto unmap;
@@ -583,7 +585,7 @@ static int test_vma_management(bool call
 	if (call_mlock && mlock2_(map, 3 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock(ONFAULT)\n");
 		goto out;
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #please run as root
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 mnt=./huge
 exitcode=0
 
@@ -36,7 +39,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_K
 		echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
 		if [ $? -ne 0 ]; then
 			echo "Please run this test as root"
-			exit 1
+			exit $ksft_skip
 		fi
 		while read name size unit; do
 			if [ "$name" = "HugePages_Free:" ]; then
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -69,6 +69,8 @@
 #include <setjmp.h>
 #include <stdbool.h>
 
+#include "../kselftest.h"
+
 #ifdef __NR_userfaultfd
 
 static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
@@ -1322,7 +1324,7 @@ int main(int argc, char **argv)
 int main(void)
 {
 	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
-	return 0;
+	return KSFT_SKIP;
 }
 
 #endif /* __NR_userfaultfd */


