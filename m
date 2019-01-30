Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051EC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51540218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfA3OY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:24:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:27023 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbfA3OYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:24:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 06:24:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="271154295"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 06:24:53 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 08/13] perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Wed, 30 Jan 2019 06:23:49 -0800
Message-Id: <1548858234-8872-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_DATA_PAGE_SIZE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/tests/sample-parsing.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0e2d00d..1de5fa0 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -145,6 +145,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		COMP(data_page_size);
+
 	return true;
 }
 
@@ -210,7 +213,9 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.mask	= sample_regs,
 			.regs	= regs,
 		},
+
 		.phys_addr	= 113,
+		.data_page_size	= PERF_PAGE_SIZE_4K,
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
@@ -310,7 +315,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PHYS_ADDR << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_DATA_PAGE_SIZE << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.7.4

