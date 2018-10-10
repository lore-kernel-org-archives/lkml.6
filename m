Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBEE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBEE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJKDYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:24:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:52848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeJKDYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 13:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="240262414"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 12:59:34 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/6] tools/gup_benchmark: Allow user specified file
Date:   Wed, 10 Oct 2018 13:56:03 -0600
Message-Id: <20181010195605.10689-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181010195605.10689-1-keith.busch@intel.com>
References: <20181010195605.10689-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows a user to specify a file to map by adding a new option,
'-f', providing a means to test various file backings.

If not specified, the benchmark will use a private mapping of /dev/zero,
which produces an anonymous mapping as before.

Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index b2082df8beb4..b675a3d60975 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -31,11 +31,12 @@ int main(int argc, char **argv)
 {
 	struct gup_benchmark gup;
 	unsigned long size = 128 * MB;
-	int i, fd, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
+	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
 	int cmd = GUP_FAST_BENCHMARK;
+	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:tTLU")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -61,11 +62,18 @@ int main(int argc, char **argv)
 		case 'w':
 			write = 1;
 			break;
+		case 'f':
+			file = optarg;
+			break;
 		default:
 			return -1;
 		}
 	}
 
+	filed = open(file, O_RDWR|O_CREAT);
+	if (filed < 0)
+		perror("open"), exit(filed);
+
 	gup.nr_pages_per_call = nr_pages;
 	gup.flags = write;
 
@@ -73,8 +81,7 @@ int main(int argc, char **argv)
 	if (fd == -1)
 		perror("open"), exit(1);
 
-	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, filed, 0);
 	if (p == MAP_FAILED)
 		perror("mmap"), exit(1);
 	gup.addr = (unsigned long)p;
-- 
2.14.4

