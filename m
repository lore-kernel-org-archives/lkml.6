Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CCC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C3B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C3B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeIMIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:09:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeIMIJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:09:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C409AD2B9EC08;
        Thu, 13 Sep 2018 11:02:01 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 13 Sep 2018 11:02:00 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>
CC:     <mingo@redhat.com>, <hpa@zytor.com>, <bp@alien8.de>,
        <luto@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: common: fix unused variable warning
Date:   Thu, 13 Sep 2018 10:49:45 +0800
Message-ID: <1536806985-24197-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

rch/x86/kernel/cpu/common.c: In function 'syscall_init':
arch/x86/kernel/cpu/common.c:1534:6: warning: unused variable 'cpu' [-Wunused-variable]
  int cpu = smp_processor_id();

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/kernel/cpu/common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0e3e803..0b283e5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1531,8 +1531,6 @@ static __init int setup_clearcpuid(char *arg)
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
-	int cpu = smp_processor_id();
-
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
@@ -1545,7 +1543,8 @@ void syscall_init(void)
 	 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
 	 */
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1));
+	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
+		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
 	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
-- 
1.7.12.4

