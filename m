Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163942AbeE1KwH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163923AbeE1KwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Zhijian <zhijianx.li@intel.com>,
        Shuah Khan <shuah@kernel.org>, SeongJae Park <sj38.park@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 239/496] selftests/vm/run_vmtests: adjust hugetlb size according to nr_cpus
Date: Mon, 28 May 2018 12:00:24 +0200
Message-Id: <20180528100329.973651930@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zhijian <zhijianx.li@intel.com>

[ Upstream commit 0627be7d3c871035364923559543c9b2ff5357f2 ]

Fix userfaultfd_hugetlb on hosts which have more than 64 cpus.

  ---------------------------
  running userfaultfd_hugetlb
  ---------------------------
  invalid MiB
  Usage: <MiB> <bounces>
  [FAIL]

Via userfaultfd.c we can know, hugetlb_size needs to meet hugetlb_size
>= nr_cpus * hugepage_size.  hugepage_size is often 2M, so when host
cpus > 64, it requires more than 128M.

[zhijianx.li@intel.com: update changelog/comments and variable name]
 Link: http://lkml.kernel.org/r/20180302024356.83359-1-zhijianx.li@intel.com
 Link: http://lkml.kernel.org/r/20180303125027.81638-1-zhijianx.li@intel.com
Link: http://lkml.kernel.org/r/20180302024356.83359-1-zhijianx.li@intel.com
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/vm/run_vmtests |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -2,25 +2,33 @@
 # SPDX-License-Identifier: GPL-2.0
 #please run as root
 
-#we need 256M, below is the size in kB
-needmem=262144
 mnt=./huge
 exitcode=0
 
-#get pagesize and freepages from /proc/meminfo
+#get huge pagesize and freepages from /proc/meminfo
 while read name size unit; do
 	if [ "$name" = "HugePages_Free:" ]; then
 		freepgs=$size
 	fi
 	if [ "$name" = "Hugepagesize:" ]; then
-		pgsize=$size
+		hpgsize_KB=$size
 	fi
 done < /proc/meminfo
 
+# Simple hugetlbfs tests have a hardcoded minimum requirement of
+# huge pages totaling 256MB (262144KB) in size.  The userfaultfd
+# hugetlb test requires a minimum of 2 * nr_cpus huge pages.  Take
+# both of these requirements into account and attempt to increase
+# number of huge pages available.
+nr_cpus=$(nproc)
+hpgsize_MB=$((hpgsize_KB / 1024))
+half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
+needmem_KB=$((half_ufd_size_MB * 2 * 1024))
+
 #set proper nr_hugepages
-if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
+if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
-	needpgs=`expr $needmem / $pgsize`
+	needpgs=$((needmem_KB / hpgsize_KB))
 	tries=2
 	while [ $tries -gt 0 ] && [ $freepgs -lt $needpgs ]; do
 		lackpgs=$(( $needpgs - $freepgs ))
@@ -107,8 +115,9 @@ fi
 echo "---------------------------"
 echo "running userfaultfd_hugetlb"
 echo "---------------------------"
-# 256MB total huge pages == 128MB src and 128MB dst
-./userfaultfd hugetlb 128 32 $mnt/ufd_test_file
+# Test requires source and destination huge pages.  Size of source
+# (half_ufd_size_MB) is passed as argument to test.
+./userfaultfd hugetlb $half_ufd_size_MB 32 $mnt/ufd_test_file
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
