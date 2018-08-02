Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317AF21526
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317AF21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeHBROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:14:53 -0400
Received: from exmail.andestech.com ([59.124.169.137]:56942 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbeHBROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:14:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w72FLmx4088843;
        Thu, 2 Aug 2018 23:21:48 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 2 Aug 2018
 23:22:14 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC:     Zong Li <zong@andestech.com>
Subject: [PATCH v2] RISC-V: Add the directive for alignment of stvec's value
Date:   Thu, 2 Aug 2018 23:21:56 +0800
Message-ID: <1533223316-9942-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w72FLmx4088843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stvec's value must be 4 byte alignment by specification definition.
These directives avoid to stvec be set the non-alignment value.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3b6293f..11066d5 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -94,6 +94,7 @@ relocate:
 	or a0, a0, a1
 	sfence.vma
 	csrw sptbr, a0
+.align 2
 1:
 	/* Set trap vector to spin forever to help debug */
 	la a0, .Lsecondary_park
@@ -143,6 +144,7 @@ relocate:
 	tail smp_callin
 #endif
 
+.align 2
 .Lsecondary_park:
 	/* We lack SMP support or have too many harts, so park this hart */
 	wfi
-- 
2.7.4

