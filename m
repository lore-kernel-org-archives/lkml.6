Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5570B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaAnKap0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5570B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeIXVGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbeIXVGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:06:02 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F51920C0A;
        Mon, 24 Sep 2018 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801407;
        bh=IFj+pP5a4hy4hKL1p6Es2mURcSt+JT85n/f4OZb/87k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaAnKap0zajmNkeV3j97fGvSju45W66Sl6Ns4Rn31fTFMPj2G0tIytnlYTaH2IhNl
         zpIsougQyAhnEWmOw95ND92qUFv31lNSRuLMLi1rGmK2WCmFG2c/AKMpLW6Rpbx/Jy
         bBykKT1VkrQQ+TgziQjONg3e/65V3uRSMrzgOHIA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/27] perf script: Allow sym and dso without ip, addr
Date:   Mon, 24 Sep 2018 12:02:19 -0300
Message-Id: <20180924150242.14235-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Currently sym and dso require printing ip and addr because the print
function is tied to those outputs. With callindent it makes sense to
print the symbol or dso without numerical IP or ADDR. So change the
dependency check to only check the underlying attribute.

Also the branch target output relies on the user_set flag to determine
if the branch target should be implicitely printed. When modifying the
fields with + or - also set user_set, so that ADDR can be removed. We
also need to set wildcard_set to make the initial sanity check pass.

This allows to remove a lot of noise in callindent output by dropping
the numerical addresses, which are not all that useful.

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

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180918123214.26728-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 66699dd351e0..7aa59696e97a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -406,9 +406,10 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
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
@@ -417,10 +418,9 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
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
@@ -2491,6 +2491,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 						output[j].fields &= ~all_output_options[i].field;
 					else
 						output[j].fields |= all_output_options[i].field;
+					output[j].user_set = true;
+					output[j].wildcard_set = true;
 				}
 			}
 		} else {
@@ -2501,7 +2503,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
-			output[type].fields |= all_output_options[i].field;
+			output[type].user_set = true;
+			output[type].wildcard_set = true;
 		}
 	}
 
-- 
2.14.4

