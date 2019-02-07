Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F8C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709D421872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZMy46Anv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfBGRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:05 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32013 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfBGRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:02 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170059epoutp0324555212c5b5a8791511f30bbb26779c~BI5K7Hotd2488224882epoutp03d;
        Thu,  7 Feb 2019 17:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170059epoutp0324555212c5b5a8791511f30bbb26779c~BI5K7Hotd2488224882epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558859;
        bh=z+2XzIlWDYBCqalO/VoQ/cstpDjX/5UQBwVI2/feHn4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ZMy46AnvkxqEsjzsh2EXA9cnxnmKkhSU7gTKXl4lUNHO/eNNLV6tbo3hPkgpqBdtW
         18d1NKX9G+oRQyLuh75ZlpwH8xXKHP+IEt1fYCLK3waSQD4xR6V7hDG2wVRJKzU5Qs
         hC+XPLU0c3OwO8zvazNjdiSmjSNOjVgjIM8AoDBE=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170059epcas1p1ebfe29d0f3a0aa360595f54dcf68a488~BI5KsTfb71074510745epcas1p1M;
        Thu,  7 Feb 2019 17:00:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.AE.04206.B446C5C5; Fri,  8 Feb 2019 02:00:59 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb~BI5JmBIF12153821538epcas1p4f;
        Thu,  7 Feb 2019 17:00:58 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-48-5c5c644b7751
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.C8.04015.A446C5C5; Fri,  8 Feb 2019 02:00:58 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:00:58 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 04/22] ASoC: samsung: i2s: Fix prescaler setting for the
 secondary DAI
Date:   Thu, 07 Feb 2019 18:00:12 +0100
Message-id: <20190207170028.720-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmrq53SkyMQd89NYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAldGy8F5jAUb+SoOX+xjbmB8wN3FyMkh
        IWAi0XCji7GLkYtDSGAHo8TZH2dYIZzvjBLf715mham6uXcDO0RiN6PE4fkPWSCcX4wSk1p3
        sIFUsQkYSvQe7WMEsUUExCRuz+lkBiliFmhhkpgzdymQw8EhLBAh8eiTDUgNi4CqxIc/fewg
        Nq+ApUTroQmMENvkJc73rgOLcwpYSdzav4MFokZQ4sfke2A2M1DNwSvPwY6QEDjAJnHzynwW
        iGYXidUv97KB7JIQkJa4dNQWIlwtsWt7NzNEfQejRMuF7cwQCWuJw8cvskIM5ZN497WHFaKX
        V6KjTQiixENiaetaaLD0MkqsPTqTbQKj1CwkN81CctMCRqZVjGKpBcW56anFhgWmesWJucWl
        eel6yfm5mxjBUa5luYPx2DmfQ4wCHIxKPLwXtGNihFgTy4orcw8xSnAwK4nwyiYAhXhTEiur
        Uovy44tKc1KLDzFKc7AoifOud3COERJITyxJzU5NLUgtgskycXBKNTAu9DTvVv8irGt49BfP
        TDeBH9uy7n9yW1TZarGmyGYRY45LyKNIpZwVaydrRM2Mqlvgtecc/8lPd+6+eC0duUyd55cO
        78L9tzZ86JQPNLh7MLVALHFFiYnbo0iP37fP79wXsfUV11n++bL/QxzEyoq949vfb7qZ0J+9
        ZPYP0ydxP5cet700LWWXEktxRqKhFnNRcSIAj/2dte4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAV2vlJgYg5n/JS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZLQfnMRZs5Ks4fLGPuYHxAXcXIyeH
        hICJxM29G9i7GLk4hAR2MkrsejqHEcL5xShxvXMVG0gVm4ChRO/RPkYQW0RATOL2nE5mkCJm
        gSYmiV23LwK1c3AIC0RIPPpkA1LDIqAq8eFPHzuIzStgKdF6aAIjxDZ5ifO968DinAJWErf2
        72ABsYWAaj5MaGKFqBeU+DH5HlicGaj+4JXnLBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYqMAw
        L7Vcrzgxt7g0L10vOT93EyMwiLcd1urbwXh/SfwhRgEORiUe3gvaMTFCrIllxZW5hxglOJiV
        RHhlE4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1MGau
        fO+vbS37ge3A3MeqGrd4vW8uCHG9LbsoJsVtFdeuogbuCZfbDmdoXlNN/rg15XlLGrfkvoTl
        c5y0M39r9N4V/l8Q9/y6W5Th5a2V+gbr98/7rG345ds+ORkOEyXhun1ZGRqf/x842f1p6kGz
        U09Xsd2s892eojSl5bO67twW1xQ+c4NAByWW4oxEQy3mouJEALqrpDJeAgAA
X-CMS-MailID: 20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure i2s->rclk_srcrate is properly initialized also during
playback through the secondary DAI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9d3dcb2204fe..d5ddad23d5e5 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -604,6 +604,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	unsigned int fmt)
 {
 	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = get_other_dai(i2s);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 mod, tmp = 0;
 	unsigned long flags;
@@ -661,7 +662,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
 		 * clock configuration assigned in DT is not overwritten.
 		 */
-		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL &&
+		    other->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -699,6 +701,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = get_other_dai(i2s);
 	u32 mod, mask = 0, val = 0;
 	struct clk *rclksrc;
 	unsigned long flags;
@@ -784,6 +787,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	i2s->frmclk = params_rate(params);
 
 	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+	if (!rclksrc || IS_ERR(rclksrc))
+		rclksrc = other->clk_table[CLK_I2S_RCLK_SRC];
+
 	if (rclksrc && !IS_ERR(rclksrc))
 		i2s->rclk_srcrate = clk_get_rate(rclksrc);
 
-- 
2.20.1

