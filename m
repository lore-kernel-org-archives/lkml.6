Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB47C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8CD2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8CD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJKDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:23:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:7018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeJKDX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:23:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 12:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="240262411"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 12:59:31 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/6] mm/gup_benchmark: Time put_page
Date:   Wed, 10 Oct 2018 13:56:00 -0600
Message-Id: <20181010195605.10689-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to measure time to unpin user pages, so this adds a second
benchmark timer on put_page, separate from get_page.

Adding the field will breaks this ioctl ABI, but should be okay since
this an in-tree kernel selftest.

Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 mm/gup_benchmark.c                         | 8 ++++++--
 tools/testing/selftests/vm/gup_benchmark.c | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7405c9d89d65..b344abd6e8e4 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -8,7 +8,8 @@
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
 
 struct gup_benchmark {
-	__u64 delta_usec;
+	__u64 get_delta_usec;
+	__u64 put_delta_usec;
 	__u64 addr;
 	__u64 size;
 	__u32 nr_pages_per_call;
@@ -48,14 +49,17 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	}
 	end_time = ktime_get();
 
-	gup->delta_usec = ktime_us_delta(end_time, start_time);
+	gup->get_delta_usec = ktime_us_delta(end_time, start_time);
 	gup->size = addr - gup->addr;
 
+	start_time = ktime_get();
 	for (i = 0; i < nr_pages; i++) {
 		if (!pages[i])
 			break;
 		put_page(pages[i]);
 	}
+	end_time = ktime_get();
+	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
 
 	kvfree(pages);
 	return 0;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 36df55132036..bdcb97acd0ac 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -17,7 +17,8 @@
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
 
 struct gup_benchmark {
-	__u64 delta_usec;
+	__u64 get_delta_usec;
+	__u64 put_delta_usec;
 	__u64 addr;
 	__u64 size;
 	__u32 nr_pages_per_call;
@@ -81,7 +82,8 @@ int main(int argc, char **argv)
 		if (ioctl(fd, GUP_FAST_BENCHMARK, &gup))
 			perror("ioctl"), exit(1);
 
-		printf("Time: %lld us", gup.delta_usec);
+		printf("Time: get:%lld put:%lld us", gup.get_delta_usec,
+			gup.put_delta_usec);
 		if (gup.size != size)
 			printf(", truncated (size: %lld)", gup.size);
 		printf("\n");
-- 
2.14.4

