Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeE3LoF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:44:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43221 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeE3LoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:44:02 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>
Subject: [PATCH 1/2] cpuidle: governors: Drop redundant checks related to PM QoS
Date: Wed, 30 May 2018 13:41:09 +0200
Message-ID: <2392049.LpkvHV6nCY@aspire.rjw.lan>
In-Reply-To: <2261593.SGWtJkXgY3@aspire.rjw.lan>
References: <2261593.SGWtJkXgY3@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

PM_QOS_RESUME_LATENCY_NO_CONSTRAINT is defined as the 32-bit integer
maximum, so it is not necessary to test the return value of
dev_pm_qos_raw_read_value() against it directly in the menu and
ladder cpuidle governors.

Drop these redundant checks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/ladder.c |    3 +--
 drivers/cpuidle/governors/menu.c   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -76,8 +76,7 @@ static int ladder_select_state(struct cp
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int resume_latency = dev_pm_qos_raw_read_value(device);
 
-	if (resume_latency < latency_req &&
-	    resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+	if (resume_latency < latency_req)
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -304,8 +304,7 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	if (resume_latency < latency_req &&
-	    resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+	if (resume_latency < latency_req)
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
