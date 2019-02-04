Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ACC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832AA2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277378;
	bh=llPzUCSMVSWXMk3sjElftmg74MvyqA5Hxe3QNo9gk4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MI+ONXz+G7T6LeeQWnf5TLWbzPvfJUalybEEUvX0a3d6PropRFC+amuO/kqzgLJXq
	 t385N6101evrYZYCQyiJrl0p3ndOjQiVFHlEy4m+wVWxN2EOvcyKsINaim9hvqO7aC
	 SeyMhZ/H9Y5pePLlK3f5pxkUud58mn3kr9FjVDxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfBDKtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730942AbfBDKtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8F92070C;
        Mon,  4 Feb 2019 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277371;
        bh=llPzUCSMVSWXMk3sjElftmg74MvyqA5Hxe3QNo9gk4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRk7yJeIGOJbj226ycVFCcEqS02zkxQgNbTNlPTdqlQwiXRrWLrSUZsbhycN2q486
         2UsvHRVVotHpIIDQJFHrnFQzBdnFaYCFAp0r20ZJg80dAww4PGSsuZ75C+y0ixIkFJ
         9pRnCIH1iNsO3VyM5tU6SLewi4LR/2sIetZsFTcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 47/74] gpio: pcf857x: Fix interrupts on multiple instances
Date:   Mon,  4 Feb 2019 11:37:00 +0100
Message-Id: <20190204103625.719948375@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 2486e67374aa8b7854c2de32869642c2873b3d53 upstream.

When multiple instances of pcf857x chips are present, a fix up
message [1] is printed during the probe of the 2nd and later
instances.

The issue is that the driver is using the same irq_chip data
structure between multiple instances.

Fix this by allocating the irq_chip data structure per instance.

[1] fix up message addressed by this patch
[    1.212100] gpio gpiochip9: (pcf8575): detected irqchip that is shared with multiple gpiochips: please fix the driver.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-pcf857x.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -84,6 +84,7 @@ MODULE_DEVICE_TABLE(of, pcf857x_of_table
  */
 struct pcf857x {
 	struct gpio_chip	chip;
+	struct irq_chip		irqchip;
 	struct i2c_client	*client;
 	struct mutex		lock;		/* protect 'out' */
 	unsigned		out;		/* software latch */
@@ -252,18 +253,6 @@ static void pcf857x_irq_bus_sync_unlock(
 	mutex_unlock(&gpio->lock);
 }
 
-static struct irq_chip pcf857x_irq_chip = {
-	.name		= "pcf857x",
-	.irq_enable	= pcf857x_irq_enable,
-	.irq_disable	= pcf857x_irq_disable,
-	.irq_ack	= noop,
-	.irq_mask	= noop,
-	.irq_unmask	= noop,
-	.irq_set_wake	= pcf857x_irq_set_wake,
-	.irq_bus_lock		= pcf857x_irq_bus_lock,
-	.irq_bus_sync_unlock	= pcf857x_irq_bus_sync_unlock,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static int pcf857x_probe(struct i2c_client *client,
@@ -376,8 +365,17 @@ static int pcf857x_probe(struct i2c_clie
 
 	/* Enable irqchip if we have an interrupt */
 	if (client->irq) {
+		gpio->irqchip.name = "pcf857x",
+		gpio->irqchip.irq_enable = pcf857x_irq_enable,
+		gpio->irqchip.irq_disable = pcf857x_irq_disable,
+		gpio->irqchip.irq_ack = noop,
+		gpio->irqchip.irq_mask = noop,
+		gpio->irqchip.irq_unmask = noop,
+		gpio->irqchip.irq_set_wake = pcf857x_irq_set_wake,
+		gpio->irqchip.irq_bus_lock = pcf857x_irq_bus_lock,
+		gpio->irqchip.irq_bus_sync_unlock = pcf857x_irq_bus_sync_unlock,
 		status = gpiochip_irqchip_add_nested(&gpio->chip,
-						     &pcf857x_irq_chip,
+						     &gpio->irqchip,
 						     0, handle_level_irq,
 						     IRQ_TYPE_NONE);
 		if (status) {
@@ -392,7 +390,7 @@ static int pcf857x_probe(struct i2c_clie
 		if (status)
 			goto fail;
 
-		gpiochip_set_nested_irqchip(&gpio->chip, &pcf857x_irq_chip,
+		gpiochip_set_nested_irqchip(&gpio->chip, &gpio->irqchip,
 					    client->irq);
 		gpio->irq_parent = client->irq;
 	}


