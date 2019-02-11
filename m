Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D231320700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896216;
	bh=aU5VABVeICoHqb6OcWjPcsTtYawNIyWRVZ0RQkwZoU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HmgCzSq0tSJYjF3qScpWJ4VN3zkRJx1w5asdeahdRXvbxnHJpuSL4IXiAY1h2KSeu
	 TqDCM4tu3BOkqvI8MbfotEIgBWZCXEaM35Ks0Gx0/aldZIr7prbmBFaMtUCXvakbCd
	 b8Q8vWNFBBzttxjXlISEBa1c7fu7Saor+dRjBIkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfBKOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfBKOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80F02081B;
        Mon, 11 Feb 2019 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896212;
        bh=aU5VABVeICoHqb6OcWjPcsTtYawNIyWRVZ0RQkwZoU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwcUKhZd2msToV4ohkS8ypSQ+WQUmTOM3Hi1L64PyjjnyxdoVlKXePV2ttkm/lBL/
         zGFbHPngmWFXBAV+/Uc1FdsGxWvzJD0W4y2zh0Q4OlmcaLrcyxUeDwCctZ4Rpiafil
         cY4HzLrcAFP/qFgP9AXcVZxWKxuqtcpjeyap78yU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/313] gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack
Date:   Mon, 11 Feb 2019 15:16:29 +0100
Message-Id: <20190211141901.148599315@linuxfoundation.org>
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



