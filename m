Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF14C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55CF204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55CF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeIMTGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeIMTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8470D10;
        Thu, 13 Sep 2018 13:56:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 091/197] irqchip/stm32: Fix init error handling
Date:   Thu, 13 Sep 2018 15:30:40 +0200
Message-Id: <20180913131845.174348825@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4096165d55218a6f58b6c2ebc5d2428aa0aa70e4 ]

If there are any errors in stm32_exti_host_init() then it leads to a
NULL dereference in the callers.  The function should clean up after
itself.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Reviewed-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-stm32-exti.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -602,17 +602,24 @@ stm32_exti_host_data *stm32_exti_host_in
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
 	if (!host_data->chips_data)
-		return NULL;
+		goto free_host_data;
 
 	host_data->base = of_iomap(node, 0);
 	if (!host_data->base) {
 		pr_err("%pOF: Unable to map registers\n", node);
-		return NULL;
+		goto free_chips_data;
 	}
 
 	stm32_host_data = host_data;
 
 	return host_data;
+
+free_chips_data:
+	kfree(host_data->chips_data);
+free_host_data:
+	kfree(host_data);
+
+	return NULL;
 }
 
 static struct
@@ -664,10 +671,8 @@ static int __init stm32_exti_init(const
 	struct irq_domain *domain;
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
@@ -724,7 +729,6 @@ out_free_domain:
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
@@ -751,10 +755,8 @@ __init stm32_exti_hierarchy_init(const s
 	}
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, node);
@@ -776,7 +778,6 @@ __init stm32_exti_hierarchy_init(const s
 
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;


