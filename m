Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABCC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCDD20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCDD20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJaMKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:10:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:51764 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeJaMKv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:10:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104689292"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 20:14:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf top: Display the LBR stats in callchain entry
Date:   Wed, 31 Oct 2018 19:06:35 +0800
Message-Id: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf report has supported the displaying of LBR stats
(such as cycles, predicted%) in callchain entry.

For example,
perf report --branch-history --stdio

--1.01%--intel_idle mwait.h:29
          intel_idle cpufeature.h:164 (cycles:5)
          intel_idle cpufeature.h:164 (predicted:76.4%)
          intel_idle mwait.h:102 (cycles:41)
          intel_idle current.h:15

While perf top has not supported that.

For example,
perf top -a -b --call-graph branch

-   13.86%     0.23%  [kernel]		[k] __x86_indirect_thunk_rax
   - 13.65% __x86_indirect_thunk_rax
      + 1.69% do_syscall_64
      + 1.68% do_select
      + 1.41% ktime_get
      + 0.70% __schedule
      + 0.62% do_sys_poll
        0.58% __x86_indirect_thunk_rax

Actually it's very easy to enable this feature in perf top.

With this patch, the result is:

perf top -a -b --call-graph branch

-   13.58%     0.00%  [kernel]		[k] __x86_indirect_thunk_rax
   - 13.57% __x86_indirect_thunk_rax (predicted:93.9%)
      + 1.78% do_select (cycles:2)
      + 1.68% perf_pmu_disable.part.99 (cycles:1)
      + 1.45% ___sys_recvmsg (cycles:25)
      + 0.81% unix_stream_sendmsg (cycles:18)
      + 0.80% ktime_get (cycles:400)
        0.58% pick_next_task_fair (cycles:47)
      + 0.56% i915_request_retire (cycles:2)
      + 0.52% do_sys_poll (cycles:4)

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-top.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d875..7691b21 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1420,6 +1420,9 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (opts->branch_stack && callchain_param.enabled)
+		symbol_conf.show_branchflag_count = true;
+
 	sort__mode = SORT_MODE__TOP;
 	/* display thread wants entries to be collapsed in a different tree */
 	perf_hpp_list.need_collapse = 1;
-- 
2.7.4

