Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B0420880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690606;
	bh=OhWL43AS179SrHPdoU2OtfJg66jHdWNiT9plSOTdTR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NE51fc13Ula/IWsW6P+ofIeQqI4yRb524QYa9EHbPlPJR2RcAMCvHpb4VOz+Z27My
	 GbFt5OBaGP3QbQaY9hKwVNHt4SawYRvGA9DJYkEmwIldve9G+szbiSF7PqNLfHGcQA
	 3AKegkU0zJ+i+Aw/ibJ1y7xiComRkIME+y2+Fu1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfA1PuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfA1PuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DBBC2147A;
        Mon, 28 Jan 2019 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690601;
        bh=OhWL43AS179SrHPdoU2OtfJg66jHdWNiT9plSOTdTR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELOPClo3ouU1ryZg2PpwtzdgS4+pno7ROwLqp7bpPZd7rKVKCffq+l1YTzk9yHnkN
         1iTNUusS+vGNSbrksvK7VwZqJyjBJq3vGRLpXRa39k+0Te79veTzYSo2hgPaMrHqR6
         43nFxSGxHdFNIPStvviX2i9du9gj96SfRfg1yzHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 137/304] gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack
Date:   Mon, 28 Jan 2019 10:40:54 -0500
Message-Id: <20190128154341.47195-137-sashal@kernel.org>
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

[ Upstream commit a109c2dbb571b10bb9969285b646f57309c98251 ]

The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
for the dev_err() messages). The probe function should return an error
if one of the banks failed to initialize properly indicated by
not returning non-0.

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Acked-by: Sean Wang <sean.wang@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mt7621.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 1ec95bc18f5b..00e954f22bc9 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct mtk *mtk;
 	int i;
+	int ret;
 
 	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
 	if (!mtk)
@@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mtk);
 	mediatek_gpio_irq_chip.name = dev_name(dev);
 
-	for (i = 0; i < MTK_BANK_CNT; i++)
-		mediatek_gpio_bank_probe(dev, np, i);
+	for (i = 0; i < MTK_BANK_CNT; i++) {
+		ret = mediatek_gpio_bank_probe(dev, np, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.19.1

