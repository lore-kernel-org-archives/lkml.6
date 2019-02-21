Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4157FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0755E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GihyNa4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBUJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31143 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfBUJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:58 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190221094256epoutp017d38179c66a02182d6bd6adc123fefc9~FV8sBJwuH0683806838epoutp01i;
        Thu, 21 Feb 2019 09:42:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190221094256epoutp017d38179c66a02182d6bd6adc123fefc9~FV8sBJwuH0683806838epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550742176;
        bh=YP9KvWTI9A4be0gsg1SEl41NIWxvoRMvktLdJnx2Ezc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GihyNa4YrO1zfk81widVocipRlmBjh7fCSdQBPKI+EPdCGVvPaGUecW+SzP8IHMii
         X6OFLMxT5ylB7cnIPj+ka+lpIGPMLOaZGEUfurdikq+PAfTvEJ7rHmCviRGIag1GTB
         thI22FtJNKHRV0d9aDfC6VXzD3yrNS6gRAAdLuQE=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190221094255epcas1p3a6d873cb0d73289f6f788ef4dc259975~FV8ruXX8x1776117761epcas1p3k;
        Thu, 21 Feb 2019 09:42:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.27.04074.F927E6C5; Thu, 21 Feb 2019 18:42:55 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190221094255epcas1p434e428e3470a8ae9963e8acd3e0c7532~FV8rB3so42236922369epcas1p4E;
        Thu, 21 Feb 2019 09:42:55 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-3a-5c6e729fb7f9
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.A8.04015.E927E6C5; Thu, 21 Feb 2019 18:42:55 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PN900LKXSAV4D80@mmp1.samsung.com>; Thu, 21 Feb 2019
        18:42:53 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Prevent uninitialized variable use
Date:   Thu, 21 Feb 2019 10:42:28 +0100
Message-id: <20190221094228.3778-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmvu78orwYg+8duhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8WM8/uYLA6/aWe1uLjiC5MDh8eGz01sHjtn3WX32LSqk82jb8sq
        Ro/Pm+QCWKO4bFJSczLLUov07RK4Mn7tecZYMJG7om3vd7YGximcXYycHBICJhIH5u5m7mLk
        4hAS2MEo8WvmWkYI5zujxP+7z5hhqjac2QKV2M0o8a7lJDtIgldAUOLH5HssXYwcHMwC8hJH
        LmWDhJkFNCW27l7PDlH/i1Hi663nTCAJNgFDid6jfYwgtoiAtsScmx1sIEXMAtsZJZZu+88C
        khAW8JI4/PAiWAOLgKrEj1tn2SCWWUn8vPaRFeIieYnVGw6A3S0hsIVNYuPNpVCnukhcXDuN
        FeQiCQFpiUtHbSHC1RK7tndD1XcwSrRc2A5Vby1x+PhFVoiz+STefe2B6uWV6GgTgijxkPjZ
        +x2sXEggVmLGvT3sExilZiH5fxbC/7OQ/L+AkXkVo1hqQXFuemqxYYGhXnFibnFpXrpecn7u
        JkZwlGuZ7mCccs7nEKMAB6MSD++GiNwYIdbEsuLK3EOMEhzMSiK8Xpl5MUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR51zs4xwgJpCeWpGanphakFsFkmTg4pRoYRa7VP87eIuB8rMLqwOt53j8c
        2Nf+zNqS6cCXI9vxzvgnh51a97L0gNUro78myvOzth3iC7M/KdMTME9+n+HDr1dK3K4qb372
        /rbOxks9oQYCi+LWMakwSYrX8fypLEqrvdWZ9q7C+DvzcoFNZo8nz/t+andSVsG5eXYG0R+n
        pl/KtjzB6D1biaU4I9FQi7moOBEAsgt6z+4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t9jAd35RXkxBjM7GC2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNosZ5/cxWRx+085qcXHFFyYHDo8Nn5vYPHbOusvusWlVJ5tH35ZV
        jB6fN8kFsEZx2aSk5mSWpRbp2yVwZfza84yxYCJ3Rdve72wNjFM4uxg5OSQETCQ2nNnC2MXI
        xSEksJNR4mTbVSaQBK+AoMSPyfdYuhg5OJgF5CWOXMoGCTMLqEtMmreIGcQWEvjFKPFrcjWI
        zSZgKNF7tI8RxBYR0JaYc7ODDWQms8B2RombC96ANQgLeEkcfngRbD6LgKrEj1tn2SB2WUn8
        vPaRFeIgeYnVGw4wT2DknYXkjFkIZ8xCcsYCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6
        yfm5mxiBwbrtsFbfDsb7S+IPMQpwMCrx8HJE58YIsSaWFVfmHmKU4GBWEuH1ysyLEeJNSays
        Si3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoExOy/LSHSfRmfWhbQp
        b06tDkhg4pDdYHBSaTlPGP+WINcSx0UvspQ3fzqk+6r7rklGyvwnn859Ld5+br9W5PzeG3uY
        q51NNL01vkb9sWU+HuR5Od75wVZlj90HnVVCjsR298Q/8hQ7Lh9e4vlum6vNrxN+JeZ//e9r
        z/76PZD3cavH+nlGRe+UWIozEg21mIuKEwEb6SjSUgIAAA==
X-CMS-MailID: 20190221094255epcas1p434e428e3470a8ae9963e8acd3e0c7532
CMS-TYPE: 101P
X-CMS-RootMailID: 20190221094255epcas1p434e428e3470a8ae9963e8acd3e0c7532
References: <CGME20190221094255epcas1p434e428e3470a8ae9963e8acd3e0c7532@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses an issue pointed out by compiler warning:

sound/soc/samsung/odroid.c: In function ‘odroid_audio_probe’:
sound/soc/samsung/odroid.c:298:22: warning: ‘cpu_dai’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/odroid.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index c3b0f6c612cb..694512f980fd 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -194,7 +194,8 @@ static struct snd_soc_dai_link odroid_card_dais[] = {
 static int odroid_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *cpu, *cpu_dai, *codec;
+	struct device_node *cpu_dai = NULL;
+	struct device_node *cpu, *codec;
 	struct odroid_priv *priv;
 	struct snd_soc_card *card;
 	struct snd_soc_dai_link *link, *codec_link;
@@ -271,8 +272,11 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		if (ret < 0)
 			break;
 	}
-	if (ret == 0)
+	if (ret == 0) {
 		cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!cpu_dai)
+			ret = -EINVAL;
+	}
 
 	of_node_put(cpu);
 	of_node_put(codec);
-- 
2.17.1

