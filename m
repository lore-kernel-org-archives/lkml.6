Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58638C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE5020881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jKIV9AYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE5020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIMXrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:47:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26981 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeIMXrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536863827; x=1568399827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gjnlUPagI1vf6/WNqKxc8KY88DkfwDRZzZi6iXSpG08=;
  b=jKIV9AYrrMwltgj04CwUEHQEcTXuDs+jXONmXZI1ERePmd7FX87WQft3
   Ufw61deTJBnx5zwk4alHmtccfSbRZvrGGrLX771qqpYqDZS55g7bYYw50
   IgTP9il6OEwnqusgY1aQoj5U/Nz+DlDN7TQN24/8dz00hnMi1gsrqqRy+
   hpW27eMlL2jS0us72NlrK7QQWVnJIP1NhqatnX56J86loc6nZs7FuU4iw
   nuB8Ams86Z4gasNNQfmeUNfnsJYroKzhg67DjFix+RvQ+mZlShE2Yn8xD
   /9OnX4RMoF+4sgN5Qcv3cyCc0avuI/lbRkAm/MPX5FK59IruOAbdxKOK1
   A==;
X-IronPort-AV: E=Sophos;i="5.53,370,1531756800"; 
   d="scan'208";a="89712007"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2018 02:37:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 Sep 2018 11:23:37 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2018 11:37:06 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org, schwab@linux-m68k.org
Subject: [PATCH v5 01/12] RISC-V: No need to pass scause as arg to do_IRQ()
Date:   Thu, 13 Sep 2018 11:36:54 -0700
Message-Id: <1536863825-66808-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
References: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

The scause is already part of pt_regs so no need to pass
scause as separate arg to do_IRQ().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/entry.S | 1 -
 arch/riscv/kernel/irq.c   | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index fa2c08e3..6eaacfa5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -168,7 +168,6 @@ ENTRY(handle_exception)
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	move a1, s4 /* scause */
 	tail do_IRQ
 1:
 	/* Exceptions run with interrupts enabled */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 0cfac48a..ca459331 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -24,12 +24,12 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
-asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
+asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irq_enter();
-	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
+	switch (regs->scause & ~INTERRUPT_CAUSE_FLAG) {
 	case INTERRUPT_CAUSE_TIMER:
 		riscv_timer_interrupt();
 		break;
-- 
2.7.4

