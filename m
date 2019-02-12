Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8362229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kd6jRrxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfBLSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:06 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:44131 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbfBLSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:03 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190212180501epoutp04f1e4bf38b5f7072786c67c508800fa59~Cr-fooQNT2257622576epoutp04r;
        Tue, 12 Feb 2019 18:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190212180501epoutp04f1e4bf38b5f7072786c67c508800fa59~Cr-fooQNT2257622576epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994701;
        bh=VLiyEtP9myrodprY+LqJ/odGrX0oLgdq+HoVSWlG+UA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=kd6jRrxGicPWVXP+HJ5ZbEo7JxWsmbvA+rwkv8cjUCIHOlIvDDkXPgvM+JEiap72B
         bmbe/1tPFqu90xNMi5/VDCB7f9SEXQjHC76qTaf2gIbkrUFV1kqs1XmXToaZcfKlgI
         i1QPBZdsIKGaDKf8gruXKRW1ctbZR5ZLAbQyW0OQ=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180500epcas2p17be266806f2ddfcf72783c6f3494d7d9~Cr-evhjy71625716257epcas2p1B;
        Tue, 12 Feb 2019 18:05:00 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.4C.04136.BCA036C5; Wed, 13 Feb 2019 03:04:59 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180459epcas2p2b5f273e37ab86a26bd7292bbcb557aa1~Cr-eXq7pa2848628486epcas2p2M;
        Tue, 12 Feb 2019 18:04:59 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-67-5c630acb14fe
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 38.30.03689.BCA036C5; Wed, 13 Feb
        2019 03:04:59 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:59 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 06/21] ASoC: samsung: i2s: Move registers cache to common
 driver data structure
Date:   Tue, 12 Feb 2019 19:03:27 +0100
Message-id: <20190212180342.32040-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmme5pruQYg1W/rC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZC37+YCtoFapYN+cTSwNjC38XIyeH
        hICJxMLZN9m7GLk4hAR2MEpsXTeFGcL5ziixu/kbG0zVw127GSESGxglTj9bwgSSEBL4xSjx
        8ngdiM0mYCjRe7SPEcQWERCTuD2nE2wSs0ALk8ScuUuZQRLCAikS1xu/gDWzCKhK7Fq7mR3E
        5hWwlrj4oIcRYpu8xPnedWBxTgEbiWcLv7FA1AhK/Jh8D8xmBqo5eOU5C8gCCYEjbBIPe9pY
        IJpdJN7eXc0EYUtLPFu1EWpotcSu7d3MEA0djBItF7YzQySsJQ4fv8gKMZVPouPwX6DNHEBx
        XomONiGIEg+JkzdmQAOpn1Gis20W+wRGqVlIjpqF5KgFjEyrGMVSC4pz01OLjQqM9IoTc4tL
        89L1kvNzNzGC41zLbQfjknM+hxgFOBiVeHhXHE2KEWJNLCuuzD3EKMHBrCTCm8acHCPEm5JY
        WZValB9fVJqTWnyIUZqDRUmc96H03GghgfTEktTs1NSC1CKYLBMHp1QDo8abNz4idd8yws97
        i04Pr/Lj+CGQvU9/R/llxYIFpX/nXbKXEbltI2rw2sT9lf9LrRKxtuD9z3vzV3JuL7h/49DU
        QwVtuvyC7Kqi77Xy089czbr1N/jG7cs558LNzqf1/mb/kSS4hl3Y/av/8d5ni+31PiW7WUtZ
        /p64bunGqYypc87vPCBTpsRSnJFoqMVcVJwIAKS/g/PvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd3TXMkxBnfPq1pcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyFvz8wVbQKlSxbs4nlgbGFv4uRk4O
        CQETiYe7djN2MXJxCAmsY5T4+vkzC4Tzi1Fi8vsLzCBVbAKGEr1H+xhBbBEBMYnbczqZQYqY
        BZqYJHbdvsgOkhAWSJG43viFCcRmEVCV2LV2M1icV8Ba4uKDHkaIdfIS53vXgcU5BWwkni38
        BrSNA2ibtcSVTbYQ5YISPybfYwGxmYHKD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQqM
        8lLL9YoTc4tL89L1kvNzNzECg3jbYa3+HYyPl8QfYhTgYFTi4V1xNClGiDWxrLgy9xCjBAez
        kghvGnNyjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQZG
        JueDDlNbvlfyVpgW/or7fbx7N8uGqD17E9wlJhmeU3iafO7ZRnaxNx151e11vz/KTtgRuibt
        9K3zSpNn/p+xcqVqfKNLRvHp79sOvhFmvepf+VyQ7866Hb/3/VKbtirlt/+cA6vkHrWpJJ2Z
        et5f8V7WzWtZC4Rn9iwusnCfMkNuvriJaOOh/UosxRmJhlrMRcWJAISkEpxeAgAA
X-CMS-MailID: 20190212180459epcas2p2b5f273e37ab86a26bd7292bbcb557aa1
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180459epcas2p2b5f273e37ab86a26bd7292bbcb557aa1
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180459epcas2p2b5f273e37ab86a26bd7292bbcb557aa1@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep the PM suspend/resume register cache separate
for each DAI as those registers are common, move related i2s_dai data
structure to the driver's common data structure.  This will allow us
to simplify the code a little eventually and to make it easier to follow.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d8414d781f83..72f0cb7abb30 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -86,9 +86,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
 	u32	quirks;
-	u32	suspend_i2smod;
-	u32	suspend_i2scon;
-	u32	suspend_i2spsr;
 	const struct samsung_i2s_variant_regs *variant_regs;
 
 	spinlock_t *lock;
@@ -120,6 +117,11 @@ struct samsung_i2s_priv {
 	/* Rate of RCLK source clock */
 	unsigned long rclk_srcrate;
 
+	/* Cache of selected I2S registers for system suspend */
+	u32 suspend_i2smod;
+	u32 suspend_i2scon;
+	u32 suspend_i2spsr;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -1205,9 +1207,9 @@ static int i2s_runtime_suspend(struct device *dev)
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
-	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
-	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
-	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
+	priv->suspend_i2smod = readl(i2s->addr + I2SMOD);
+	priv->suspend_i2scon = readl(i2s->addr + I2SCON);
+	priv->suspend_i2spsr = readl(i2s->addr + I2SPSR);
 
 	if (priv->op_clk)
 		clk_disable_unprepare(priv->op_clk);
@@ -1234,9 +1236,9 @@ static int i2s_runtime_resume(struct device *dev)
 		}
 	}
 
-	writel(i2s->suspend_i2scon, i2s->addr + I2SCON);
-	writel(i2s->suspend_i2smod, i2s->addr + I2SMOD);
-	writel(i2s->suspend_i2spsr, i2s->addr + I2SPSR);
+	writel(priv->suspend_i2scon, i2s->addr + I2SCON);
+	writel(priv->suspend_i2smod, i2s->addr + I2SMOD);
+	writel(priv->suspend_i2spsr, i2s->addr + I2SPSR);
 
 	return 0;
 }
-- 
2.20.1

