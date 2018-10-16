Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="miHWfsCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbeJQBLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbeJQBLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4816A20866;
        Tue, 16 Oct 2018 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710430;
        bh=dgD1yTU/Pr3JM8ddBryup3Yw+TZS5LGx+nAWqT+fu6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miHWfsCK79p1y52bp4QDcW2Aa3ze/YmlrRP4MCtVa+qSFLWwcHcdtGfMH7xES/tYA
         F9jI9M2B/pV1Vv2XowsqkMNcvrl1fltuFd7qjyD8nj1cOvQnfKbc9JQKniRJp2kdsb
         tS4WaPIQmT7hYd5Vl4gvmrGDq/2zgQCcKy80ph78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Dmitry Mastykin <mastichi@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 074/109] pinctrl: mcp23s08: fix irq and irqchip setup order
Date:   Tue, 16 Oct 2018 19:05:42 +0200
Message-Id: <20181016170528.845153303@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Marco Felsch <m.felsch@pengutronix.de>

commit f259f896f2348f0302f6f88d4382378cf9d23a7e upstream.

Since 'commit 02e389e63e35 ("pinctrl: mcp23s08: fix irq setup order")' the
irq request isn't the last devm_* allocation. Without a deeper look at
the irq and testing this isn't a good solution. Since this driver relies
on the devm mechanism, requesting a interrupt should be the last thing
to avoid memory corruptions during unbinding.

'Commit 02e389e63e35 ("pinctrl: mcp23s08: fix irq setup order")' fixed the
order for the interrupt-controller use case only. The
mcp23s08_irq_setup() must be split into two to fix it for the
interrupt-controller use case and to register the irq at last. So the
irq will be freed first during unbind.

Cc: stable@vger.kernel.org
Cc: Jan Kundrát <jan.kundrat@cesnet.cz>
Cc: Dmitry Mastykin <mastichi@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Fixes: 82039d244f87 ("pinctrl: mcp23s08: add pinconf support")
Fixes: 02e389e63e35 ("pinctrl: mcp23s08: fix irq setup order")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-mcp23s08.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -643,6 +643,14 @@ static int mcp23s08_irq_setup(struct mcp
 		return err;
 	}
 
+	return 0;
+}
+
+static int mcp23s08_irqchip_setup(struct mcp23s08 *mcp)
+{
+	struct gpio_chip *chip = &mcp->chip;
+	int err;
+
 	err =  gpiochip_irqchip_add_nested(chip,
 					   &mcp23s08_irq_chip,
 					   0,
@@ -907,7 +915,7 @@ static int mcp23s08_probe_one(struct mcp
 	}
 
 	if (mcp->irq && mcp->irq_controller) {
-		ret = mcp23s08_irq_setup(mcp);
+		ret = mcp23s08_irqchip_setup(mcp);
 		if (ret)
 			goto fail;
 	}
@@ -932,6 +940,9 @@ static int mcp23s08_probe_one(struct mcp
 		goto fail;
 	}
 
+	if (mcp->irq)
+		ret = mcp23s08_irq_setup(mcp);
+
 fail:
 	if (ret < 0)
 		dev_dbg(dev, "can't setup chip %d, --> %d\n", addr, ret);


