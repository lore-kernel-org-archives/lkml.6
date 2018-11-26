Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbNlZDSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKZTiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:38:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:38:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so17910912wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jfsMP20PX9AzxiepyEa67RYbHxSdA147CoEw18eFqcM=;
        b=cbNlZDSpq8IRQ7pT28gQc99KmWLJsf6QyE3TEIsiKTA3YLWt9T8j9XOM0w2wQ/NCat
         Ljn2vxsTrq7L0/Ec1UKBYgCH3LoLbnaz19rYBoX3AF1Gtou4p/3fbWqaGLg/VhIoZR5p
         wrnNs3uYO4Yu0IOIyMK1aRTJewKo5zZXGoqBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jfsMP20PX9AzxiepyEa67RYbHxSdA147CoEw18eFqcM=;
        b=H4fDTFcie51n7PBO8Wj7wfOKkit7oEt/40GaRra0A5m4a8wSIA4z6AkrnYO5JcchJD
         HnoC8xLdWLoXkN8pYJbHHTkPJL74vMalL6cVMTBH270CclHVZ3bvKkn86UdLS52yrBQt
         qXj9Z9f2DbxPi41tI0OuSuVz2urLzIKP2bV/JnoSdEBr7cFxeUXv86RE6yIzh0mJfz8/
         EqRAOZw1nqRaoYJr0RUM4Ub797jVXCO6AqV7QZqzsKGwlyc5vtWjxRhXvhDbvnDtZmea
         rzaxliP4IDq87LPYekb2GlGKX2xItLIxfvDkSz7tr0qTn7zLqeDGxUSx6HKCWLuI6bVD
         7JEQ==
X-Gm-Message-State: AA+aEWbk9gMLwUcLnhCCx6+vdecCJE2XShWAJSUFC/WxvwZNbJALfgDB
        pAGuJ1DuisGZG5x/+PXEnYP5ag==
X-Google-Smtp-Source: AFSGD/Xo2l4a7beU44svbWqIvHz0YzWPpJbFn1glzlbxbAHKNtx4FybyNc5mL02tp1cRyrr6+vQ92w==
X-Received: by 2002:adf:9382:: with SMTP id 2mr7131445wrp.269.1543221874465;
        Mon, 26 Nov 2018 00:44:34 -0800 (PST)
Received: from localhost.localdomain (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.gmail.com with ESMTPSA id a204sm98009wmh.23.2018.11.26.00.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 00:44:33 -0800 (PST)
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
Subject: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if they are not set in DT
Date:   Mon, 26 Nov 2018 09:44:21 +0100
Message-Id: <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
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

In order to fix this situation, allocate 'raw_capacity' so the pointer
is set and the init_cpu_capacity_callback() function can be called.

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

