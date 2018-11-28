Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F96BC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B4206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ssx41Wij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1B4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeK2Cek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:34:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41089 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2Cej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:34:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181128153235euoutp026199417e259d264ba28855ecc9c6091a~rU4tvZi5E2386823868euoutp02j
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:32:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181128153235euoutp026199417e259d264ba28855ecc9c6091a~rU4tvZi5E2386823868euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543419155;
        bh=bG+eXSgqOEq+2CgtyyiU+MDO0vGklIiPQGnS7BenaTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssx41WijAbhBxD8Q925Qz/gRW63DK96P1Vk4/cx+YP6QVL58XZkQpspJ/+JosbgUS
         55g/vw95kNJ4/+BIPd+N/t1TA3ID2QFvdSkx9xJnobMJegELSH2AwkrZQXMiFGkK6+
         rxAaG4/nhOJNlTa3ccTNF6Nl6J2AzawqJ6yiWNJY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181128153234eucas1p1de2ec58cbc1ff06b575b22315f21feb8~rU4sv3c9R3210632106eucas1p1H;
        Wed, 28 Nov 2018 15:32:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.A7.04441.215BEFB5; Wed, 28
        Nov 2018 15:32:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181128153233eucas1p2e5224bacb69616fdd794751593dc1629~rU4r6gjjr0556805568eucas1p21;
        Wed, 28 Nov 2018 15:32:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181128153233eusmtrp13c012efff3df553996bacb3e61e1c063~rU4rqxwiS0810708107eusmtrp1e;
        Wed, 28 Nov 2018 15:32:33 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-47-5bfeb5128a96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.10.04284.115BEFB5; Wed, 28
        Nov 2018 15:32:33 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181128153232eusmtip2bdf7be7695531caea5959a410df3dc7d~rU4rDMbJP2013420134eusmtip2C;
        Wed, 28 Nov 2018 15:32:32 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] drm/exynos: mixer: Fix color format setting
Date:   Wed, 28 Nov 2018 16:32:11 +0100
Message-Id: <1543419132-16099-2-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3YuO7POOk7DDwsH66qhJiUcu4hGf0wq7J8kVMipB5XmlM2Z
        FtXUEp1Wc5otkTLwkpdS57RSVBTLRN2wRHTiBcTwiuYNrWZ5PIr//Z7nfd7v4YWPQEQlmDMR
        o0hglAqZXILboQ1fN8zuovrNkDOvVkja+sGM0U/NXTy61lCN0Z1NJYDuX13Aaf2YDqWnRvtQ
        +vnELEJbLDV8ujd1jk8bJwYw+kdjIU4bLC08+n3HCJ825E7jfgelxopMXPpxbRyTjmV18qR1
        xY+kz0wVQLpsdLmBB9tdjGTkMYmM0tM3zC76V0YvEl++P2m6wIZqQLlACwgCUudg3nSQFtgR
        IuodgFmjf3FOrABYrK/DOLEM4LdWA7a7oan15/wyAGfLJvc2alr1qBYICJzyhsMjSzjLjtRR
        aMupAGwIoepR2Nw1yGMHDpQffNuzgLGMUsdh5VATYJmkpHA4xYywDCkXOGTO3GYBFQBzdJYd
        38iHuupAjq9AfXf6ju8AZzpNfI6PwO7cbJQthlQagNaVAYwTOgDbKrUol7oAjYMzPPY2hHKF
        1Y2e3Jn+sCj7OodCODhvz4aRLdQ3vEQ4m4QZ6SLujRNw1mTCd1unllcBx1I4V7Ww7YuoQgAz
        p911QFywV1UEQAVwYtSq2ChG5aVg7nqoZLEqtSLKIyIu1gi2Pk/3ZufSJ7D6PbwdUASQHCBh
        5WaICJMlqpJj2wEkEIkjqfbdsshIWfI9Rhl3W6mWM6p2cJhAJU7k/X3jISIqSpbA3GGYeEa5
        O+URAmcN0BBVLfqZpEvnk3vqOlLw34F/Xq/LhTfzdPYPNm+FScQDgeGfH+dnB6TJF629ogib
        4cvIivZfaNgpt/nU0jXryeA3h15465rPbvjKkOr8RXo9/af4IaI7zVtuExb2C4/51E2S2idU
        3zWb8Spw7TEGteSVHuXVB4SKE8nLPoxWgqqiZV5uiFIl+w+r+RnROAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV3Brf+iDd4/EbO4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXzsOMtcsJK7
        4uWsvywNjCs5uxg5OCQETCQaNjp2MXJxCAksZZR49+IiaxcjJ1BcRmLe2T42CFtY4s+1LjaI
        ok+MEgcmnwUrYhMwlbh99xNYkYiAssTfiasYQYqYBQ6ySLRsPMMIkhAWcJBYeOY9WAOLgKrE
        6pu7weK8Ah4StxvPMUNskJO4ea4TzOYU8JSYOOE8mC0EVLPo6lXWCYx8CxgZVjGKpJYW56bn
        FhvqFSfmFpfmpesl5+duYgRGw7ZjPzfvYLy0MfgQowAHoxIP74EV/6KFWBPLiitzDzFKcDAr
        ifCW2gGFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8YqXkl8YamhuYWlobmxubGZhZK4rzn
        DSqjhATSE0tSs1NTC1KLYPqYODilGhjLV5z94iL7Mv0I+949y28f2Zod3STzjHHFed6jJZ2f
        Jnuryaz+Ffp0zcHsjhvLH7ZE5BhlcPH6PX66R17wkd+5b7L1y/ivr8hiXSglOdt8iTP3dBU5
        36sf5n3ubLAUfSz+S+z5yg3xfieeaFy+KOXa873gzM2AhMDbHKKx30S3cv9rCck2PtmvxFKc
        kWioxVxUnAgAfdZYTZwCAAA=
X-CMS-MailID: 20181128153233eucas1p2e5224bacb69616fdd794751593dc1629
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181128153233eucas1p2e5224bacb69616fdd794751593dc1629
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181128153233eucas1p2e5224bacb69616fdd794751593dc1629
References: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181128153233eucas1p2e5224bacb69616fdd794751593dc1629@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix color format decision based on height(pixels).

According to CEA-861-E:
"High Definition (HD) - A CE video format that, inclusively, has between
720 to 1080 active vertical lines (Vactive) lines per video frame."

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20181128
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index e3a4ecbc503b..bcc26c10095a 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -385,14 +385,9 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 {
 	u32 val;
 
-	switch (height) {
-	case 480:
-	case 576:
+	if (height < 720) {
 		val = MXR_CFG_RGB601_0_255;
-		break;
-	case 720:
-	case 1080:
-	default:
+	} else {
 		val = MXR_CFG_RGB709_16_235;
 		/* Configure the BT.709 CSC matrix for full range RGB. */
 		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
@@ -402,7 +397,6 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 			MXR_CSC_CT(-0.102, -0.338,  0.440));
 		mixer_reg_write(ctx, MXR_CM_COEFF_CR,
 			MXR_CSC_CT( 0.440, -0.399, -0.040));
-		break;
 	}
 
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_RGB_FMT_MASK);
-- 
2.7.4

