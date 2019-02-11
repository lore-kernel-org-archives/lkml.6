Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC88218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895185;
	bh=AaxbHy0b+4seBHfJiloA2E6VY/47av3S3drPFAc7384=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CUiOZOMqlgrJyduy1FDHqOAHFawjXRi89HntCrsWRaKfPPyzaEA6FV6wvZlCl+9rz
	 lcDgdyahqOX14vUvvL1xsNQMR0+6YtDS+JfcsObhAjjZ7izj/2Frvn0QAFO8noU+WI
	 ceY2o+ka6Po5dhgPJilkWaSNp1wTT2Uwd2ttgEx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfBKO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfBKO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2026D20838;
        Mon, 11 Feb 2019 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895175;
        bh=AaxbHy0b+4seBHfJiloA2E6VY/47av3S3drPFAc7384=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zObQTEUtxO74PADj4aYuB/TeB4UUY8x81b+1rSnJ1dbHfQmSNd0IEnCBWRnQnPxfX
         tNGaGYAQzP8zEub1B5jKgBbuB5Y6Ofenc6H1Zbv8lncOs0pniHq/DOYmAW3Hl1in8U
         RD2Ar9KtK2amGsmgm9ElAZ67P6x+5vU4Vf8jF49c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 119/352] pinctrl: nuvoton: check for devm_kasprintf() failure
Date:   Mon, 11 Feb 2019 15:15:46 +0100
Message-Id: <20190211141853.621905595@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4be1eaf322f07bb9694618fd2763a3a1f0a3dd25 ]

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignment to  .label  is not safe if not checked. On error
npcm7xx_gpio_of() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 7ad50d9268aa..3bda620d18bb 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1932,6 +1932,9 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 			pctrl->gpio_bank[id].gc.label =
 				devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOF",
 					       np);
+			if (pctrl->gpio_bank[id].gc.label == NULL)
+				return -ENOMEM;
+
 			pctrl->gpio_bank[id].gc.dbg_show = npcmgpio_dbg_show;
 			pctrl->gpio_bank[id].direction_input =
 				pctrl->gpio_bank[id].gc.direction_input;
-- 
2.19.1



