Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63A2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeIXUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:39:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbeIXUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:39:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EDE2C04AC54;
        Mon, 24 Sep 2018 14:37:22 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592305F596;
        Mon, 24 Sep 2018 14:37:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
Date:   Mon, 24 Sep 2018 16:37:19 +0200
Message-Id: <20180924143719.22191-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 24 Sep 2018 14:37:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were relying on the interrupt being shared with the ACPI SCI and the
ACPI core calling irq_set_wake. But that does not always happen on
Bay Trail devices, so we should do it ourselves.

This fixes wake from USB not working on various Bay Trail devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_int0002_vgpio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index 987a3b03f225..33c3489f5bc1 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -106,6 +106,21 @@ static void int0002_irq_mask(struct irq_data *data)
 	outl(gpe_en_reg, GPE0A_EN_PORT);
 }
 
+static int int0002_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct platform_device *pdev = to_platform_device(chip->parent);
+	int irq = platform_get_irq(pdev, 0);
+
+	/* Propagate to parent irq */
+	if (on)
+		enable_irq_wake(irq);
+	else
+		disable_irq_wake(irq);
+
+	return 0;
+}
+
 static irqreturn_t int0002_irq(int irq, void *data)
 {
 	struct gpio_chip *chip = data;
@@ -128,6 +143,7 @@ static struct irq_chip int0002_irqchip = {
 	.irq_ack		= int0002_irq_ack,
 	.irq_mask		= int0002_irq_mask,
 	.irq_unmask		= int0002_irq_unmask,
+	.irq_set_wake		= int0002_irq_set_wake,
 };
 
 static int int0002_probe(struct platform_device *pdev)
-- 
2.19.0.rc1

