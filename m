Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394AC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970AD2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Oi/qH11A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970AD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeJAHYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:24:20 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729415AbeJAHOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=028S44iN98LaVZLExT8z/9tNrmncioo6L3Wg8DbLwWo=;
 b=Oi/qH11AbN5cHnmNmdi++bB3SANvMob/ruilCf5INq6GhdQvnGx3FaEcXgY5VkcBMHFNB58ujyTi8U9wab5GDR2szc6094h4WR5eN8sfk7z7AdaeCcbNcfxXzj0Yju2g4sRRIztsedeM02gzB72vl6foyBK46JL3Dm+6EM5x1Ec=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/37] usb: gadget: fotg210-udc: Fix memory leak
 of fotg210->ep[i]
Thread-Topic: [PATCH AUTOSEL 4.14 03/37] usb: gadget: fotg210-udc: Fix memory
 leak of fotg210->ep[i]
Thread-Index: AQHUWR8hsbqn1U9E6EywcI59DMCN5Q==
Date:   Mon, 1 Oct 2018 00:38:54 +0000
Message-ID: <20181001003850.147107-3-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:NV49whuKHTuU19ankzleL82IfBDOtPv6QXoO9R1Y0S+Giebm3jeYzjVWKpaFVbNePf8BWa3Q5S5Ksa2O8LDM3sg1YyNlhH+sjjEetenOpRRrwu9YOagZQAh4/kmCJLECV/CHGMU08Wc0OHUXmsjUD7V+Cbq/nqg4/n/puxPhLIwDPKFLLNnp1cz+EL7VsD/20uTJPm/ues0sw4DIo8kdTjHzPy7XLyb9k9xovshf6zNT6rbKtg09mirdB8o2DWDzDz9elIam763R+eJB4BXQhOTRYw/pZl721rHSlkIT7wyxmu3bidgufu7o4Gvq/EFmUC7sj+O5A+aaNhihK5LO4T9xxcSqzXFUDmfEd4ts18gBwSb8URlFcJNO2PkMX//5epTLTYbepkEvbgXr9OWzasHjM4I6781YZAwAjRedjatM3WypExTHAvgsSydWfr2lIthAH0Fs4lJgnmDTfCJDlA==;5:Q749GG1F11klE+uQiA8P7rUm3R91qbjYoX1iCi74NPnzEMN6bFLA/qIqG0DZwtXZ7pMRlqYaWokn4PEtXwxvgrCGiEf9pk2NJiZXIpd1Ci7BStlUwLSmQKeEEXMCgCks0wpg8qlc99fxF635N3r8NqNcvjsuA6PUhZ6N0eOnfIE=;7:XZU/qQ6SxPzgedeDH626qJicv2tUinjp8TJE49bonjMo5N0vXpPhWnV0lutmhRnfoMfJLSczfhz2gaUeuFJGFVUxh0ubC+hszzzbQtCnXT6Spz6VrWp7IyTV0BRAf7UKUep9ATElLgaJaCCac1gKpvn0bXBYxPUof5RUHdfGVtdVeE91keov1hPEO+dGhFcPHnQ5dwzyaEIqnuwU3qrXhMfv4ePuuLEFD9VmgtzNGocHClZM6T6wCQ6GiYuYQUNE
x-ms-office365-filtering-correlation-id: e21d1042-7109-4ece-6bb5-08d627365e93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696402278B0A5D1D83A3A44FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(4477795004)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4YKnIJCfcQ40NAZNUSFXkjBT0yeu9fVi8jYH06Q+vJ4bx/dZJRIW7xrAr6AnW2/4zp4h3WMH9RaKRC/DNdQ31wi3BJKcdLbH+n7oOd3eS/yGNxt8AF5POyArgwJW8qAwJShQqzb3hVWdjqXed+ISdX7pmDbOlPrdcG4KyEK5euzFe+q5u+x6c8otfPvgRuBBLJEZiXcltyd5liZwUUo2T8qD45kTTnEStb9jj7dwbOXJ/U13X4Se1ZYmyENjqez8EHOCSp2NwME/mNx04zFkxWncGRADrpxUa/kzDwmeH9zdp/YmM1UnEhNbR84AcGJ/787Fb/nSjOn4YLiG7a29nNBrjE+jCUXsXdq+oMUW7Oc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d1042-7109-4ece-6bb5-08d627365e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:54.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit c37bd52836296ecc9a0fc8060b819089aebdbcde ]

There is no deallocation of fotg210->ep[i] elements, allocated at
fotg210_udc_probe.

The patch adds deallocation of fotg210->ep array elements and simplifies
error path of fotg210_udc_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/=
fotg210-udc.c
index 78d0204e3e20..d17d7052605b 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1066,12 +1066,15 @@ static const struct usb_gadget_ops fotg210_gadget_o=
ps =3D {
 static int fotg210_udc_remove(struct platform_device *pdev)
 {
 	struct fotg210_udc *fotg210 =3D platform_get_drvdata(pdev);
+	int i;
=20
 	usb_del_gadget_udc(&fotg210->gadget);
 	iounmap(fotg210->reg);
 	free_irq(platform_get_irq(pdev, 0), fotg210);
=20
 	fotg210_ep_free_request(&fotg210->ep[0]->ep, fotg210->ep0_req);
+	for (i =3D 0; i < FOTG210_MAX_NUM_EP; i++)
+		kfree(fotg210->ep[i]);
 	kfree(fotg210);
=20
 	return 0;
@@ -1102,7 +1105,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	/* initialize udc */
 	fotg210 =3D kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 =3D=3D NULL)
-		goto err_alloc;
+		goto err;
=20
 	for (i =3D 0; i < FOTG210_MAX_NUM_EP; i++) {
 		_ep[i] =3D kzalloc(sizeof(struct fotg210_ep), GFP_KERNEL);
@@ -1114,7 +1117,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	fotg210->reg =3D ioremap(res->start, resource_size(res));
 	if (fotg210->reg =3D=3D NULL) {
 		pr_err("ioremap error.\n");
-		goto err_map;
+		goto err_alloc;
 	}
=20
 	spin_lock_init(&fotg210->lock);
@@ -1162,7 +1165,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	fotg210->ep0_req =3D fotg210_ep_alloc_request(&fotg210->ep[0]->ep,
 				GFP_KERNEL);
 	if (fotg210->ep0_req =3D=3D NULL)
-		goto err_req;
+		goto err_map;
=20
 	fotg210_init(fotg210);
=20
@@ -1190,12 +1193,14 @@ static int fotg210_udc_probe(struct platform_device=
 *pdev)
 	fotg210_ep_free_request(&fotg210->ep[0]->ep, fotg210->ep0_req);
=20
 err_map:
-	if (fotg210->reg)
-		iounmap(fotg210->reg);
+	iounmap(fotg210->reg);
=20
 err_alloc:
+	for (i =3D 0; i < FOTG210_MAX_NUM_EP; i++)
+		kfree(fotg210->ep[i]);
 	kfree(fotg210);
=20
+err:
 	return ret;
 }
=20
--=20
2.17.1
