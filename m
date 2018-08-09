Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D736321537
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GfhwIKHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D736321537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeHIKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:19:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=onVrk4Ue5U6Y5FVmhzvy5vvSCXKp2I9PpSVSMu5j6io=; b=GfhwIKHGTKT3TGQtU/EVNlX6I
        ITFaIdx41S5E9icW+jMXEDGybuA8P5klP9DJC8/B6WaM4l4tf/gGWrw8OrSgQpaB2e5fLs0GDBN4k
        XXnl5/SfGDzLXZFcoLVXEAY69iQXr4vxQvxB1TIZXXoYF8d3gEheTAshW08hypD4hOwaMM+KnvK42
        rUjtEvbfNKOydDdRPImpkpDrV6FcI5eei/nXWP0SKU6jT1PLm4pDGnFgEQuMol3aX2qs25tOYi4rh
        0i9xSRuGuqT/Kf6OCNxiUOnc8HoWZrTy2A8j028KYbEqtcvcHaUOsXbai4dkivlTDa9qeRnTQ0Int
        4m2YocIHQ==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnfnj-00085N-IZ; Thu, 09 Aug 2018 07:56:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: simplified RISC-V interrupt and clocksource handling v4
Date:   Thu,  9 Aug 2018 09:55:59 +0200
Message-Id: <20180809075602.989-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries adds support for interrupt handling and timers
for the RISC-V architecture.

The basic per-hart interrupt handling implemented by the scause
and sie CSRs is extremely simple and implemented directly in
arch/riscv/kernel/irq.c.  In addition there is a irqchip driver
for the PLIC external interrupt controller, which is called through
the set_handle_irq API, and a clocksource driver that gets its
timer interrupt directly from the low-level interrupt handling.

Compared to previous iterations this version does not try to use an
irqchip driver for the low-level interrupt handling.  This saves
a couple indirect calls and an additional read of the scause CSR
in the hot path, makes the code much simpler and last but not least
avoid the dependency on a device tree for a mandatory architectural
feature.

A git tree is available here (contains a few more patches before
the ones in this series).  The series is against the riscv for-next
tree, so using the git tree is advised

    git://git.infradead.org/users/hch/riscv.git riscv-irq-simple.4

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple.4

Changes since v3:
 - more improvements to the DT bindings
 - add back the patch adding the riscv,cpu-intc binding documentation
   as it is referenced from others

Changes since v2:
 - actually use SEIE instead of STIE in the plic driver
 - rename the default compat string for the plic to sifive,u5-plic
 - various spelling fixes
 - drop a superflous derefence in the plic driver that is taken care of
   by the following loop
 - drop the patch to document the enable method - not relevant for the
   rest of the series
 - drop the patches for the per-hart timebase frequency - not relevant
   for the rest of the series.
 - use riscv_of_processor_hart in the timer driver

Changes since v1:
 - rename the plic driver to irq-sifive-plic
 - switch to a default compatible of sifive,plic0 (still supporting the
   riscv,plic0 name for compatibility)
 - add a reference for the SiFive PLIC register layout
 - fix plic_toggle addressing for large numbers of hwirqs
 - remove the call to ack_bad_irq
 - use a raw spinlock for plic_toggle_lock
 - use the irq_desc cpumask in the plic enable/disable methods
 - add back OF contexid parsing in the plic driver
 - don't allow COMPILE_TEST builds of the clocksource driver, as it
   depends on <asm/sbi.h>
 - default the clocksource driver to y
 - clean up naming in the clocksource driver
 - remove the MINDELTA and MAXDELTA #defines
 - various DT binding fixes
