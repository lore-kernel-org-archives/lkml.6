Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF18CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B8E20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B8E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIACLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:11:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:23516 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeIACLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:11:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 15:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,313,1531810800"; 
   d="scan'208";a="229317075"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2018 15:02:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E6062301BFB; Fri, 31 Aug 2018 15:02:09 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 05/10] tools, perf, script: Set user_set/wildcard_set for +- fields in -F
Date:   Fri, 31 Aug 2018 15:02:01 -0700
Message-Id: <20180831220206.28351-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831220206.28351-1-andi@firstfloor.org>
References: <20180831220206.28351-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The branch target output relies on the user_set flag to determine
if the branch target should be implicitely printed. When
modifying the fields with + or - also set user_set,
so that ADDR can be removed. We also need to set wildcard_set
to make the initial sanity check pass.

Before:

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff,-addr
         swapper     0 [000]  3377.917072:          1   branches: pt_config                        => ffffffff81010486 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     pt_config                    => ffffffff8101063e ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     pt_event_add                 => ffffffff8115e687 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_enable              => ffffffff811579b0 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_void            => ffffffff8115e72b ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     event_sched_in.isra.107      => ffffffff8115e7a5 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     __x86_indirect_thunk_rax     => ffffffff81a03000 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_int             => ffffffff8115e7fb ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in               => ffffffff811583a8 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match           => ffffffff81153e10 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match           => ffffffff811583d4 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in               => ffffffff8115e738 ([kernel.kallsyms])
         swapper     0 [000]  3377.917072:          1   branches:         __x86_indirect_thunk_rax => ffffffff81a03000 ([kernel.kallsyms])

After:

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

v2: Use correct index for fallback case
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bae960c56763..d7d454d10074 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2490,6 +2490,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 						output[j].fields &= ~all_output_options[i].field;
 					else
 						output[j].fields |= all_output_options[i].field;
+					output[j].user_set = true;
+					output[j].wildcard_set = true;
 				}
 			}
 		} else {
@@ -2500,7 +2502,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
-			output[type].fields |= all_output_options[i].field;
+			output[type].user_set = true;
+			output[type].wildcard_set = true;
 		}
 	}
 
-- 
2.17.1

