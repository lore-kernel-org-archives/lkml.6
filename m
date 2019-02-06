Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB2BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D51217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfBFKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:49:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbfBFKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:49:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5321650;
        Wed,  6 Feb 2019 02:49:03 -0800 (PST)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.30.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317A43F719;
        Wed,  6 Feb 2019 02:49:00 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
Date:   Wed,  6 Feb 2019 10:48:46 +0000
Message-Id: <20190206104848.12580-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206104848.12580-1-marc.zyngier@arm.com>
References: <20190206104848.12580-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely event that we cannot find any available LPI in the
system, we should gracefully return an error instead of carrying
on with no LPI allocated at all.

Fixes: 38dd7c494cf6 ("irqchip/gic-v3-its: Drop chunk allocation compatibility")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f25ec92f23ee..c3aba3fc818d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1586,6 +1586,9 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 		nr_irqs /= 2;
 	} while (nr_irqs > 0);
 
+	if (!nr_irqs)
+		err = -ENOSPC;
+
 	if (err)
 		goto out;
 
-- 
2.20.1

