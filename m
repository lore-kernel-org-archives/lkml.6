Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIzbAVaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbeKTDQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbeKTDQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B5421104;
        Mon, 19 Nov 2018 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646326;
        bh=yENuWU7l34XokPTkoWu3Epd4w5mXTBRiBofPacUqWQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIzbAVaK+DF8HD8xJUMbaU+7L4EZcpyJ8ZnOgAhgW72H/TApjmnmntNSDKv4kaJBv
         dFk6UfAUF684ZEuHsMweidsRib6kL8qP7EWR96Csn0EVMehkX/uGvt5DtY0/TIdf35
         dUr1en/K6HKWGm2rngV2kQEp07lfkZmn+AECVhic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 124/124] gpio: brcmstb: release the bgpio lock during irq handlers
Date:   Mon, 19 Nov 2018 17:29:38 +0100
Message-Id: <20181119162634.317442434@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 142c168e0e50164e67c9399c28dedd65a307cfe5 upstream.

The basic memory-mapped GPIO controller lock must be released
before calling the registered GPIO interrupt handlers to allow
the interrupt handlers to access the hardware.

Examples of why a GPIO interrupt handler might want to access
the GPIO hardware include an interrupt that is configured to
trigger on rising and falling edges that needs to read the
current level of the input to know how to respond, or an
interrupt that causes a change in a GPIO output in the same
bank. If the lock is not released before enterring the handler
the hardware accesses will deadlock when they attempt to grab
the lock.

Since the lock is only needed to protect the calculation of
unmasked pending interrupts create a dedicated function to
perform this and hide the complexity.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-brcmstb.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -63,6 +63,21 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip
 	return bank->parent_priv;
 }
 
+static unsigned long
+brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
+{
+	void __iomem *reg_base = bank->parent_priv->reg_base;
+	unsigned long status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
+	status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
+		 bank->gc.read_reg(reg_base + GIO_MASK(bank->id));
+	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
+
+	return status;
+}
+
 static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
 		unsigned int offset, bool enable)
 {
@@ -205,11 +220,8 @@ static void brcmstb_gpio_irq_bank_handle
 	struct irq_domain *irq_domain = bank->gc.irqdomain;
 	void __iomem *reg_base = priv->reg_base;
 	unsigned long status;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
-	while ((status = bank->gc.read_reg(reg_base + GIO_STAT(bank->id)) &
-			 bank->gc.read_reg(reg_base + GIO_MASK(bank->id)))) {
+	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
 		int bit;
 
 		for_each_set_bit(bit, &status, 32) {
@@ -224,7 +236,6 @@ static void brcmstb_gpio_irq_bank_handle
 			generic_handle_irq(irq_find_mapping(irq_domain, bit));
 		}
 	}
-	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
 }
 
 /* Each UPG GIO block has one IRQ for all banks */


