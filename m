Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE6FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0BF21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WASyGRPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBGRA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:00:57 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31989 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:00:54 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170051epoutp03385fbb804a1734a55f99278db627a3f6~BI5DjIR9F2895028950epoutp03p;
        Thu,  7 Feb 2019 17:00:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170051epoutp03385fbb804a1734a55f99278db627a3f6~BI5DjIR9F2895028950epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558852;
        bh=Z3qp8NJqkxPTiayffdnOCrSlYTCyQwDLBEB9V7x+dYQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=WASyGRPVmOkbW7KACRzrVFc/4hNBEij2sjUWMX4QTpNCX9VaoNOwz8rDGh+B8dtcc
         pp9vGNvKG0JijJfxbq5q44WvWyZQWuZLGFtK2mf+creJMsSohNww4mhOJ6EOoQjd6I
         CeM8iuQPBtROZe2vv8odb0u8WiZdyw1EE6EbWSCE=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170051epcas1p274507f06eabb8d4923bdb80a862458bc~BI5DUp2Xi1282112821epcas1p2B;
        Thu,  7 Feb 2019 17:00:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.A3.04074.3446C5C5; Fri,  8 Feb 2019 02:00:51 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170051epcas1p37a1acaef52cffb01af00c8d34dd9b1dd~BI5C-PBW80868808688epcas1p3d;
        Thu,  7 Feb 2019 17:00:51 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-38-5c5c64438eda
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.C8.04015.3446C5C5; Fri,  8 Feb 2019 02:00:51 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:00:51 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 02/22] ASoC: dmaengine: Extend use of chan_names provided in
 custom DMA config
Date:   Thu, 07 Feb 2019 18:00:10 +0100
Message-id: <20190207170028.720-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmga5zSkyMwfWrqhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MiT++Mhes4q14utymgXEmdxcjJ4eE
        gInEhffnWbsYuTiEBHYwSny8c4wZwvnOKPFv3zJWmKov53dAVe1mlNi24x0bhPOLUWLfncks
        IFVsAoYSvUf7GEFsEQExidtzOsFGMQu0MEnMmbuUGSQhLJAgsWnpVbAiFgFViVUtvUwgNq+A
        pcTh5ZPZINbJS5zvXccOYnMKWEnc2r+DBaJGUOLH5HtgNjNQzcErz1lAFkgIHGCTOP19DdSt
        LhJtbxqBmjmAbGmJS0dtIcLVEru2dzND1HcwSrRc2M4MkbCWOHz8IivEUD6Jd197WCF6eSU6
        2oQgSjwknu7aCA2XXkaJ3iM/2ScwSs1CctMsJDctYGRaxSiWWlCcm55abFhgqFecmFtcmpeu
        l5yfu4kRHOVapjsYp5zzOcQowMGoxMOroRcTI8SaWFZcmXuIUYKDWUmEVzYBKMSbklhZlVqU
        H19UmpNafIhRmoNFSZx3vYNzjJBAemJJanZqakFqEUyWiYNTqoGxIOef0PuGNZt/lyh4fl3e
        PPfUadX7Wy4luATxb/reVeJ/vu9j/r1s1UmCHGcFPokZiM4z7qh0jew9wDbzzxNLxqeyUyde
        ezX37SZG5seVfQccnC9kKea9lg1h/7fMaEqs3YWTSuUmXHPvyh2M/1UntPn+f5VVebtT1aWe
        5s3Vfvp5k/+K3aa3lViKMxINtZiLihMB057y7e4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAV3nlJgYg4blwhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MiT++Mhes4q14utymgXEmdxcjJ4eE
        gInEl/M7WLsYuTiEBHYySpz8OxPK+cUo8fbsSWaQKjYBQ4neo32MILaIgJjE7TmdzCBFzAJN
        TBK7bl9kB0kICyRIbFp6FayIRUBVYlVLLxOIzStgKXF4+WQ2iHXyEud714HVcwpYSdzav4MF
        xBYCqvkwoYkVol5Q4sfke2BxZqD6g1ees0xg5JuFJDULSWoBI9MqRsnUguLc9NxiowLDvNRy
        veLE3OLSvHS95PzcTYzAIN52WKtvB+P9JfGHGAU4GJV4eC9ox8QIsSaWFVfmHmKU4GBWEuGV
        TQAK8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJgsv9SP
        5ebCF05H2Kcx892Uc0uO7Oz3ap+RUnd8ypNlVz49tinknMOjPH2Cur/3pjNMy956OrOd/yRo
        Pt/36bfPeZff/97jH9KtIxBf+NTz0axePfOcfTaa+t8NFD7WPmc9KewxXXvppYU3X56cnFwq
        NqngYbdnw/XHvSKaZQoxQVdPfJKyWqvEUpyRaKjFXFScCABmTR3CXgIAAA==
X-CMS-MailID: 20190207170051epcas1p37a1acaef52cffb01af00c8d34dd9b1dd
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170051epcas1p37a1acaef52cffb01af00c8d34dd9b1dd
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170051epcas1p37a1acaef52cffb01af00c8d34dd9b1dd@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently two ways to specify custom DMA channel names:
 - through the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag and
   snd_dmaengine_dai_dma_data data structure,
 - through chan_names field of struct snd_dmaengine_pcm_config.

In order to replace the DAI DMA data method with the custom DMA config
one on non-DT platforms the dmaengine_pcm_new() function is extended
to also consider channel names specified in the custom DMA config.
If both config->chan_names and dma_data->chan_name are provided
the former will be used.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6d7638c1233d..1b44e363c50c 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -288,9 +288,16 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 		if (!pcm->chan[i] &&
-		    (pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME))
+		    ((pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME) ||
+		     (config && config->chan_names[i]))) {
+			const char *chan_name = dma_data->chan_name;
+
+			if (config && config->chan_names[i])
+				chan_name = config->chan_names[i];
+
 			pcm->chan[i] = dma_request_slave_channel(dev,
-				dma_data->chan_name);
+				chan_name);
+		}
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
-- 
2.20.1

