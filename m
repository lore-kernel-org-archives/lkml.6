Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuVhJ67A3YciWV/h7IA9cbD6Zunt53JOyHaBEJqHq9cfYtECL0HzC0SNqmd90mfgW3HsV/8
ARC-Seal: i=1; a=rsa-sha256; t=1520081462; cv=none;
        d=google.com; s=arc-20160816;
        b=SCIEawimulm7yfcNDsSeY4BstDa6uyuysGieN/Xlpm3LyqoDCvNST5Dn6EpW1AXBXA
         Lb1tICMRw2zZGLLZwm+1XSvmsmyaVsVC8sBiLCDe3GHKJ2u6L2tcbJhZJb0SG4GDpiey
         INdtf4FJL1YW9ePcOcRK2BmF1mkDMXPr8nSwyFq4n9EcghHLhdCm3O6wWgQR1r682Ode
         s7/T8WqVamxYNQwiGjTqaiJleyuvLJVN/imr/YhQLjRu0vtuH0ZB6KhCJf4/CikbzpSo
         IV4Yv8TUrM5qAl4RLpEPwjy0NOUTR44qWxtCMCzeWFAZgvgx18+45sca3afTPXp3FTfl
         yb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/YRb8Jv7YzZBcafNoyWoRSv6Sa23bek/7Ur3T23DW1g=;
        b=yCXBYFdHMkXrswaLDdnSBLB/YfjhSSAOFTBQ7wu3qmpE7Nc0bdGLjEj34Yfw9p7qLp
         B3dPtSkTjVtJiGRrtpZo+3Qtj04lWd0bWCWmMlY3EZafEVQmN6osDFGhfuR/PaWgn0AY
         qvjH1h0qMgTCvVsmmhDYlYSEho28gLvE0/836WZ84D5BL8FzRk2tUnWMM1YJQj7E7/5h
         iDevgAhD6owmuj2neaJNuSVbdKprgaaLQrjdxzJhhQ88bFU4fyBSg9/EYGA/v1lEXkoQ
         ATyA16P0Q5QBXDDh5l0GBwDCyk4NRb0GOGBx2xSO+mMnKwTWU/DCtqGB5hLiNgHoipPm
         HRVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCCMvB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 3 Mar 2018 07:51:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:7688 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbeCCMvB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Mar 2018 07:51:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,417,1515484800";
   d="scan'208";a="208538720"
From: Li Zhijian <zhijianx.li@intel.com>
To: shuah@kernel.org, akpm@linux-foundation.org, sj38.park@gmail.com,
        pombredanne@nexb.com, aneesh.kumar@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        Li Zhijian <zhijianx.li@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] selftests/vm/run_vmtests: adjust hugetlb size accroding to nr_cpus
Date: Sat,  3 Mar 2018 20:50:27 +0800
Message-Id: <20180303125027.81638-1-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593920939898882066?=
X-GMAIL-MSGID: =?utf-8?q?1593920939898882066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix userfaultfd_hugetlb on hosts which have more than 64 cpus.

---------------------------
running userfaultfd_hugetlb
---------------------------
invalid MiB
Usage: <MiB> <bounces>
[FAIL]

Via userfaultfd.c we can know, hugetlb_size needs to meet hugetlb_size >=
nr_cpus * hugepage_size.  hugepage_size is often 2M, so when host cpus >
64, it requires more than 128M.

Changes since v1:
  - update changelog/comments and variable name to make code more easier to
    read/understand(stolen from Mike Kravetz)

Link: http://lkml.kernel.org/r/20180302024356.83359-1-zhijianx.li@intel.com
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/selftests/vm/run_vmtests | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index d2561895a021a..22d5646738302 100755
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
-- 
2.11.0

