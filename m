Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B20ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA32F2148E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wfI/SGeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32F2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeKIHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbeKIHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8D620989;
        Thu,  8 Nov 2018 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714836;
        bh=GqQl3YN1NP2id/ZslhuOMCbTPzxVQkMjgljuxKkiInk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfI/SGeBR2s83kB4Z8ZD4CRmp1bnWz85fMPdpQkLfgwtd8wy6hNG2kzWx736I/z2p
         Fj4WQCCBRRUcv+7ky6vEcnFgb088W5SgiVjA7AU5egGKO2IYQTWE4UjrU7eG/FLm4R
         rS4JGcEPCL3g4qWQxAfXTjPNQ/+LbB5u5g8cCXm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Janusz Uzycki <j.uzycki@elproma.com.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 156/171] gpio: mxs: Get rid of external API call
Date:   Thu,  8 Nov 2018 13:52:06 -0800
Message-Id: <20181108215138.032696776@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 833eacc7b5913da9896bacd30db7d490aa777868 ]

The MXS driver was calling back into the GPIO API from
its irqchip. This is not very elegant, as we are a driver,
let's just shortcut back into the gpio_chip .get() function
instead.

This is a tricky case since the .get() callback is not in
this file, instead assigned by bgpio_init(). Calling the
function direcly in the gpio_chip is however the lesser
evil.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Janusz Uzycki <j.uzycki@elproma.com.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mxs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index ee1724806f46..ab8dcfea0680 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -32,8 +32,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
-/* FIXME: for gpio_get_value(), replace this by direct register read */
-#include <linux/gpio.h>
 #include <linux/module.h>
 
 #define MXS_SET		0x4
@@ -94,7 +92,7 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	port->both_edges &= ~pin_mask;
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
-		val = gpio_get_value(port->gc.base + d->hwirq);
+		val = port->gc.get(&port->gc, d->hwirq);
 		if (val)
 			edge = GPIO_INT_FALL_EDGE;
 		else
-- 
2.17.1



