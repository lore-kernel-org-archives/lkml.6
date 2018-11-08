Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A72BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46CC2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="goTb1+SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46CC2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeKIHdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbeKIHdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:35 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ED520892;
        Thu,  8 Nov 2018 21:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714167;
        bh=KKdpaQ2GSNjHjIDlTMJpWwtQagKPv2MYniOPlXNPrxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goTb1+SWYziyLZKsuqawewMfGU2AaMUWulsT0dDz1CgL+qXkxWCmzK97cWY+7AYNX
         Yi4J8FBAKwA/clHlt4x8d0JBctJQ2RepciercDorDwdfQPRHQA5gRISLT9mHI8CBrm
         7EEXKQOPBexvadc1M9oqT3TWVfuQYSuy6TfkVRYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 088/144] pinctrl: imx25: ensure that a pin with id i is at position i in the info array
Date:   Thu,  8 Nov 2018 13:50:59 -0800
Message-Id: <20181108215101.774172742@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9911a2d5e9d14e39692b751929a92cb5a1d9d0e0 ]

The code in pinctrl-imx.c only works correctly if in the
imx_pinctrl_soc_info passed to imx_pinctrl_probe we have:

	info->pins[i].number = i
	conf_reg(info->pins[i]) = 4 * i

(which conf_reg(pin) being the offset of the pin's configuration
register).

When the imx25 specific part was introduced in b4a87c9b966f ("pinctrl:
pinctrl-imx: add imx25 pinctrl driver") we had:

	info->pins[i].number = i + 1
	conf_reg(info->pins[i]) = 4 * i

. Commit 34027ca2bbc6 ("pinctrl: imx25: fix numbering for pins") tried
to fix that but made the situation:

	info->pins[i-1].number = i
	conf_reg(info->pins[i-1]) = 4 * i

which is hardly better but fixed the error seen back then.

So insert another reserved entry in the array to finally yield:

	info->pins[i].number = i
	conf_reg(info->pins[i]) = 4 * i

Fixes: 34027ca2bbc6 ("pinctrl: imx25: fix numbering for pins")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/freescale/pinctrl-imx25.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx25.c b/drivers/pinctrl/freescale/pinctrl-imx25.c
index b5fabf684632..23e480b5da3e 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx25.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx25.c
@@ -26,7 +26,8 @@
 #include "pinctrl-imx.h"
 
 enum imx25_pads {
-	MX25_PAD_RESERVE0 = 1,
+	MX25_PAD_RESERVE0 = 0,
+	MX25_PAD_RESERVE1 = 1,
 	MX25_PAD_A10 = 2,
 	MX25_PAD_A13 = 3,
 	MX25_PAD_A14 = 4,
@@ -169,6 +170,7 @@ enum imx25_pads {
 /* Pad names for the pinmux subsystem */
 static const struct pinctrl_pin_desc imx25_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX25_PAD_RESERVE0),
+	IMX_PINCTRL_PIN(MX25_PAD_RESERVE1),
 	IMX_PINCTRL_PIN(MX25_PAD_A10),
 	IMX_PINCTRL_PIN(MX25_PAD_A13),
 	IMX_PINCTRL_PIN(MX25_PAD_A14),
-- 
2.17.1



