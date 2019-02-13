Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11212C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214420811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KWXay685"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405855AbfBMSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10375 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405808AbfBMSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:16 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190213184312epoutp03b28fa698e7afdcfc740c291105935d67~DAKIZZAQP1818718187epoutp031;
        Wed, 13 Feb 2019 18:43:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190213184312epoutp03b28fa698e7afdcfc740c291105935d67~DAKIZZAQP1818718187epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083393;
        bh=RiH3ahhVKOH75JYNzV0klrcfLZmbHDaDh+RWeur8M9c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=KWXay685eyDIBsrBNDrxb/P1kjKYSHhvMLjAThJixLdkm9yon179KeqJQR+ji3rT5
         bNYrliNH7zY9lk0kmmeaDE1zWMQRNRIuDPeliMaKkv2qVdNJagjRV8B5ePMCiMiqDL
         hA0c/v9px+5eYimETKaAxtPJxBkzKQ/7qC/I3GFE=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184311epcas2p379b5719941923faabb38978d93ca9637~DAKHKjAl60253402534epcas2p3t;
        Wed, 13 Feb 2019 18:43:11 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.3E.04093.F35646C5; Thu, 14 Feb 2019 03:43:11 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213184310epcas2p239500afce801a9828da360fef41bb886~DAKF_I07x2251322513epcas2p2c;
        Wed, 13 Feb 2019 18:43:10 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-4a-5c64653fd209
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B6.ED.03689.E35646C5; Thu, 14 Feb
        2019 03:43:10 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:10 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 05/13] ASoC: samsung: i2s: Get rid of a static spinlock
Date:   Wed, 13 Feb 2019 19:42:04 +0100
Message-id: <20190213184212.5473-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmma59akqMQfMbBYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGih1HWAtmilas6L7K2sB4VLCLkZND
        QsBEovHORbYuRi4OIYEdjBLrn+xghHC+M0rc/NfKBFN1YecLqMQGRonz66cwQTi/GCXaryxg
        BqliEzCU6D3axwhiiwiISdye08kMUsQs0MIkMWfuUiCHg0NYwEvicpsPSA2LgKrE1rlPwDbw
        ClhJzF+0ghFim7zE6g0HwGZyClhL/Fv7nB1kjoTAEjaJCde7oE5ykTj99wQ7hC0t8WzVRqjm
        aold27uZIRo6GCVaLmxnhkhYSxw+fpEVxGYW4JPoOPyXHeQgCQFeiY42IQjTQ2L9d2+QCiGB
        PkaJaa+YJjBKLGBkWMUollpQnJueWmxUYKJXnJhbXJqXrpecn7uJERyDWh47GA+c8znEKMDB
        qMTDWyGUEiPEmlhWXJl7iFGCg1lJhFcvCijEm5JYWZValB9fVJqTWnyIUZqDRUmc96H03Ggh
        gfTEktTs1NSC1CKYLBMHp1QDI0OaX/DyQyaPsy7vu3Wu+EfxmeNHUu8y+vc2lZrmOwlP/W2x
        XHSjz4Q/L83db957xctkm1QWYLpugTL35Bd/Az0D4v3+8htfvqURIlrGK36irm7xXm2pXafs
        53945+k1SfLI55BmnwAe66MvXE5f5n3QyNrjlfUh59yVlJL6HQv5vsu+iWl/pMRSnJFoqMVc
        VJwIAFvOwxu9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQV271JQYgy8bhCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZK3YcYS2YKVqxovsqawPjUcEuRk4O
        CQETiQs7XzB2MXJxCAmsY5RYfGMvK4Tzi1Hiwquz7CBVbAKGEr1H+xhBbBEBMYnbczqZQYqY
        BZqYJHbdvghUxMEhLOAlcbnNB6SGRUBVYuvcJ0wgNq+AlcT8RSsYIbbJS6zecIAZxOYUsJb4
        t/Y52HwhoJqJHy4xT2DkWcDIsIpRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzDIth3W
        6t/B+HhJ/CFGAQ5GJR7eCqGUGCHWxLLiytxDjBIczEoivHpRQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8/PnHIoUE0hNLUrNTUwtSi2CyTBycUg2Ms4W+LBKpOsHuVLw4N/+10+uvd+7632vZ
        MuXpkg28q+5fYmTb9m0J58kPnQ4qYdzZWT4ub5b0TxSYUZDoPu/8Z5dez6m+xzl/bFeYsdd+
        iaLNT17Zx/yvegKX5h5Kq6g2YvwSIWSunzgtcM9E5WMnEy/sSnO41uTbm79oW/iK3Vtbw3Rv
        hr1crsRSnJFoqMVcVJwIAKz9OTguAgAA
X-CMS-MailID: 20190213184310epcas2p239500afce801a9828da360fef41bb886
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184310epcas2p239500afce801a9828da360fef41bb886
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184310epcas2p239500afce801a9828da360fef41bb886@epcas2p2.samsung.com>
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
index 8f0af4b0f25a..692a752b194c 100644
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
2.17.1

