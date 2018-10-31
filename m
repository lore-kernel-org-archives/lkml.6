Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC01C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9562081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9562081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeKAGHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:07:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:6767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbeKAGHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 14:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,449,1534834800"; 
   d="scan'208";a="102369365"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2018 14:07:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 1/8] selftests/resctrl: Add README for resctrl tests
Date:   Wed, 31 Oct 2018 14:02:27 -0700
Message-Id: <1541019754-192204-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
References: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl tests will be implemented. README is added for the tool first.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/README | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/README

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
new file mode 100644
index 000000000000..09851a619547
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,53 @@
+resctrl_tests - resctrl file system test suit
+
+Authors:
+	Fenghua Yu <fenghua.yu@intel.com>
+	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+	Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+
+resctrl_tests tests various resctrl functionalities and interfaces including
+both software and hardware.
+
+Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidth
+Allocation test on Intel RDT hardware. More tests will be added in the future.
+And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
+as well.
+
+BUILD
+-----
+
+Run "make" to build executable file "resctrl_tests".
+
+RUN
+---
+
+To use resctrl_tests, root or sudoer privileges are required. This is because
+the test needs to mount resctrl file system and change contents in the file
+system.
+
+Executing the test without any parameter will run all supported tests:
+
+	sudo ./resctrl_tests
+
+OVERVIEW OF EXECUTION
+---------------------
+
+A test case has four stages:
+
+  - setup: mount resctrl file system, create group, setup schemata, move test
+    process pids to tasks, start benchmark.
+  - execute: let benchmark run
+  - verify: get resctrl data and verify the data with another source, e.g.
+    perf event.
+  - teardown: umount resctrl and clear temporary files.
+
+ARGUMENTS
+---------
+
+Parameter '-h' shows usage information.
+
+usage: resctrl_tests [-h] [-b benchmark_cmd [options]] [-t test list]
+        -b benchmark_cmd [options]: run specified benchmark
+         default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm,mba
+        -h: help
-- 
2.5.0

