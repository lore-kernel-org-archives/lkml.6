Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6559ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB80214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kQP/5it4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB80214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeIQIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:26 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeIQIcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3z8QoYp0fTPmEDFpQ2ZY/DfCG5PNul1QKts4mtY+Nk=;
 b=kQP/5it4zFfce7vI+JXT6nzju3fJxPF7B7lFSvIearRm6EAIjAtY0kElekIdSPlr7p/kWecQXytJDszWdCSlwQVW4CE2VKE9xLPA2/OkoTaZ6GBJGEGcM6m93KgzPt8tDqfQnIvlZgODnXJ0Q4MKU17vDAzZkdQfS2aR0GWhnKo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/43] media: fsl-viu: fix error handling in
 viu_of_probe()
Thread-Topic: [PATCH AUTOSEL 4.4 14/43] media: fsl-viu: fix error handling in
 viu_of_probe()
Thread-Index: AQHUTjM2sk4mkEQ+AUi0iUNB/WDjSQ==
Date:   Mon, 17 Sep 2018 03:04:57 +0000
Message-ID: <20180917030445.484-14-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:CQZ/PHcPCyDnZeeqIzObyd92iGJjMMyVaQm5dIdEmmompw4Oxlw2+Jz8TunO1ej84EH4V64CxT06pknslzKpLOFeVrf6rSOaMM8WxufDCzSPM/fPXDbjmW9Nl5iPQGD4n/yB3UbvGES5NHUmfr5vpIWvXdWkEJEalo8dQoKlgkOKWveENpieUolZ/MEunt2y1e/zdjoeoKTezY5UjiXQR3V9rjXaDADtKJ1IQthpNLiL+LZlkHOdZ4/ZShDDGp1Nj2FXNEkZj6wzzcLxtuTL4Gxt1S1rRkxFR4GiVUlByBNH76hACFsfoileu5UxhRncBvHJlkOVker7gHdqgLKLNorLcbKooq4XU2N7X7S3lO+DiYMGbvEEqPxOmdTvZDiwMArIi+YT31Qc+bVttATwPpskAYKHFbS4FryDOXPo8gaZlUtwqcXew4n3Xes/9ZHIp4n6yyfCQDGvTyfls/KkpA==;5:K1Q2uJt7LZz3Sm87aviDZ5CyiB/ueLZ4xpJ9Q17eSJFuSDMRFJ+O4OcDqvgACO6L+KTG25lww9APWiCg6R9pHuCoaxtKS1CS+YA7YfdfMZkqrtYTCjV13pAtryWWuG4FIGjARgjYK+xcusg4ZMIo1FehPuKZQKBGAcQo/QR4GU8=;7:u/Adc7OsB7+zqjNelLTf6UElnNcRYRMP+4bNdzC4bLQKG1x05GttMJG29fRvh6+OTYOl4nmrZdz1BCy+4XlxjfSSnJ3ocQp2F84xp9R1VcjCsptw2418wWrreGGMROqmKP18E7ivFy1M1IyCpUjsFrnn4cBDd6pcgsknlXM1hGvqzHpX4jhWaAxaAhs0T+QgZtJ9ce+DL6Hc7XifsHdASeLIr4dK/BERIpnVwxr1ePM8tFAsK94CNG5oYTipB0+C
x-ms-office365-filtering-correlation-id: ca28ae63-b79b-48b7-7db0-08d61c4aa657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742A1EF67A8EEE17B92BF21FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(4477795004)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fSuWrxov2fUzBF3k7Q9x1xhNtod2yUIE1IjTScUzLkhKtAfyxI7pxaJMpI1AgnPX+Nk/DaU2asJLNO3Mdiipu6A1cJUZaLvaFq2ADE5Mm5v/mGS9U5ZxuRTqMw6d26XY6t4xD5Ls85yZidPImI5UPk5B3s5u4dqd6F0BUudmcCklZTsNjyi+NuO8m54X8911ygtLfBGbhGFOtOT7URJ1THgZvdRoEwwbkXQnI0SnMHzUkc8qPBz+wtL9dZm36GS17pJ2hYkxrMAYaBFfZWyszFVOQRd3oL7rBZ+rMyO1Emei4CyL1obWd3yNxkqbKbqg74Z2ifPCUk858IvrP5YLdhijzF4Wh+RUIOEmjYksY1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca28ae63-b79b-48b7-7db0-08d61c4aa657
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:57.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index ae8c6b35a357..7f0ed5a26da9 100644
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
@@ -1476,7 +1481,7 @@ static int viu_of_probe(struct platform_device *op)
 	vdev =3D video_device_alloc();
 	if (vdev =3D=3D NULL) {
 		ret =3D -ENOMEM;
-		goto err_vdev;
+		goto err_hdl;
 	}
=20
 	*vdev =3D viu_template;
@@ -1497,7 +1502,7 @@ static int viu_of_probe(struct platform_device *op)
 	ret =3D video_register_device(viu_dev->vdev, VFL_TYPE_GRABBER, -1);
 	if (ret < 0) {
 		video_device_release(viu_dev->vdev);
-		goto err_vdev;
+		goto err_unlock;
 	}
=20
 	/* enable VIU clock */
@@ -1505,12 +1510,12 @@ static int viu_of_probe(struct platform_device *op)
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
@@ -1521,7 +1526,7 @@ static int viu_of_probe(struct platform_device *op)
 	if (request_irq(viu_dev->irq, viu_intr, 0, "viu", (void *)viu_dev)) {
 		dev_err(&op->dev, "Request VIU IRQ failed.\n");
 		ret =3D -ENODEV;
-		goto err_irq;
+		goto err_clk;
 	}
=20
 	mutex_unlock(&viu_dev->lock);
@@ -1529,16 +1534,19 @@ static int viu_of_probe(struct platform_device *op)
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
