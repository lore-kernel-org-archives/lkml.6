Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE83C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E035920666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ObCZvR8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E035920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeJAHQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:36 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:55885
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbeJAHQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOdiXoEWFgn/cGyYlrrKzlTp1cvVMayIO6LyUe4LTy4=;
 b=ObCZvR8nRCAwUC3C6wNnvsxxvXi3lz6OoQW572pPpZHQ2pRxo/Q1fMJ1O4A8gVpecAEzqx1p7aUAvGXvbGjlAL8n3ZNgNNav+uusNFUxxQJmYx0JxtiKZHjfa+spKDOlfwT8UiX6eERt7lk0nFLTPl2nBayMgl9/+EsQ3rOMDQo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/17] usb: gadget: fotg210-udc: Fix memory leak
 of fotg210->ep[i]
Thread-Topic: [PATCH AUTOSEL 4.4 01/17] usb: gadget: fotg210-udc: Fix memory
 leak of fotg210->ep[i]
Thread-Index: AQHUWR97HR0QfY/82UOdYsf1lmKYiA==
Date:   Mon, 1 Oct 2018 00:41:25 +0000
Message-ID: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:TEKflC+Fg24/bBWb5VnQErhKOIrjWWxmf2ctpso3cTto3hKVlmvBcSBKF3XMEEFCxm0V6S65LknEPwVtbhVKWRY/vb1rehzNehKe7CNlJZMjWM6lpCiZ7anRbMJRNy3xfEru4vqmdJVTmnKo+8uXtER4JjuIsx7ttm6LipbH1J65XHs92yCo1XnVWlRejLUBroyaAv0L+ZeHk3f+tJrTi/JPQ+hok515Fdf0HaZvJX4FjIO3ozEKQxZwmBKoL377Yve2PGhabkIxy/V+rwolAIi9U8l1TEK68tsobkIWigV9XIMxUX1GXibiT9XUv/gpIUs7eNLv4HWQ7/kAgQfEmzjRGE0nC8AITRPITV2zgMFkfBUTJzumGTO7UMXNZgon3v529izRBD3VD8sdzhJ5PLIVTmuNxOb8dFdw53ac00rMA7IjHNKwuBwXmjuQGzhk7bckwL3RuqB/Y6BVs5mteQ==;5:o58uXmfUnMzvwSXsZHBvhS/s/FnKqvQQH6wvq0PRbrtimx1LkJZgm/ROHyOQx03V3KFtOYIuzqoJbf7Wsj3gQKLkn4yq9M1K/n7IaeS9sMxE9ZiBbWehAE2Oh4pb0nF8O3KBA2VGTFwDmIqQZllsmhgBM7Q8U8kBkeuI7q4RppM=;7:jAfiK72LBux+ewfoOrOzKPGGhqE89MznAzdMIGMyaN/k1ljCEeP9/GUht2F2p3GdRfi5wDPb3z+K/DQrKn71EfIsTCBqYtsLk42KkEurad0fzDemR+QN79obC7JOU8CwCEu4tTLWCADf4JYw5xqMnYOLIQIJV+KTcqQbxpMfDkQWlkg7OK97wT05uETTK+hpQEjx4zAz7+05mzS7hfLw7RgMDxesFX8Ym/tHJw18TjDQE8xiNFbIrp/GMRxua1Se
x-ms-office365-filtering-correlation-id: d60ed631-9239-416d-2e31-08d627369e6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01653DAFD99050F032B11E33FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(6512007)(72206003)(4477795004)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: U6JsyQiwbsexohIo+tTptcByOAAe8sUuEe+q43r03Bp7kEXGf2lupGHeUbZ4MpgddMB9BaONyKTAKEaZGUjsu/o0RQUKBgpzr9Cgkinky1iKAeq31mg4Mq0NmB7P+8ywdniWDAd9SG2sJdBffmirNRxYA2xflIbOrRIvX9xlfhhSMswwiC1mXhRZhVWjTF+qipm4CFH/J7OAPMlv4CsYwRvxf6PZvBNfOsmaFIt5J0CRh8hLi4vHeGHKFCSaZnqycmGOX3Uw7SIy8b5ITkJyT+KyIiKvUwYR4ZeFZ3DcFuAMjDl6NqGXQl5ZPtZV9SUmlOqYMueeJXP97/0WPA27hydH0TtYj8Gj0dGZHf9lE8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60ed631-9239-416d-2e31-08d627369e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:25.6743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
