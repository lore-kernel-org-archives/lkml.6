Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeEJUOa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:14:30 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56744 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEJUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:14:28 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc: marcandre.lureau@redhat.com, sj38.park@gmail.com,
        anders.roxell@linaro.org, lizhijian@cn.fujitsu.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: memfd: split regular and hugetlbfs tests
Date: Thu, 10 May 2018 14:13:54 -0600
Message-Id: <20180510201354.23930-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split normal memfd and hugetlbfs tests to improve the test reporting.
Remove run_fuse_test.sh and memfd_test from run_tests.sh and add them
to the Makefile.

Add memfd_test to TEST_GEN_PROGS to be run separately.
Rename run_tests.sh to run_hugetlbfs_test.sh
Add run_fuse_test.sh and run_hugetlbfs_test.sh to TEST_PROGS

The report for non-root run wth this change is:

TAP version 13
selftests: memfd: memfd_test
========================================
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP
memfd: SHARE-MMAP
memfd: SHARE-OPEN
memfd: SHARE-FORK
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
ok 1..1 selftests: memfd: memfd_test [PASS]
selftests: memfd: run_fuse_test.sh
========================================
opening: ./mnt/memfd
fuse: DONE
ok 1..2 selftests: memfd: run_fuse_test.sh [PASS]
selftests: memfd: run_hugetlbfs_test.sh
========================================
Please run memfd with hugetlbfs test as root
not ok 1..3 selftests: memfd: run_hugetlbfs_test.sh [SKIP]

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/memfd/Makefile                              | 6 +++---
 .../testing/selftests/memfd/{run_tests.sh => run_hugetlbfs_test.sh} | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/memfd/{run_tests.sh => run_hugetlbfs_test.sh} (95%)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 0862e6f47a38..53a848109f7b 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,9 +4,9 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_PROGS := run_tests.sh
-TEST_FILES := run_fuse_test.sh
-TEST_GEN_FILES := memfd_test fuse_mnt fuse_test
+TEST_GEN_PROGS := memfd_test
+TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
+TEST_GEN_FILES := fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
similarity index 95%
rename from tools/testing/selftests/memfd/run_tests.sh
rename to tools/testing/selftests/memfd/run_hugetlbfs_test.sh
index 2013f195e623..fb633eeb0290 100755
--- a/tools/testing/selftests/memfd/run_tests.sh
+++ b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
@@ -4,12 +4,6 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-#
-# Normal tests requiring no special resources
-#
-./run_fuse_test.sh
-./memfd_test
-
 #
 # To test memfd_create with hugetlbfs, there needs to be hpages_test
 # huge pages free.  Attempt to allocate enough pages to test.
-- 
2.14.1
