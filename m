Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3737FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBAE2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBAE2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeH1Tor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:47 -0400
Received: from foss.arm.com ([217.140.101.70]:41108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EA5ED1;
        Tue, 28 Aug 2018 08:52:30 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C34E3F557;
        Tue, 28 Aug 2018 08:52:28 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 18/27] irqchip/gic-v3: Do not overwrite PMR value
Date:   Tue, 28 Aug 2018 16:51:28 +0100
Message-Id: <1535471497-38854-19-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the architecture is using ICC_PMR_EL1 to mask IRQs, do not overwrite
that value.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fef6688..162c49c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -407,6 +407,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();

 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -422,6 +425,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();

+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }

@@ -583,7 +588,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();

 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!gic_prio_masking_enabled())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);

 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
--
1.9.1
