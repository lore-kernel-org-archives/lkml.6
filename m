Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE13C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61289222D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WJS17Jk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405921AbfBMSng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47008 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfBMSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:33 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190213184330epoutp013b8040aa7edfe7989c4eafd887e9a541~DAKY-9p3z3268832688epoutp01G;
        Wed, 13 Feb 2019 18:43:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190213184330epoutp013b8040aa7edfe7989c4eafd887e9a541~DAKY-9p3z3268832688epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083410;
        bh=wJrfDh99xY9IGMJ/GVWwXV3RyQHDulVmWrQX44qRpvo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=WJS17Jk6+xs4CNAkdd9knPyju6TnStw9AV9/J9Wye9q+RpJoBJHGs6Ujgjt4PjcZx
         /18TC09Ty6DY0I2IRpW67Y8xjI3ZAXFsQYNjHFqYh+7t0xeBDYzD8lxwuC6KgUt1AT
         7fdNNWP57fX9g9YjX+4OMDsMWTBYX8W0k/61KU0c=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213184329epcas2p27cc8752a9089930af7b57e5f9866b8eb~DAKYP9GOT2251322513epcas2p2i;
        Wed, 13 Feb 2019 18:43:29 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.3E.04093.155646C5; Thu, 14 Feb 2019 03:43:29 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184328epcas2p3c89ed5fa3e58baf4b5af9b56418fb0d9~DAKWpSig22577225772epcas2p3l;
        Wed, 13 Feb 2019 18:43:28 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-66-5c646551a17b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id C8.ED.03689.055646C5; Thu, 14 Feb
        2019 03:43:28 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:28 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 10/13] ASoC: samsung: i2s: Simplify pri_dai, sec_dai
 pointers usage
Date:   Wed, 13 Feb 2019 19:42:09 +0100
Message-id: <20190213184212.5473-11-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmhW5gakqMwf6ZlhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MC+vYCtZyVSw8cIGtgXEDRxcjJ4eE
        gInE8s/PWLsYuTiEBHYwShw+t5sRJCEk8J1R4vSaWpiiV6vvQxVtYJT4t2k1C4Tzi1Hi55+z
        TCBVbAKGEr1H+8C6RQTEJG7P6WQGKWIWaGGSmDN3KTNIQlggQqL9wyp2EJtFQFXiz877YHFe
        AWuJtSt3skCsk5dYveEAWJwTKP5v7XN2kEESAgvYJPpudQDdwQHkuEjsm2cIUS8t8WzVRkYI
        u1pi1/ZuZoj6DkaJlgvbmSES1hKHj19kBbGZBfgkOg7/ZYeYwyvR0SYEUeIhce/7E2aIz/oY
        JVaf2c46gVFiASPDKkax1ILi3PTUYqMCE73ixNzi0rx0veT83E2M4BjU8tjBeOCczyFGAQ5G
        JR7eCqGUGCHWxLLiytxDjBIczEoivHpRQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8D6XnRgsJ
        pCeWpGanphakFsFkmTg4pRoY17p0Pz8gKNYrupJJ6iobWzm33qLetv8s527WSCxXbWz6ts/b
        SM/GQeLrFoXV60uPierfKKyNLpZ553vYsvQpT/Grr59tDQ5tbLornHCwXHh5asmtU8w7Nxw3
        cJdqL5Rq/Gp1oFP/eNYVgay5m77LRatYRR+4c9kjapfXMdmJDF550e5fU0qVWIozEg21mIuK
        EwG8DNoHvQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd2A1JQYg5XdfBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MC+vYCtZyVSw8cIGtgXEDRxcjJ4eE
        gInEq9X3WbsYuTiEBNYxSnw4dIkFwvnFKLH/agMTSBWbgKFE79E+RhBbREBM4vacTmaQImaB
        JiaJXbcvsoMkhAUiJNq3PGEGsVkEVCX+7LwPZvMKWEusXbmTBWKdvMTqDQfA4pxA8X9rn4P1
        CglYSUz8cIl5AiPPAkaGVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgUG27bBW/w7G
        x0viDzEKcDAq8fBWCKXECLEmlhVX5h5ilOBgVhLh1YsCCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Euflzz8WKSSQnliSmp2aWpBaBJNl4uCUamBcpi+z7rth5FSfo89CzrrPX7Iy4vtpzuuL01V+
        Lvu6e+EG3r8aO1lOadyS6JBJFiy7zlj91Xgrm9/8l+ZbC11mirZwXmU4LKf6UzfNOHfTk9qa
        6OkK4cnbGaSKG9PLtuofcPrZKy/F8b7iILNW9bU5z5JEVPmCX+k+3LLgrMA9S9NbC5oY52sp
        sRRnJBpqMRcVJwIAfgQsvS4CAAA=
X-CMS-MailID: 20190213184328epcas2p3c89ed5fa3e58baf4b5af9b56418fb0d9
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184328epcas2p3c89ed5fa3e58baf4b5af9b56418fb0d9
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184328epcas2p3c89ed5fa3e58baf4b5af9b56418fb0d9@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe call is on the primary DAI we can use 'other' in place of
i2s->sec_dai, if the probe call is on the secondary DAI we can use 'i2s'
in place of other->sec_dai.

While at it fix one whitespace issue.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 16e6868376f6..4f15b6af8268 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1057,18 +1057,17 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
-		snd_soc_dai_init_dma_data(dai, &other->sec_dai->dma_playback,
-					   NULL);
+		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-					   &i2s->dma_capture);
+					  &i2s->dma_capture);
 
 		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
-					i2s->sec_dai->idma_playback.addr);
+					   other->idma_playback.addr);
 	}
 
 	/* Reset any constraint on RFS and BFS */
-- 
2.17.1

