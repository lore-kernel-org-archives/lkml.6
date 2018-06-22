Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E70C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E2D241D6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E2D241D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeFVM2V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:28:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeFVM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:28:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCS5Ej066834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:28:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCS4sF066831;
        Fri, 22 Jun 2018 05:28:04 -0700
Date:   Fri, 22 Jun 2018 05:28:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-82f499c8811149069ec958b72a86643a7a289b25@git.kernel.org>
Cc:     jason@lakedaemon.net, mingo@kernel.org, yangyingliang@huawei.com,
        linux-kernel@vger.kernel.org, sumit.garg@linaro.org, hpa@zytor.com,
        alexandre.belloni@bootlin.com, marc.zyngier@arm.com,
        tglx@linutronix.de
Reply-To: alexandre.belloni@bootlin.com, marc.zyngier@arm.com,
          tglx@linutronix.de, sumit.garg@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          jason@lakedaemon.net, yangyingliang@huawei.com
In-Reply-To: <20180622095254.5906-8-marc.zyngier@arm.com>
References: <20180622095254.5906-8-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Fix reprogramming of
 redistributors on CPU hotplug
Git-Commit-ID: 82f499c8811149069ec958b72a86643a7a289b25
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

Commit-ID:  82f499c8811149069ec958b72a86643a7a289b25
Gitweb:     https://git.kernel.org/tip/82f499c8811149069ec958b72a86643a7a289b25
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:54 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:02 +0200

irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug

Enabling LPIs was made a lot stricter recently, by checking that they are
disabled before enabling them. By doing so, the CPU hotplug case was missed
altogether, which leaves LPIs enabled on hotplug off (expecting the CPU to
eventually come back), and won't write a different value anyway on hotplug
on.

So skip that check if that particular case is detected

Fixes: 6eb486b66a30 ("irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lkml.kernel.org/r/20180622095254.5906-8-marc.zyngier@arm.com

---
 drivers/irqchip/irq-gic-v3-its.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0269ffb93f6e..d7842d312d3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3427,6 +3427,16 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world. Detect this case
+	 * by checking the allocation of the pending table for the
+	 * current CPU.
+	 */
+	if (gic_data_rdist()->pend_page)
+		return 0;
+
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
