Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807632077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bb7HqXat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfBSPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:20:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38045 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBSPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:20:15 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190219152012epoutp019d63d8fd48c21163512c9c38d6c72aba~EzQmiagLt0260402604epoutp01f;
        Tue, 19 Feb 2019 15:20:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190219152012epoutp019d63d8fd48c21163512c9c38d6c72aba~EzQmiagLt0260402604epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550589613;
        bh=JHwTFh48S3B1ikB/OlwFRSfz4YrSAVRhOCixy70VD3o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bb7HqXatc3UauPYqZqIYhQIMjTJaZDE16BZHJDkl9sMtR5oKoZUMxl5z0qtnltLxI
         yaq+Y/nPDiDb2SIo9Wo4kyqsMK2NkI/uRPJdpNlDimNDsQrpG9erx4n5DIdCYkHicQ
         S5TPtRunzfvwDg1RAh9M4u1HGGkQ+1J3sckqGoOw=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190219152012epcas1p29632b37ef8d3f9b369a210af24322c64~EzQmHxTuy2097420974epcas1p2O;
        Tue, 19 Feb 2019 15:20:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.7B.04173.CAE1C6C5; Wed, 20 Feb 2019 00:20:12 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190219152012epcas1p4df1d6e4f6439ab05de95c089a4416e06~EzQlol-A20144401444epcas1p4_;
        Tue, 19 Feb 2019 15:20:12 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-7f-5c6c1eacd5ad
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.72.04015.BAE1C6C5; Wed, 20 Feb 2019 00:20:11 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PN600EUVIL44F30@mmp1.samsung.com>; Wed, 20 Feb 2019
        00:20:11 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 1/2] ASoC: samsung: i2s: Fix secondary platform device
 unregistration
Date:   Tue, 19 Feb 2019 16:19:40 +0100
Message-id: <20190219151941.9795-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmge4auZwYg5bvchZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mhj8fmAo6RSou3zvL3sB4VaCLkZND
        QsBE4v/TeUwgtpDADkaJAz+tIezvjBLvtmjB1Hy70czWxcgFFN/NKPHr6Uwo5xejxNaD11lB
        qtgEDCV6j/YxgtgiAtoSc252gBUxC7xllJj3bBdQEQeHsECUxOflYDUsAqoSb3b8YgaxeQWs
        JB4cbmaB2CYvsXrDAWaQXgmBDjaJzz/Xs0EkXCS+tb5kA5kjISAtcemoLUS4WmLX9m6YekaJ
        lgvbmSES1hKHj18EO45ZgE/i3dceVoheXomONiGIEg+JE8++s0B8HCsxc8ETpgmM4gsYGVYx
        iqUWFOempxYbFhjpFSfmFpfmpesl5+duYgTHmZbZDsZF53wOMQpwMCrx8Gow5MQIsSaWFVfm
        HmKU4GBWEuE15AIK8aYkVlalFuXHF5XmpBYfYpTmYFES513v4BwjJJCeWJKanZpakFoEk2Xi
        4JRqYKzy0BHwTwjuab3l/vloa+G0uYfr3179O/FPxccC64m6XJ4x90u7Fr11DnwR1Zer7nCc
        4fMNLfnls7OCpzV0BJWsmXL17/5307wcglu+PDf4Karalrb/luTP92ktogZ/Jib47ufQU4lk
        nvM3PjZUKPmoXXLvmzf6L9OyKhI+KNe/ZJl0JsjCWomlOCPRUIu5qDgRAMIT88+vAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xgO5quZwYgxV/LS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZDX8+MBV0ilRcvneWvYHxqkAXIyeH
        hICJxLcbzWxdjFwcQgI7GSW+vTnABOH8YpRY//oeC0gVm4ChRO/RPkYQW0RAW2LOzQ6wDmaB
        t4wSDWfagBwODmGBKInPy8FqWARUJd7s+MUMYvMKWEk8ONzMArFNXmL1hgPMExi5FjAyrGKU
        TC0ozk3PLTYqMMxLLdcrTswtLs1L10vOz93ECAyabYe1+nYw3l8Sf4hRgINRiYdXgyEnRog1
        say4MvcQowQHs5IIryEXUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWp
        RTBZJg5OqQZGkdxHX3bXLnpZymFfF/Au/4L5mRkTw/41m+0UrPHlPbrm53lu1Yvhghf5v2+3
        KW6/5lj01vHIIZk3D91YDXveJFY3qe8p9DsdYXP/l8evWdKqiU4WUav3HXBiOfeueNHjTTEf
        Jzp2PTr951ABx7L/KfeOfrdx8xAy9t1wKtTyu+G3szdtMtyslFiKMxINtZiLihMBoTT+JRYC
        AAA=
X-CMS-MailID: 20190219152012epcas1p4df1d6e4f6439ab05de95c089a4416e06
CMS-TYPE: 101P
X-CMS-RootMailID: 20190219152012epcas1p4df1d6e4f6439ab05de95c089a4416e06
References: <CGME20190219152012epcas1p4df1d6e4f6439ab05de95c089a4416e06@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes unregistration of the secondary platform device so all
resources are properly released.  Additionally the removal sequence
is corrected so it is in reverse order comparing to probe sequence.
The test against NULL priv->pdev_sec is removed as it is not necessary.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - corrected order of calls on error path in probe() and in remove().

 sound/soc/samsung/i2s.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 02472f576e17..cd92bb6e1da1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)

 static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
 {
-	if (priv->pdev_sec) {
-		platform_device_del(priv->pdev_sec);
-		priv->pdev_sec = NULL;
-	}
+	platform_device_unregister(priv->pdev_sec);
+	priv->pdev_sec = NULL;
 }
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1487,14 +1486,14 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 						sec_dai->filter, "tx-sec", NULL,
 						&pdev->dev);
 		if (ret < 0)
-			goto err_disable_clk;
+			goto err_del_sec;

 	}

 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
 		ret = -EINVAL;
-		goto err_disable_clk;
+		goto err_del_sec;
 	}

 	dev_set_drvdata(&pdev->dev, priv);
@@ -1503,7 +1502,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 					&samsung_i2s_component,
 					priv->dai_drv, num_dais);
 	if (ret < 0)
-		goto err_disable_clk;
+		goto err_del_sec;

 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1518,9 +1517,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)

 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
+err_del_sec:
+	i2s_delete_secondary_device(priv);
 err_disable_clk:
 	clk_disable_unprepare(priv->clk);
-	i2s_delete_secondary_device(priv);
 	return ret;
 }

@@ -1536,9 +1536,10 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);

 	i2s_unregister_clock_provider(priv);
+	i2s_delete_secondary_device(priv);
 	clk_disable_unprepare(priv->clk);
+
 	pm_runtime_put_noidle(&pdev->dev);
-	i2s_delete_secondary_device(priv);

 	return 0;
 }
--
2.17.1

