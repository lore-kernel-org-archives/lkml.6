Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1A6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D221904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OXGanKvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfBGRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46815 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfBGRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207170125epoutp022c46b5860264d792d358be09dfcd0277~BI5ikhsU10594605946epoutp02D;
        Thu,  7 Feb 2019 17:01:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207170125epoutp022c46b5860264d792d358be09dfcd0277~BI5ikhsU10594605946epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558885;
        bh=fCsdwjdNwG9u/naWrmAr0rLFX67hfSlTmvz4bZJA2H0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=OXGanKvtEcKYtM1vetFWB8Lcz4Z4Ao8zZOhZCND1gQN19kOY/SdVoDpDp3WmfdOl1
         pj/dggusxQJ/7hGYN+Up2OliZll86TBbtdV5Nkq7Ey3vrX8Wo15ZLBnEUcpjS/aDac
         LsNeueKa2A0aXmZtjKzqin69SAfCarcX2wNT0CnA=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170124epcas1p2c6d3458a4383f543aa3bedde9c51f3f9~BI5ht8YOd3249332493epcas1p2I;
        Thu,  7 Feb 2019 17:01:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.B3.04074.4646C5C5; Fri,  8 Feb 2019 02:01:24 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170123epcas1p2fae464ba7f102d841548c5a523cc6660~BI5hQr89z1282112821epcas1p2_;
        Thu,  7 Feb 2019 17:01:23 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-6c-5c5c6464881e
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.C8.04015.3646C5C5; Fri,  8 Feb 2019 02:01:23 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:23 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 11/22] ASoC: samsung: i2s: Move registers cache to common
 driver data structure
Date:   Thu, 07 Feb 2019 18:00:19 +0100
Message-id: <20190207170028.720-12-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmvm5KSkyMQd9ZQYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG+3c3WAquCFacPdnE3MB4g6+LkYND
        QsBEYuL+3C5GLg4hgR2MEr/vvWSHcL4zSkxY/IS5i5ETrOjFhFY2iMRuRomHja1MEM4vRonJ
        dx8ygVSxCRhK9B7tYwSxRQTEJG7P6WQGKWIWaGGSmDN3KdgoYYFEieNX14HZLAKqEluXHGEH
        sXkFrCSuXNjKBLFOXuJ87zqwOCdQ/Nb+HSwQNYISPybfA7OZgWoOXnnOArJAQuAAm8SGMx2M
        EM0uEns3n2CGeE5a4tJRW4hwtcSu7d3MEPUdjBItF7ZD/WYtcfj4RVaIoXwS7772sEL08kp0
        tAlBlHhILL/znBXi415Gib8PutknMErNQnLTLCQ3LWBkWsUollpQnJueWmxYYKhXnJhbXJqX
        rpecn7uJERzlWqY7GKec8znEKMDBqMTDq6EXEyPEmlhWXJl7iFGCg1lJhFc2ASjEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcd72Dc4yQQHpiSWp2ampBahFMlomDU6qB0WoBX+jTw5d/nd6kZMya
        5Gwky3Jr2RO5lGerp9xZeOdMgnl3+Cm3PXeNHjv1rAm4P/s+T3/k1ftfZx1vqdqnl+x7Z++L
        tKITK5YZ7ZxTL9GtnV/j+C/yYiKjx8WKsvkTHTrWvdqudTj3EfdH/dzjbJ/3fG5P1bGfOUPv
        v4K6xFb3AunuQ13ndyqxFGckGmoxFxUnAgD/xWyf7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd3klJgYg1uzDC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ79/dYCm4Ilhx9mQTcwPjDb4uRk4O
        CQETiRcTWtm6GLk4hAR2MkqcXr4IyvnFKLHu4lkWkCo2AUOJ3qN9jCC2iICYxO05ncwgRcwC
        TUwSu25fZAdJCAskShy/uo4ZxGYRUJXYuuQIWJxXwEriyoWtTBDr5CXO964Di3MCxW/t3wG2
        QEjAUuLDhCZWiHpBiR+T74HFmYHqD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECw3jbYa2+HYz3l8QfYhTgYFTi4b2gHRMjxJpYVlyZe4hRgoNZSYRX
        NgEoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA2P1Va/Z
        Ci+8JQ7JXWnN+Pnyn9ElQTPrdxs3Gyy9fXZ+wfvHpiUtfFzdD6UjmE8t/23eb3Rl1vS58Vf2
        +RueeS4ozPnobvOhn+cq15l7a2olKd3UUHrlLcUfXKw9q/lU1Y6W9U8a+v+znekJq7HUn3hn
        stnxn80TRFz9uQ8J7Sw7nThby9eBoUiJpTgj0VCLuag4EQA/uj/yXwIAAA==
X-CMS-MailID: 20190207170123epcas1p2fae464ba7f102d841548c5a523cc6660
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170123epcas1p2fae464ba7f102d841548c5a523cc6660
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170123epcas1p2fae464ba7f102d841548c5a523cc6660@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep the PM suspend/resume register cache separate
for each DAI as those registers are common, move related i2s_dai data
structure to the driver's common data structure.  This will allow us
to simplify the code a little eventually and to make it easier to follow.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b7b28813645a..b0913cc488ab 100644
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

