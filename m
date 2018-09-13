Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2621C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5903A20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5903A20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeIMStD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:49:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbeIMStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:49:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B502BCF3;
        Thu, 13 Sep 2018 13:39:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 34/78] irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP
Date:   Thu, 13 Sep 2018 15:31:21 +0200
Message-Id: <20180913131809.530519368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 0702bc4d2fe793018ad9aa0eb14bff7f526c4095 ]

When compiling bmips with SMP disabled, the build fails with:

drivers/irqchip/irq-bcm7038-l1.o: In function `bcm7038_l1_cpu_offline':
drivers/irqchip/irq-bcm7038-l1.c:242: undefined reference to `irq_set_affinity_locked'
make[5]: *** [vmlinux] Error 1

Fix this by adding and setting bcm7038_l1_cpu_offline only when actually
compiling for SMP. It wouldn't have been used anyway, as it requires
CPU_HOTPLUG, which in turn requires SMP.

Fixes: 34c535793bcb ("irqchip/bcm7038-l1: Implement irq_cpu_offline() callback")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-bcm7038-l1.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -215,6 +215,7 @@ static int bcm7038_l1_set_affinity(struc
 	return 0;
 }
 
+#ifdef CONFIG_SMP
 static void bcm7038_l1_cpu_offline(struct irq_data *d)
 {
 	struct cpumask *mask = irq_data_get_affinity_mask(d);
@@ -239,6 +240,7 @@ static void bcm7038_l1_cpu_offline(struc
 	}
 	irq_set_affinity_locked(d, &new_affinity, false);
 }
+#endif
 
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
@@ -291,7 +293,9 @@ static struct irq_chip bcm7038_l1_irq_ch
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+#ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
+#endif
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,


