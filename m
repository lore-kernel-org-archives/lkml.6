Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9617C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EF1214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EF1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIZO4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:56:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:56:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8iXLn3771295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:44:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8iXQW3771292;
        Wed, 26 Sep 2018 01:44:33 -0700
Date:   Wed, 26 Sep 2018 01:44:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-37fed3de555199733805a2d3e03aee7727c09ea4@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com, kim.phillips@arm.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com
Reply-To: mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, kim.phillips@arm.com, ak@linux.intel.com,
          adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20180918123214.26728-5-andi@firstfloor.org>
References: <20180918123214.26728-5-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Allow sym and dso without ip, addr
Git-Commit-ID: 37fed3de555199733805a2d3e03aee7727c09ea4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  37fed3de555199733805a2d3e03aee7727c09ea4
Gitweb:     https://git.kernel.org/tip/37fed3de555199733805a2d3e03aee7727c09ea4
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 18 Sep 2018 05:32:09 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 15:20:03 -0300

perf script: Allow sym and dso without ip, addr

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
@@ -2491,6 +2491,8 @@ parse:
 						output[j].fields &= ~all_output_options[i].field;
 					else
 						output[j].fields |= all_output_options[i].field;
+					output[j].user_set = true;
+					output[j].wildcard_set = true;
 				}
 			}
 		} else {
@@ -2501,7 +2503,8 @@ parse:
 				rc = -EINVAL;
 				goto out;
 			}
-			output[type].fields |= all_output_options[i].field;
+			output[type].user_set = true;
+			output[type].wildcard_set = true;
 		}
 	}
 
