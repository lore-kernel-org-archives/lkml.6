Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8898C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6543420664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d27OAhIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6543420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeKZXPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:15:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37710 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZXPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:15:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4739549wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 04:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abLiOL6He8MFbX9WjSZ+2m54aIn+aGbFhoF9OKEmlgQ=;
        b=d27OAhIkqIEYMn86QK8N/esaK8HPkoaRPnvQg3JdQZbvf5DmQuURNIZ8C5uRCvetg6
         kyLjk8VHlkJ2PeY9g7GK7hS4QtjUDztrB6G//kVy2DdabFkM44ayF4IPZDp59/FbNYzw
         Woxpw6tOqJ6haxa8j7wYZ+Z8QI6dyYTCTJIqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abLiOL6He8MFbX9WjSZ+2m54aIn+aGbFhoF9OKEmlgQ=;
        b=PGDu6Jq3IQEBuBKie4ereBLz4QQcCuFmsO1rO9ukkM66Nt492so+FJxwU/unvslrss
         qjVJirjLZ5s4Vg1sc8P3nPh2cPZQsopdDxRFz2bKoqGioAM1niomtbranjxzjHt3H2v8
         JXB5z/z9oYL3Zn0Lnps0aTJuZ4PlQIDPxbKWUaZV6RS9sO+IILnegj3FAz9kMvKW6Ioe
         6N+Ok+/b3vuX2D8a4vV2/k0czPnEBDpIMjXBQg9tGLrxDVboVrRb7s40tfh1CKcSnx63
         F/97C8iFTrE8vMo2R0F4bMUrYS8oNn9XgffmaE3CUnZ52nar4bYzH1INRPmekAweFO2Y
         ggxw==
X-Gm-Message-State: AGRZ1gJ1FyEPtRrXOuu0Y80oCtRXVkBuS5IflcYIWRAScZNUD03NQA39
        xFcZSbbZN+K1I/bzFcDl8ncuDQ==
X-Google-Smtp-Source: AJdET5cgFi+rVaXzl0GWGveOUgDV78kGEugxzQ1EQbhT6fgUjJkn50l1nZkygsqhSCwQH50vceh8Tw==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr23003771wmf.111.1543234872086;
        Mon, 26 Nov 2018 04:21:12 -0800 (PST)
Received: from localhost.localdomain (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.gmail.com with ESMTPSA id r76-v6sm797816wmb.21.2018.11.26.04.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 04:21:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if they are not set in DT
Date:   Mon, 26 Nov 2018 13:20:43 +0100
Message-Id: <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
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
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt |  6 ++++++
 drivers/base/arch_topology.c                           | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 84262cd..f53a3c9 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
 available, final capacities are calculated by directly using capacity-dmips-
 mhz values (normalized w.r.t. the highest value found while parsing the DT).
 
+If capacity-dmips-mhz is not specified or if the parsing fails, the
+default capacity value will be computed against the highest frequency.
+When all CPUs have the same OPP, they will have the same capacity
+value otherwise the capacity will be scaled down for CPUs having lower
+frequencies.
+
 ===========================================
 4 - Examples
 ===========================================
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

