Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B25C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956E21527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956E21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbeHBRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:15:18 -0400
Received: from exmail.andestech.com ([59.124.169.137]:10638 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbeHBRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:15:18 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w72FMdPG088910;
        Thu, 2 Aug 2018 23:22:39 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 2 Aug 2018
 23:23:03 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC:     Zong Li <zong@andestech.com>
Subject: [PATCH] RISC-V: Add preprocessor directives for boot_sec_cpu
Date:   Thu, 2 Aug 2018 23:22:56 +0800
Message-ID: <1533223376-10130-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w72FMdPG088910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot_sec_cpu is for hutplug CPU on SMP system. It should
be conditional compiling. Otherwise, it causes undefined reference
to `smp_callin' when compiling uniprocessor kernel.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 11066d5..9b6f601 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -154,6 +154,7 @@ END(_start)
 .section .text
 .global boot_sec_cpu
 
+#ifdef CONFIG_HOTPLUG_CPU
 boot_sec_cpu:
 	/* clear all pending flags */
 	csrw sip, zero
@@ -162,6 +163,7 @@ boot_sec_cpu:
 	fence
 
 	tail smp_callin
+#endif
 
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
-- 
2.7.4

