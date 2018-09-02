Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C5AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737E320837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RAo7cPbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737E320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeIBRgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:36:44 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:54352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730084AbeIBRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbu//Wpi7PxYiQC+vElA9DI5p3gi5mQZ0/UKOXRIwNU=;
 b=RAo7cPbGypgKNui0vU7ZrSQzWQBNMAMAk2HLR9s3/4LFax9ZIXE3bCxXkCPVSpzrMEB5/ef/399Kr6zilJWaxobud0uAmYIYj4Ygjva7iAkyh3pIf8K1Pnhhj8EPjp7SB3j8DeM7DhicU55Q+iDxEsfGU9QoxAXfUO7xBZ9STpE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/47] misc: mic: SCIF Fix scif_get_new_port()
 error handling
Thread-Topic: [PATCH AUTOSEL 4.4 01/47] misc: mic: SCIF Fix
 scif_get_new_port() error handling
Thread-Index: AQHUQr8KqS8igm8pykiiA9npCYKjhQ==
Date:   Sun, 2 Sep 2018 13:15:39 +0000
Message-ID: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:5inilhMyXxrPmic14eatPiM1zMxup1xxgDsL5+muVwhF9GG+I0yEuR+d6bYfmxCBrPMgiWLDHQf/mCpeNx9b+Awa2txJG7LWjfyZzAk4z4V5Ao220x74/O2Au2hqnnklrfYN3VotosXT88XJyrLv8r5E/SKhDmGW+Nr9BYA+TvUVEiFYer0R1iNXaJ4Fz0565eiv/qte9N/Tk6pQ/8VfjKPq+94PnHChS2ONHqQyGejCNAbebOX8mI34gUHskbGNpMNMowJfwATCuRxqwL26xevnoGy+s7ggU3wWBW4aej6UUEPY4OZSEOsWVYAH5R2mOnb8AaycI1eGf3uW49tuRhWBm+2tN9U9qcmFaRBI7Z3WHhtUntXCcG3R2GnHzkgSoMjDAIlTFRiTOEWN/Cw/AVJvB2GB788YW/QWMnc1xq2mNp7LIXbWDf40qZ9Q/GOXxhVHXssoXF6E4DR0ycsMwA==;5:XaPOmGhc7bC1DwvrPK/WFb28PeRPYFBcXVfLGmQXLBSDmhDjbblL3y3VxK+dZsa8CT73hCNOYPjZKIfgB42qu/sxIR4h7OwCIz2z+4Y+8EkXTDKMaaT0cmGhulBYELeRvcaSgFKAvt89XOazICbXyRIZ0b2Uuo2auv4boHsJawk=;7:6q8SL3ie1vi2ToArxzPKu5hbrkGbqTx+nRfo4zn7Q5/sINQx6NXdIAmWQFgAPz73+0cjHtauY6IG2QRewMAfBw2iNNPuDfOO0UAEzZI3WVAvkyWzmLNep9JVxPvU5SBLjEEufrJ0NmMIOb9oDub9psWmFCqBX8fxrUdLxaiUSjDaU206Dk0pTp9tCKOC5J/3U8pKGn7YUQHH89GClsagQIXsOrYeaZrQzqiD0R1oZDZ8GJ95RQjKPIOX0xFYzhov
x-ms-office365-filtering-correlation-id: 6bb9191e-6181-43a4-cf8a-08d610d62d83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018463FBD6D24328A0CA94D1FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(2906002)(8936002)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2eA8n9iX/LteYDoSMBr3JwGHxbPi9S7LpiILqVxtYTe2ncXX5u2aQjMJQ2+JOuz+Kw63Pd3GhHvrEY5w6mZOiWgiGJOG6Upm0R3EYaTxRUgq4rQt/CvDzuUHl7HJWVbvOvx/17+yALJSxXKPKBXXHtfiEpHpxTMlM1Ald2PA3QGFleJ0i1cRJ7Oxx0o3YTo4yiug5v3GxEPSSQzarZ+doqweXMouSiuSCxb53X1ldMvAuJc3gRFqJfrzJ4k1xOhU3kajwjfSno2hCvtTpAOiObUS39slJaCtq4bB6xuoG0elJyk/xzIRlRhqyRfabM7zKzBBkbfJifWM7IoxBSXFRxvKM/tunbJctF0teVy+iNI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb9191e-6181-43a4-cf8a-08d610d62d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:39.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index ddc9e4b08b5c..56efa9d18a9a 100644
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
