Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723AAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E16206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eid0aJWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E16206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395140AbeKVXQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:16:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51897 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395115AbeKVXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:16:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id j207so1698579wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 04:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SiwgRx6Q1l7iY5NUc0wCGobyhCRyGF6V12d2REUS55w=;
        b=eid0aJWgdiiKu+mHiHVKRO5pYSXoC8+yApiLupucnzxSJVSj/V2eRvWZteaSRN3WFi
         su5YJILv0uIfp88a2KO3ghMUy3mRPRkm8Q85jumZmvqeqEhEjAGsF4xnIFK0PNRHA10p
         hsO3p+QuipDW55RVQQXycgVBsrKX4MyeW5kso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SiwgRx6Q1l7iY5NUc0wCGobyhCRyGF6V12d2REUS55w=;
        b=YsiYJWEOI2AsU6sRs9cMYrlXw5mQCqM1gz6kVKz/zjk/rOcdmqijTAsqdfhWHoEoEg
         WC8JoX8ajRq/s7oh0NfJd4hvqW4HgiZ5lNvEu11k0rpVWxxzsLPW46GyTFJTZ7dl//Sx
         IxwBSMHXbbvxM/OL5GbTvclW3u6ggzXqEcZijxc8oGo6DbAeNd+NVqWgYg2sv9ZVpU9Z
         S/RTt0RBNQlHcYBya42ZmXbG/S9LnYBKPMKUrItd1L05hKG85/2fwNK0Rlt7W/T1mZde
         wnBR01i+bBlMxRW1tDllO8LkQebnWR8Zv8kBiqXyBL/ASTo+xC9KdPW2w4IwmVcoNGwT
         f1Eg==
X-Gm-Message-State: AGRZ1gKvcZqS4oQv0qnxZp8rZXVRlM4ay6l6OJ+7c7l/iqP+kODsvxJW
        PL6vLUh6+NqgT5tYP1eP0s2GYA==
X-Google-Smtp-Source: AJdET5ejIb/lpqGCGl+Zva7YVk3nzlW5CcX4SLlbK2o0XFmPPEa9b38soF+bXQppT0KBNFhILCm8Kg==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr9933302wmh.87.1542890227066;
        Thu, 22 Nov 2018 04:37:07 -0800 (PST)
Received: from localhost.localdomain (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.gmail.com with ESMTPSA id x8sm12376840wrd.53.2018.11.22.04.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 04:37:06 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH V2 2/2] base/drivers/arch_topology: Default dmips-mhz if they are not set in DT
Date:   Thu, 22 Nov 2018 13:36:45 +0100
Message-Id: <1542890209-3263-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
References: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of asymmetric SoC with the same micro-architecture, we
have a group of CPUs with smaller OPPs than the other group. One
example is the 96boards dragonboard 820c. There is no dmips/MHz
difference between both groups, so no need to specify the values in
the DT. Unfortunately, without these defined, there is no scaling
capacity computation triggered, so we need to write
'capacity-dmips-mhz' for each CPU with the same value in order to
force the scaled capacity computation.

Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
'capacity-dmips-mhz' is defined in the DT.

This was tested on db820c:
 - specified values in the DT (correct results)
 - partial values defined in the DT (error + fallback to defaults)
 - no specified values in the DT (correct results)

correct results are:
  cat /sys/devices/system/cpu/cpu*/cpu_capacity
   758
   758
  1024
  1024

  ... respectively for CPU0, CPU1, CPU2 and CPU3.

That reflects the capacity for the max frequencies 1593600 and 2150400.

Cc: Chris Redpath <chris.redpath@linaro.org>
Cc: Quentin Perret <quentin.perret@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/arch_topology.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index fd5325b..e0c5b60 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
+	if (!raw_capacity) {
+
+		pr_info("cpu_capacity: No capacity defined in DT, set default "
+		       "values to %ld\n", SCHED_CAPACITY_SCALE);
+
+		raw_capacity = kmalloc_array(num_possible_cpus(),
+					     sizeof(*raw_capacity), GFP_KERNEL);
+		if (!raw_capacity)
+			return -ENOMEM;
+	}
+
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
 		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
 		return -ENOMEM;
-- 
2.7.4

