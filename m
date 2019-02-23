Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261922085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956231;
	bh=cUEbUAt4SCpwj/wk1kfSOk8ukrDLUWEMYmS9x5tdB3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oexb6FE2uyo8+f4+EEvl+VFZvpRwQUN+TiNO/ls5HSL1b7WtmmOuu6SOdFTh3cbJp
	 IzJUDK45CQoSXXa04vdBfM2Haq//ICOpG9KIMf21KMGZjYtAFrTFTkutSr8Vi9bChq
	 D2breBpapNOfD6z4ZA9LdKR4J11Vt7ZXs8GuGXqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfBWVKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfBWVKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58F42086A;
        Sat, 23 Feb 2019 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956222;
        bh=cUEbUAt4SCpwj/wk1kfSOk8ukrDLUWEMYmS9x5tdB3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2qDpegHJbGA6Vfey0KwTaMI3loEmF3gsRSI1ZbjzXB53+YwMaHh0xLly0UOojhYi
         9UsipH5JS3hgZLpFqw4d/ST19sj0ckJQKP8W4IVVYaIsZweuiEz/a01qBbWGeTKN7L
         45BzW3ksGKj/bTujq200aju5uWXSWMDR2DgQfwlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 19/32] gpio: vf610: Mask all GPIO interrupts
Date:   Sat, 23 Feb 2019 16:09:38 -0500
Message-Id: <20190223210951.202268-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 7ae710f9f8b2cf95297e7bbfe1c09789a7dc43d4 ]

On SoC reset all GPIO interrupts are disable. However, if kexec is
used to boot into a new kernel, the SoC does not experience a
reset. Hence GPIO interrupts can be left enabled from the previous
kernel. It is then possible for the interrupt to fire before an
interrupt handler is registered, resulting in the kernel complaining
of an "unexpected IRQ trap", the interrupt is never cleared, and so
fires again, resulting in an interrupt storm.

Disable all GPIO interrupts before registering the GPIO IRQ chip.

Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-vf610.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 3edb09cb9ee08..1f599bc082374 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -221,6 +221,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct resource *iores;
 	struct gpio_chip *gc;
+	int i;
 	int ret;
 
 	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
@@ -259,6 +260,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/* Mask all GPIO interrupts */
+	for (i = 0; i < gc->ngpio; i++)
+		vf610_gpio_writel(0, port->base + PORT_PCR(i));
+
 	/* Clear the interrupt status register for all GPIO's */
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
-- 
2.19.1

