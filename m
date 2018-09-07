Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F643C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95062083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FjmCSDK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95062083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeIHCZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:04 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:8260 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbeIHCZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356528; x=1567892528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbPcVkVqOz+R+v6aQlcMNERwnmRKSEKZObG9AN+yBJs=;
  b=FjmCSDK4ayK4e7iCAnEyLZjZCkEeQlXC6f1rbMKtJy0u/B+dXGWIqFP4
   UwI82sJXmwBpWB1hP6VBco0JcVu8k1v9v8YDtQw9pHYlw12X43M5wOy+H
   1LKBbiF9fpmc7smyNIjtHoiLHOEzMmX5VHtWvkYIM+ivbBKiMlgC0Dmlx
   g=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243161"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:07 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg1x6129451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:03 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfxJf027366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:59 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lfw3R027362;
        Fri, 7 Sep 2018 23:41:58 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 22/60] cosched: Add config option for coscheduling support
Date:   Fri,  7 Sep 2018 23:40:09 +0200
Message-Id: <20180907214047.26914-23-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scheduled task groups will bring coscheduling to Linux.
The actual functionality will be added successively.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 init/Kconfig           | 11 +++++++++++
 kernel/sched/Makefile  |  1 +
 kernel/sched/cosched.c |  9 +++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 kernel/sched/cosched.c

diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2f1cba..78807f8f2cf7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -762,6 +762,17 @@ config FAIR_GROUP_SCHED
 	depends on CGROUP_SCHED
 	default CGROUP_SCHED
 
+config COSCHEDULING
+	bool "Coscheduling extension for SCHED_OTHER (EXPERIMENTAL)"
+	depends on FAIR_GROUP_SCHED && SMP
+	default n
+	help
+	  This feature enables coscheduling for SCHED_OTHER. Unlike
+	  regular task groups the system aims to run members of
+	  scheduled task groups (STGs) simultaneously.
+
+	  Say N if unsure.
+
 config CFS_BANDWIDTH
 	bool "CPU bandwidth provisioning for FAIR_GROUP_SCHED"
 	depends on FAIR_GROUP_SCHED
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7fe183404c38..f32781fe76c5 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
+obj-$(CONFIG_COSCHEDULING) += cosched.o
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
new file mode 100644
index 000000000000..3bd4557ca5b7
--- /dev/null
+++ b/kernel/sched/cosched.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Coscheduling extension for CFS.
+ *
+ * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ * Author: Jan H. Schönherr <jschoenh@amazon.de>
+ */
+
+#include "sched.h"
-- 
2.9.3.1.gcba166c.dirty

