Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF925C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxxHfwla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D43A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK1AWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:22:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeK1AWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:22:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so22653508wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NJqalrlY6zsQZc0ivwLpnohBDHC3FmMpUejAlCMT5BQ=;
        b=JxxHfwlatDv8FEstRe7FQepQ36EjICxZakkmP3nsmx/DRqID0+ZY6sSTMcV8X9eYB9
         BoDQwWqj9TY8TAshh33a+a2qfEGCoquSc2bQ4HF7yYeUEuALyr9+otItBJgfDU8a//lD
         asNfPj+7mG3cSxDg7WPJZtwDsDiq030N4b8KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NJqalrlY6zsQZc0ivwLpnohBDHC3FmMpUejAlCMT5BQ=;
        b=VOo4hPQ97RZ9y2gHk8yUR7nrHLQZzNPLexYpWhbOfh+/sTix2DxW7ygRHr7GeU/Q9t
         u1umtl4Snisvn1t++9CbaT0g6csAkDABQM4ZoO379OKfx32GAorJohQxjdIVoD63NV7k
         UvDB2z9d09+h41jlu8IIjWhvIzmafFmz+ZZvdzGOQYj7Hwe7xweyQxZcuTH3k+1JzUWQ
         VUfUBUOfwVOOGKH4dYQ/g6nwqWmz3eN8u3dAWKyLbITA5gGzBpiVt0gbLMRScuh+JVs/
         84bg68jpB8O0m3/Udhx28cYiJwN0a8PZZNICNn+XIxK9yv2oyaw2jfzXlGZOf9OPj6sD
         LVZA==
X-Gm-Message-State: AA+aEWYNyJ35/PkU+EtrTMI7Y+Un9w5US1VUcfoXSshEJUtHgGqhswXP
        qYA3ywbPHCTDwGMLgRi1GQsAdw==
X-Google-Smtp-Source: AFSGD/UoTE88iQIWwq0eRKWtSYRG/nZOzppWyfK66RbSLcnNfmzS5jEYgGi7+iG2IJpUb1CNO41iBg==
X-Received: by 2002:adf:f211:: with SMTP id p17mr27285751wro.293.1543325076651;
        Tue, 27 Nov 2018 05:24:36 -0800 (PST)
Received: from localhost.localdomain (179.156.136.77.rev.sfr.net. [77.136.156.179])
        by smtp.gmail.com with ESMTPSA id 80sm6137635wmv.6.2018.11.27.05.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 05:24:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH V5 2/2] base/drivers/arch_topology: Default dmips-mhz if they are not set in DT
Date:   Tue, 27 Nov 2018 14:24:15 +0100
Message-Id: <1543325060-1599-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
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
Tested-by: Quentin Perret <quentin.perret@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 6 ++++++
 drivers/base/arch_topology.c                           | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index fd5325b..696cea5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -243,9 +243,16 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
+	if (!raw_capacity) {
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

