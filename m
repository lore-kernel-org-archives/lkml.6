Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52050C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2293920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2293920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeKGEli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:41:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKGEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:41:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JEbCS911187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:14:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JEbYa911184;
        Tue, 6 Nov 2018 11:14:37 -0800
Date:   Tue, 6 Nov 2018 11:14:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-590ac60d8aa929bd21e35cd95a7d8720d00eb4f3@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        hpa@zytor.com, kan.liang@linux.intel.com, ak@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        yao.jin@linux.intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          yao.jin@linux.intel.com, mingo@kernel.org,
          kan.liang@linux.intel.com, ak@linux.intel.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
References: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Display the LBR stats in callchain
 entry
Git-Commit-ID: 590ac60d8aa929bd21e35cd95a7d8720d00eb4f3
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

Commit-ID:  590ac60d8aa929bd21e35cd95a7d8720d00eb4f3
Gitweb:     https://git.kernel.org/tip/590ac60d8aa929bd21e35cd95a7d8720d00eb4f3
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Wed, 31 Oct 2018 19:06:35 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:37:11 -0300

perf top: Display the LBR stats in callchain entry

'perf report' has supported the displaying of LBR stats (such as cycles,
predicted%) in callchain entry.

For example:

  $ perf report --branch-history --stdio

  --1.01%--intel_idle mwait.h:29
            intel_idle cpufeature.h:164 (cycles:5)
            intel_idle cpufeature.h:164 (predicted:76.4%)
            intel_idle mwait.h:102 (cycles:41)
            intel_idle current.h:15

While 'perf top' doesn't support that.

For example:

  $ perf top -a -b --call-graph branch

  -   13.86%     0.23%  [kernel]		[k] __x86_indirect_thunk_rax
     - 13.65% __x86_indirect_thunk_rax
        + 1.69% do_syscall_64
        + 1.68% do_select
        + 1.41% ktime_get
        + 0.70% __schedule
        + 0.62% do_sys_poll
          0.58% __x86_indirect_thunk_rax

Actually it's very easy to enable this feature in 'perf top'.

With this patch, the result is:

  $ perf top -a -b --call-graph branch

  $ -   13.58%     0.00%  [kernel]		[k] __x86_indirect_thunk_rax
     $ - 13.57% __x86_indirect_thunk_rax (predicted:93.9%)
        $ + 1.78% do_select (cycles:2)
        $ + 1.68% perf_pmu_disable.part.99 (cycles:1)
        $ + 1.45% ___sys_recvmsg (cycles:25)
        $ + 0.81% unix_stream_sendmsg (cycles:18)
        $ + 0.80% ktime_get (cycles:400)
          $ 0.58% pick_next_task_fair (cycles:47)
        $ + 0.56% i915_request_retire (cycles:2)
        $ + 0.52% do_sys_poll (cycles:4)

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1540983995-20462-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b2838de13de0..aa0c73e57924 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1429,6 +1429,9 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (opts->branch_stack && callchain_param.enabled)
+		symbol_conf.show_branchflag_count = true;
+
 	sort__mode = SORT_MODE__TOP;
 	/* display thread wants entries to be collapsed in a different tree */
 	perf_hpp_list.need_collapse = 1;
