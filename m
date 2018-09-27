Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5621C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39F2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1laWX4A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iIyPQum2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39F2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeI0Xhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:37:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0Xhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:37:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16BF460C65; Thu, 27 Sep 2018 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538068697;
        bh=nmCriQjxkqGqnbGJUbF3PVwO/6EuQLmkqH+k4EUdj/o=;
        h=From:To:Cc:Subject:Date:From;
        b=K1laWX4AD7vJfxKSZB7ik1o6M/xO2iXICr9Trla+VfwRkx+XUwAmtX43sxkGYAvAF
         DvQ/Pyzo0PeRA7DXHkfpSRR0x8WqMVR7PJFfXny/IgdyVJW0ogF5pUxs0b50Rqzq8c
         XoDN05YeM08/uskT1GtUlEOb5HP44l16I1Fcf5HA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26EBB60CA2;
        Thu, 27 Sep 2018 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538068696;
        bh=nmCriQjxkqGqnbGJUbF3PVwO/6EuQLmkqH+k4EUdj/o=;
        h=From:To:Cc:Subject:Date:From;
        b=iIyPQum2Qq5pkaCOksdTgtV5wn/aZ5Z7i5z3Quw/cmiQe1FHXbmcKvfMspSlHf3DE
         0N8g6FFbV15DhK9T0eFjUjkBW/7cTgJsodKAzWOaDpY34upu3IWiVe8MzmRio5ZDDt
         eq9nInW/YZWlvkJ8uJt6uyF5LnlPJFHG8KuEAHag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26EBB60CA2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     evgreen@chromium.org, marc.zyngier@arm.com
Cc:     bjorn.andersson@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, andy.gross@linaro.org, sboyd@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] drivers: irqchip: pdc: setup all edge interrupts as rising edge at GIC
Date:   Thu, 27 Sep 2018 11:18:10 -0600
Message-Id: <20180927171810.22968-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDC irqchp can convert a falling edge or level low interrupt to a
rising edge or level high interrupt at the GIC. We just need to setup
the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
as IRQ_TYPE_EDGE_RISING at the GIC.

Reported-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

