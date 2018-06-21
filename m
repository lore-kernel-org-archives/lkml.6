Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A644820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeFUBs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:48:29 -0400
Received: from exmail.andestech.com ([59.124.169.137]:56675 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbeFUBsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:48:08 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w5L1futG038390
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:41:56 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1flkD038369;
        Thu, 21 Jun 2018 09:41:47 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:42:07 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>, <greentime@adnestech.com>
Subject: [PATCH] RISC-V: Add conditional marco for boot_sec_cpu
Date:   Thu, 21 Jun 2018 09:41:42 +0800
Message-ID: <1529545326-29272-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529506497.git.zong@andestech.com>
References: <cover.1529506497.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1flkD038369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link error when disable support SMP.
It causes the undefined reference to `smp_callin'.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3b6293f10e3e..396ec7b349ce 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -152,6 +152,7 @@ END(_start)
 .section .text
 .global boot_sec_cpu
 
+#ifdef CONFIG_HOTPLUG_CPU
 boot_sec_cpu:
 	/* clear all pending flags */
 	csrw sip, zero
@@ -160,6 +161,7 @@ boot_sec_cpu:
 	fence
 
 	tail smp_callin
+#endif
 
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
-- 
2.16.1

