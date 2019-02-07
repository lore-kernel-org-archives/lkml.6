Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929AC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBFF21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AzGK8A7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfBGRBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10890 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBGRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:45 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170143epoutp0443f0e171e8fd152689cd827e505244aa~BI5zL1Nwa3094230942epoutp047;
        Thu,  7 Feb 2019 17:01:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170143epoutp0443f0e171e8fd152689cd827e505244aa~BI5zL1Nwa3094230942epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558903;
        bh=d2ZZc+KAorTY5urEQl6SCVVmJJZuh9QNvYlYv4J/q+w=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AzGK8A7G7svVQX8NuyRi793A6R6OCxMj2yuEdHFOHLFn3JJ7a3Br0Sf5I+tDPaFsg
         FSSuwStFziQsYpet4npIoKm8YyxToafqv8PW6DgSWXfGP+o5qT4/iwkBU4Z6gqRCSc
         0FeJ5Tgpahh+y8/e4Dhq/ZqyG2+hOhFpHJIHRIrE=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170142epcas1p2ef94647a292547ef4de33c67774aaa94~BI5y2cAQ01808618086epcas1p2r;
        Thu,  7 Feb 2019 17:01:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.C9.04173.6746C5C5; Fri,  8 Feb 2019 02:01:42 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170141epcas1p29a038bfd0df69df10e916ea8a695a85b~BI5x2HAHh1833218332epcas1p2n;
        Thu,  7 Feb 2019 17:01:41 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-40-5c5c64768445
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.D8.04015.5746C5C5; Fri,  8 Feb 2019 02:01:41 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:41 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 16/22] ASoC: samsung: i2s: Get rid of a static spinlock
Date:   Thu, 07 Feb 2019 18:00:24 +0100
Message-id: <20190207170028.720-17-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmnm5ZSkyMwZfzmhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MxTvPsRe8EKmY+kyzgXGmYBcjJ4eE
        gInEwd51bCC2kMAORolzf9y7GLmA7O+MEkuP72OHKfrRsoAdIrGbUeLGxiVQHb8YJe6cigSx
        2QQMJXqP9jGC2CICYhK353QygzQwC7QwScyZu5QZJCEs4C7Rfu0lC4jNIqAqcXVSC5jNK2Al
        0Xq1mRFim7zE+d51YJs5geK39u+AqhGU+DH5HpjNDFRz8MpzFpAFEgJ72CT2L7wA1ewi0dd7
        gLWLkQPIlpa4dNQWIlwtsWt7NzNEfQejRMuF7cwQCWuJw8cvskIM5ZN497UHqpdXoqNNCKLE
        Q2LWvu8sEN/3MkrcvPeadQKj1CwkN81CctMCRqZVjGKpBcW56anFhgVGesWJucWleel6yfm5
        mxjBEa5ltoNx0TmfQ4wCHIxKPLwaejExQqyJZcWVuYcYJTiYlUR4ZROAQrwpiZVVqUX58UWl
        OanFhxilOViUxHnXOzjHCAmkJ5akZqemFqQWwWSZODilGhhLZe3nqSs9nr/4DWP1yTU/+hqu
        Bx02tKueldn1QLvv48mrzAc3/uGJvnRHssm4/8v2K/9y+vr365ln+B4obu93rXJd9GbfaS4W
        lsoXcday06Qapr+1SEuatEScNb066nfzk1geTsFTF8Mvnn3t7fT9t8j9OTVmeyNs4wJrwyrv
        60WsU3FkSVNiKc5INNRiLipOBADB7Qj+7AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jAd3SlJgYg3Nv1SyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZi3eeYy94IVIx9ZlmA+NMwS5GTg4J
        AROJHy0L2LsYuTiEBHYySiw+cIEFJCEk8ItRom2dMYjNJmAo0Xu0jxHEFhEQk7g9p5MZpIFZ
        oIlJYtfti+wgCWEBd4n2ay/BmlkEVCWuTmoBs3kFrCRarzYzQmyTlzjfuw6snhMofmv/Dqhl
        lhIfJjSxQtQLSvyYfA8szgxUf/DKc5YJjHyzkKRmIUktYGRaxSiZWlCcm55bbFRgmJdarlec
        mFtcmpeul5yfu4kRGMLbDmv17WC8vyT+EKMAB6MSD+8F7ZgYIdbEsuLK3EOMEhzMSiK8sglA
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhiDpt/7lK/i
        cOOoKS+XWpzXY4NlC8/EzY/j8+3js6ie+WpRZMQRv5bKVXNn3DLocD3+31jxWFupxLLDQbVb
        zxle9mGaaNUqrie8fLFzw7Wj5nc+Zz45ZT4921Qyb1JWZdvtiQ+LDzw3Ly8LSL+kvT3oV1zs
        jVPXC1fO+rs68dSOoF5uub+Z28yUWIozEg21mIuKEwHrmE6fXQIAAA==
X-CMS-MailID: 20190207170141epcas1p29a038bfd0df69df10e916ea8a695a85b
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170141epcas1p29a038bfd0df69df10e916ea8a695a85b
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170141epcas1p29a038bfd0df69df10e916ea8a695a85b@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the spinlock serializing access to the primary/secondary
PCM a per I2S controller lock, rather than a global one. There is no need
to have a global lock across multiple I2S controllers in the SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e11d678e9c1f..9931d007bc13 100644
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

