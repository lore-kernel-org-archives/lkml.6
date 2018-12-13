Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06537C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B302086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B302086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeLMQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:20:35 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:53298 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:20:34 -0500
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id BULX1z00L3XaVaC01ULXlL; Thu, 13 Dec 2018 17:20:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gXTix-0006EU-9q; Thu, 13 Dec 2018 17:20:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gXTix-0003Qs-8B; Thu, 13 Dec 2018 17:20:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pinctrl: sh-pfc: r8a77990: Fix IOCTRL reg state after s2ram on R-Car E3
Date:   Thu, 13 Dec 2018 17:20:27 +0100
Message-Id: <20181213162027.13137-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to an interaction with commit 9f2b76a2db3c4387 ("pinctrl: sh-pfc:
r8a77990: Add R8A774C0 PFC support"), the state of the I/O Control
Registers is saved/restored during s2ram on RZ/G2E, but not on R-Car E3.
Hence on R-Car E3, SDHI voltage state is lost after system resume.

Fix this by registering the I/O Control Registers on R-Car E3, too.

Fixes: 33847a71373cd6ae ("pinctrl: sh-pfc: r8a77990: Add voltage switch operations for SDHI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued as a fix in sh-pfc-for-v4.21.

 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 784d4400c3e0e7ea..d5b7a83e8b614370 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -5017,6 +5017,7 @@ const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 	.bias_regs = pinmux_bias_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.17.1

