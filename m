Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE50C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IQqSXRGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD6420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIBRTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:01 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbeIBRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EitwxfQaYfKFWKx82SDAHzfFh9sXjjn1sgXCyUBB4HU=;
 b=IQqSXRGpfHS1uNtPlE0ku9GDx9xJb6Y3AWj2CwXbb+k/aZ001gQ2nJpT6ZEmG7qbyLdR1VuY5DtOMSrYMTZO3YPUn319I6+gmVtUQbmFJFGi7yxQzt2Uqh0JAHFVAnaWVZ0c+xCAs5xPsKeu6A7ZRTucfpF6AO/HcGOF3DyVGcM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 003/131] misc: mic: SCIF Fix scif_get_new_port()
 error handling
Thread-Topic: [PATCH AUTOSEL 4.18 003/131] misc: mic: SCIF Fix
 scif_get_new_port() error handling
Thread-Index: AQHUQr1HAwwfXYzi6EmMHcT7qGvYtQ==
Date:   Sun, 2 Sep 2018 13:03:01 +0000
Message-ID: <20180902064601.183036-3-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:RXwyHbYTkmLhYxFqwzHKAUfbT1Tp8MVjgB4bXj7fb3xOvAX/YOgO+z/46qXVt4QH/CisXcynjdRvODm/Txz75v6HM+8uTx7uAtq5RZzmE7tNWfcyKoDpRgDwaCBkv8DfwDhtMvnjcX1Viwb8LBG7o+bP0DUTJhRbfc0Q9xo52tDTQ08JwL9o7KZkwsLah7EBhtyK2v0d7lo4JBzvZUxYb7zI/qrMbPvxcoDabJPBUrKl6KmqSKQ7xkF6U6lE8DvbdvlbW6WeFuNxhKDexMsd0Yi0dFKfpThpe8++cup4XOZay/moGR9ABRhyhE+uEmibswUR0ZsjKrJYBbDTH2cstQ7mvqvOrl8AbY+J8sMEZ8HvPfpx3WwRY1DWXoaWzNeRiEMEgMSVFvbyTlw/IXEpFv9oYMFrU8zmtTobvFTnLOMNQpsgEZcs6N/Wk1CDAXvV38l0ZDFvxluwsGmPLVxmGw==;5:JeWrG2p1Y5XkTPFH8lIb/0hZzgIGazfYnLa5uaZNpG1Jpo5+ozfDlX2sC7meqiLSu/A1Ehsh4wnZyocSSX6M8tDajzg0YiDFrysUvab8RipxWU0o9g4t2joYbLphw4KYFBcFe/m4YazHSYORbRgEAw/eQAa95KIxTkZl1Xk4cCI=;7:kycLrFeLS/f8ffqE/U0IEP1quNpmU77PnnoJ9D3APGSN20CFaxz2xMZnZYmmr9sXBfFaq6EszLeh6rcAPbTzmC+HPPKSd8oOhQAlYPJX1nQ4xiyXLvLYzf1jS4h6BN5LC1+eoK2FcDJz0LyTL1yX47n6rA/56W6BXD+OWyWx90fQKFYWQkQNhAUEOy/P0dItkxRcaJiMzRND83cAWMvZbm6YfAfMshGSRphZIyUShSLqtVdgHQFNqw/yHQflSHn5
x-ms-office365-filtering-correlation-id: 2c39001f-877e-4168-09e5-08d610d46a36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08377C68C7E8FE43E58F53C2FB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3/xUDGC73yhoVw5V+q75rR0XN5Ric8gNusfBYgmyfaqjaWAb0yl0z9o5udt0GhSsq5XRonyygQpBXVsgo0A7YDyIDr51pUWigrE+eRZSLbD648WzboNzYgcCaflTZC4N7KIDnRUiq8WayltsC+vd2BETN4ttnp9YbXPsKgXl+/cMCTKcic00sI/rCtvaxLByumBjmJWEwgHrILTREDPLf29PPavdwuMxhS+4YWWU99IB+052rvg1mPVfHwQ5e3lACoBKINHzwic+b8XYPRyzvI5PUBXhwaamUlR0qE4foiqBEVwiaSX5FpezimqudF83ESCCEPGSUAz64F9M712YckkFyVCeRCIJpL+cRGk07ts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c39001f-877e-4168-09e5-08d610d46a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:01.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a39284ae9d2ad09975c8ae33f1bd0f05fbfbf6ee ]

There are only 2 callers of scif_get_new_port() and both appear to get
the error handling wrong.  Both treat zero returns as error, but it
actually returns negative error codes and >=3D 0 on success.

Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/mic/scif/scif_api.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_=
api.c
index 7b2dddcdd46d..42f7a12894d6 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -370,11 +370,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
 			goto scif_bind_exit;
 		}
 	} else {
-		pn =3D scif_get_new_port();
-		if (!pn) {
-			ret =3D -ENOSPC;
+		ret =3D scif_get_new_port();
+		if (ret < 0)
 			goto scif_bind_exit;
-		}
+		pn =3D ret;
 	}
=20
 	ep->state =3D SCIFEP_BOUND;
@@ -648,13 +647,12 @@ int __scif_connect(scif_epd_t epd, struct scif_port_i=
d *dst, bool non_block)
 			err =3D -EISCONN;
 		break;
 	case SCIFEP_UNBOUND:
-		ep->port.port =3D scif_get_new_port();
-		if (!ep->port.port) {
-			err =3D -ENOSPC;
-		} else {
-			ep->port.node =3D scif_info.nodeid;
-			ep->conn_async_state =3D ASYNC_CONN_IDLE;
-		}
+		err =3D scif_get_new_port();
+		if (err < 0)
+			break;
+		ep->port.port =3D err;
+		ep->port.node =3D scif_info.nodeid;
+		ep->conn_async_state =3D ASYNC_CONN_IDLE;
 		/* Fall through */
 	case SCIFEP_BOUND:
 		/*
--=20
2.17.1
