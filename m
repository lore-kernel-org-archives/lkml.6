Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C23C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9D621874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfADC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:29:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:63283 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfADC3v (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:29:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 18:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="106835509"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2019 18:29:49 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Poll for monitored tasks being alive in fork mode
Date:   Fri,  4 Jan 2019 10:28:17 +0800
Message-Id: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following test shows the stat keeps running even if no longer
task to monitor (mgen exits at ~5s).

perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
            time             counts unit events
     1.000148916      1,308,365,864      cycles
     2.000379171      1,297,269,875      cycles
     3.000556719      1,297,187,078      cycles
     4.000914241        761,261,827      cycles
     5.001306091      <not counted>      cycles
     6.001676881      <not counted>      cycles
     7.002046336      <not counted>      cycles
     8.002405651      <not counted>      cycles
     9.002766625      <not counted>      cycles
    10.001395827      <not counted>      cycles

We'd better finish stat immediately if there's no longer task to
monitor.

After:

perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
            time             counts unit events
     1.000180062      1,236,592,661      cycles
     2.000421539      1,223,733,572      cycles
     3.000609910      1,297,047,663      cycles
     4.000807545      1,297,215,816      cycles
     5.001001578      1,297,208,032      cycles
     6.001390345        582,343,659      cycles
sleep: Terminated

Now the stat exits immediately when the monitored tasks ends.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc..71f3bc8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -553,6 +553,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
+				if (!is_target_alive(&target,
+					evsel_list->threads) &&
+					(child_pid != -1)) {
+					kill(child_pid, SIGTERM);
+					break;
+				}
+
 				nanosleep(&ts, NULL);
 				if (timeout)
 					break;
-- 
2.7.4

