Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DBD2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwZ8akAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DBD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeKFVb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:55 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A2E2086A;
        Tue,  6 Nov 2018 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506021;
        bh=1TvFqvlE361iHy7/8kHxI1NphgPxhNEP4yg5DgyIBaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwZ8akAq3Y5ArJX6/SYr/i44jDV01l16tqF0dgOHISSsyrmE+FfHgO/SCfL6vGzhw
         +k+ddoN12pX7v931W3EokynmPz/FH4hnqVL4xrRH2oEmeQKCzfeFSv0rr83bXxyZr7
         9rTy7i9F6YOCzKOGmXbxRj9ys+nYUyOy4f1IRGxk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/18] perf top: Display the LBR stats in callchain entry
Date:   Tue,  6 Nov 2018 09:06:03 -0300
Message-Id: <20181106120612.8262-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
-- 
2.14.4

