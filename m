Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F389C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375422177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690604;
	bh=f0spF4CTYM5t033TBalzw1w3xyJzYaiO5209hAX0zS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eiuOTk+uVkONHwmeROTMZw1gyOO41Nglq8PFzGrRG5NweKlxxP8hvtuFjGSCQTHEQ
	 wc52EZ+N0M/1GfV8q9K4NO0Eym9r52j+veOb94ndAvjB8WpowLDjMz6vPBGiErPrWh
	 /BloNZYIbsAw5wNNvkppHQyml7cFsboN6IdzBIuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfA1PuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbfA1PuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E80720880;
        Mon, 28 Jan 2019 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690599;
        bh=f0spF4CTYM5t033TBalzw1w3xyJzYaiO5209hAX0zS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSpMZBz2Aeht6ZGmNgBsp1OcUokiO/M/RrB7NpqxWaF+RfE2tOL1XSv3XXcQZM7M1
         RDwrW+Et1mesUkiUG8cFlKhIbedRcYXGum48nRGvuXjSZCMG1BOStyHOZIVCjeIitm
         imJhXx4O+60/UN5k/EAqi559A/yUekFxev/4VTO4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 136/304] gpio: mt7621: report failure of devm_kasprintf()
Date:   Mon, 28 Jan 2019 10:40:53 -0500
Message-Id: <20190128154341.47195-136-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

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

