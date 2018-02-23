Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Fez7/FdHQDOKZVEcrwu+Ng210Ioo4StOhNw8rUSNnCO6YJQhN2mWKzdeY8G0MUJYQKvYE
ARC-Seal: i=1; a=rsa-sha256; t=1519410904; cv=none;
        d=google.com; s=arc-20160816;
        b=mx0dywteDrtTT8VImkwKWw3NStM9jCvKbQFyGmXNvqw/o7JpxJbpwl9NLLZkwaJpUK
         hFI2hd8vZKlDnQUpiQYxT45pmDm+KbOXJHO2d5wKL3Ok8GutWZUwIPB6Uvh8COWIhu7o
         YfX2flDv8PnQLETzf6j6rjMOIzmp8i0hE0uvrh6n+eUM8B4/PAV/w6o8rzD+X66VNzZE
         5zeyt2DT2ijUGZiDr2R2Wp5xiyL9OsKpmk5w51WnyDKcOOyUSjv2ZhVUsd4yrsQRntsH
         Xag0tzPglWBGRvVQkvH10q5KjaGal5Ck1KT08ddvRaPzFjFLXaTrAjiKA5jm7znO26Y/
         ht1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6GYVm/DGCe/4L/Mr9aVnY2YNGPuExYGyFrAXIBW46fE=;
        b=sl2HMQo5sJbecHUheeZyoF9/EavX6a0GlOEn22AZDESb2bUMxtXaCdM2sOFyDn6gYE
         wNh3/N5xU+AMAbOwjAooSa8lEIMfT8b5ItZiVefutTKsgsP/3aD+wEN2faiDLDmfJmYk
         hrkzEgpyXHDJMo3UTKV2PsuUt9mI3yFjKDy0RJhm5vzR19/whP+RIlaJqL6c0dRWddmJ
         H2DBSsOn7WLd3iDvsrGVCFfjrl9BKeV0l5cwn4+s9bT6jD7Lx4t/OdGJDnYvf7qp7FfG
         y3MMC3jKKSR9XOkww97MNP14Ns/b6pBD/1i3t4LZDmZZfb8tuIDKsElbYbOkh0ClIA5V
         T4zQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 053/193] ASoC: rockchip: disable clock on error
Date: Fri, 23 Feb 2018 19:24:46 +0100
Message-Id: <20180223170334.317541368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217808867092644?=
X-GMAIL-MSGID: =?utf-8?q?1593217808867092644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>


[ Upstream commit c7b92172a61b91936be985cb9bc499a4ebc6489b ]

Disable the clocks in  rk_spdif_probe when an error occurs after one
of the clocks has been enabled previously.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: f874b80e1571 ASoC: rockchip: Add rockchip SPDIF transceiver driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/rockchip_spdif.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -316,26 +316,30 @@ static int rk_spdif_probe(struct platfor
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
@@ -367,6 +371,10 @@ static int rk_spdif_probe(struct platfor
 
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
+err_disable_clocks:
+	clk_disable_unprepare(spdif->mclk);
+err_disable_hclk:
+	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
