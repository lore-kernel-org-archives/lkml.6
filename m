Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D5CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AE32064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AE32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIENFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:05:24 -0400
Received: from asrmicro.com ([210.13.118.86]:62926 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeIENFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:05:23 -0400
X-Greylist: delayed 931 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 09:05:22 EDT
Received: from localhost (10.1.170.117) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 5 Sep 2018 16:20:10
 +0800
From:   Zhizhou Zhang <zhizhouzhang@asrmicro.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <dave.martin@arm.com>, <zhizhouzhang@asrmicro.com>,
        <suzuki.poulose@arm.com>, <sudeep.holla@arm.com>,
        <adobriyan@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: don't account for cpu offline time with irqsoff tracer
Date:   Wed, 5 Sep 2018 16:19:43 +0800
Message-ID: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.117]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no need to account for cpu offline time with irqsoff tracer.
We can trigger a large irqsoff latency with below commands:

$ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
$ echo 0 > /sys/kernel/debug/tracing/options/function-trace
$ echo 1 > /sys/kernel/debug/tracing/tracing_on
$ echo 0 > /sys/devices/system/cpu/cpu1/online
$ # wait a while ...
$ echo 1 > /sys/devices/system/cpu/cpu1/online
$ cat /sys/kernel/debug/tracing/trace

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 25fcd22..faed8f6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -346,6 +346,7 @@ void cpu_die(void)
 	idle_task_exit();
 
 	local_daif_mask();
+	stop_critical_timings();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
 	(void)cpu_report_death();
-- 
1.9.1

