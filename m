Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4DF47C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C240320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeFLJXL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:23:11 -0400
Received: from [210.13.118.86] ([210.13.118.86]:15564 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:23:10 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2018 05:23:09 EDT
Received: from localhost (10.1.170.117) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 12 Jun 2018 17:07:40
 +0800
From:   Zhizhou Zhang <zhizhouzhang@asrmicro.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <james.morse@arm.com>, <mark.rutland@arm.com>,
        <julien.thierry@arm.com>, <suzuki.poulose@arm.com>,
        <hoeun.ryu@gmail.com>, <ard.biesheuvel@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhizhouzhang@asrmicro.com>
Subject: [PATCH] arm64: make secondary_start_kernel() notrace
Date:   Tue, 12 Jun 2018 17:07:37 +0800
Message-ID: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
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

We can't call function trace hook before setup percpu offset.
When entering secondary_start_kernel(), percpu offset has not
been initialized.  So this lead hotplug malfunction.
Here is the flow to reproduce this bug:

echo 0 > /sys/devices/system/cpu/cpu1/online
echo function > /sys/kernel/debug/tracing/current_tracer
echo 1 > /sys/kernel/debug/tracing/tracing_on
echo 1 > /sys/devices/system/cpu/cpu1/online

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f3e2e3ae..11b0f30 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -179,7 +179,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void secondary_start_kernel(void)
+notrace asmlinkage void secondary_start_kernel(void)
 {
 	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	struct mm_struct *mm = &init_mm;
-- 
1.9.1

