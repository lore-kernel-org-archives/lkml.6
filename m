Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40919ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ACB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="axcijbLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ACB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeKAIHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbeKAIHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A9C2064C;
        Wed, 31 Oct 2018 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027244;
        bh=DrvpFuZ8C1WZGOUneKjTLBox+gqu0umAjhbt2Uiu8rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axcijbLwRTMK82T4gkPzywm1Vm1gkcSCWKNLk8pQ4MaGtwHypPqAsSFGzNH1pedv8
         DdTPfUYI9ucu5sFzf2taJ4CpTJlh6t2+C4G9uGvlXiqcNY9pClXxkVpPJrpxXKCQjc
         0t1ErGqUEVJX9F8V0ugvZTi40hj/tcRxJNoI48rE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 113/146] irqchip/pdc: Setup all edge interrupts as rising edge at GIC
Date:   Wed, 31 Oct 2018 19:05:08 -0400
Message-Id: <20181031230541.28822-113-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

[ Upstream commit 7bae48b22c8d38c5cd50f52b6e15d134e2bb3935 ]

The PDC irqchp can convert a falling edge or level low interrupt to a
rising edge or level high interrupt at the GIC. We just need to setup
the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
as IRQ_TYPE_EDGE_RISING at the GIC.

Fixes: f55c73aef890 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")
Reported-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index b1b47a40a278..faa7d61b9d6c 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -124,6 +124,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		pdc_type = PDC_EDGE_DUAL;
+		type = IRQ_TYPE_EDGE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		pdc_type = PDC_LEVEL_HIGH;
-- 
2.17.1

