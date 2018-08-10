Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D27C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1477223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1477223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeHJQIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:08:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:32059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbeHJQIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 06:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,219,1531810800"; 
   d="scan'208";a="80633172"
Received: from otc-lr-04.jf.intel.com ([10.54.39.114])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2018 06:38:01 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RFC 7/7] perf test: Add test case for PERF_SAMPLE_PAGE_SIZE
Date:   Fri, 10 Aug 2018 06:36:27 -0700
Message-Id: <1533908187-25204-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
References: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_PAGE_SIZE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/sample-parsing.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0e2d00d..cfba33d 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -145,6 +145,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_PAGE_SIZE)
+		COMP(page_size);
+
 	return true;
 }
 
@@ -210,7 +213,9 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.mask	= sample_regs,
 			.regs	= regs,
 		},
+
 		.phys_addr	= 113,
+		.page_size	= PERF_MEM_PAGE_SIZE_4K,
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
@@ -310,7 +315,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PHYS_ADDR << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PAGE_SIZE << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.7.4

