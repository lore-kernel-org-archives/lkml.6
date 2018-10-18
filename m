Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CFD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0yCzCep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CFD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJRRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:45:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:45:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so32901345wrt.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ML7BC+6djTXaiO8RLCoqQuER7nYUMEieYbNI6AwQsNM=;
        b=c0yCzCepjoxWx7YcNmhbQu/ScnPLtkTaWmT8c9RtF3xAwQLm9r5ejfxXmQwio64eNt
         1AW732GjuZJmStsdMwv6w6hPJHQys9AXNjMEsxYi05y+HCSHUShdZsZi+ywiGmD7mLYw
         r4mdZQNoWC0yolt5ldF2OkzyesDiWauLW5A1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ML7BC+6djTXaiO8RLCoqQuER7nYUMEieYbNI6AwQsNM=;
        b=O+LfTnvGEcUxlXwTpjIq6KkFcT80Wj+bVkWNbtcEmgC7HCA89QHeV3flJnvRyivNwL
         j50gt/YGL/1CttGjd/RMkc3H28Q7RVsCEFh/6qS90uvemSseBoXnXQ6MWFFGjXQ+Mzq6
         pzaxuPs6j0x/Lsf2MC41mpzaQxOXFF1gsblowFg8bTACfD1g9PbMObyfqi9Sr4yf2p2J
         gDZcpxrfQf4YApemwZ3tclhqyuZ9eo/irr2UIyAzyFbkDoMdNzJSvJp85Cx8bKahm25g
         gVSPnFuSYvz8IsPWtOO31ypoa5xpwPLtSwLKmd+r4SF5klLI4WGi9wUcgdbEmdahYBzJ
         1RsQ==
X-Gm-Message-State: ABuFfohZ7JI+JVm7q67v76i4MEDnkahAFRJBHa+v3AezXM9lR8kWGc7w
        qbCK9qhww0iOmSNzLAFTkQz/gw==
X-Google-Smtp-Source: ACcGV635rRRH2B61L7+KLIZouzC7QMHvC+kvOpQet61wifZbYTqj7zAD7xdolPLp9O6FxGibXqnrAg==
X-Received: by 2002:adf:a201:: with SMTP id p1-v6mr27743114wra.89.1539855914405;
        Thu, 18 Oct 2018 02:45:14 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id 195-v6sm4321756wmx.21.2018.10.18.02.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 02:45:13 -0700 (PDT)
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
Subject: [PATCH V2 1/2] sched/cpufreq: Reorganize the cpufreq files
Date:   Thu, 18 Oct 2018 11:44:14 +0200
Message-Id: <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
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
Changelog:
 * git added the Makefile in cpufreq/Makefile (V2)

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/Makefile                                   | 3 +--
 kernel/sched/cpufreq/Makefile                           | 3 +++
 kernel/sched/{cpufreq.c => cpufreq/core.c}              | 2 +-
 kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 kernel/sched/cpufreq/Makefile
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
diff --git a/kernel/sched/cpufreq/Makefile b/kernel/sched/cpufreq/Makefile
new file mode 100644
index 0000000..4bf1087
--- /dev/null
+++ b/kernel/sched/cpufreq/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CPU_FREQ) += core.o
+obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += metrics.o
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

