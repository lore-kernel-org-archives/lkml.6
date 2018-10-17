Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9474ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6676821528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MKuQRRcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6676821528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJQXuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63366 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:39 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181017155418epoutp01ef3021c391a5f319ee502bad01c5d14e~ecFrXvXo62806228062epoutp01l;
        Wed, 17 Oct 2018 15:54:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181017155418epoutp01ef3021c391a5f319ee502bad01c5d14e~ecFrXvXo62806228062epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791658;
        bh=CNGKVTRYfXVdSjJbQ49PGA9Orip/uVvSegZ9MuPr7to=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=MKuQRRcqdRLILgzdDUx3y1eFmPocBxsR3Bo1neSXEuOcR3KGhnrojLNDyL5PG2UVU
         ItOui/IlRHZTzMo2kGduyfhcfFkE2zANDhNNRhIYcWu0lUGdWf7cmz541TFhMT9qpW
         1ykSjLrH6kdCZbnaHuIw5ePwXEqJF4f1anyXHk18=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155417epcas2p34f8c248193156f5f60af69e400620d32~ecFqftACi0461104611epcas2p3Q;
        Wed, 17 Oct 2018 15:54:17 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.67.04015.92B57CB5; Thu, 18 Oct 2018 00:54:17 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155416epcas2p32f63571e9c06cd1aba2b40bcf23de8e1~ecFpk1h501998019980epcas2p3w;
        Wed, 17 Oct 2018 15:54:16 +0000 (GMT)
X-AuditID: b6c32a45-6c1ff70000000faf-14-5bc75b29991d
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A6.44.03633.72B57CB5; Thu, 18 Oct
        2018 00:54:16 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:15 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 10/17] thermal: rcar_gen3_thermal: enable+check sensor
 after its setup is finished
Date:   Wed, 17 Oct 2018 17:52:36 +0200
Message-id: <1539791563-5959-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRzGfbdz22pxOkq+KlgtxAtpXrLeMsoPGQcqunyrfcihpynexqaS
        1oel4Q0Ul6TmrakVugxzrLxnzbZlqHgJ0dLEC+I9bKSmhTmPfvv9n+f5839eeCkhk4a7UtHx
        iZwqXh4rJcTYu07vU77eMqvMvzUfR+maagFqKK7H0YzNCtDrXDOGnn0dwtGHh4MAbU0u4OhL
        Y5oAPSqpwtDz6QkSDbaUEciW+wmgsuXvJJqeyCPQrNEZGWqGCfSnpQJD7T9sIJRh035aCLZk
        vIdgm0vGSPbtt2C2um1OwBr02QQ7OtRGsLnpywSbZ9QDtnGoQsh+LlrDWOtwo4C1GdyvS26L
        z0VysdHJnOrE+XBxVJ1VgysrqXulRbVAAzaJHCCiIH0SZo/NkTlATDF0E4AV7euY3WDoNQCr
        yrz2QrrCbsDrbwAczlTxCxsA1vSvknaDoM9CbaZ+O0RRTvRlaKyj7LKQNmNwyuZtZ0daAZd7
        tDuHMdoDDkyadlhCs9Dc9XG3kDvsshTgdhZt671bul29gIRDJQ94vgiXRtIFPDvCeauR5NkN
        zugbgL0bpIsAXNx4gfFDPYB13ZbdjRDYae3H+XYHYFbnP9JeGtISmJXB8BEW1vatkfyDSwHc
        0sF84KIDDnpwiFOq4xScOlAZ4KeWx6mT4hV+EQlxBrDzM3zCmkBx7xUToCkg3S+hXSwyBpcn
        q1PiTABSQqmTJPWoVcZIIuUpqZwq4Y4qKZZTm4AbhUmdJZNu5TKGVsgTuRiOU3KqPVdAiVw1
        IKFAcctp3rMnVMTq5pu1KDA86ObmeNLjdAdjq+ffxa4FqnZiRfRLmRBk67i2uXA8b7Tw2MGQ
        7KvEU+sTk4fr75UbXpURs6c9jqz5bpUPyLGRC9pkgjO89A8bKY7qYExTrvsiOyLNGXNt4hhp
        33vPwKz1u6+0S2fGDgdfCnJbvS/F1FHyAB+hSi3/D1E3m7gVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV2N6OPRBn+Ws1k0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsErow1xxtYCxZyVMyevpKxgfE3WxcjJ4eEgInEgmlnGLsYuTiEBNYxShy93wfl/GKU
        aJj4kRmkik3ASmJi+yqgBAeHiIC3xJY1HCA1zAJHWSTWzvgGNklYIF2i6VAHO4jNIqAqcenR
        IbA4r4CHxNGTB6G2yUmcPDaZFcTmBIqf+78ALC4k4C5xcsdL9gmMPAsYGVYxSqYWFOem5xYb
        FRjlpZbrFSfmFpfmpesl5+duYgRGwLbDWv07GB8viT/EKMDBqMTDu0PsWLQQa2JZcWXuIUYJ
        DmYlEd4qxePRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODil
        Ghj7zxlr7lp2vmEbT8mdE5X/9afl5AZaRDLk34tlvv26wE067/Nq5/9NbDkSVxXZDvxYFp56
        Y7vqvrDzGXc8ZR2yLJeJn/xZ6t65QrWP/fiMpox+qYnloZM/rXhzt8p8R8O99xNk+1PPqRRO
        eTV/6uxvX09vZ2R9vKH9cdeFfcaxMqyCDhvCt81SYinOSDTUYi4qTgQAaU2JQ3wCAAA=
X-CMS-MailID: 20181017155416epcas2p32f63571e9c06cd1aba2b40bcf23de8e1
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155416epcas2p32f63571e9c06cd1aba2b40bcf23de8e1
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155416epcas2p32f63571e9c06cd1aba2b40bcf23de8e1@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after setting tsc->zone and checking ntrips.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c72453e..eb50f33 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -421,9 +421,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		thermal_zone_set_mode(zone, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(zone);
-
 		tsc->zone = zone;
 
 		ret = of_thermal_get_ntrips(tsc->zone);
@@ -431,6 +428,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+
+		thermal_zone_set_mode(zone, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(zone);
 	}
 
 	priv->num_tscs = i;
-- 
1.9.1

