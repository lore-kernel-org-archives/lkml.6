Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4834C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50932082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQsbquth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50932082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeKZTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:04:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZTEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:04:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQ83XV3104251;
        Mon, 26 Nov 2018 08:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=L04w6/G3QJX6fPql7+DbXsoRMVwb87RrsyfwHHjSwSI=;
 b=EQsbquthI+Mlkg+PIbOEWUrxfwet8QXZo4HUGO2frdxfxEhTYpSFWiTwuSTTCnNMsij/
 FcKnoeHXdX0WiW3useSiw8TMkz4cjvIEhg7ybul5ws//BiQRl9Ql7us88ceppw9fF50s
 hslpI/Qwb22Qf5b7+m23iaRlcyiWVM2s5sIApjHUNDVOhlyr3iGvvPW7BCLp+LrM2VBt
 CDbTOQsXcdYUc5zf+SEcHwrgEXJOo6anS/5TDpquf+uUJbFoRn1v1w0km3rq8Bvg1JuF
 KGBEOCcGgJgnmBO0IlnoCWXwX5+CHyCrDFpmgAY43p9f0Z9tM0zW4Z1p7tRJJeCwdzvt UQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2tv5k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:11:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ8AvW4000321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:10:57 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAQ8AsN9020714;
        Mon, 26 Nov 2018 08:10:54 GMT
Received: from kili.mountain (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 00:10:54 -0800
Date:   Mon, 26 Nov 2018 11:10:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] media: cedrus: Fix a NULL vs IS_ERR() check
Message-ID: <20181126081044.yz5tenssdbt7mugb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=916
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() function doesn't return NULL pointers, it
returns error pointers.

Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 32adbcbe6175..07520a2ce179 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -255,10 +255,10 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	res = platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
 	dev->base = devm_ioremap_resource(dev->dev, res);
-	if (!dev->base) {
+	if (IS_ERR(dev->base)) {
 		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
 
-		ret = -ENOMEM;
+		ret = PTR_ERR(dev->base);
 		goto err_sram;
 	}
 
-- 
2.11.0

