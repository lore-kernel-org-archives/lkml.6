Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FCC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86F32175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Mbpyz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86F32175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeKLIUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388642AbeKLIUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB1F21582;
        Sun, 11 Nov 2018 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975427;
        bh=UGFvd7ojE1Fzw7DNcCZFzJZ1fuxn4oAUHIUcf1hgX8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/Mbpyz52q8skIAPjDiuT1WW9fbMo4EVMf+ZREUkbjqQZRO5UjaZ+V2JicOz/XpRv
         fUbDey+GSz5gEgVPePNuTN+OCimGPxMMnIrjWvbgMS9yFHue3MIL2498uuH0BnQRVJ
         HTzDolwe3+2KbHmVhWXfKHhV/AMAuQqW0zhRWwoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 128/350] gpio: brcmstb: allow 0 width GPIO banks
Date:   Sun, 11 Nov 2018 14:19:52 -0800
Message-Id: <20181111221713.068281294@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Justin Chen <justinpopo6@gmail.com>

[ Upstream commit bfba223dcc4548632d8f3bfd15690a86d4c68504 ]

Sometimes we have empty banks within the GPIO block. This commit allows
proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
incrementing the bank and number of GPIOs, but not initializing them.
This will mean a call into the non-existent GPIOs will return an error.

Also remove "GPIO registered" dev print. This information is misleading
since the incremented banks and gpio_base do not reflect the actual GPIOs
that get initialized. We leave this information out since it is already
printed with dev_dbg.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-brcmstb.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -664,6 +664,18 @@ static int brcmstb_gpio_probe(struct pla
 		struct brcmstb_gpio_bank *bank;
 		struct gpio_chip *gc;
 
+		/*
+		 * If bank_width is 0, then there is an empty bank in the
+		 * register block. Special handling for this case.
+		 */
+		if (bank_width == 0) {
+			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
+				num_banks);
+			num_banks++;
+			gpio_base += MAX_GPIO_PER_BANK;
+			continue;
+		}
+
 		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 		if (!bank) {
 			err = -ENOMEM;
@@ -740,9 +752,6 @@ static int brcmstb_gpio_probe(struct pla
 			goto fail;
 	}
 
-	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
-			num_banks, priv->gpio_base, gpio_base - 1);
-
 	if (priv->parent_wake_irq && need_wakeup_event)
 		pm_wakeup_event(dev, 0);
 


