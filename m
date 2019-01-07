Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F8F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfAGBCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 20:02:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:36769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfAGBCX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 20:02:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2019 17:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,449,1539673200"; 
   d="scan'208";a="309483277"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2019 17:02:20 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] Poll for monitored tasks being alive in fork mode
Date:   Mon,  7 Jan 2019 09:00:50 +0800
Message-Id: <1546822850-30649-1-git-send-email-yao.jin@linux.intel.com>
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

v2:
---
There is a potential race condition window, that is the
child_pid set with -1 and kill(-1, SIGTERM) may happen.
Jiri provides a simple method which stores the child_pid to
a local variable and check the local variable before kill().
At least, we can avoid the kill(-1, SIGTERM) case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc..bd5fb8e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -553,6 +553,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
+				if (!is_target_alive(&target,
+					evsel_list->threads)) {
+					int pid = child_pid;
+
+					if (pid != -1)
+						kill(pid, SIGTERM);
+					break;
+				}
+
 				nanosleep(&ts, NULL);
 				if (timeout)
 					break;
-- 
2.7.4

