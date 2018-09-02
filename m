Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA58D20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GmM2ixyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA58D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeIBRWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:24 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728943AbeIBRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itHIyWKy6VaYf43LzZ0VgnvVUfO5H26RihGAgxrDMhc=;
 b=GmM2ixyhNCEZx62XL3ApDyWiFG2NQCF/2fb1gyy5HQNNV/NSaYWpaHzR/PgCAn0AkcKruv93ameTAohvqlFCgXmqNc7bVNIWzMzb7gcR29qI11bRC5E9DyIwkkYCzgI8EdvSrDWs3SIfm84i/669nL8kAdiacOcg1Sx+fuKqFOA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/89] media: davinci: vpif_display: Mix memory
 leak on probe error path
Thread-Topic: [PATCH AUTOSEL 4.14 09/89] media: davinci: vpif_display: Mix
 memory leak on probe error path
Thread-Index: AQHUQr29QEwFiBojUEauXuXtqft0xQ==
Date:   Sun, 2 Sep 2018 13:06:19 +0000
Message-ID: <20180902064918.183387-9-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:/NbOQEgxQeIjVMfoTvp3wrXlFbDIghdZZW5sRXT7rkRcupXyiEQbhtflmmqTAq9aJwAHtPWm8LKMF4C63RrgOJPHXyHz+ef6csGCFBHyQVO9uKWBXD7AawScXtz98gu/56P05WwM9Cgz3uAoqMNj65+rX3mThB1rWAdhozQUB+q3iOaWnbRSf6tn/Gf3sjOYrSAXkY5ZnypM3NmGmu1ZTQdxAFNT2e+ybJZhs3cta9BvUKS7V9QjiJP86p0Xnue9O3D9yl036VdN4RTSi5cxEypW+xqtPLM0/js4GZr3zKOnqbyuCNNtY3ZP/vknjTGM2+nKAe7BYT5sYo1qDXDFElmXbqb//uN0tHONFKu+48WN1rGiPF88I2Y2ZHv65tVXrT9bDpD01EDc1S349+8+Tc4GqS0ZY9PunHXoLjB3EMNJIg2MpCNP+ow9MrP2Q3C+yEG/dsgJPmA92DjB/EdJJA==;5:pB1Opvb1EIe7CvnpjcMr98GzLIGs5+wdf3Rcs6Uwi8Hjxa6tc1SwB/ZZaFPzUGjQVa1ttuQsuLPl3t/RmxYdEj3EFsKYTEYV7EjkPTsLJZfIfjy/HaHqyjQ6s0MoUFxM59KsDAdWBbl2J8vOmWYeh4eZEL8ubu/gXbSF2+5tItc=;7:rrJpe2eoFr0Kz+nbrg9DHLHxnUfzt0t0SVtZVgreTr0FgRzjquU5CxntIzZGGsjixZ7DF4stnciugN04hnQNOzEbx9TRsnVJ5LtGs6svNVOW4ORXD5EH854nkguiQLbylBjApWLmfODoHNMM8Yc6SrFY8SMFJOwZEBHhmumv7Pz72a6WLj0QKz5BdKdjp58Ih+dLBaHIazZ7SU8bayp8eEIKUbNW88P+/eAGkGhQzSykPGNMaJqZGPNtpmQClAeY
x-ms-office365-filtering-correlation-id: 941aa937-7cc7-43c2-594b-08d610d4e23f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08229479405C4B8F7C9CC007FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(4477795004)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eZt6pkB3AvNjOFBLC4YF0f16ZyZ0EUcVdgAU69tD/oEMEKKm8snnsUZ15EfUqwbISAHgcS4234vOvlxxzjvlDuv/2IQ40c6qOcK+LuTiV9ilOm83+L8AlTLuGODT+R+Iejd5nFny6m8XfemVytr1iXqG8k+xWN2LnAZIAu4Apej3BbQndZjZwurlUppg0DgYNSODKo8lVL59pr9Zr2OFndSnIfFJ2nQTpF8oBJAX9A58q+uV51syjktXCpD+Kdb//+QY5t9z3fi8Lg1VQ5LBYuseB6lJbWJh7gXTRrTj0tGXQ3SospibA7ChUBv9e7Rp0EOdSxWNP7Qq3uPVcM8oh/DkyYQxA/GuPwR+oUhE/vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941aa937-7cc7-43c2-594b-08d610d4e23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:19.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 56fe4e5b396e..4a65861433d6 100644
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
@@ -1250,11 +1258,6 @@ static __init int vpif_probe(struct platform_device =
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
@@ -1266,7 +1269,7 @@ static __init int vpif_probe(struct platform_device *=
pdev)
 	err =3D v4l2_device_register(vpif_dev, &vpif_obj.v4l2_dev);
 	if (err) {
 		v4l2_err(vpif_dev->driver, "Error registering v4l2 device\n");
-		return err;
+		goto vpif_free;
 	}
=20
 	while ((res =3D platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
@@ -1309,7 +1312,10 @@ static __init int vpif_probe(struct platform_device =
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
@@ -1330,6 +1336,8 @@ static __init int vpif_probe(struct platform_device *=
pdev)
 	kfree(vpif_obj.sd);
 vpif_unregister:
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
+vpif_free:
+	free_vpif_objs();
=20
 	return err;
 }
@@ -1351,8 +1359,8 @@ static int vpif_remove(struct platform_device *device=
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
