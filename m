Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C82C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A120664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="du4esRFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793A120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeJ3BNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:13:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeJ3BNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:13:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so9385199wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EHn6ZSQVTOKaLg/bsltnbcaMuQIuilo+eLx553lzoE4=;
        b=du4esRFMfsG/CHN+tAw+Upgcaeh4mGCj+P/HX/DLpbrWe1SWcZNq92SMA+NmWYcrjf
         dDuFTN/RB/KhTo6vZnSgXxtTQ9eeE/oMZxaXmsBqUAZMbtUJn57+/WFt97KEypsQu2he
         npIR3XBuoZfKUpCzVXusp+Yt//RuxWOchtKak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EHn6ZSQVTOKaLg/bsltnbcaMuQIuilo+eLx553lzoE4=;
        b=UGtefS/DIPOYgWTXg5jHml45778JNLv9m7AFIVtGevhFkPdItAehWejZqb2/oCqY5F
         /S0WcTgd+tYPGvtgceTHjH/iTycfFij1+UYxwzw3w9N8BSIfpINMvZ/9hTKcdHnuDBYF
         10DUoEirvNS/duzI9HLJNyrUF3k0FcdgmDqsPiGj043hvuts5RUiqhEyzYWPCLvsvYOi
         NSJ91Z6FQMDhw1ilyMTnNRlWV/C+e5++ZovHbq3k+mpIjwOigbRhAEQGf/TLneCLtOmW
         M+4YRbg6TubvdKMM+2uW0aelvq0DHVR3hZi6ll7ftXRs6D82fT6m9jb+GtjvTtFBbVzY
         YEAg==
X-Gm-Message-State: AGRZ1gKzLFBxAHJ6nErbrPBfeWAALkZtVxK3XhxA30LISsY26F8j/Sy2
        EN4X4ewEhz+kPNUvQNEPFWhM4g==
X-Google-Smtp-Source: AJdET5fhYVzPTXeR9x+u8Hvo2YtAMOz69DTGFAfsIEn5jRYgjckq4PBQSsB0sEGj/JMgiqm/wUb8PA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr14542750wrx.114.1540830238967;
        Mon, 29 Oct 2018 09:23:58 -0700 (PDT)
Received: from localhost.localdomain (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.gmail.com with ESMTPSA id y19-v6sm28150499wra.60.2018.10.29.09.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 09:23:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are not set in DT
Date:   Mon, 29 Oct 2018 17:23:20 +0100
Message-Id: <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of assymetric SoC with the same micro-architecture, we
have a group of CPUs with smaller OPPs than the other group. One
example is the 96boards dragonboard 820c. There is no dmips/MHz
difference between both groups, so no need to specify the values in
the DT. Unfortunately, without these defined, there is no scaling
capacity comutation triggered, so we need to write
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
 drivers/base/arch_topology.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 7311641..7d594a6 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -205,6 +205,21 @@ static struct notifier_block init_cpu_capacity_notifier = {
 	.notifier_call = init_cpu_capacity_callback,
 };
 
+static int topology_set_default_capacity(void)
+{
+	int cpu;
+
+	raw_capacity = kzalloc(num_possible_cpus() * sizeof(*raw_capacity),
+			       GFP_KERNEL);
+	if (!raw_capacity)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu)
+		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;
+
+	return 0;
+}
+
 static int __init register_cpufreq_notifier(void)
 {
 	int ret;
@@ -214,9 +229,19 @@ static int __init register_cpufreq_notifier(void)
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
+		ret = topology_set_default_capacity();
+		if (ret)
+			return ret;
+	}
+
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
 		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
 		return -ENOMEM;
-- 
2.7.4

