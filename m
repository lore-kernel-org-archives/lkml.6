Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487B3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF0F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PHisCOA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF0F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeIQI3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:06 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:17633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbeIQI3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/T64wYABD25HlXju51k67xUHK541wp0ONHjQtaUjMc=;
 b=PHisCOA3ZSU9x3xtQRGu+sXnNvqDNywa0+3lXLxWYVi7K9rQAtZkNqcggyN/+0mVmBGY+F5KgvGa7oNF77Bo+R/c6RHbcEIO0pDt60C8yMm+2fgTt5VLHJRyC8nwEI4Tp/wn8dB9BFQD75wMnqkhZy/Dm/oJjHnefhgAMdPzVBQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/87] media: fsl-viu: fix error handling in
 viu_of_probe()
Thread-Topic: [PATCH AUTOSEL 4.14 27/87] media: fsl-viu: fix error handling in
 viu_of_probe()
Thread-Index: AQHUTjLlCmA8CTzZkUKLGku4/QpUgA==
Date:   Mon, 17 Sep 2018 03:02:40 +0000
Message-ID: <20180917030220.245686-27-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:B06bxQ10Bw5wBX+ch58vifMuCn7NAhczVUI3VRHMYoftOZsAVosvzeCNvjaB5b96J6dZXsFw3okU4IYBzDOjbFAZRRbK2HDXjNDtGz3rN6l3UknaUdy13b9Y4Tpa0ihdUdHAZAbN4MhY6OU4dLZnShvA7fRsJQ/kEjdKVoLd/5G65Y3hQkAPAkapAa8h+28/8lWQREHSgowx9WRosGAG8rVMG14gbjr7AxdnGT0f99Hi0Lx1bjnYawLtWFP1Yk3P+MxwxRkGl/CO0Jal61Xg2fbrP53M2xJFCp170EzAd5cDEqF9HYCU1K7jivgwftFZIIvmIFeeKC8SccrJezw+oswjczbSPEaTMnsyTzLAKZQ3KWm9a7jGK4xoT8AtclpI/PLD38zsaimKTH0hQGsJnFXTc4xFCElI6mEfxTEBRuzvMEEaZe1e8qd955zIOG6GV5HntgXOBBZYlsK+oDKMng==;5:IRMZUPO/WzVFGZUIMEoCTR3lbqKqd93/w7C5vmIs33sOpuCvupYxouvi0jUW29ycrxBwBiGrdHdB3cNhbWVJKOOMgdCvuMMUufVfRpZGHJG5YqCJd9nX49ZY/BidSzmy6Al0VtxhsyaxouJTOmDqaew+GKI1VYYksWkOMf/m+tA=;7:s3WleBM+QaFsd0UN+fkJ5kz0sqoQJkdC8Z/ZSUiE8QC0ZFUoAd2ZTNlAw6r125SPnL0MuGYMo2VQk0GKkPG8Qa8mzHXU+JlNrzndVL3OhUwarTFTZxw5DEzQY4+nDZkdIPnTTmQ0PgeFUxX6u9s1S4+ZxeCSJ1yyDlYT0yzkCcGGhiP8hZgLYEQ8VI9KBgEvkxnKa2sfp7CgfjmDASxtsqcNgcYHLVJngSFBqrOW/nnFVXKVHj5aUJBi7uD+Vnak
x-ms-office365-filtering-correlation-id: 3a48313f-94da-4f91-41f2-08d61c4a2b3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04704DD6BE38AD6D0BD4226BFB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(4477795004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(6666003)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +UIUOpcyCvGkPohY6AsKI+xXa6LsjWm6ClVC7s2H7nWEkqYOeUAICzt3Lu/JQYu9u4V6krUBjxVAM3WE5+YCXQZwMwBqiF0SK7X1drVuoJXXrKkXgU8ypXcaKtLy9KhniNcuhZoRvCQzpe9vBSCJvueUCxP77fS0kILsE68wG8+vzKfzmwN/8P6BFiDx+8J86OcaZbehkVlRO0R8TnPdoOYyN+n3W9hJaUfWPiLjCKVASpFMDdp5FMBje3XBb0cshuiVruJnuPtwrezKlY5yNYU4dpKUjWHRKrjhInQUXpXzEHbgCyU22tsARz3f5BFcVfsGEiHN4rCQwWg02uxY8fP+Ty29Ud8kRf1FP5hCl14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a48313f-94da-4f91-41f2-08d61c4a2b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:40.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 662a99e145661c2b35155cf375044deae9b79896 ]

viu_of_probe() ignores fails in i2c_get_adapter(),
tries to unlock uninitialized mutex on error path.

The patch streamlining the error handling in viu_of_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/fsl-viu.c | 38 +++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-=
viu.c
index fb43025df573..254d696dffd8 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1417,7 +1417,7 @@ static int viu_of_probe(struct platform_device *op)
 				     sizeof(struct viu_reg), DRV_NAME)) {
 		dev_err(&op->dev, "Error while requesting mem region\n");
 		ret =3D -EBUSY;
-		goto err;
+		goto err_irq;
 	}
=20
 	/* remap registers */
@@ -1425,7 +1425,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (!viu_regs) {
 		dev_err(&op->dev, "Can't map register set\n");
 		ret =3D -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
=20
 	/* Prepare our private structure */
@@ -1433,7 +1433,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (!viu_dev) {
 		dev_err(&op->dev, "Can't allocate private structure\n");
 		ret =3D -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
=20
 	viu_dev->vr =3D viu_regs;
@@ -1449,16 +1449,21 @@ static int viu_of_probe(struct platform_device *op)
 	ret =3D v4l2_device_register(viu_dev->dev, &viu_dev->v4l2_dev);
 	if (ret < 0) {
 		dev_err(&op->dev, "v4l2_device_register() failed: %d\n", ret);
-		goto err;
+		goto err_irq;
 	}
=20
 	ad =3D i2c_get_adapter(0);
+	if (!ad) {
+		ret =3D -EFAULT;
+		dev_err(&op->dev, "couldn't get i2c adapter\n");
+		goto err_v4l2;
+	}
=20
 	v4l2_ctrl_handler_init(&viu_dev->hdl, 5);
 	if (viu_dev->hdl.error) {
 		ret =3D viu_dev->hdl.error;
 		dev_err(&op->dev, "couldn't register control\n");
-		goto err_vdev;
+		goto err_i2c;
 	}
 	/* This control handler will inherit the control(s) from the
 	   sub-device(s). */
@@ -1475,7 +1480,7 @@ static int viu_of_probe(struct platform_device *op)
 	vdev =3D video_device_alloc();
 	if (vdev =3D=3D NULL) {
 		ret =3D -ENOMEM;
-		goto err_vdev;
+		goto err_hdl;
 	}
=20
 	*vdev =3D viu_template;
@@ -1496,7 +1501,7 @@ static int viu_of_probe(struct platform_device *op)
 	ret =3D video_register_device(viu_dev->vdev, VFL_TYPE_GRABBER, -1);
 	if (ret < 0) {
 		video_device_release(viu_dev->vdev);
-		goto err_vdev;
+		goto err_unlock;
 	}
=20
 	/* enable VIU clock */
@@ -1504,12 +1509,12 @@ static int viu_of_probe(struct platform_device *op)
 	if (IS_ERR(clk)) {
 		dev_err(&op->dev, "failed to lookup the clock!\n");
 		ret =3D PTR_ERR(clk);
-		goto err_clk;
+		goto err_vdev;
 	}
 	ret =3D clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(&op->dev, "failed to enable the clock!\n");
-		goto err_clk;
+		goto err_vdev;
 	}
 	viu_dev->clk =3D clk;
=20
@@ -1520,7 +1525,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (request_irq(viu_dev->irq, viu_intr, 0, "viu", (void *)viu_dev)) {
 		dev_err(&op->dev, "Request VIU IRQ failed.\n");
 		ret =3D -ENODEV;
-		goto err_irq;
+		goto err_clk;
 	}
=20
 	mutex_unlock(&viu_dev->lock);
@@ -1528,16 +1533,19 @@ static int viu_of_probe(struct platform_device *op)
 	dev_info(&op->dev, "Freescale VIU Video Capture Board\n");
 	return ret;
=20
-err_irq:
-	clk_disable_unprepare(viu_dev->clk);
 err_clk:
-	video_unregister_device(viu_dev->vdev);
+	clk_disable_unprepare(viu_dev->clk);
 err_vdev:
-	v4l2_ctrl_handler_free(&viu_dev->hdl);
+	video_unregister_device(viu_dev->vdev);
+err_unlock:
 	mutex_unlock(&viu_dev->lock);
+err_hdl:
+	v4l2_ctrl_handler_free(&viu_dev->hdl);
+err_i2c:
 	i2c_put_adapter(ad);
+err_v4l2:
 	v4l2_device_unregister(&viu_dev->v4l2_dev);
-err:
+err_irq:
 	irq_dispose_mapping(viu_irq);
 	return ret;
 }
--=20
2.17.1
