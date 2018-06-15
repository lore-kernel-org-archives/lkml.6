Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90721C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9D620891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9D620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965475AbeFOCKH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:10:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:54467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965072AbeFOCKE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:10:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="49141623"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2018 19:10:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        me@kylehuey.com
Cc:     Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/2] perf Documentation: Introduce the sysctl perf_allow_sample_leakage
Date:   Fri, 15 Jun 2018 18:03:23 +0800
Message-Id: <1529057003-2212-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new sysctl /sys/devices/cpu/perf_allow_sample_leakage, which
turns on/off dropping leaked kernel samples.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 04168da..97fb0f8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -93,6 +93,20 @@ OPTIONS
 	  prevent the shell interpretation.  You also need to use --group on
 	  "perf report" to view group events together.
 
+	Note that if workload does a lot of kernel entry/exit we may see
+	kernel samples even if :u is specified. That is due to skid existing.
+	This might be a security issue because it can leak kernel address even
+	though kernel sampling support is disabled. We have a sysctl to turn
+	on/off the dropping of leaked kernel samples.
+
+	/sys/devices/cpu/perf_allow_sample_leakage
+
+	0 - drop the leaked kernel samples, default option.
+	1 - don't drop the leaked kernel samples.
+
+	For example, write 1 to perf_allow_sample_leakage
+	echo 1 > /sys/devices/cpu/perf_allow_sample_leakage
+
 --filter=<filter>::
         Event filter. This option should follow a event selector (-e) which
 	selects either tracepoint event(s) or a hardware trace PMU
-- 
2.7.4

