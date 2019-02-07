Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5407C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C321917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bO7Il1f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfBGRBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:23 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63667 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfBGRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:21 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190207170118epoutp01ddb8aefc4505fe3b64f4314dab67c8ea~BI5cKy-0n1148911489epoutp01R;
        Thu,  7 Feb 2019 17:01:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190207170118epoutp01ddb8aefc4505fe3b64f4314dab67c8ea~BI5cKy-0n1148911489epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558878;
        bh=GEtG85kEEkBYvjn7ahbjfWXUuidG8thlI4Py+FY2OCQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=bO7Il1f8bPzYxtx8dA3PbzVbwqZ8dsvar5iSg9Gr/qRvHMYW/0hcrAbEko3e3b0rj
         j6esi29V0zfwDpzXy8oUHqJi2HScw+tNMAGDX3D+o/7NbY/hAJR9/vc77Gf8ISRjSZ
         M7VU8tMcJakWagn4tanpaIICVgCIYDGjCnO+0y7E=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170117epcas2p3e9cef5ff7e4da52b136aa0213865e224~BI5bTkTfx2769327693epcas2p3N;
        Thu,  7 Feb 2019 17:01:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.B6.04093.D546C5C5; Fri,  8 Feb 2019 02:01:17 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170116epcas2p1e0768a74062c8af83842ddb59309850f~BI5aMGJ8t2100621006epcas2p1D;
        Thu,  7 Feb 2019 17:01:16 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-23-5c5c645ddc56
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.B8.03689.C546C5C5; Fri,  8 Feb 2019 02:01:16 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:16 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 09/22] ASoC: samsung: i2s: Move core clk to the driver
 common data structure
Date:   Thu, 07 Feb 2019 18:00:17 +0100
Message-id: <20190207170028.720-10-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmqW5sSkyMwZod0hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mlh1bmQvWyVUc3X6SvYHxv0QXIyeH
        hICJxKSte9i6GLk4hAR2MEqsm76UBcL5zijxfNJuJpiq7zPWsUIkdjNKHJ+xDcr5xSixefF7
        dpAqNgFDid6jfYwgtoiAmMTtOZ3MIEXMAi1MEnPmLmUGSQgLxEnMOjcHqJuDg0VAVeJpRypI
        mFfASuLv/KdsENvkJc73rgObyQkUv7V/BwtEjaDEj8n3wGxmoJqDV56zQNQfYZNY3SEOYbtI
        XN37BOpqaYlnqzYyQtjVEru2d4PdIyHQwSjRcmE7M0TCWuLw8YusEEP5JDoO/2UHuU1CgFei
        o00IosRD4vmfBcwQD/cCPfz/IMsERqlZSG6aheSmBYxMqxjFUguKc9NTi40KTPSKE3OLS/PS
        9ZLzczcxgqNcy2MH44FzPocYBTgYlXh4L2jHxAixJpYVV+YeYpTgYFYS4ZVNAArxpiRWVqUW
        5ccXleakFh9ilOZgURLnfSg9N1pIID2xJDU7NbUgtQgmy8TBKdXAWMZwgGmLYqOLmmnAV9n7
        BrOvzuRnv8zmqvxa6IuW6vH+SX9sNT7IbV56MKfyzaMd7uK7w9eHvpjA43rmFM/rPJMgMWHh
        M8qmtu5CDHanNd67fik+NaXVZpXWsqOR7p6Pd05Z9d6pYcXMteVcbm/inP9fWHjpQ7P5ddNo
        fovVtQ4aP18tVtjIp8RSnJFoqMVcVJwIANcPbbbuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd2YlJgYg/1PeS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZLTu2Mhesk6s4uv0kewPjf4kuRk4O
        CQETie8z1rF2MXJxCAnsZJQ4cfgkO4Tzi1Fi+Yp9LCBVbAKGEr1H+xhBbBEBMYnbczqZQYqY
        BZqYJHbdvsgOkhAWiJP4/3oTUIKDg0VAVeJpRypImFfASuLv/KdsENvkJc73rgMr5wSK39q/
        A2y+kIClxIcJTawQ9YISPybfA4szA9UfvPKcZQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFRjl
        pZbrFSfmFpfmpesl5+duYgQG8bbDWv07GB8viT/EKMDBqMTDe0E7JkaINbGsuDL3EKMEB7OS
        CK9sAlCINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDI9cy
        t9OHhfbUas2LWpRT3i2SNWe74a1zlvNnP3zSkRT98pb9zXiWB1GHWIJkTndvVjt4YdnKklP8
        OX++uugdvr7m4ZcGy508ubZL7F0Sb735U2hTtmKFuhmD2c9SV6VW8U0xk9P9zyf8e/bk4K4/
        01ts1Z8mHUgv1fu1+9bWqD2/Lrmx1q0yFVRiKc5INNRiLipOBAB4plovXgIAAA==
X-CMS-MailID: 20190207170116epcas2p1e0768a74062c8af83842ddb59309850f
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170116epcas2p1e0768a74062c8af83842ddb59309850f
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170116epcas2p1e0768a74062c8af83842ddb59309850f@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core clock is also common for both CPU DAIs so move it to
the driver's private data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b435e6226ec2..c2c3a3286c63 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -71,8 +71,6 @@ struct i2s_dai {
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
 	unsigned rfs, bfs;
-	/* I2S Controller's core clock */
-	struct clk *clk;
 	/* Clock for generating I2S signals */
 	struct clk *op_clk;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
@@ -117,6 +115,9 @@ struct samsung_i2s_priv {
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dais;
 
+	/* The I2S controller's core clock */
+	struct clk *clk;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -1205,6 +1206,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 #ifdef CONFIG_PM
 static int i2s_runtime_suspend(struct device *dev)
 {
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
 	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
@@ -1213,24 +1215,25 @@ static int i2s_runtime_suspend(struct device *dev)
 
 	if (i2s->op_clk)
 		clk_disable_unprepare(i2s->op_clk);
-	clk_disable_unprepare(i2s->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
 
 static int i2s_runtime_resume(struct device *dev)
 {
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
-	ret = clk_prepare_enable(i2s->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
 	if (i2s->op_clk) {
 		ret = clk_prepare_enable(i2s->op_clk);
 		if (ret) {
-			clk_disable_unprepare(i2s->clk);
+			clk_disable_unprepare(priv->clk);
 			return ret;
 		}
 	}
@@ -1428,13 +1431,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	regs_base = res->start;
 
-	pri_dai->clk = devm_clk_get(&pdev->dev, "iis");
-	if (IS_ERR(pri_dai->clk)) {
+	priv->clk = devm_clk_get(&pdev->dev, "iis");
+	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "Failed to get iis clock\n");
-		return PTR_ERR(pri_dai->clk);
+		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(pri_dai->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
 		return ret;
@@ -1472,7 +1475,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 		sec_dai->dma_playback.addr_width = 4;
 		sec_dai->addr = pri_dai->addr;
-		sec_dai->clk = pri_dai->clk;
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
@@ -1519,7 +1521,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
-	clk_disable_unprepare(pri_dai->clk);
+	clk_disable_unprepare(priv->clk);
 	i2s_delete_secondary_device(priv);
 	return ret;
 }
@@ -1527,7 +1529,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
-	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	if (!priv)
 		return 0;
@@ -1536,7 +1537,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	i2s_unregister_clock_provider(priv);
-	clk_disable_unprepare(pri_dai->clk);
+	clk_disable_unprepare(priv->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	i2s_delete_secondary_device(priv);
 
-- 
2.20.1

