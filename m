Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73992087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBYFwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:52:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:8865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBYFwI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:52:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 21:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="149671632"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2019 21:52:06 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/3] perf diff: Support --pid/--tid filter options
Date:   Mon, 25 Feb 2019 21:42:44 +0800
Message-Id: <1551102164-3443-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
References: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better filtering support for perf diff, it would be useful to
add --pid and --tid filter options.

For example,
perf diff --tid 13965

It only diff the samples for thread 13965.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 6 ++++++
 tools/perf/builtin-diff.c              | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index ed13b3f..83c9496 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -164,6 +164,12 @@ OPTIONS
 	CPUs are specified with -: 0-2. Default is to report samples on all
 	CPUs.
 
+--pid=::
+	Only diff samples for given process ID (comma separated list).
+
+--tid=::
+	Only diff samples for given thread ID (comma separated list).
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 319fbc9..9053eda 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -993,6 +993,10 @@ static const struct option options[] = {
 	OPT_STRING(0, "time", &pdiff.time_str, "str",
 		   "Time span (time percent or absolute timestamp)"),
 	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_STRING(0, "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
+		   "only consider symbols in these pids"),
+	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
+		   "only consider symbols in these tids"),
 	OPT_END()
 };
 
-- 
2.7.4

