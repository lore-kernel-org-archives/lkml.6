Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF00222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qldPeRl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfBLSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59203 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBLSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:20 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180518epoutp03283913f092220bbb7d312e12e97de507~Cr-vjnX6H2783327833epoutp03d;
        Tue, 12 Feb 2019 18:05:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180518epoutp03283913f092220bbb7d312e12e97de507~Cr-vjnX6H2783327833epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994718;
        bh=yr7j0mmEfQdXsLpTVDz398hU2ekDJIDFpZ+QayW8Sio=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qldPeRl/GSegp/9cbn1o9TZ5QhCHHSGsyi8Cvo9s5xIc55DCPrVyxoSEBhKxwfS1x
         d35SlSh5zG/C07zpMt15q4MOQ3G4A/qw4oTwilqh97/qiW7Hrtv6Hg5Y4oew9JQBdp
         k9tzKQ9H/XsHFpZqOBFgWMkE40Sa7znPdJL6Evzk=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180517epcas1p1a40a2b521e3030df6513347272dff799~Cr-vPFFoG0083500835epcas1p1E;
        Tue, 12 Feb 2019 18:05:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.FC.04173.DDA036C5; Wed, 13 Feb 2019 03:05:17 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180517epcas1p1fdb94e96f06b23dca66d63b3559f6c0b~Cr-u8vO9i1881518815epcas1p1Q;
        Tue, 12 Feb 2019 18:05:17 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-32-5c630add4463
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 04.11.04015.DDA036C5; Wed, 13 Feb
        2019 03:05:17 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:17 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 11/21] ASoC: samsung: i2s: Get rid of a static spinlock
Date:   Tue, 12 Feb 2019 19:03:32 +0100
Message-id: <20190212180342.32040-12-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmge5druQYg58dWhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mha2OBTNFK5pnbWBpYDwq2MXIySEh
        YCLx6uglti5GLg4hgR2MEmsmr2OCcL4zSux+/IcFpqr74SOoqg2MEjdfHINyfjFKXF7WwghS
        xSZgKNF7tA/MFhEQk7g9p5MZpIhZoIVJYs7cpcwgCWEBL4m9S3axg9gsAqoSN5a8BGvgFbCR
        eHX7BzPEOnmJ873rwGo4geLPFn5jgagRlPgx+R6YzQxUc/DKcxaQBRICR9gkFp1+AdTMAeS4
        SCxd7Q9hSktcOmoLMbJaYtf2bmaI8g5GiZYL26F2WUscPn6RFWImn8S7rz2sEL28Eh1tQhAl
        HhIvH+9hgXi4n1Hi9usLTBMYpWYhOWkWkpMWMDKtYhRLLSjOTU8tNiww0itOzC0uzUvXS87P
        3cQIjnEtsx2Mi875HGIU4GBU4uFdcTQpRog1say4MvcQowQHs5IIbxpzcowQb0piZVVqUX58
        UWlOavEhRmkOFiVx3vUOzjFCAumJJanZqakFqUUwWSYOTqkGRsGHER038piS9i3nZFe6GWw1
        /+vJK2/1b5xV2zZjQqrxou/7Vgm59F96knxw576Ds91r5jjG9bLtfbVZaG7yjxeut76d+rJV
        1/Ll8aap20qMPc4XiHakdHCzXju4cb78xT3zvMpWNDXenH1ivyfjLz35lt0qHh81cip2xF+6
        yMn2o/gfW6CjU6ASS3FGoqEWc1FxIgBFMFFG7QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd27XMkxBh8WSltcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyFrY6FswUrWietYGlgfGoYBcjJ4eE
        gIlE98NHbF2MXBxCAusYJY4e+8AE4fxilNj/bAcjSBWbgKFE79E+MFtEQEzi9pxOZpAiZoEm
        Joldty+ygySEBbwk9i7ZBWazCKhK3FjyEqyBV8BG4tXtH8wQ6+QlzveuA6vhBIo/W/iNpYuR
        A2ibtcSVTbYQ5YISPybfYwGxmYHKD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECQ3jbYa2+HYz3l8QfYhTgYFTi4V1xNClGiDWxrLgy9xCjBAezkghv
        GnNyjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2CyTBycUg2MabxO
        Vfs/R27+cPRTO9fW3vkGv6K3r3q+vXDBgq1bTsYffXzMMEPl7+7r69JfaZ3Y+iFz9/1jk280
        PLd5s+D7gpOn5jnkvmrbYK9ms9L/pp+X0v8dB+o7XzwvWzfzbfufQ0KSaYY3UrYdXqmvHc35
        OD3zU428h9qH7/pvnudNy5hcaM28VMDIX0uJpTgj0VCLuag4EQCZxqENXQIAAA==
X-CMS-MailID: 20190212180517epcas1p1fdb94e96f06b23dca66d63b3559f6c0b
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180517epcas1p1fdb94e96f06b23dca66d63b3559f6c0b
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180517epcas1p1fdb94e96f06b23dca66d63b3559f6c0b@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the spinlock serializing access to the primary/secondary
PCM a per I2S controller lock, rather than a global one. There is no need
to have a global lock across multiple I2S controllers in the SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 14d9fd658cfd..1156d63ce923 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -88,9 +88,6 @@ struct i2s_dai {
 	struct samsung_i2s_priv *priv;
 };
 
-/* Lock for cross i/f checks */
-static DEFINE_SPINLOCK(lock);
-
 struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
@@ -101,6 +98,9 @@ struct samsung_i2s_priv {
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t lock;
 
+	/* Lock for cross i/f checks */
+	spinlock_t pcm_lock;
+
 	/* CPU DAIs and their corresponding drivers */
 	struct i2s_dai *dai;
 	struct snd_soc_dai_driver *dai_drv;
@@ -832,7 +832,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 
 	pm_runtime_get_sync(dai->dev);
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&priv->pcm_lock, flags);
 
 	i2s->mode |= DAI_OPENED;
 
@@ -844,7 +844,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	if (!any_active(i2s) && (priv->quirks & QUIRK_NEED_RSTCLR))
 		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
-	spin_unlock_irqrestore(&lock, flags);
+	spin_unlock_irqrestore(&priv->pcm_lock, flags);
 
 	return 0;
 }
@@ -852,11 +852,12 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&priv->pcm_lock, flags);
 
 	i2s->mode &= ~DAI_OPENED;
 	i2s->mode &= ~DAI_MANAGER;
@@ -868,7 +869,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 
-	spin_unlock_irqrestore(&lock, flags);
+	spin_unlock_irqrestore(&priv->pcm_lock, flags);
 
 	pm_runtime_put(dai->dev);
 }
@@ -1406,6 +1407,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
 
 	spin_lock_init(&priv->lock);
+	spin_lock_init(&priv->pcm_lock);
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
-- 
2.20.1

