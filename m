Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38188ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EEA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMTAB4Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EEA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJRRgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeJRRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so32860535wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xMYQ9kY4+9vkCjcMghg1qRg2z805eO3RerngQ9XZVKM=;
        b=PMTAB4Av4/xscFhI1yMEIjKdAYn1VXnBYndTH/hlhO26qo23pTmSpgxqMZxzKpKULP
         57yXLvVo9rNw5+1+AXrhIDOBJCyOCOytM0YljOzSd5rQOEieXiTrZ0yH79zlaepEPPPx
         suPzIk9gaS4jjJbqNbAJme/bwQgJcJDM0bm5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xMYQ9kY4+9vkCjcMghg1qRg2z805eO3RerngQ9XZVKM=;
        b=I6LPhri2TO8aTEVXkEjH9x8jyDc2jUEYuFruzKyuZ3nO5wKrI1kEniTKSnkjWpNtp+
         JbhlHjSMpG2e6bPZ4KZinCTbfN6R8oeAmA/NGlvooLfnmNNyRBL7MC6F102YE19UqfQ9
         q/HNFZkMLCRLQZCW1Ffj7lg7CP6NM0b3ZxIL2yyhKyTw6VMCUZ0zWxRuOH+SDomKNR0h
         AbDoauh/hqeKhc0m2w8JcaFcsZz9RQvxzpR//lRIA9oC2kPXrlS3Xp5Je8yRhfa/i/9z
         EpPSpj0WHMsZLEx4ixVXg5V3oOfkGtyb7gs7v7Dtjc4DzQR5qBthF61ZVt2FrIjH4frw
         Oilg==
X-Gm-Message-State: ABuFfogMPmSJcjtyKmsxOBGtI8Z8JqBsdDfY3tt5f1OC4PwqOjuVIUC+
        e9Pg/cZ+k/CgUFozpHh6+hOykw==
X-Google-Smtp-Source: ACcGV60CK0y9to2bKcpQdK0JxhuPIs13P9LmmxmplEY1UQitPdhkQ3GAEz+ipg+ugZfjjaKu2Ei0cA==
X-Received: by 2002:adf:f4c3:: with SMTP id h3-v6mr26496114wrp.259.1539855389737;
        Thu, 18 Oct 2018 02:36:29 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id 6-v6sm811323wrb.95.2018.10.18.02.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 02:36:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org
Cc:     thara.gopinath@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
Date:   Thu, 18 Oct 2018 11:35:58 +0200
Message-Id: <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was suggested to set the scene for the PM components in the
scheduler code organization in the recent discussion about making the
scheduler aware of the capacity capping from the thermal framework.

Move the cpufreq files into its own directory as suggested at:

https://lkml.org/lkml/2018/10/18/353
https://lkml.org/lkml/2018/10/18/408

Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/Makefile                                   | 3 +--
 kernel/sched/{cpufreq.c => cpufreq/core.c}              | 2 +-
 kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)
 rename kernel/sched/{cpufreq.c => cpufreq/core.c} (99%)
 rename kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} (99%)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7fe1834..bc6bce0 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -19,13 +19,12 @@ endif
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
+obj-y += cpufreq/
 
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
-obj-$(CONFIG_CPU_FREQ) += cpufreq.o
-obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq/core.c
similarity index 99%
rename from kernel/sched/cpufreq.c
rename to kernel/sched/cpufreq/core.c
index 5e54cbc..8c17a63 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq/core.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include "sched.h"
+#include "../sched.h"
 
 DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq/metrics.c
similarity index 99%
rename from kernel/sched/cpufreq_schedutil.c
rename to kernel/sched/cpufreq/metrics.c
index 3fffad3..597df47 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq/metrics.c
@@ -11,7 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include "sched.h"
+#include "../sched.h"
 
 #include <trace/events/power.h>
 
-- 
2.7.4

