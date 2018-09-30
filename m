Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32587C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A992082A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A992082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeI3OPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 10:15:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeI3OPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 10:15:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2B734E90D;
        Sun, 30 Sep 2018 07:43:11 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAF8A60164;
        Sun, 30 Sep 2018 07:43:07 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        linux-mm@kvack.org, Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/3] userfaultfd: selftest: cleanup help messages
Date:   Sun, 30 Sep 2018 15:42:57 +0800
Message-Id: <20180930074259.18229-2-peterx@redhat.com>
In-Reply-To: <20180930074259.18229-1-peterx@redhat.com>
References: <20180930074259.18229-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 30 Sep 2018 07:43:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the help in the comment region is obsolete, now we support
three parameters.  Since at it, change it and move it into the help
message of the program.

Also, the help messages dumped here and there is obsolete too.  Use a
single usage() helper.

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 46 ++++++++++++++----------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7b8171e3128a..5ff3a4f9173e 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -34,18 +34,6 @@
  * per-CPU threads 1 by triggering userfaults inside
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
- *
- * The program takes two parameters: the amounts of physical memory in
- * megabytes (MiB) of the area and the number of bounces to execute.
- *
- * # 100MiB 99999 bounces
- * ./userfaultfd 100 99999
- *
- * # 1GiB 99 bounces
- * ./userfaultfd 1000 99
- *
- * # 10MiB-~6GiB 999 bounces, continue forever unless an error triggers
- * while ./userfaultfd $[RANDOM % 6000 + 10] 999; do true; done
  */
 
 #define _GNU_SOURCE
@@ -115,6 +103,30 @@ pthread_attr_t attr;
 				 ~(unsigned long)(sizeof(unsigned long long) \
 						  -  1)))
 
+const char *examples =
+    "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
+    "./userfaultfd anon 100 99999\n\n"
+    "# Run share memory test on 1GiB region with 99 bounces:\n"
+    "./userfaultfd shmem 1000 99\n\n"
+    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
+    "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"
+    "# Run the same hugetlb test but using shmem:\n"
+    "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
+    "# 10MiB-~6GiB 999 bounces anonymous test, "
+    "continue forever unless an error triggers\n"
+    "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n\n";
+
+static void usage(void)
+{
+	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
+		"[hugetlbfs_file]\n\n");
+	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
+		"hugetlb_shared, shmem\n\n");
+	fprintf(stderr, "Examples:\n\n");
+	fprintf(stderr, examples);
+	exit(1);
+}
+
 static int anon_release_pages(char *rel_area)
 {
 	int ret = 0;
@@ -1272,8 +1284,7 @@ static void sigalrm(int sig)
 int main(int argc, char **argv)
 {
 	if (argc < 4)
-		fprintf(stderr, "Usage: <test type> <MiB> <bounces> [hugetlbfs_file]\n"),
-				exit(1);
+		usage();
 
 	if (signal(SIGALRM, sigalrm) == SIG_ERR)
 		fprintf(stderr, "failed to arm SIGALRM"), exit(1);
@@ -1286,20 +1297,19 @@ int main(int argc, char **argv)
 		nr_cpus;
 	if (!nr_pages_per_cpu) {
 		fprintf(stderr, "invalid MiB\n");
-		fprintf(stderr, "Usage: <MiB> <bounces>\n"), exit(1);
+		usage();
 	}
 
 	bounces = atoi(argv[3]);
 	if (bounces <= 0) {
 		fprintf(stderr, "invalid bounces\n");
-		fprintf(stderr, "Usage: <MiB> <bounces>\n"), exit(1);
+		usage();
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
 	if (test_type == TEST_HUGETLB) {
 		if (argc < 5)
-			fprintf(stderr, "Usage: hugetlb <MiB> <bounces> <hugetlbfs_file>\n"),
-				exit(1);
+			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
 		if (huge_fd < 0) {
 			fprintf(stderr, "Open of %s failed", argv[3]);
-- 
2.17.1

