Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeBXATt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:19:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeBXATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:19:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4837E602B6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
From: Saravana Kannan <skannan@codeaurora.org>
To: mark.rutland@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: skannan@codeaurora.org, avilaj@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] perf/core: Add API to look up PMU type by name
Date: Fri, 23 Feb 2018 16:19:37 -0800
Message-Id: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the event numbers registered by multiple PMUs overlap, the
attr->type value passed to perf_event_create_kernel_counter() is used
to determine which PMU to use to create a perf_event.

However, when the PMU in question is not a standard PMU (defined in
perf_type_id), there is no way for a kernel client to look up the PMU
type for the PMU of interest and set the attr->type appropriately.

So, add an API to look up the PMU type by name. That way, the kernel
APIs can function in a fashion similar to the user space interface.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 kernel/events/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae..5d3df58 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10310,6 +10310,29 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 	return err;
 }
 
+int perf_find_pmu_type_by_name(const char *name)
+{
+	struct pmu *pmu;
+	int ret = -1;
+
+	mutex_lock(&pmus_lock);
+
+	list_for_each_entry(pmu, &pmus, entry) {
+		if (!pmu->name || pmu->type < 0)
+			continue;
+
+		if (!strcmp(name, pmu->name)) {
+			ret = pmu->type;
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&pmus_lock);
+
+	return ret;
+}
+
 /**
  * perf_event_create_kernel_counter
  *
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
