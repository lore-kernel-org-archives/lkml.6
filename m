Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD64E20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD64E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbeIVEbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:31:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:61603 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeIVEbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:31:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 15:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="234946780"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2018 15:37:58 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 2/6] mm/gup_benchmark: Add additional pinning methods
Date:   Fri, 21 Sep 2018 16:39:52 -0600
Message-Id: <20180921223956.3485-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180921223956.3485-1-keith.busch@intel.com>
References: <20180921223956.3485-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides new gup benchmark ioctl commands to run different
user page pinning methods, get_user_pages_longterm and get_user_pages,
in addition to the existing get_user_pages_fast.

Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 mm/gup_benchmark.c                         | 28 ++++++++++++++++++++++++++--
 tools/testing/selftests/vm/gup_benchmark.c | 13 +++++++++++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 76cd35e477af..e6d9ce001ffa 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -6,6 +6,8 @@
 #include <linux/debugfs.h>
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -41,7 +43,23 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = (next - addr) / PAGE_SIZE;
 		}
 
-		nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
+		switch (cmd) {
+		case GUP_FAST_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr, gup->flags & 1,
+						 pages + i);
+			break;
+		case GUP_LONGTERM_BENCHMARK:
+			nr = get_user_pages_longterm(addr, nr, gup->flags & 1,
+						     pages + i, NULL);
+			break;
+		case GUP_BENCHMARK:
+			nr = get_user_pages(addr, nr, gup->flags & 1, pages + i,
+					    NULL);
+			break;
+		default:
+			return -1;
+		}
+
 		if (nr <= 0)
 			break;
 		i += nr;
@@ -70,8 +88,14 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 	struct gup_benchmark gup;
 	int ret;
 
-	if (cmd != GUP_FAST_BENCHMARK)
+	switch (cmd) {
+	case GUP_FAST_BENCHMARK:
+	case GUP_LONGTERM_BENCHMARK:
+	case GUP_BENCHMARK:
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	if (copy_from_user(&gup, (void __user *)arg, sizeof(gup)))
 		return -EFAULT;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index bdcb97acd0ac..c2f785ded9b9 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -15,6 +15,8 @@
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -30,9 +32,10 @@ int main(int argc, char **argv)
 	struct gup_benchmark gup;
 	unsigned long size = 128 * MB;
 	int i, fd, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
+	int cmd = GUP_FAST_BENCHMARK;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:tT")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:tTLU")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -49,6 +52,12 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
+		case 'L':
+			cmd = GUP_LONGTERM_BENCHMARK;
+			break;
+		case 'U':
+			cmd = GUP_BENCHMARK;
+			break;
 		case 'w':
 			write = 1;
 		default:
@@ -79,7 +88,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < repeats; i++) {
 		gup.size = size;
-		if (ioctl(fd, GUP_FAST_BENCHMARK, &gup))
+		if (ioctl(fd, cmd, &gup))
 			perror("ioctl"), exit(1);
 
 		printf("Time: get:%lld put:%lld us", gup.get_delta_usec,
-- 
2.14.4

