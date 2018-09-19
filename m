Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC4ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A77206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A77206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbeITClE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:41:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:60272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeITCko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:40:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 14:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="71344745"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2018 14:01:02 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/7] tools/gup_benchmark: Allow user specified file
Date:   Wed, 19 Sep 2018 15:02:47 -0600
Message-Id: <20180919210250.28858-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919210250.28858-1-keith.busch@intel.com>
References: <20180919210250.28858-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gup benchmark by default maps anonymous memory. This patch allows a
user to specify a file to map, providing a means to test various
file backings, like device and filesystem DAX.

Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index b2082df8beb4..f2c99e2436f8 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -33,9 +33,12 @@ int main(int argc, char **argv)
 	unsigned long size = 128 * MB;
 	int i, fd, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
 	int cmd = GUP_FAST_BENCHMARK;
+	int file_map = -1;
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	char *file = NULL;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:tTLU")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -61,11 +64,22 @@ int main(int argc, char **argv)
 		case 'w':
 			write = 1;
 			break;
+		case 'f':
+			file = optarg;
+			flags &= ~(MAP_PRIVATE | MAP_ANONYMOUS);
+			flags |= MAP_SHARED;
+			break;
 		default:
 			return -1;
 		}
 	}
 
+	if (file) {
+		file_map = open(file, O_RDWR|O_CREAT);
+		if (file_map < 0)
+			perror("open"), exit(file_map);
+	}
+
 	gup.nr_pages_per_call = nr_pages;
 	gup.flags = write;
 
@@ -73,8 +87,7 @@ int main(int argc, char **argv)
 	if (fd == -1)
 		perror("open"), exit(1);
 
-	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, file_map, 0);
 	if (p == MAP_FAILED)
 		perror("mmap"), exit(1);
 	gup.addr = (unsigned long)p;
-- 
2.14.4

