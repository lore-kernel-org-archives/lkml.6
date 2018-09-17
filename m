Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B468ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0970214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f+w/LK0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0970214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbeIQIbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:37 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730807AbeIQIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFPp14T1JI7dtzQGr0s/02xnfgaMaRDaoWX9e/vguo8=;
 b=f+w/LK0f+bx8vU2TLIGU/dXDsqMTMMxe6f5M5k22EhMXnVGey87paHSaQ/Hx0t8FP34mWJZuvYdelY4+uzPaffwRx4pE/TDKp0Fzmb7/RPyLpIBb9WSF2exAyl91jvXwARd8JQniIW8bxzK8Z7MxGBpVPKgiBaSvpHVtw4xQ5pQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/57] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Topic: [PATCH AUTOSEL 4.9 20/57] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Index: AQHUTjMSP5cLDSpT+Ey8e+CjPHNa4Q==
Date:   Mon, 17 Sep 2018 03:03:55 +0000
Message-ID: <20180917030340.378-20-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:SDl4slBjime/hXZmy0Z7gwJWTro9p0W9qXk76/XqePiSYVIUaYcWk7Qdg6xPNhkFXzdFbgfiwXlSL+gGknl1V7GCypTvQJpi3JbkeY1Ash+sy0TLENEfXzmz4E1A/zqQWOU0+Ro+EHsWNYrJXo+8Tdda6V58BG70LDHKbvkSSsf9zdYBS0h51mywVe4H/feFGIW65kuv/FqhvvRfgffFlew3q8fMvj6S5Stqyuc7ZJ8AfnkduIpSeULACrLb7BXFAsvV+nRtWO9TWIYy+ZVRN89KKqUBiRv1CTH85rS2MvfmU7Xtu+m//VCVnr4rz2GxjoGWdoqfB4BmkXTiogsUsZHEXkHiQeZ3uQZAECv6MtG4XBCdV6wCnNlj1JLR8E+bjYpLlUKG6bb5dz+3K33WeWa7IA0vtUcw37HhoOClMZXsanzCSOnQ/sWtKGPl6UAt2lGaFvI4JDB262tHmUxVtg==;5:lk0sRB3OK4v2M5r0jm0owloAX6110ua6lhz0EUt6ut9O+p7mde5boiwKj39VJgjYQmDfjgb173dmLbZCEW8DaEzW8GSA2ia2bJPnfB1a9PdUaCl8VDZiDJFn3o2S+hJID1z/YQ0flCBrbis/j04mlJeQLztG171p7A/a8ZTRTtM=;7:SSjVMvDNGjmbhczhO3yIY72ih9vY2Us6aPDUJ70RucwyXsbMO2vNmoBvBOB8gBqc3Dl8lXF/21E4eFiAx8kaU1+1Tos44n+bKPfSWKDxRcBfFbRR3H4v26+QZOkoTRMOWcF1iq63Ua2V1Wp2XYL1SZY2HFWRZMFV60pxN/aQq0tL3lKwh0ubkSEineid4hQxPyG0BEbt9eSuQVwaL8EcePftfAMYgnU6M7m6BQQmFicDqEa9G1qO2U5ogpc6QLMH
x-ms-office365-filtering-correlation-id: 25e319fc-8a22-4312-141f-08d61c4a745e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120BBA633EF5FEE798F8448FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: E9G9XKhfARmF7PbpqdT6eo+vcFeDU1xiRKNKDPpGDzeVqDyVGY7TH1R72y8JTqDNPERO2avqp65brl1zU4DXp8aS+oJuxfvd+h58JZ51hVJF7mY+Iij7pM1yzwc9fIXCEw9Lw25g7AiA8g1DEHu83xDNsPl25I6bwm5lSdjBStLRuHtHOIPvCXVqcgmUWGybWUhe6nP7J1/zrckIX5VBubDBY3jtglgZ90vcivNcYo5CaS0JGZvdqnnlIXvXJ00npNotLT5BRDXvpeO9FVbBy3tdTAXFM7k1L6HwmOdS8HYKcBVQ1cDFTfTF9OdGQdrJIxXiX+sfQr7yffvNYzqrin5C11SGKUwW0bAMcPkE2rY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e319fc-8a22-4312-141f-08d61c4a745e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:55.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit cd63c0288fd760ce7de247fba618e2bbcfc0c35c ]

Currently, this driver does not serialize its video4linux
ioctls, which is a bug, as race conditions might appear.

In addition, video_device and vb2_queue locks are now both
mandatory. Add them, and implement wait_prepare and
wait_finish.

To stay on the safe side, this commit uses a single mutex
for both locks. Better latency can be obtained by separating
these if needed.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/sta2x11/sta2x11_vip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/st=
a2x11/sta2x11_vip.c
index aeb2b4e2db35..521a6f84359d 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -145,6 +145,7 @@ struct sta2x11_vip {
 	unsigned int sequence;
 	struct vip_buffer *active; /* current active buffer */
 	spinlock_t lock; /* Used in videobuf2 callback */
+	struct mutex v4l_lock;
=20
 	/* Interrupt counters */
 	int tcount, bcount;
@@ -385,6 +386,8 @@ static struct vb2_ops vip_video_qops =3D {
 	.buf_queue		=3D buffer_queue,
 	.start_streaming	=3D start_streaming,
 	.stop_streaming		=3D stop_streaming,
+	.wait_prepare		=3D vb2_ops_wait_prepare,
+	.wait_finish		=3D vb2_ops_wait_finish,
 };
=20
=20
@@ -859,6 +862,7 @@ static int sta2x11_vip_init_buffer(struct sta2x11_vip *=
vip)
 	vip->vb_vidq.mem_ops =3D &vb2_dma_contig_memops;
 	vip->vb_vidq.timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vip->vb_vidq.dev =3D &vip->pdev->dev;
+	vip->vb_vidq.lock =3D &vip->v4l_lock;
 	err =3D vb2_queue_init(&vip->vb_vidq);
 	if (err)
 		return err;
@@ -1024,6 +1028,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->std =3D V4L2_STD_PAL;
 	vip->format =3D formats_50[0];
 	vip->config =3D config;
+	mutex_init(&vip->v4l_lock);
=20
 	ret =3D sta2x11_vip_init_controls(vip);
 	if (ret)
@@ -1070,6 +1075,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->video_dev =3D video_dev_template;
 	vip->video_dev.v4l2_dev =3D &vip->v4l2_dev;
 	vip->video_dev.queue =3D &vip->vb_vidq;
+	vip->video_dev.lock =3D &vip->v4l_lock;
 	video_set_drvdata(&vip->video_dev, vip);
=20
 	ret =3D video_register_device(&vip->video_dev, VFL_TYPE_GRABBER, -1);
--=20
2.17.1
