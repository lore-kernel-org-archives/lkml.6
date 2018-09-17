Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4352147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jr06C2Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4352147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeIQI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:23 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeIQI0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLzNEeBGDyZA/Lj/QSMx7ZKWVQLFzMd019GL62ET+t8=;
 b=Jr06C2AdKv/rNTU2U1pC1K+uxHuiIjKS5fcBx/Fm5D2WinncDz/BYYjfjnZfS9sVplYT+MpKFqGusazDyMzSu5zImnxz8HJ9twtZ+zyXYg+zfPO0OSTpO7KTAwK2SW7hvCh9VcvYXnPlkiqeHtP7vfCOOoZllbzS9sjg/T1ptoM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 037/136] media: fsl-viu: fix error handling in
 viu_of_probe()
Thread-Topic: [PATCH AUTOSEL 4.18 037/136] media: fsl-viu: fix error handling
 in viu_of_probe()
Thread-Index: AQHUTjKan0QE8/FUxUO1iX6AEphaWA==
Date:   Mon, 17 Sep 2018 03:00:35 +0000
Message-ID: <20180917030006.245495-37-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:U5qAqcMUCVyCWm/4mWnEd9Mab7GcIk2brJwS57ZDxT9apEmaOqm7TRuxohxIgWNk9gPae33DvocjDH6POUH8ug8gojoU2zuwf7F9upsTsb75nq1HodWUj+ZhQc3G/k5345mcXiNf+gbf9P18XCUgwRmL9+dLB2uAsIZCritXgahwOJ1jx1StWzV8x/dIE5aXNVefm4qlJ+N8IomoPx618SZEjpZECAA9TcaNZDnOrPtLCEIl79/T34VXRanVyvJ3SJsppqiXVM9MLkK4J6mzGVNhRz4FXzGg+9gFfApqDdbgOkvzklAZbBdaPUEKqO3j59hUDxr63RPwFH4P9cfQ6LdBE/0sGpLXyK50XFZLh+71QPJeMCXetXxdigmi/d6rV9almO4CGHE0lNtPbnGF2yEbvnUwUYiX2/qxMuO4UNYgySHg1N9XwBne0+b13ZeLUkz6lJcP9RqKQFy/5D3XBQ==;5:RkiS4D5SNg7lKS7SFHTakEBmNkGpMmuVWkEbXNNOnZHaTI0CoIQLI6KqPkZ7mlfrOw8ITdXDnxVibkf7OC7FW+tYO81TS/I1ULoikwUzUnjaKZdZwLQBCHuIDmfaVcRWqchmqrfSk9K14nTrsPQpCtn/hRmghFsQGQtwzndkBIs=;7:M3AFh+UW91bbI/lAIR6xiWB4jcKtiD9T5MdKuhkvz2ThTCvFofkYEhJVGKcyuSP35KSlrJVGswE8WxHbaS6tpbhbt1O4LsZZavfmZWkSFWwgwdgor/uxMR851AwiQ+XaovQGStq4RRrDpriQQIT89h65Qf+4o0qXIaiN+9ZjqkNHfYjkZt0xsmzrd4WZlsGXhl1J0/9BdK9CeLaHQ+/W2vWVjTZyrwsdl/4v9A17SDHBXUDtDeRXfUk9wpq4pwJs
x-ms-office365-filtering-correlation-id: 2871142a-bf4d-4972-e60f-08d61c49ce70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06296FBF4A6BDFD65D3450CFFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(4477795004)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F37PFcyr5W/BbDto+OJzm82rhZVCJr6WZccuSEJYRNTLHByrgw++xBrBLyQ+VF1TZFpiJAxI7Ks3O+VSYfyA1M/ozpXPmCJUNZeIzfl1A6nTfnHdLBh8MPCD73c43aw0WsjpAi8mvPr+uORNW4Ml+1Rz9NxNx7jeY4biPvfb4ivEjrZVtMPHdZ+HyPhLY/j+UC8YrJN1Y8ZX0JB1V4dEshyeAuMFqTEPHf5jmhoGnljoH/QcmEENWwJU77z3S5wzuPmi4ujwM4PSRYhQODc2z01D2rk5F9MWNZ3Qh+4WWTYFiq75lqB0LhHwcw2vn6xoyaZ/Uz8hxBi5M4Me9wtthCAHZzIbMchDIs/RPUGjOZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2871142a-bf4d-4972-e60f-08d61c49ce70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:35.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index e41510ce69a4..0273302aa741 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1414,7 +1414,7 @@ static int viu_of_probe(struct platform_device *op)
 				     sizeof(struct viu_reg), DRV_NAME)) {
 		dev_err(&op->dev, "Error while requesting mem region\n");
 		ret =3D -EBUSY;
-		goto err;
+		goto err_irq;
 	}
=20
 	/* remap registers */
@@ -1422,7 +1422,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (!viu_regs) {
 		dev_err(&op->dev, "Can't map register set\n");
 		ret =3D -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
=20
 	/* Prepare our private structure */
@@ -1430,7 +1430,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (!viu_dev) {
 		dev_err(&op->dev, "Can't allocate private structure\n");
 		ret =3D -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
=20
 	viu_dev->vr =3D viu_regs;
@@ -1446,16 +1446,21 @@ static int viu_of_probe(struct platform_device *op)
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
@@ -1471,7 +1476,7 @@ static int viu_of_probe(struct platform_device *op)
 	vdev =3D video_device_alloc();
 	if (vdev =3D=3D NULL) {
 		ret =3D -ENOMEM;
-		goto err_vdev;
+		goto err_hdl;
 	}
=20
 	*vdev =3D viu_template;
@@ -1492,7 +1497,7 @@ static int viu_of_probe(struct platform_device *op)
 	ret =3D video_register_device(viu_dev->vdev, VFL_TYPE_GRABBER, -1);
 	if (ret < 0) {
 		video_device_release(viu_dev->vdev);
-		goto err_vdev;
+		goto err_unlock;
 	}
=20
 	/* enable VIU clock */
@@ -1500,12 +1505,12 @@ static int viu_of_probe(struct platform_device *op)
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
@@ -1516,7 +1521,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (request_irq(viu_dev->irq, viu_intr, 0, "viu", (void *)viu_dev)) {
 		dev_err(&op->dev, "Request VIU IRQ failed.\n");
 		ret =3D -ENODEV;
-		goto err_irq;
+		goto err_clk;
 	}
=20
 	mutex_unlock(&viu_dev->lock);
@@ -1524,16 +1529,19 @@ static int viu_of_probe(struct platform_device *op)
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
