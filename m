Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YSCBcsOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeIQI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:22 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:17633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730059AbeIQI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6tVlhiKCMu17sYQHeJVYzdNdC1/t3B2ykZuTGXLWgg=;
 b=YSCBcsOpPw4hRepYV+b3qkgI2C3OhrO/WdmLTi8GDAnovzeq/VDo7criplrJ8bNaWrTUZy8lDUry4wQjYDau+GxRgPAmFQKeGSconXMnkbLgzt3yI46UORw1SVAVMWvgFhYVH/0GgufyoQIbzuyCDzfYwBVfjmXwHv4+FB7aIuU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/87] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Topic: [PATCH AUTOSEL 4.14 29/87] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Index: AQHUTjLmy55KdzMTx0G32bIbg+JNRg==
Date:   Mon, 17 Sep 2018 03:02:42 +0000
Message-ID: <20180917030220.245686-29-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:mJ4k8pxhF5y0/f0lZUWTLcQfeT1Imn5Z6p2SVg4aRFshN4SkN6GAQrpjvj7E7j/TLPUtePAJLNweUiZGFfaqaaeKLNW+v2UCbXBB564AG72Lf3E7ifQo93ASQiiZteJvj4yV91BXL3NhW/kis3XvcutVw1+zlHdC/kMgDCKADF48uY0RZMVCGK5/acuvMnD0VpEPXueeVo9OkhmkIBwzEIzqxh3gGpBap5jdGf/i+uyspfwXIoOcmZ2k965grTCwemK/jUZ6keTdGGffecRONdx7Yw9AX+ELy+u/lbmxW1FcSU6GGKZBXAt+g85tZBJgtA4i/DabU7OHnhqrcjhKwrqKsWcPbvwRRkZjeumeRRATI1Q0CkyojqciJOVJ6+1eXNqG5H/MWdqjtxfCoBKlZ92bueCMc83d2N6HcHdP9kXZnyGcSWZwkQZsl4HYN0LKhh+HTScvtu1rWuJSq6hc8Q==;5:z8Wyvma4nbr1e/4f9qn8bsaDBiSRjuo6E0v6EfmLNc+TvRvhVGOoR0uwS2QrJz7ysNYVOR3xkYQB9VmrF30SAXi4m23RvUqPM5zkA0P9L1TnEUIwQpAkYbUxeGCIGR3zo2Mh5kDot4A4UIPTlxQ31gyt613NO+tVapeNkVo8ukY=;7:iX2vpVo616A8DCaGV37SsvUaWFNh7xbweqf8z0eZB7L19/LWpAurEOpiOUzEYFzWjHzznDx39yVENocNmo8S9P8fB5ot3vnHky7W49QAG5lAspG0n6g7IBrrK63dkdULBUbmx/M1z0IWpK7nGdErAZuikM6jj4GakAYXy0Il9Y/sx1/RnH22US00lu35JXI+na8TtbhWBI5xyrrhqKNUtvoAz5LAhSLFDEaoDsb9FSW5wCYFPrSCU8ZnVdQDe2D8
x-ms-office365-filtering-correlation-id: 0bfccff8-6f38-4081-3d5b-08d61c4a2b97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047080C940898600A4276EF7FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OZzGwM4HyCPSNdHmU/9+I0bgcrBmYaF8tmV1IgHTDlelndfHn/fLMMquyZFaiJkLoQPJ4rMlkuk1KKuQdyUMvn5E0Un4pwZO6UoF9U/9Or5SbnvKlfgCmdwPLxEZDkJiFGPvi5YRcEnEA+d46J9UVIPHOSoKASfmoPVG/IfOdzCSIfCAg1gdPQHFecKT+duVv/dn8tMsBXiha0KcZD0NhImO2JcANzW9bPzAtVnHezwJcusLKThK33LTmXiK0NGatlk/q2eR2AtQzttP3OaT6ljr+KzeSeZqeQJs9sIl38EoZ0SOt+6DE2fpa/6VHsx5NOx/jsL5Fzb7PgNCldI/7C2debIRhS+g5Ipvler8n+I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfccff8-6f38-4081-3d5b-08d61c4a2b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:42.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index eb5a9eae7c8e..0722e9ad2a98 100644
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
