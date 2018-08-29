Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D59205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D59205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeH2VQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:6998 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeH2VQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68826404"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8A62F301BA0; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 04/10] perf, tools, script: Allow sym and dso without ip, addr
Date:   Wed, 29 Aug 2018 10:18:28 -0700
Message-Id: <20180829171834.6590-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Currently sym and dso require printing ip and addr because
the print function is tied to those outputs. With callindent
it makes sense to print the symbol or dso without numerical
IP or ADDR. So change the dependency check to only check the
underlying attribute.

This allows to remove a lot of noise in callindent output by
dropping the numerical addresses, which are not all that useful.

Before

% perf script --itrace=cr -F +callindent
         swapper     0 [000] 156546.354971:          1   branches: pt_config                                       0 [unknown] ([unknown]) => ffffffff81010486 pt_config ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     pt_config                    ffffffff81010499 pt_config ([kernel.kallsyms]) => ffffffff8101063e pt_event_add ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     pt_event_add                 ffffffff81010635 pt_event_add ([kernel.kallsyms]) => ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_enable              ffffffff8115e726 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff811579b0 perf_pmu_enable ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_nop_void            ffffffff81151730 perf_pmu_nop_void ([kernel.kallsyms]) => ffffffff8115e72b event_sched_in.isra.107 ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     event_sched_in.isra.107      ffffffff8115e737 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff8115e7a5 group_sched_in ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     __x86_indirect_thunk_rax     ffffffff8115e7f6 group_sched_in ([kernel.kallsyms]) => ffffffff81a03000 __x86_indirect_thunk_rax ([kernel.kallsyms])

After

% perf script --itrace=cr -F +callindent,-ip,-sym
       swapper     0 [000] 156546.354971:          1   branches:  pt_config
         swapper     0 [000] 156546.354971:          1   branches:      pt_config
         swapper     0 [000] 156546.354971:          1   branches:      pt_event_add
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_enable
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_void
         swapper     0 [000] 156546.354971:          1   branches:       event_sched_in.isra.107
         swapper     0 [000] 156546.354971:          1   branches:       __x86_indirect_thunk_rax
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_int
         swapper     0 [000] 156546.354971:          1   branches:       group_sched_in
         swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
         swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
         swapper     0 [000] 156546.354971:          1   branches:       group_sched_in

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 66daa7df68c5..bae960c56763 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -407,9 +407,10 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					PERF_OUTPUT_WEIGHT))
 		return -EINVAL;
 
-	if (PRINT_FIELD(SYM) && !PRINT_FIELD(IP) && !PRINT_FIELD(ADDR)) {
+	if (PRINT_FIELD(SYM) &&
+		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
-			   "sample address\nis selected. Hence, no addresses to convert "
+			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
 		return -EINVAL;
 	}
@@ -418,10 +419,9 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 		       "selected.\n");
 		return -EINVAL;
 	}
-	if (PRINT_FIELD(DSO) && !PRINT_FIELD(IP) && !PRINT_FIELD(ADDR) &&
-	    !PRINT_FIELD(BRSTACK) && !PRINT_FIELD(BRSTACKSYM) && !PRINT_FIELD(BRSTACKOFF)) {
-		pr_err("Display of DSO requested but no address to convert.  Select\n"
-		       "sample IP, sample address, brstack, brstacksym, or brstackoff.\n");
+	if (PRINT_FIELD(DSO) &&
+		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(SRCLINE) && !PRINT_FIELD(IP)) {
-- 
2.17.1

