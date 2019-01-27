Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0EAC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AF7214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="TZKtfR0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA0Pxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:53:39 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25412 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfA0Pxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:53:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548604342; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=a1ChEj4cC4n0KVcBzGVjQI7P3f2L/3IeohYjWIqONJ11pqxTrPPPbCAqO9+0UKW29byopb+G/pM6aIJ6K6jp4PyIxLiaN5hKOOfStX8bRXIbt41RG/FrDEwGE7qZ82c6Dfha5zy+r4IAb0bpRWgoHG8EFB+4R0txvUfB8HgmCiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548604342; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=7HzIeaQSUx5xlWAQFwdRtQNLI5/1C3CnMswaPfoyJVs=; 
        b=W9RnTAtkcJuuA6Qd/q3WV2GjhDUKlzjlqDzG1oCsuuU5mNyKRHaPGfZaax7/Wq8yqRV1VUnILURyvzEABP9b1DqA0PBWmAupAxglMxD86B7DFf0IIsrN0u3QwnQA1mL2T72QTyE769JD1E1ZhBZnd/fnp+equGj7NlibA8PKmZk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=j1Fx6FVWJ6FOFyGO6rfCqdq8jWwYnbNIl3vet8/QxIR5i4b7vKI/Ge+9YQEuVhQ/ZywdE5yBFApv
    p3njBRyAayU24uXIo204H2fR6kikZdHkp7Sw4XwvXKbajgav0wXv  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548604342;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1406; bh=7HzIeaQSUx5xlWAQFwdRtQNLI5/1C3CnMswaPfoyJVs=;
        b=TZKtfR0e5kFrO0a+OYNg1Yc94OX/rAJrMzEacRz6MUTCBFLDu9peuoH3Mp03BZF1
        1ez+zZCCrpDqYFSizGBT6PrQ4rfzLYL6TVzdpdPPYZfF+JQ489ADe3qtKStiltthRJl
        AndaaNLPNJ4pUHKTM/md+duiKJ06wriIupqFgwS8=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548604340770526.6169555892552; Sun, 27 Jan 2019 07:52:20 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH v2 2/4] Irqchip: Ingenic: Unify the function name prefix to "ingenic_intc_".
Date:   Sun, 27 Jan 2019 23:50:30 +0800
Message-Id: <1548604232-19159-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
 <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of uniform style, function "intc_irq_set_mask" is
changed to "ingenic_intc_intc_irq_set_mask".

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/irqchip/irq-ingenic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 5f775a1..32d090a 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -63,7 +63,8 @@ static void ingenic_chained_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
+static void ingenic_intc_irq_set_mask(struct irq_chip_generic *gc,
+						uint32_t mask)
 {
 	struct irq_chip_regs *regs = &gc->chip_types->regs;
 
@@ -74,13 +75,13 @@ static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
 void ingenic_intc_irq_suspend(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->wake_active);
+	ingenic_intc_irq_set_mask(gc, gc->wake_active);
 }
 
 void ingenic_intc_irq_resume(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->mask_cache);
+	ingenic_intc_irq_set_mask(gc, gc->mask_cache);
 }
 
 static int __init ingenic_intc_of_init(struct device_node *node,
-- 
2.7.4


