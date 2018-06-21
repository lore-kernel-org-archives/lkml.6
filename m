Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED495C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B0020875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B0020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeFUBry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:47:54 -0400
Received: from exmail.andestech.com ([59.124.169.137]:17899 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeFUBrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:47:52 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w5L1eAoj038232
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:40:10 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1doBI038038;
        Thu, 21 Jun 2018 09:39:50 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:40:11 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>, <greentime@adnestech.com>
Subject: [PATCH] RISC-V: Add the directive for alignment of stvec's value
Date:   Thu, 21 Jun 2018 09:40:07 +0800
Message-ID: <1529545207-26999-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1doBI038038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stvec's value must be 4 byte alignment by specification definition.
This directive avoids to stvec be set the non-alignment value by the
following code in head.S

 /* Point stvec to virtual address of intruction after satp write */
la a0, 1f
add a0, a0, a1
csrw stvec, a0

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 396ec7b349ce..ae7b204f531c 100644
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
-- 
2.16.1

