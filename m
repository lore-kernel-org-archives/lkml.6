Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8236C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9739B241C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739B241C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFVM0R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:26:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeFVM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:26:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCQ2MR066526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:26:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCQ2Xv066523;
        Fri, 22 Jun 2018 05:26:02 -0700
Date:   Fri, 22 Jun 2018 05:26:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-cbaf45a6be497c272e80500e4fd9bccdf20d5050@git.kernel.org>
Cc:     yangyingliang@huawei.com, alexandre.belloni@bootlin.com,
        sumit.garg@linaro.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jason@lakedaemon.net, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          jason@lakedaemon.net, marc.zyngier@arm.com,
          yangyingliang@huawei.com, tglx@linutronix.de, mingo@kernel.org,
          sumit.garg@linaro.org, alexandre.belloni@bootlin.com
In-Reply-To: <20180622095254.5906-4-marc.zyngier@arm.com>
References: <20180622095254.5906-4-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v2m: Fix SPI release on error path
Git-Commit-ID: cbaf45a6be497c272e80500e4fd9bccdf20d5050
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cbaf45a6be497c272e80500e4fd9bccdf20d5050
Gitweb:     https://git.kernel.org/tip/cbaf45a6be497c272e80500e4fd9bccdf20d5050
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:50 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:00 +0200

irqchip/gic-v2m: Fix SPI release on error path

On failing to allocate the required SPIs, the actual number of interrupts
should be freed and not its log2 value.

Fixes: de337ee30142 ("irqchip/gic-v2m: Add PCI Multi-MSI support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20180622095254.5906-4-marc.zyngier@arm.com

---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 0f52d44b3f69..f5fe0100f9ff 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -199,7 +199,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 fail:
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	gicv2m_unalloc_msi(v2m, hwirq, get_count_order(nr_irqs));
+	gicv2m_unalloc_msi(v2m, hwirq, nr_irqs);
 	return err;
 }
 
