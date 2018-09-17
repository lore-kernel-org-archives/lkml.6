Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA52AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B240208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UhwqWc4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B240208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeIQI0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:25 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728869AbeIQI0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8jJnR7vGjeckOf5MAv4edkqCVZW8n0tcsFN6RQ6Hg8=;
 b=UhwqWc4QWDhq36Hp/6sTSOwerPD/rVqyyH1dD9071CPOgqWbfZtn5FTNlo2tL/jin7mpud3zc6uTO1FWBt24I/AlBVdgSq14plAauUQQMWGuyZog35oTjwkfYVkbwK55NlJxDf8w+2tX456c/iEwo0/k+MQTKGN9HLaqm/VRCUA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 040/136] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Topic: [PATCH AUTOSEL 4.18 040/136] media: sta2x11: Add video_device
 and vb2_queue locks
Thread-Index: AQHUTjKb4Wu9yN3vEki777TbnLBs5A==
Date:   Mon, 17 Sep 2018 03:00:37 +0000
Message-ID: <20180917030006.245495-40-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:4SL+C458NMYEfhfPVU2lGVFRtU0kXXW78c+XZrPZz78M1WCI/0HQQ6oA+7FI1jFr4vZ1Dlm33YGkEXFXq1rvMX31t8v1euzCOQ7QD/zUUujuf8GtD0t/uFWC7AtmelTk1mo7jEynPURHj4rCdN7GWPk/b5VUj/k2r08Sh7I05bmUpG3bVr11oPRN8Axov/gOas2UkBPZjhFtZUrqRbYJQPNzUcBUxokwk60uzoilNzSuOYJJ0wSwHDqFQBL8WYiCUFadzA9Cb/Fz7CEJC0pRg2zIHGPOvgNX4oDbyN6FQu6fRdWD5DEtXyiyR7jjvXze+HlnBoefwNZC/RhWqhItMzqNSgbV7uQaMaFkZm9YqmmS0azu8xmsytZ3Yb05dGe8Ry6IdSn3qeQ9fXP8rKTjs7lmjSSEZNUjFTlFlWdORsRvqfhqi9a8p01Q0Aa+4hHtJzfCo7Q/VUb0TH9HFAyNpA==;5:xhGnuxnQr1zVMEFqJBrOGM/4IxewxzPx7XsXkx0m5WRuLk3OiPpIq7cAQHKF1iBDaeKnNE+BzsedRWK2x1MNQ73O1vXY/tOCWK7MJSNomFqYWvRiyBOtGsIyWwyVx6eFcL4yL61HRefJDvinto7Y0hiPXz6TxQXzoAFmxVm0zNk=;7:JNYnyQ//trGjet56OIkiYMPC/GJU842+h4P4G4WYGwT01ZM4aX9XQUiobiIMd4Wq/FIcQHq2lUskxv5yxihSxg9tdt6XSz1kFIqyMc58kHtK36FZNoRrN2QtVgzigI55kkBhhrjceiq1e3XXE2XNxKF85yq9fBmihYjeJJi8t4dSy1Zr743x4IZ0qbYYyaHaCtISmVB/BNucloCZB3Ahhecz9u8cY12GOYVFQaQqYPZ95cD7HvSui1gffql5jOXl
x-ms-office365-filtering-correlation-id: 95ed1543-b899-4a7e-5388-08d61c49cf21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06299FE3BAD623E24C39B4FCFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7wt5dWymwWFb15x7/D+XlMjZZ2Ay40rw6epcALKJegU1orUqDOWVxuprz55oJKzxfhKNFVYg2YwNNZiczsoGWmi+cNJ1cP/6ZPeT+6CT/xYaTHQTYXJPOmfvb7icjQbO3x8196KMQw+1Dput6uxct01wb8o6y367QXWwGaFCaL1KwZVOq6SqyzORpAeSiacE4ORS76Q7lacS+teP28XO86TcZh5EQzEl2X8y6yT7S27BUXtKLsLWQyeMnbDONLsKO4Yi5zoNMlvOmJAES+Y5w7ROojve23Q3RlwTNF/5BNZp2MaAlVIBASc0eqbY5SmnX1RpYYFDakegBm7zXuVnKdHTYwsk3OQbEysDnzQbRro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ed1543-b899-4a7e-5388-08d61c49cf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:37.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 069c4a853346..da2b2a2292d0 100644
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
@@ -385,6 +386,8 @@ static const struct vb2_ops vip_video_qops =3D {
 	.buf_queue		=3D buffer_queue,
 	.start_streaming	=3D start_streaming,
 	.stop_streaming		=3D stop_streaming,
+	.wait_prepare		=3D vb2_ops_wait_prepare,
+	.wait_finish		=3D vb2_ops_wait_finish,
 };
=20
=20
@@ -870,6 +873,7 @@ static int sta2x11_vip_init_buffer(struct sta2x11_vip *=
vip)
 	vip->vb_vidq.mem_ops =3D &vb2_dma_contig_memops;
 	vip->vb_vidq.timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vip->vb_vidq.dev =3D &vip->pdev->dev;
+	vip->vb_vidq.lock =3D &vip->v4l_lock;
 	err =3D vb2_queue_init(&vip->vb_vidq);
 	if (err)
 		return err;
@@ -1034,6 +1038,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->std =3D V4L2_STD_PAL;
 	vip->format =3D formats_50[0];
 	vip->config =3D config;
+	mutex_init(&vip->v4l_lock);
=20
 	ret =3D sta2x11_vip_init_controls(vip);
 	if (ret)
@@ -1080,6 +1085,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->video_dev =3D video_dev_template;
 	vip->video_dev.v4l2_dev =3D &vip->v4l2_dev;
 	vip->video_dev.queue =3D &vip->vb_vidq;
+	vip->video_dev.lock =3D &vip->v4l_lock;
 	video_set_drvdata(&vip->video_dev, vip);
=20
 	ret =3D video_register_device(&vip->video_dev, VFL_TYPE_GRABBER, -1);
--=20
2.17.1
