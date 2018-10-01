Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7BC64EB1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB63A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mqa22X1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB63A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeJAHRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:07 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com ([104.47.37.102]:43666
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729343AbeJAHRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDdtTkPcKmZbirQS5UlHgcWN0bltM8LVHIjBd8I11UE=;
 b=mqa22X1DXYVc/yKET6uf0G54v1B2gyMkg2XOykJd93Ba/HGE2QYN3JhmDlVML8vdrfqrQ735wkkJ/U2FM/W5oDhlONwaFiRX8+xP9fzXFstCQU3QkYr4lwPkQuCaFopdE7qfRcTLQbTuglzCr8ZC6k+qyT/IbbVU0ZSst2GXKhU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 01/13] usb: gadget: fotg210-udc: Fix memory leak
 of fotg210->ep[i]
Thread-Topic: [PATCH AUTOSEL 3.18 01/13] usb: gadget: fotg210-udc: Fix memory
 leak of fotg210->ep[i]
Thread-Index: AQHUWR+GCR63kUDMx0+6VRfe7CaKgQ==
Date:   Mon, 1 Oct 2018 00:41:44 +0000
Message-ID: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:2A6D/7sMBKjZD/R2HyrX+Ne0fr0YLYb+jlBrf0ulJDAuVQtnt8GG21wIG5vZz0r6z8mXLb9MmU++DO8YO/wjy+yhOeU/B3EFbsH6s/Q+QTiwDkKfTq1r8nZIsuIeJ4In6EoQN7NN6W4kW1L7imYpFweNKEh1yKjRQzeaU+1b/Z1f4jBnIgShFxLs9LWUfv8b+9QsuaIUYONJKKH9eKjDBcUoovbjduPOh+Mk4y/bceZ2mXSYL/+PAn8dy/hjBuXOQ5yhAX/bG3l8Pu3TgXWfpWw4vEigiWhdDGF1I/F1aWIzNvWV44dQ+P/6fCHN24h/Jvld/LRYdL5JnsMC8K31a/6xMhzSCLpl9I68M6/gHNCnsyJF/ZkGu0Cu/tJr2pgZmvWKrvxTN7+cqvATSRqNJFLMRQrn+utrAnirueK16EAXeIz/t98HYyPOY+mFKPi5W5wjmg31B32AplCqtdmJeA==;5:416V3B0jvwhzhNRkMCT9p06wn9TdGT40MwHtS6AfluP2tNAPQua+Oxal/oPHxEXLG8ohn1KnWJJbrD/+8tFEwxnCPNUeeMxd9djtWPRqj/N2o3z+PunLQREcX2Ceg5i0Q7nrk48uFwyvTPjqUdrXhjPLHFXIT5RndxbSnE5rPnk=;7:nDJdm9diBw/KYnX2T4pc7R16yr49hYlV/fSoYAU4TGnVDEBxAmzfj2HGQa0raqHaF++dasMCCzQ7KIxiP+WaY5vdrBfR5KAewdacpc15K2vHYN/j+3AvcnHYrgxxmrJoGvUc0LseZuaBgKxfOdEYSy0cLqXFA/jfgqh45cr+X0+Kh89TiCqpUqQMlN18vOjClriBywqpqBG+v1DJ224e01GAKlL4JSqkyvpA6KFL56mDT3j2n1jK7THnQRNjjtlr
x-ms-office365-filtering-correlation-id: a891766a-273f-4061-ce3d-08d62736a980
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791AD28018077095D9D8210FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(4477795004)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +hl+l/RJBp3TSR9VVenfqLIvdD0afifxbpt1YHMih3A158JsW/n+7t+83zfKLbMxRng5YbF0fTvARjbTf8NVVjTm21JRmD66jSHUlCqOUBMtg64CVw2pi34ZeGzOsBsLpCf+WeJrX8CZO9pKZ8qny37U2leldc8+1LQrwVQ19BE5mabj6L0aQ7K8P3j+YdgG4/BkeUYSQNqrSSI6iv/SI+a2ab7jPzwDvdrDd/XMnC1BQawEqJM/3JvatoD5If3yQwEIvQfRUYD3fvQSU+Tl2ECzYa9jVdpQKLZz6GJVQBhmYr9qiSmEstid/L3S6hYK4mSdRMGON58D6/SvB0j0hW20UTBw+ecPstKoZETznB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a891766a-273f-4061-ce3d-08d62736a980
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:44.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
index 1d315921bf34..9500e2b6cd59 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1077,12 +1077,15 @@ static struct usb_gadget_ops fotg210_gadget_ops =3D=
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
@@ -1113,7 +1116,7 @@ static int fotg210_udc_probe(struct platform_device *=
pdev)
 	/* initialize udc */
 	fotg210 =3D kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 =3D=3D NULL)
-		goto err_alloc;
+		goto err;
=20
 	for (i =3D 0; i < FOTG210_MAX_NUM_EP; i++) {
 		_ep[i] =3D kzalloc(sizeof(struct fotg210_ep), GFP_KERNEL);
@@ -1125,7 +1128,7 @@ static int fotg210_udc_probe(struct platform_device *=
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
@@ -1191,12 +1194,14 @@ static int fotg210_udc_probe(struct platform_device=
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
