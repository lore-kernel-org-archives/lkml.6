Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E290F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E290F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeIACLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:11:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:23515 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIACLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:11:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 15:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,313,1531810800"; 
   d="scan'208";a="229317077"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2018 15:02:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0015A301BFA; Fri, 31 Aug 2018 15:02:09 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 07/10] perf, tools, script: Print DSO for callindent
Date:   Fri, 31 Aug 2018 15:02:03 -0700
Message-Id: <20180831220206.28351-8-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831220206.28351-1-andi@firstfloor.org>
References: <20180831220206.28351-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Now that we don't need to print the IP/ADDR for callindent the DSO
is also not printed. It's useful for some cases, so add an own DSO
printout for callindent for the case when IP/ADDR is not enabled.

Before:

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff,-addr
         swapper     0 [000]  3377.917072:          1   branches: pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_event_add
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches:     event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches:     __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in

After:

         swapper     0 [000]  3377.917072:          1   branches: ([unknown])   pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_event_add
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           perf_pmu_nop_txn
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           event_sched_in.isra.107

(in the kernel case of course it's not very useful, but it's important
with user programs where symbols are not unique)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 129b11404a9c..0a80ae3aa33e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1116,6 +1116,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
+	int dlen = 0;
 	u64 ip = 0;
 
 	/*
@@ -1142,6 +1143,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 			ip = sample->ip;
 	}
 
+	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
+		dlen += fprintf(fp, "(");
+		dlen += map__fprintf_dsoname(al->map, fp);
+		dlen += fprintf(fp, ")\t");
+	}
+
 	if (name)
 		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
@@ -1160,7 +1167,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (len < spacing)
 		len += fprintf(fp, "%*s", spacing - len, "");
 
-	return len;
+	return len + dlen;
 }
 
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
-- 
2.17.1

