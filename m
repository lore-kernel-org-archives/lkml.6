Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8576A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJKDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:23:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:7018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJKDX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:23:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 12:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="240262412"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 12:59:32 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] mm/gup_benchmark: Add additional pinning methods
Date:   Wed, 10 Oct 2018 13:56:01 -0600
Message-Id: <20181010195605.10689-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181010195605.10689-1-keith.busch@intel.com>
References: <20181010195605.10689-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides new gup benchmark ioctl commands to run different
user page pinning methods, get_user_pages_longterm and get_user_pages,
in addition to the existing get_user_pages_fast.

Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 mm/gup_benchmark.c                         | 28 ++++++++++++++++++++++++++--
 tools/testing/selftests/vm/gup_benchmark.c | 13 +++++++++++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index b344abd6e8e4..ab103a018627 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -6,6 +6,8 @@
 #include <linux/debugfs.h>
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -42,7 +44,23 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
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
@@ -71,8 +89,14 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
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

