Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0082077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0082077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeHWMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:16:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeHWMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:16:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E7BF941;
        Thu, 23 Aug 2018 08:48:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 090/324] irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug
Date:   Thu, 23 Aug 2018 09:52:36 +0200
Message-Id: <20180823075000.359758172@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 82f499c8811149069ec958b72a86643a7a289b25 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3405,6 +3405,16 @@ static int redist_disable_lpis(void)
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


