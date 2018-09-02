Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E98C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EDE2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SOs34/Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EDE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeIBRaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:05 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:49888
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIBRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PXhtGDGIGxP+4yc6uNmwBAouo7izSRKTl/bLkrGpg8=;
 b=SOs34/Xgwtv4NpVWmfYknfATFR833CM5MbeNabOomq0JL5Ft//SVHTzKms5FJDRzQWo5hrMGEpAO+ZVxh6gs306MOIoFvcuXNTLUOCd3aoT/G695IzCQA8cSAY21AYBxhCra7SX5RZ+1C4R5j17YVzkru3ktiVA1a+wjLOxTR8g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/62] uio: potential double frees if
 __uio_register_device() fails
Thread-Topic: [PATCH AUTOSEL 4.9 11/62] uio: potential double frees if
 __uio_register_device() fails
Thread-Index: AQHUQr7ZteiVOusiIkK1xTf3DWXDqg==
Date:   Sun, 2 Sep 2018 13:14:15 +0000
Message-ID: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:MkXRCz05fQAjfAkSxWGZfbU+iY3CSIui4DreR8SYCfwNHlTlEvaCenCbwX6B3riwz1a1lwBjQEmyPPudBxIX3HLVNV6ujxcX7u2n+12yeAtVxJy8aCDJRUPD07cjuORTh3Q/go0txLzLaxzmNtUnnlkenXtBsmMPvjEEjoLx0gZy/XnxN1SjuwGN4Rj17oJaS5VjSuZbLYI+JlRmkoZc51yI/Oe9m4yCUeD4GQOjFUKKU1GWSgvCxpQHjlkeJ5ZG0gSUlpqVSiWp64OzljK/+zetaEO/a9LtjbTtfqcLVdn0T0zgKUF72NxRPLAil+LxUhgokaAwc65HxFapoxzmgA63KjGeNbOKwtbBvdbC08lV2Ybqc0GAtQmprdF9l+g2ef4gV4ArcAxKIXD1gzCasGRoiGfVdcS/ZzAZ88joZpVtMakUhmrA5QxnBo17Rs0WFrn0WD6jxeNw63o0eS5HIQ==;5:eFuOU6za0+h+qf53EgR1xzCWHxBl5EBOoRGDDaCGAO9lcEAUhKrMhIzx4cOYVfzBdfGDIQvs0nm2oNDOYAHIF06aZNMoBuhbiNLbt+JiuSJ0EDmISXgwBxSqIH7+48JRBHEWM6/9uqg33tq0fMIv5xqixTzkvvKmwzxhBL0KWMI=;7:UBeIfl7saxsLJrsXTOo0MMyG72MtsUubSB0HPlsWKtkuFxI2faI5PKPn4Dope6WvDK4TN03Cz6bzuFtWfv49m4hh/9E6KjU5jKw1BulVCWMSXh3kcVigbVoC8DbY1gymeUk7gB6m8CMWPkbir0AN+LSAWNGEfO2EVWAhF/yezR9PIByLqWFOPm0VWkUQBk0LeAVSazKz6lh6pQhkz8cD3lMP616LUoOjKHQ+yfaeqb/dXEHFHiZ955hu1ONVzMOU
x-ms-office365-filtering-correlation-id: 5ea13a4e-9310-4265-7105-08d610d5fbf3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120FB816D3A70FC6F106544FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3i6lk2i1D5ugGS94ILQqvbi4DnBXZvX79Y722VhV3YGKk7aMzwwsx2kMde0SoIKTUbUIV8NNQ3PxIITMZuVZHNLa6MalrzVQ/WZylz657r49lbCdbaN5JBC+4/C+/XwS2oT9ELS6k/AMBXMYcLCY8Jmtt8XffVPKRYVvZs03EtH459lXHs/sOWamL464EqhFFVcLmpP9TdFYLIFhX14mfiQvJ6H/wlaMZYkx1vuZ58z6xqTmose4hKOcbUenltpgeKuscUmszp+GHKwWVwa8pVKhDzPDW6RCOrCNZWSXJNmSvbAyGjgL2v0kO5OkL31wjKChyzeZeHCNl8v1pdOvUtkbUcQdQQPtJXC+R92QOm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea13a4e-9310-4265-7105-08d610d5fbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:15.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f019f07ecf6a6b8bd6d7853bce70925d90af02d1 ]

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 208bc52fc84d..f0a9ea2740df 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -841,8 +841,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
-	info->uio_dev =3D idev;
-
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		/*
 		 * Note that we deliberately don't use devm_request_irq
@@ -858,6 +856,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
=20
+	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
--=20
2.17.1
