Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D5C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FB52083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HI8N40EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FB52083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJAHNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:18 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbeJAHNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0/7YZB4RumOH7Kk2wR9o3c4vFdiBHHDwxvX1FqO1Og=;
 b=HI8N40EMEBQ4gpDwpjXJ0UDFw1+3tVo56kkkqja/TxQMu7ezVjBzMAWXQSY8rlIylL1XlVq27ctHO8jOeqznLmjfUQ1XWpz/p4QzzIuvdArxIb+gKSCoJih67ulVxXCeVO9ZK2Q7w54EgJfTTjSKlBeisZPmveC+vqGGGv4HmWQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/65] usb: gadget: fotg210-udc: Fix memory leak
 of fotg210->ep[i]
Thread-Topic: [PATCH AUTOSEL 4.18 05/65] usb: gadget: fotg210-udc: Fix memory
 leak of fotg210->ep[i]
Thread-Index: AQHUWR8EW9oghlPgQEeIdL676zZHyg==
Date:   Mon, 1 Oct 2018 00:38:04 +0000
Message-ID: <20181001003754.146961-5-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:uezVXxj8iDFiSwUNsOHnblhPBIRp+m+xn6azdRpcxP5iQT1l0CKyZUvhDIJtc0YzkJQvI3NSX17MBiHSrDJg49J8eyvEvP+0ojPdYUwvqC0MLDWWQUVHAdybKTtzI6hXJbbAeeFeXxCWMvT94yb4+lCm5mGMi8NAUDt4nUUqAOn/5ruOumXyrgpVmIWkdKT32k6g2yZCuvYa4e+b0AVUd4DPM0+YwtfnaarjYRqNqLuPyxY5TdQZRyoBZczOP9mvIUpZzcBTS4HJb2ALzCHLgBthAe0iDfpXHSj9yMjOenyMl78RY40IxYKPMdW3i6xJR63EMEzCI13WlleGk5Wyr3ejFJhXa858W7p8Mtf8C8k/TWODqUJ1X8FpjiZritGv0faacwVdqMaFgneX4+5++pen6AkhXh/Cn4qauzFJCio3yhcKnqTxfbBOcK76bMrhGtxD/89fjART4f9eGUUCCQ==;5:4gtuVwsXsQQUG0BL2UWoAW2sNYu091mtirjpv2riw3xfA8HV05RYhOeseVFIY/2BG7nGiGeYY4h95DCA2uDsAvREENWDSDQwKs/XvOHLxK7vgBkaJ0unvnM79doXSNxe1SgHPbyoXUw51cu9DPYWScxfMPMvVR2eUyYfU5C5Vjw=;7:O1KAXmMj3fU7bc9PVBHxcoxSrAqMDtsBnEJY3o9x+A1RM8e6MEc7+XjS5f5OWPSw9znaQZFUn0UNc5kAjznZakdWAzpcahCHMXNsH0fKqVImzVfckC55IX8E5Zq3oYZOREd/9Teeb3ufKZ7T+9N3mDOQeDsH2EJguXnvAoZkzKZr+8SOJl5wxEp6yjRpCBJjRte8XUmL68ULy4FTdY80ie7deAKmFDJn4MkW/y0QDbR0tu1axIXRgtbZ8mMHXLrn
x-ms-office365-filtering-correlation-id: 026ff66d-72fc-4a03-2f06-08d6273626e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04698E1246080202B4FA2F76FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(4477795004)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v0N4EcH2022AGv5XzFbHAF53O80GF+eS3SjEJZPQke2tzptGsxx+s0xF6JrN4NT0Mgyi2zc/qhaN6sRIlhYRtbHqULDwWpMHlRuN9mqFH285onVrWYkTpTb11BcqTGJUY0yIPLzQB0BSUE5EogmBfkO2aj0gvQtxeBtSIdxzVErWNXsks1BjbHwaXTY/mJMySTbEllcKC8LK7pqEHprDj0mBVvJZQHGlAOaU2BVzJE3UqhQ5tf+RPHb3oD19pBI8Mw5sBCJpG4ezDZ0bsrXkorqFd9hJDz5euKUu6f9i/nFOa9NDTvQPR4I7FIFatLI99w12Gqrozsjtf4gYtNtKZHbPR1wPcczYmwIbru6cMX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026ff66d-72fc-4a03-2f06-08d6273626e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:05.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 53a48f561458..587c5037ff07 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1063,12 +1063,15 @@ static const struct usb_gadget_ops fotg210_gadget_o=
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
@@ -1099,7 +1102,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	/* initialize udc */
 	fotg210 =3D kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 =3D=3D NULL)
-		goto err_alloc;
+		goto err;
=20
 	for (i =3D 0; i < FOTG210_MAX_NUM_EP; i++) {
 		_ep[i] =3D kzalloc(sizeof(struct fotg210_ep), GFP_KERNEL);
@@ -1111,7 +1114,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	fotg210->reg =3D ioremap(res->start, resource_size(res));
 	if (fotg210->reg =3D=3D NULL) {
 		pr_err("ioremap error.\n");
-		goto err_map;
+		goto err_alloc;
 	}
=20
 	spin_lock_init(&fotg210->lock);
@@ -1159,7 +1162,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	fotg210->ep0_req =3D fotg210_ep_alloc_request(&fotg210->ep[0]->ep,
 				GFP_KERNEL);
 	if (fotg210->ep0_req =3D=3D NULL)
-		goto err_req;
+		goto err_map;
=20
 	fotg210_init(fotg210);
=20
@@ -1187,12 +1190,14 @@ static int fotg210_udc_probe(struct platform_device=
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
