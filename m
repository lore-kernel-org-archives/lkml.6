Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F711C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4280A21479
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JllnNF1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeJYWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeJYWwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60A3208A3;
        Thu, 25 Oct 2018 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477162;
        bh=z9kOXNNHOiwJZkyxo2GAHP07xzIJTmqr5xMFQBRSaMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JllnNF1IJT5oO95hqsJTR3bvh9vxBdM9caK8c2mXopBPgPTygwKZ9PHF9sjU4N28E
         uYJpEtcbOSF4gj9wVWbLnFpfWucoZYoKk5J4PqaVwW2kDPI2OqZ4HNJEV1xVeAPE1L
         ntqUnwPU56WE17hQG86UDPgwCUvk9tvRLxSH+lyc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 17/98] usb: musb: Fix randconfig build issues for Kconfig options
Date:   Thu, 25 Oct 2018 10:17:32 -0400
Message-Id: <20181025141853.214051-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit c0442479652b99b62dd1ffccb34231caff25751c ]

Commit 82c02f58ba3a ("usb: musb: Allow multiple glue layers to be
built in") enabled selecting multiple glue layers, which in turn
exposed things more for randconfig builds. If NOP_USB_XCEIV is
built-in and TUSB6010 is a loadable module, we will get:

drivers/built-in.o: In function `tusb_remove':
tusb6010.c:(.text+0x16a817): undefined reference to `usb_phy_generic_unregister'
drivers/built-in.o: In function `tusb_probe':
tusb6010.c:(.text+0x16b24e): undefined reference to `usb_phy_generic_register'
make: *** [vmlinux] Error 1

Let's fix this the same way as commit 70c1ff4b3c86 ("usb: musb:
tusb-dma can't be built-in if tusb is not").

And while at it, let's not allow selecting the glue layers except
on platforms really using them unless COMPILE_TEST is specified:

- TUSB6010 is in practise only used on omaps

- DSPS is only used on TI platforms

- UX500 is only used on STE platforms

Cc: Linus Walleij <linus.walleij@linaro.org>
Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index dbc56eb5eee4..5ab24cd38f37 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -73,6 +73,8 @@ config USB_MUSB_DA8XX
 
 config USB_MUSB_TUSB6010
 	tristate "TUSB6010"
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on NOP_USB_XCEIV = USB_MUSB_HDRC # both built-in or both modules
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
@@ -86,6 +88,7 @@ config USB_MUSB_AM35X
 config USB_MUSB_DSPS
 	tristate "TI DSPS platforms"
 	select USB_MUSB_AM335X_CHILD
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on OF_IRQ
 
 config USB_MUSB_BLACKFIN
@@ -94,6 +97,7 @@ config USB_MUSB_BLACKFIN
 
 config USB_MUSB_UX500
 	tristate "Ux500 platforms"
+	depends on ARCH_U8500 || COMPILE_TEST
 
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
-- 
2.17.1

