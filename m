Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F222229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VtP0q9eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437878AbfBNJio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:44 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64843 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbfBNJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:41 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214093838epoutp02745750143189e226d93f4baa4861aa18~DMX8LPbDO1800018000epoutp02e;
        Thu, 14 Feb 2019 09:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214093838epoutp02745750143189e226d93f4baa4861aa18~DMX8LPbDO1800018000epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137118;
        bh=RiH3ahhVKOH75JYNzV0klrcfLZmbHDaDh+RWeur8M9c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=VtP0q9eAdnYD/Pr/74UrP6UVE1FUZhX2RzBPSFWIf0WC7YFSZ/ZNPJpbakVyk3Kkh
         ojkE9TmZBlp21yJM+sHFjtMHrKxp0kk2JKEvZWXXIAWYBb/Wcsc7VWs2/+dSd4cYd6
         /x73B1FZJMqvsoWcaDu3GAmDdvGednYknKWI4XDg=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093837epcas1p2b88c313fbee03c253182817d035cf98d~DMX7K2rXl2981829818epcas1p2R;
        Thu, 14 Feb 2019 09:38:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.C9.04206.D17356C5; Thu, 14 Feb 2019 18:38:37 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093836epcas1p36ff39d1a7ae59bf475256c6ae5c6171c~DMX6f0NQ-2145421454epcas1p3g;
        Thu, 14 Feb 2019 09:38:36 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-a8-5c65371df436
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 8A.F3.04015.C17356C5; Thu, 14 Feb
        2019 18:38:36 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:36 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 05/13] ASoC: samsung: i2s: Get rid of a static
 spinlock
Date:   Thu, 14 Feb 2019 10:37:39 +0100
Message-id: <20190214093747.2414-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCmvq6seWqMQfNUUYsrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK2PFjiOsBTNFK1Z0X2VtYDwq2MXIySEhYCKx5fUOti5GLg4hgR2M
        Egvf7WIDSQgJfGeU+HpDE6bo2utPUEUbGCXePH7CDOH8YpT4OHctWAebgKFE79E+RhBbREBM
        4vacTrAiZoGVjBJb9m0CKuLgEBYIlvi4MAKkhkVAVWLJ7D52EJtXwEriy55r7BDb5CVWbzjA
        DGJzClhLzNy0nRFkjoTABDaJNyeeMoLMkRBwkdi9xxrClJa4dNQWorVaYtf2bmaI8g5GiZYL
        25khEtYSh49fZAWxmQX4JN597WGF6OWV6GgTgijxkHi+eCIrxF99jBIz21+yTWCUWMDIsIpR
        LLWgODc9tdiwwFSvODG3uDQvXS85P3cTIzjGtCx3MB4753OIUYCDUYmHt0IoJUaINbGsuDL3
        EKMEB7OSCO9Fo9QYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzrHZxjhATSE0tSs1NTC1KLYLJM
        HJxSDYymU/pvHAz4wGMg2HQvI1F1XbK7Sofdq9YH7K8DzgTzV03ewxTYlfHvcnPamvIzIjkP
        Vxs+Yuza9sFu2ezJWxbkMhSJScveaHtwa6ngofe7+Y589CvdfMKQ44pFcdm/9YH3EkRlj91Y
        3xj07s03uc//t1zcoah/M/3J/d/GWV0rzG4Fcz77fn2KEktxRqKhFnNRcSIAmMk2Aq0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xoK6MeWqMwd1fihZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8aKHUdYC2aKVqzovsrawHhUsIuRk0NCwETi2utPbF2MXBxCAusY
        JU50LmSFcH4xSsy7vZQdpIpNwFCi92gfI4gtIiAmcXtOJzNIEbPASkaJI99XASU4OIQFgiU+
        LowAqWERUJVYMrsPrJdXwEriy55r7BDb5CVWbzjADGJzClhLzNy0HaxVCKhm3aHyCYw8CxgZ
        VjFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBAbRtsNafTsY7y+JP8QowMGoxMOrIJAS
        I8SaWFZcmXuIUYKDWUmE96JRaowQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1Kz
        U1MLUotgskwcnFINjExpP8Km+0pHmO4NCP7iNIVbMfeWQjrDx1d/pr+25zsmFfLSU4y5y26v
        64Y96592npPJ3+Gau9/24dke3Ui2zQ4FamEMSxb5vhT/au8ltU7x990pN2WdrhTxyZ12rFxX
        snA5w/RbXIfTXqn8Wb3F8JHY+TOTTs290//5wCGJfds5Ln4Sk2rrFlBiKc5INNRiLipOBACK
        SnYGHgIAAA==
X-CMS-MailID: 20190214093836epcas1p36ff39d1a7ae59bf475256c6ae5c6171c
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093836epcas1p36ff39d1a7ae59bf475256c6ae5c6171c
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093836epcas1p36ff39d1a7ae59bf475256c6ae5c6171c@epcas1p3.samsung.com>
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

