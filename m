Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD03C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7794214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lb3cCcSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7794214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeHPCuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22885 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHPCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377379; x=1565913379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=i1vnyqmho6i8If9KEHE9BxefvqbQcJrPI+HNnleoCt4=;
  b=lb3cCcSlV8WHfLgRBm0h6SnXjj5b3T/J9SOu7FyGftZ++MvFkawTExCV
   VPErAxbYqwEijWXIps5oOk0Vf/Z2c7ydbT4k43zpilgxvwAHT6sAHzZ5i
   QJjZqegxYy7g3VoNiIgB9G7cpxuzj7grXlN+r1iWEPvjcCkIs8EJMzEwF
   qso3ckvwHEOPp4HK+yLWVXrFfvXX68Lull0erhwsvTjxtebMg98gSA3IG
   MdD+aqG0LcrEqiehA9vSrDNs8ApCiOSqXK43KuNqyKHmS6qqT4lQJH2O4
   OxILmM+UAekJi+Icr0sC6fxDeuXbP1HC1PzKt/QFHNsc96xr9AQMM4JU6
   w==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="89176689"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:17 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:19 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 4/5] RISC-V: Move interrupt cause declarations to irq.h
Date:   Wed, 15 Aug 2018 16:56:16 -0700
Message-Id: <1534377377-70108-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU hotplug code in smpboot requires interrupt cause
to identify the cause of cpu wakeup.

Move the IRQ cause declarations to appropriate header
file.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/irq.h | 7 +++++++
 arch/riscv/kernel/irq.c      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 996b6fbe..abf2e4e3 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -20,6 +20,13 @@
 void riscv_timer_interrupt(void);
 void riscv_software_interrupt(void);
 
+/*
+ * Possible interrupt causes:
+ */
+#define INTERRUPT_CAUSE_SOFTWARE    1
+#define INTERRUPT_CAUSE_TIMER       5
+#define INTERRUPT_CAUSE_EXTERNAL    9
+
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 0cfac48a..0dd2df01 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,13 +10,6 @@
 #include <linux/irqdomain.h>
 
 /*
- * Possible interrupt causes:
- */
-#define INTERRUPT_CAUSE_SOFTWARE    1
-#define INTERRUPT_CAUSE_TIMER       5
-#define INTERRUPT_CAUSE_EXTERNAL    9
-
-/*
  * The high order bit of the trap cause register is always set for
  * interrupts, which allows us to differentiate them from exceptions
  * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
-- 
2.7.4

