Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF2C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF2C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJKDYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:24:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:52848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbeJKDYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 13:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="240262417"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 12:59:34 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/6] tools/gup_benchmark: Add MAP_SHARED option
Date:   Wed, 10 Oct 2018 13:56:04 -0600
Message-Id: <20181010195605.10689-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181010195605.10689-1-keith.busch@intel.com>
References: <20181010195605.10689-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new benchmark option, -S, to request MAP_SHARED. This
can be used to compare with MAP_PRIVATE, or for files that require this
option, like dax.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index b675a3d60975..24528b54549d 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -32,11 +32,11 @@ int main(int argc, char **argv)
 	struct gup_benchmark gup;
 	unsigned long size = 128 * MB;
 	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
-	int cmd = GUP_FAST_BENCHMARK;
+	int cmd = GUP_FAST_BENCHMARK, flags = MAP_PRIVATE;
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUS")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -65,6 +65,10 @@ int main(int argc, char **argv)
 		case 'f':
 			file = optarg;
 			break;
+		case 'S':
+			flags &= ~MAP_PRIVATE;
+			flags |= MAP_SHARED;
+			break;
 		default:
 			return -1;
 		}
@@ -81,7 +85,7 @@ int main(int argc, char **argv)
 	if (fd == -1)
 		perror("open"), exit(1);
 
-	p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, filed, 0);
+	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
 	if (p == MAP_FAILED)
 		perror("mmap"), exit(1);
 	gup.addr = (unsigned long)p;
-- 
2.14.4

