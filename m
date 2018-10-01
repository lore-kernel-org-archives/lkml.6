Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C46C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B02083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QnCLnlbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5B02083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeJAHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:21:43 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbeJAHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOdiXoEWFgn/cGyYlrrKzlTp1cvVMayIO6LyUe4LTy4=;
 b=QnCLnlbV8MAb/ztfESKe3n+G2ceiiqWboMBXM+aAyfTCoflfPl7VeaRgPUbmDGXu/ovhA6P36igeli12d1KKGkjzBr1svb1W3GjBP3CNO2ayqGEPNmHYAPuBzQQXO7MUeGgzUvRe56PrR7dwJM2cm6LfLuVDMzzH5weiKAeZ/DI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/26] usb: gadget: fotg210-udc: Fix memory leak
 of fotg210->ep[i]
Thread-Topic: [PATCH AUTOSEL 4.9 02/26] usb: gadget: fotg210-udc: Fix memory
 leak of fotg210->ep[i]
Thread-Index: AQHUWR9a85QBNEia2EyTTc7YuUNM3Q==
Date:   Mon, 1 Oct 2018 00:40:30 +0000
Message-ID: <20181001004026.147201-2-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:IroaNg796buxdh/3rE0P6FdbwTLGwPr23lZuFEpMpk9lOcUfxtJdZVgcBwlMrgyBKHvjzGMMlxC6T4mJL2lmPRWL0yNLVp4xn94BpjgWf5ug5U3HcqkotYa9MtwchaMCTmCj2IABegfCzH/C2QuDhyvXzlMpVNgvxp0+Kbx4UN6XFg9jY8JmMomm5D7wNFgj2c7FHZVINJQ5zmjSN7PwfRt3iR4hHqUyHpsZoGbOhopwXsDM21zw4tBUBqEgiJX2B9mvdYd0ynCl0AcngEpLZZkcaSZw5yb3trVKJq6sA4fCGo8OC/VfEUzDnb8o3ByeNz7ACinzy7CseG5jtjT5+ebxNTUmREl6jfCxj4LNM7XFHrrHDWJfU/K18SrM9rRlVkd2IqJVQfdZTpaYRDVPWD3Yzzfp2nbNkwK36BJDvEUvP7ShQuGiuI/BBrgpODLG1BHhMNc7aaifMtK6pLIc6Q==;5:aqRop1zXVq/pBU8Xn1V0Aa1O0NZjVkXcxHLSFUuJes4QbTZ1GasdX6elwq6dihktQZ2NYAcJ9u6LkEfJM+3mU5D/aRLJCzU1fZu0oFNWEG7aL6yknE9Is0xA+Ung9mJQut+jRyCTHF0rS0fp8+VCw3aZ8LwlxoQEtTaoaqipj7M=;7:6tNg7mO8kX6ASt0xsGV5fTDNNYcOL8TcYtY0gDuggZaPqaXw29wJ8aHm14vp6hD70UmMW+UvF2dn9ixxvsk5v5BRNqOoVxtl1zt2A30qnw0ZIlnB6VtoOG24U7a/OjIB4qkPzdT/4OwYYr4T5rwy8Myzs8bnkFOhl/ih9qmfK+oFiuXk9rOVKrwGByalwNBOaUDr+QhXxxIBBrV3qizc65epQ3GBORZndAV5IVNQsR96EMLl2fAUM/LbPHKDPS7w
x-ms-office365-filtering-correlation-id: 28955004-86c6-4964-e27a-08d627367d87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120C98A0450CE15F1A107E5FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(4477795004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +iv2uWCJcjtH3WxfRoXHOD3ZujjRKe8AxvuoeyITtaXFkGe/ZM9AW6R9eB9z5lgig6LFj1qLS3AGC7H4m1dW6qLy+kn9cZ0FW9Tzy6UsNEtGYzF8WA/B7+ZQb7jgi3AbmCB5/WgGJHkf2cKgEX5F7e5GqPj7aQZy3yVfj+BVrNpWo2q+1msmbDNvryRCAi1ITtfJDjHVY8nX+AUw/cA9Q0zcDbWJDpBk5ZECmwMEm95sBw3eF/RzJR+FFBTb8ZTTC9xcJDfzW0ENOiqsHdUlWLYZP283rMeYyDBLU2LYpB6FT93PDW0P5FUK5Bp7oBuIE+AGcRx0KhFy207anO/DhT7FMOTkZn418muF5CqR7xI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28955004-86c6-4964-e27a-08d627367d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:30.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 6ba122cc7490..95df2b3bb6a1 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1066,12 +1066,15 @@ static struct usb_gadget_ops fotg210_gadget_ops =3D=
 {
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
