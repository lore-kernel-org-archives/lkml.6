Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C3D2152E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNFxEm+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C3D2152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeJQXvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:51:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12955 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:51:05 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155443epoutp04ef1cfc5380017884c5cef126d93ec9c5~ecGC4zUxo0668806688epoutp049;
        Wed, 17 Oct 2018 15:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155443epoutp04ef1cfc5380017884c5cef126d93ec9c5~ecGC4zUxo0668806688epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791683;
        bh=UQ4eoVxr3LPXmaXuV9z+qSoklL/ynuV49Be7ea1NhGI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=vNFxEm+5DWzkcfuGqbrkKs12cAGbcOZYZMkbxLkXC5O9cZyB8RRpbV93WzdxHDbcz
         9TpaEDOJ7l9E8G4EbjzbwTL12R8oioR4Vx6HD1ri+yHcCqCjKBn1wTsR8mYLsEMXTx
         Zi3kUYY3TJkD7LS3m+1A/JsVOwBCw04bTU33g5bM=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155442epcas1p246b2e004b4aad1bff572db8c4ccdd750~ecGCEKuJB1629016290epcas1p2C;
        Wed, 17 Oct 2018 15:54:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.D9.04081.24B57CB5; Thu, 18 Oct 2018 00:54:42 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155440epcas1p12c33048a8c1c083496d1a8996591d884~ecGAs9xoa1224012240epcas1p1k;
        Wed, 17 Oct 2018 15:54:40 +0000 (GMT)
X-AuditID: b6c32a39-689ff70000000ff1-77-5bc75b4222b3
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 4C.A6.03743.04B57CB5; Thu, 18 Oct
        2018 00:54:40 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:40 +0900 (KST)
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
Subject: [PATCH v2 14/17] thermal: ti-soc-thermal: enable+check sensor after
 its setup is finished
Date:   Wed, 17 Oct 2018 17:52:40 +0200
Message-id: <1539791563-5959-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTURjHO7t3d9fh5DZNjwpGoyAFNS3zZGUhFRcqivpQNMpG3lTyrXtV
        0rLWlExNsaQsXdOysJZlDd8SBV/mrqZJqYg1y3xBKsdCV82UNOe1b7//8/ye85wDh8TkmWIv
        MjYhmWETVHEKQorXtfsG+kcoeeWmEYs7ylRXiNCru9ViNGnjAXqe34GjsoFBMWq52g/Q4tiU
        GL2p14hQVslDHD2aGJWg/kYtgWz5RoC0VrMETYwWEOhrjQcyPBki0J9GHY6aP9vAbjmt+WEi
        6JKRtwT9uuSThK79GEJXNH0T0QZ9DkEPDzYRdH6mlaALavSArh/UYXRnsR2n+aF6EW0z+ByW
        nZDuiGLiYlMZNjD8tDRmobIIS9I4XbC844EaTElyAUlCagusNDC5QErKqQYAa28/EAvBDmCX
        2bwUnJYla36PSGi8BPBnwQwmhDkA7bOluMMiqDB4M1sPHMe6UfthTRXpKGNUBw7Hbb4OdqWi
        4GzfNHAwTm2ARWVqiYNlFA1vP5tYWeYDu0xFy+y0VO9dLCccuyBVLIGNc9oVaQ9s7ZomBHaF
        3/maled4w76OnSs+gJa5x7gQqgGs6jGJhIHtsJ1/LxZu5wKtv26IhWEZvH5NLig0LO58gTlY
        TpUCqPstKwSe5WCVHrgzSVx8NMMFJYUEcKp4LiUhOuBMYrwBLH8Nv20NwNR7oA1QJFA4yxrc
        TUq5WJXKpcW3AUhiCjdZ+jpeKZdFqdLSGTYxkk2JY7g24E3iCg/ZhNd9pZyKViUz5xgmiWH/
        d0Wkk5caHNuczR+5+CH3sqcJYyab7813xazWGtNCZ9tZ4ynWVIzv+qI92HiruydDX5Y305px
        /M5wniWKU65dY80Z700JuaIzFlwaGo20b7QEe4YHmefVraUDEcYF57Ozf7e2aOr2+rvuC03s
        VodVBLuut6abWZeTwdJDfOzY+cyjhVnSpwqci1EF+WEsp/oHuCO1txYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV2H6OPRBh9um1g0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsErox/yyczFzRxVry5cJyxgfE1excjJ4eEgInEu94zTF2MXBxCAusYJa5N+88O4fxi
        lFjaP4MZpIpNwEpiYvsqxi5GDg4RAW+JLWs4QGqYBY6ySKyd8Y0NpEZYIEXix6WPjCA2i4Cq
        xOT5DWAbeAU8JKaufsIKsU1O4uSxyWA2J1D83P8FYL1CAu4SJ3e8ZJ/AyLOAkWEVo2RqQXFu
        em6xUYFhXmq5XnFibnFpXrpecn7uJkZgBGw7rNW3g/H+kvhDjAIcjEo8vDvEjkULsSaWFVfm
        HmKU4GBWEuGtUjweLcSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgs
        EwenVAOjYrJK8KxtbKs4LISEe1y8Dv2+q3Zl/0bpv49vF9g6fHypFr3v7HEZqdbtP8sld+v8
        1w/Z9+aE5sfy9RVXuAwFni1I2TnTcKXqkd0q3n92eFiIrpuiXfDJ+VRMk2HaTGV7ldlvb7Jt
        mzS9stSPXW3Vbk+JnptC6paiUpufp2v4uAYESO/vabdRYinOSDTUYi4qTgQAq9U703wCAAA=
X-CMS-MailID: 20181017155440epcas1p12c33048a8c1c083496d1a8996591d884
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155440epcas1p12c33048a8c1c083496d1a8996591d884
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155440epcas1p12c33048a8c1c083496d1a8996591d884@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after setting sensor data and check sensor after
writing update interval.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index aa15719..4675d96 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -197,13 +197,15 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	ti_bandgap_set_sensor_data(bgp, id, data);
+
 	thermal_zone_set_mode(data->ti_thermal, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(data->ti_thermal);
 
-	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
 
+	thermal_zone_device_check(data->ti_thermal);
+
 	return 0;
 }
 
-- 
1.9.1

