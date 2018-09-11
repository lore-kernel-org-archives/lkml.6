Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E937ECDFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474DE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PbhLu9GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474DE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeILBGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52878 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILBGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696341; x=1568232341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gjnlUPagI1vf6/WNqKxc8KY88DkfwDRZzZi6iXSpG08=;
  b=PbhLu9GY0LSxENMVX+MoNgMu027Pc6PBxRTg5wFXl5rA8LmWx4i4XMwM
   DRuMO40BEusS8PxZaaEFFdCS5FzaQT5ORrnUOqoSgMwczkVbGdrzVQSCh
   pDimAvrrwoqrz0+3xGKunalbP6BLwaQSpUrDA+tCzMKKRvO7w2BL42ps3
   Ro8LNW+Jan+Hfok6qhuqm+RzjCtFd0ScEvqde51IVL7gPcF7JS36mlI4F
   q9lhkcmvYfC5Pg9KWD24Y4uYl5gD5d/ius+0VB+XOfdp33dPtKzSxzB0D
   VKw8HrxJuQNRTsGay7o1jRRIYxx6QHz+10xW01GkgI5qzKSnKEh49647d
   w==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728820"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:14 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 01/12] RISC-V: No need to pass scause as arg to do_IRQ()
Date:   Tue, 11 Sep 2018 13:05:28 -0700
Message-Id: <1536696339-15204-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
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

