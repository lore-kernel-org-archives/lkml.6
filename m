Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224NVUi391Fyf3O0PJldfifQbhR8jic4bTqG+Td4MboAq502qPkHEX+FK/CRrfsOIoJKVdUF
ARC-Seal: i=1; a=rsa-sha256; t=1519412136; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWDmrw5dR2YY959WSrZ/XWXvI5KAbHpJD6PPexUx5/ZMp2jcVHFnN3ZXhLiJYfljsY
         KnHFMraEL4LiK4jVMrx0UA7SZX+TB6S08Fo3/lPQWx2mYLMej5KK80rWgXs+DoqN2Fzc
         eETSvV7aghO/qF8sIC0YHEjRkQRqk2zOzIRu7JNGd6dyE9fPqEvfKW8y0ogmMsoH4CRq
         /LZkXuZMjxDWwE2tAwUT7redUHXL/Gb0yJSsCEOHwkSJnJv2BLo5n+ezgE8t76dee0O2
         mBT1PtTDyRyzlc5/SipUWLQfNTeNAPhR3PxIoXdN+4Ul7gE6Rfm1d+jSql4m/zAbAhDG
         OtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w9dlSJJW6pyk6EkEzXEjibTzlvX/muRU6ITsG+F5cLI=;
        b=gCuRawPOmtLrFkvnE9n336CUQ4sDIwN5GjtCDF+/v6u6w6cRwfWkJlY6W0mySj0ApM
         Zzx2ua+hLZYRJ+SgW+Ya98pifcv5J1dvi0Be+JVPk0RyBNirFhD6FQHWsobcDc5E555c
         WYQefp07c3sScVST4aRGavui8VbYt1pzkbh3LbVz8I9+PP5X+NUPStwEONmOeHIGKkMQ
         KCRcoU8/ljw43ZhsZqrLfn4Ww+r5Iw++trnfnYUoURUessO+F011f4YrWUceCjozZe3X
         EmWZhhA+i2kxYkVTo2uYR0bjNprtd2wMhSNuT6sYbVoDAqy1sT4snAGhzEfq9nNrGWAU
         kI9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Potyra <Stefan.Potyra@elektrobit.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 137/159] ASoC: rockchip: disable clock on error
Date: Fri, 23 Feb 2018 19:27:25 +0100
Message-Id: <20180223170759.663091447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217808867092644?=
X-GMAIL-MSGID: =?utf-8?q?1593219100904817901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>


[ Upstream commit c7b92172a61b91936be985cb9bc499a4ebc6489b ]

Disable the clocks in  rk_spdif_probe when an error occurs after one
of the clocks has been enabled previously.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: f874b80e1571 ASoC: rockchip: Add rockchip SPDIF transceiver driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/rockchip_spdif.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -322,26 +322,30 @@ static int rk_spdif_probe(struct platfor
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(spdif->mclk)) {
 		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		return PTR_ERR(spdif->mclk);
+		ret = PTR_ERR(spdif->mclk);
+		goto err_disable_hclk;
 	}
 
 	ret = clk_prepare_enable(spdif->mclk);
 	if (ret) {
 		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		return ret;
+		goto err_disable_clocks;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_disable_clocks;
+	}
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev,
 			"Failed to initialise managed register map\n");
-		return PTR_ERR(spdif->regmap);
+		ret = PTR_ERR(spdif->regmap);
+		goto err_disable_clocks;
 	}
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
@@ -373,6 +377,10 @@ static int rk_spdif_probe(struct platfor
 
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
+err_disable_clocks:
+	clk_disable_unprepare(spdif->mclk);
+err_disable_hclk:
+	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
