Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC296C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1ED2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dz55hJRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1ED2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeIBRTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:01 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:46915
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbeIBRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmfsSB8v5bvAS0wlvNC0l6IpvINnD7UWQSAMV9IOSj8=;
 b=Dz55hJRJ9rsaRIIvQnCBM8hw6lLs+GZfCfbTlc8RPEw77XY9zafikpqdi4mxk9IXYVgm2p21mgTSQ/b+VijxMtx0dXJb1nXZ1ht8Qlj4jWkf7n+l1GgdLLYEs1UJbvX9PqK5tnnyJOQFeLSplqoyK2h80tUYpbLhogll9EQYu8o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 013/131] media: davinci: vpif_display: Mix memory
 leak on probe error path
Thread-Topic: [PATCH AUTOSEL 4.18 013/131] media: davinci: vpif_display: Mix
 memory leak on probe error path
Thread-Index: AQHUQr1PjdXqDK45HUCFAUvxfs0A+w==
Date:   Sun, 2 Sep 2018 13:03:14 +0000
Message-ID: <20180902064601.183036-13-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:7OkHrEqPN8gmyYdwRPqcmkaqnr6k+7LfljsRs7J3MKL9KVAWybvL6n9l+5/2NyKAmf7ZyhnnKHq34X+UqC5VBVwQ3MHR6kzu1Cw5plb5gBRUwqgkpYkd8JylMOEan7hDXjMPVXtodJfWJwOM4EPUDeAz0N93slOxZKeE8Hgm5DaP++3HwAovHX5Wv5Q/PumC9djoXx03MI3m7kIZuLjubNMaIDYHxHKXW9kxjMlVpLRqRuwDNotODs/SqZKjJ8eoyTeySC0RZ+LH0L8HvRLjBX/u5CBgXFD0Bv12Z6fT3fbhA8iEdRIzLpiKxwAZfqoF0A/l3sFEOxrIJLXm4HUmtJVhTmEsZAVrZTu6lWSoME0oi2UkZFKiQdlmWLRff3ZmNndhd5f3v1V7rrWPJzY5hjFEMXvJf9RVCFbZZdZaVo3sg9zZmKUDQkynnfFDsh+W7ItklVuwJYInJKc43ctJgw==;5:FzscCpgVBmCIdNE1Vjrx/dgi3RmamOMyebP1QC6bi0Tk0z2QT1U6P2sf9wjb1oF/826Lm0s5DpClJ04JgWO3NJTtidAFE9iQopxpcVhNgYPG1GMgYHGyGRNriiFawgCKCYllZHl5zewvCNHXGASgFnwppQc6L65Ghs7aW3Ygjxs=;7:JBTq1oTHxF27t6xuoyaz4OZicEjdTJbs2PJhaAnNye4XF1VtbT7MEiYJ7XjI4CMkLtP1JF825jx5MGNLuEQFRsBh5yicAGt4B58CmZjjD+Pq3DqztqVLaWzjpXRm0HsvuvMxVog7H+i4rP6c9t6IqMkqjwJWBvyLU7JhNK5LN3CDlSklVQ/TSOTuoe1AeL7FIH7Ime9kh06PRVJNYI88PX7K+AF8jTazJqvY3k8DcHTdMN4GxRWnWIaxNivyMhmu
x-ms-office365-filtering-correlation-id: 488a5112-f13f-4d20-bd30-08d610d471c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015027CFE9384385891E89D8FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(4477795004)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jc/UGZOvuR54Eb0qGrVgG8G5Evm8e2kJABEX568ljR/WnAqGspRSTisvEt7PnOFZ3jahwwQl24xOjPpA5woEqnPp1bJ3RYUAUxkW/9kWds0ZQn4Xv3e3uvgb1Xxy/VVxZCuLWwRDKUoW9bMFNddcaSptLforXERjkL3+hBoSutC+u26L3GxdswMxD7Y2F2TmxMF7DqTK8imsQZqMrgNi/0/sdpc6OpT87qIZiTC6ZRlObnGbcaynhx8rwda4nWQMseJtsQ28YIu1Mu5HUVKaUY4woym6qOPGKJhoXPIBV5WKkGK9mbE0RCCASmH4OwEyZLV6as0MnTkcHQt+k1oNogdyIWP9acpxchA2X4LjgoA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488a5112-f13f-4d20-bd30-08d610d471c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:14.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 61e641f36ed81ae473177c085f0bfd83ad3b55ed ]

If vpif_probe() fails on v4l2_device_register() then memory allocated
at initialize_vpif() for global vpif_obj.dev[i] become unreleased.

The patch adds deallocation of vpif_obj.dev[i] on the error path and
removes duplicated check on platform_data presence.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/davinci/vpif_display.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/=
platform/davinci/vpif_display.c
index 7be636237acf..0f324055cc9f 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -1114,6 +1114,14 @@ static int initialize_vpif(void)
 	return err;
 }
=20
+static void free_vpif_objs(void)
+{
+	int i;
+
+	for (i =3D 0; i < VPIF_DISPLAY_MAX_DEVICES; i++)
+		kfree(vpif_obj.dev[i]);
+}
+
 static int vpif_async_bound(struct v4l2_async_notifier *notifier,
 			    struct v4l2_subdev *subdev,
 			    struct v4l2_async_subdev *asd)
@@ -1255,11 +1263,6 @@ static __init int vpif_probe(struct platform_device =
*pdev)
 		return -EINVAL;
 	}
=20
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev =3D &pdev->dev;
 	err =3D initialize_vpif();
=20
@@ -1271,7 +1274,7 @@ static __init int vpif_probe(struct platform_device *=
pdev)
 	err =3D v4l2_device_register(vpif_dev, &vpif_obj.v4l2_dev);
 	if (err) {
 		v4l2_err(vpif_dev->driver, "Error registering v4l2 device\n");
-		return err;
+		goto vpif_free;
 	}
=20
 	while ((res =3D platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
@@ -1314,7 +1317,10 @@ static __init int vpif_probe(struct platform_device =
*pdev)
 			if (vpif_obj.sd[i])
 				vpif_obj.sd[i]->grp_id =3D 1 << i;
 		}
-		vpif_probe_complete();
+		err =3D vpif_probe_complete();
+		if (err) {
+			goto probe_subdev_out;
+		}
 	} else {
 		vpif_obj.notifier.subdevs =3D vpif_obj.config->asd;
 		vpif_obj.notifier.num_subdevs =3D vpif_obj.config->asd_sizes[0];
@@ -1334,6 +1340,8 @@ static __init int vpif_probe(struct platform_device *=
pdev)
 	kfree(vpif_obj.sd);
 vpif_unregister:
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
+vpif_free:
+	free_vpif_objs();
=20
 	return err;
 }
@@ -1355,8 +1363,8 @@ static int vpif_remove(struct platform_device *device=
)
 		ch =3D vpif_obj.dev[i];
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
-		kfree(vpif_obj.dev[i]);
 	}
+	free_vpif_objs();
=20
 	return 0;
 }
--=20
2.17.1
