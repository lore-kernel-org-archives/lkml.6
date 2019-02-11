Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45061C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098DC21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899928;
	bh=Nf/F5AKUn6Eadyi4XSpw4xl4/Hs0Ci4eWLXn+tOfRfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNhUGLThcjXW8rEx8050qcU4qtHlV4IV/lveeIgzk1uuAvrFZogCbEMkOB8L0PtX2
	 t7cvEffHeJ6eOmAAiRFILOLfdGu3BvoZyzYq/jR1tX+RrBRkhkdvFjW3bputQmF3Kd
	 QLHk2H7mWO40z1ZUIRZv0vCrCgM8RJ8F51goEbXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfBKOnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbfBKOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1739020700;
        Mon, 11 Feb 2019 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896208;
        bh=Nf/F5AKUn6Eadyi4XSpw4xl4/Hs0Ci4eWLXn+tOfRfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssGmLofI9J4l5WL2uIcjLYP4vR9iOXcQKXtlzPIe1Rl8/KIRA29be2TvYLt5x4Wfh
         wzbVZaGOXIT1TDYJloA/GV2DQ6Lkupv3Bkksc7iLxeJQthpyF4chjZEHD9m8fjXgH8
         EnMvydaQgAtzel79PsaUKQQ0pcafskXTAHirnrJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/313] gpio: mt7621: report failure of devm_kasprintf()
Date:   Mon, 11 Feb 2019 15:16:28 +0100
Message-Id: <20190211141901.075658356@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 59d646c775d6ae688ee90fda9f2a4270c47b7490 ]

kasprintf() may return NULL on failure of internal allocation thus the
assigned  label  is not safe if not explicitly checked. On error
mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
(unlikely) failure case should be fine here.

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Sean Wang <sean.wang@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index d72af6f6cdbd..1ec95bc18f5b 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -244,6 +244,8 @@ mediatek_gpio_bank_probe(struct device *dev,
 	rg->chip.of_xlate = mediatek_gpio_xlate;
 	rg->chip.label = devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
 					dev_name(dev), bank);
+	if (!rg->chip.label)
+		return -ENOMEM;
 
 	ret = devm_gpiochip_add_data(dev, &rg->chip, mtk);
 	if (ret < 0) {
-- 
2.19.1



