Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rBkjDtpHGVssQAAAmS7hNA
	; Thu, 07 Jun 2018 15:06:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC8C9608B8; Thu,  7 Jun 2018 15:06:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 830596063F;
	Thu,  7 Jun 2018 15:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 830596063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935807AbeFGPGf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:06:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41558 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935962AbeFGPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:04:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbT-0005Zk-LJ; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Bh-LT; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Justin Chen" <justinpopo6@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, "James Hogan" <jhogan@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.568346237@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 325/410] MIPS: BMIPS: Do not mask IPIs during suspend
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justinpopo6@gmail.com>

commit 06a3f0c9f2725f5d7c63c4203839373c9bd00c28 upstream.

Commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on CPU IRQs") fixes an
issue where disable_irq did not actually disable the irq. The bug caused
our IPIs to not be disabled, which actually is the correct behavior.

With the addition of commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on
CPU IRQs"), the IPIs were getting disabled going into suspend, thus
schedule_ipi() was not being called. This caused deadlocks where
schedulable task were not being scheduled and other cpus were waiting
for them to do something.

Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called on the
IPIs during suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17385/
[jhogan@kernel.org: checkpatch: wrap long lines and fix commit refs]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/smp-bmips.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -159,11 +159,11 @@ static void bmips_prepare_cpus(unsigned
 		return;
 	}
 
-	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi0", NULL))
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
-	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi1", NULL))
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi1", NULL))
 		panic("Can't request IPI1 interrupt");
 }
 
