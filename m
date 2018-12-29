Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F06C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353BA20855
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ekX1oiMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeL2OO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 09:14:59 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58048 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeL2OO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 09:14:59 -0500
Received: from zyt.lan (unknown [37.17.239.109])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C49295C0471;
        Sat, 29 Dec 2018 15:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546092897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=1MUz9x2LpbVOrd430j/KtspEUhUTKidFBEQv87V8yXM=;
        b=ekX1oiMkwSbfqWJS/Oh1Uworw8MC8aJP8HIxz5SykZBBF8kvCpZ/7NaFmSe9tq4GlBVYgM
        gYL81PoqIbp8yoJ1zadGmRf6hRdgKo+1OE9Qrp3wVUyByTrLxtLROBIxhdrvi1k6D9N1sC
        wiVlIxbXsSSUdq6fcZrSQDNPjf3nXKQ=
From:   Stefan Agner <stefan@agner.ch>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org,
        linux-arm-kernel-bounces@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] irqchip/gic-v3: use __init where appropriate
Date:   Sat, 29 Dec 2018 15:14:58 +0100
Message-Id: <478402dd50e3237b14f4d0b41cd945de92de1756.1546092851.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with section mismatch debugging enabled prints the
following warning:
  WARNING: vmlinux.o(.text+0xffa1b8): Section mismatch in reference from
  the function gic_smp_init() to the function .init.text:set_smp_cross_call()

Avoid this warning by adding __init to gic_smp_init(). While add it,
also add it where appropriate.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0868a9d81c3c..3b33c94041e5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -768,7 +768,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	isb();
 }
 
-static void gic_smp_init(void)
+static void __init gic_smp_init(void)
 {
 	set_smp_cross_call(gic_raise_softirq);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
@@ -848,7 +848,7 @@ static struct notifier_block gic_cpu_pm_notifier_block = {
 	.notifier_call = gic_cpu_pm_notifier,
 };
 
-static void gic_cpu_pm_init(void)
+static void __init gic_cpu_pm_init(void)
 {
 	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
 }
-- 
2.20.1

