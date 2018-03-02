Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvP2BMRp5R7taqAb5bygPWpDhenQQ5BLC66IPnawEGRv5c455g+BQjJ8y7ncXgN/jZaZ8XC
ARC-Seal: i=1; a=rsa-sha256; t=1519958642; cv=none;
        d=google.com; s=arc-20160816;
        b=WBSg7BuulcViNpiXWGKMAiMf+TMcXhV7S1TMZhKoy9uScu6lsFhOcWZg/BlDlPA4E2
         WNEbq9G4SmXT5jtLXNUgg+vUMqDw1lMZBXN2HperNXYobrTMcHhTdvM7WRJXmMDOctg7
         3JSK9pCf3/Xf+KcwK1ZnIQByrv1KqmUUgxNKISdwHGUeevGagrZzc0BicSgFuR1g5gaV
         o0L0PY0xSaJPitzJoqTXLXWZ/3rDi4MR0sgxLpFGvovLwhKthdhRvbRsI4dMwCqVzTD3
         AOLV1iHelR4t4dMQjYCpmbJryuUE4bvzECPnwTj6Ezth1Qf7T4eJJ4dysO8AmrnDYjrZ
         Wpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UJihOXN3mvGwEPrHPfhrzES9bTp5kbyhKkQ4ekFcikM=;
        b=disYdAClJ1NSHIfaH9BGsMI6olZyTEUh3DheSxGHcHEJuMTsvp1YjD76/r++dy6feQ
         VSa2ACFlC8GIzdcb0linv/tzLOlaSOyf1a2ChRvRccAxYn5OKx8NtuDh3QifyeXg6+Ub
         o7XnE/7V8EAjT6jj2lh14HoKZE0bV/O/Bc9DroFpvi4LK2hltiNu+LI2uOIVeOGZ+ICz
         4VkvcvrdwtVMxtPd6yuoFvcw80PooyLrFqUxkjfCW5989clc+pSUJIXjoQZbVWM/B4BR
         P8yMG4/oNZB/efOEom7DTlcAiokhnHpCx8mV6XR9z+7L0BDO1m+w89xWc86AWpzkVVqq
         DUxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164316AbeCBCoC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 1 Mar 2018 21:44:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:51067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164256AbeCBCoB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Mar 2018 21:44:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="34866274"
From: Li Zhijian <zhijianx.li@intel.com>
To: shuah@kernel.org, akpm@linux-foundation.org, sj38.park@gmail.com,
        pombredanne@nexb.com, aneesh.kumar@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH] selftests/vm/run_vmtests: adjust hugetlb size accroding to nr_cpus
Date: Fri,  2 Mar 2018 10:43:56 +0800
Message-Id: <20180302024356.83359-1-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593792153540765223?=
X-GMAIL-MSGID: =?utf-8?q?1593792153540765223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

this patch is to fix running userfaultfd_hugetlb failed on the host which has
more than 64 cpus
---------------------------
running userfaultfd_hugetlb
---------------------------
invalid MiB
Usage: <MiB> <bounces>
[FAIL]

>From userfaultfd.c we can know, hugetlb_size need to meet hugetlb_size >= nr_cpus * hugepage_size
hugepage_size is often 2M, so when host cpus > 64, it requires more than 128M.

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 tools/testing/selftests/vm/run_vmtests | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index d2561895a021a..c440fb972afe9 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -2,8 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #please run as root
 
-#we need 256M, below is the size in kB
-needmem=262144
 mnt=./huge
 exitcode=0
 
@@ -17,6 +15,13 @@ while read name size unit; do
 	fi
 done < /proc/meminfo
 
+nr_cpus=$(nproc)
+pgsize_MB=$((pgsize/1024))
+# rule: nr_cpus * pgsize_MB <= hugetlb_size(round to 128M for testing)
+hugetlb_size=$((((nr_cpus*pgsize_MB+127)/128)*128))
+# needmem depends on the nr_cpus, below is the size in kB
+needmem=$((hugetlb_size*2*1024))
+
 #set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
@@ -107,8 +112,8 @@ fi
 echo "---------------------------"
 echo "running userfaultfd_hugetlb"
 echo "---------------------------"
-# 256MB total huge pages == 128MB src and 128MB dst
-./userfaultfd hugetlb 128 32 $mnt/ufd_test_file
+# 256MB total huge pages == 128MB src and 128MB dst when nr_cpus <= 64
+./userfaultfd hugetlb $hugetlb_size 32 $mnt/ufd_test_file
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
-- 
2.11.0

