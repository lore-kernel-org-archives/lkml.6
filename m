Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DBBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128972075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895210;
	bh=ORHMkE56yCpPS36/XCErJUN4nbC/6zb61EDCVquZ3Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+MQ3Ntpv5JDJbBV8UNQ0NMvGEji5g4IefDkeCzDoQFj5xyUTeGaBuW083IUNBxBh
	 UfMn6cxFhOy9KAcUKdZikkCx1WvVz83mU+HglBzlYRkYagB9kHTe/8WuzxJV9uDa/p
	 XoM9VLbE0iwkBZrbi5Uo0NkvjnRBgkLdu2xavIPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfBKO0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbfBKO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37C7218A3;
        Mon, 11 Feb 2019 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895202;
        bh=ORHMkE56yCpPS36/XCErJUN4nbC/6zb61EDCVquZ3Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN7CYrh9Rv1VSr/Yq3y7CRWeEEaiWa+sfcpgEi+d9LNxBGn1fOVUiDtQX8MS1/4Hs
         +2RjkRhan0G4huD7WXXdGqHUdfgzJoM0BgQgn1y1hHgKyWo0Ix76fiRtZHFqZ7nj+/
         GGEIBS6shBtfI7MhTSzzg+P9sjAqeJf+hwl/4FME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 128/352] gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack
Date:   Mon, 11 Feb 2019 15:15:55 +0100
Message-Id: <20190211141854.538563288@linuxfoundation.org>
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



