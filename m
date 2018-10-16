Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089AFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE1A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfn703Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeJQBL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbeJQBL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CDD2089E;
        Tue, 16 Oct 2018 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710433;
        bh=ixrGYlTRel1oyuksAoGqCftHnfgMvlXw5Z5hqdqDy7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xfn703QwKgmddTfYwJNuLx9Ne2XiGf3IGlSGXELozVcTbI2MalY5mU7mrsPmU/+jN
         /0d8ajjiS+XckXYa/0PlEnQ4jwGRqmtyzVq19zXBrVzMEGHO9if3AvtVMPKZ6qwsBp
         TObHM6yvUZFufIrI67zicMWXnl0gEt9OiY+R8YkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 075/109] arm64: perf: Reject stand-alone CHAIN events for PMUv3
Date:   Tue, 16 Oct 2018 19:05:43 +0200
Message-Id: <20181016170528.919490719@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit ca2b497253ad01c80061a1f3ee9eb91b5d54a849 upstream.

It doesn't make sense for a perf event to be configured as a CHAIN event
in isolation, so extend the arm_pmu structure with a ->filter_match()
function to allow the backend PMU implementation to reject CHAIN events
early.

Cc: <stable@vger.kernel.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/perf_event.c |    7 +++++++
 drivers/perf/arm_pmu.c         |    8 +++++++-
 include/linux/perf/arm_pmu.h   |    1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -824,6 +824,12 @@ static int armv8pmu_set_event_filter(str
 	return 0;
 }
 
+static int armv8pmu_filter_match(struct perf_event *event)
+{
+	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
+	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
+}
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -970,6 +976,7 @@ static int armv8_pmu_init(struct arm_pmu
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	return 0;
 }
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -483,7 +483,13 @@ static int armpmu_filter_match(struct pe
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	unsigned int cpu = smp_processor_id();
-	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+	int ret;
+
+	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+	if (ret && armpmu->filter_match)
+		return armpmu->filter_match(event);
+
+	return ret;
 }
 
 static ssize_t armpmu_cpumask_show(struct device *dev,
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -110,6 +110,7 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
+	int		(*filter_match)(struct perf_event *event);
 	int		num_events;
 	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */


