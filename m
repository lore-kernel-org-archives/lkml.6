Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeB1D6y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 22:58:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752172AbeB1D6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 22:58:51 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] selftests/vm: Update max va test to check for high address return.
Date: Wed, 28 Feb 2018 09:28:30 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18022803-0028-0000-0000-0000093C014A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996132; UDB=6.00506390; IPR=6.00775455;
 MB=3.00019771; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 03:58:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022803-0029-0000-0000-000039C6EC3C
Message-Id: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap(-1,..) is expected to search from max supported VA top down. It should find
an address above ADDR_SWITCH_HINT. Explicitly check for this.

Also derefer the address even if we failed the addr check.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/va_128TBswitch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
index e7fe734c374f..f68fa4bd8179 100644
--- a/tools/testing/selftests/vm/va_128TBswitch.c
+++ b/tools/testing/selftests/vm/va_128TBswitch.c
@@ -44,6 +44,7 @@ struct testcase {
 	unsigned long flags;
 	const char *msg;
 	unsigned int low_addr_required:1;
+	unsigned int high_addr_required:1;
 	unsigned int keep_mapped:1;
 };
 
@@ -108,6 +109,7 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
@@ -115,12 +117,14 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR) again",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
 		.size = 2 * PAGE_SIZE,
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
 		.msg = "mmap(HIGH_ADDR, MAP_FIXED)",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
@@ -128,12 +132,14 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
 		.size = 2 * PAGE_SIZE,
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1) again",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = ((void *)(ADDR_SWITCH_HINT - PAGE_SIZE)),
@@ -193,6 +199,7 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
@@ -200,12 +207,14 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB) again",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
 		.size = HUGETLB_SIZE,
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
 		.msg = "mmap(HIGH_ADDR, MAP_FIXED | MAP_HUGETLB)",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
@@ -213,12 +222,14 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1, MAP_HUGETLB)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
 		.size = HUGETLB_SIZE,
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1, MAP_HUGETLB) again",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *)(ADDR_SWITCH_HINT - PAGE_SIZE),
@@ -257,14 +268,16 @@ static int run_test(struct testcase *test, int count)
 		if (t->low_addr_required && p >= (void *)(ADDR_SWITCH_HINT)) {
 			printf("FAILED\n");
 			ret = 1;
-		} else {
-			/*
-			 * Do a dereference of the address returned so that we catch
-			 * bugs in page fault handling
-			 */
-			memset(p, 0, t->size);
+		} else if (t->high_addr_required && p < (void *)(ADDR_SWITCH_HINT)) {
+			printf("FAILED\n");
+			ret = 1;
+		} else
 			printf("OK\n");
-		}
+		/*
+		 * Do a dereference of the address returned so that we catch
+		 * bugs in page fault handling
+		 */
+		memset(p, 0, t->size);
 		if (!t->keep_mapped)
 			munmap(p, t->size);
 	}
-- 
2.14.3
