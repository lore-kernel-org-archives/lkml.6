Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0EC20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L9JU76oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0EC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIBRar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:47 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729368AbeIBRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFzBx3sFYqVaTp4LHhLCH0CaoQ5bMsFsIyT7kwZ10aA=;
 b=L9JU76oyFHgpFuVVbXx2Zb8/W3flLggsu9lUF5ZAHslFJZ3a95dFDJUGFmjrNRXtExGkQ7vyvsEU9xlasqO8mPHU71r78+CmFCoM+U/t0VplulrRlzh2OL8wqWI2IBPehC7Ku/2Lsu+mJM7d2mK5J/JfFStcd9eE4MJ2Kg+CQ7s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 39/62] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Topic: [PATCH AUTOSEL 4.9 39/62] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Index: AQHUQr7vlxgJosKlWkCkLGfpgrNzIw==
Date:   Sun, 2 Sep 2018 13:14:53 +0000
Message-ID: <20180902131411.183978-29-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:MPo0K6f0KBKWR42VN9sGnCm11opXzRfg+GLR9FSPdzHx6YCZs7Z+RzMU3ZNa0xhUBEdVMU2JVPkaJ7Iy1Zf6VWeVD4uhmJOinjKCycM/EtAuIVWykBU+EiVlX3bihAwLj1krBAKoPyjN7+y4pZNtn83iSpdVm5F6Qo/47ZnIMGK5I8gLdnTEc2452Lhczqg4uswZ9o4tHLgR2uR3n7vSSqVS4a2xcI2jkTM0OXDsjsa7xWINKrLkHMZxTA1/OgKeyAxbZHYBKen2XUZl+rz1zmBeg1s/BjjGTnzyg2yh/jxxozdKXHP10aoQ5iv0YUtWgyZ2XojKonvtst8WeqYhFnLj5CR3NRDqzOW8TPf3oU2Oec64dDl6nohXNKvy6atTFJnp8aMf49Ek8b6UHMkAeGQdwYt16SrK/KvgdD695OYtgCGiz2/MPU3qaHnyCX31W6Uu8ZXCQ2HTQfFS4Eq6DQ==;5:zgKE3Vvm59OcQ5lCnEqjCg2kC0VG5f0b1/7OKqp2K15lS3t79L5CWlS3jhg8wkUWwGGKQqNdplVMnBsJ1+mZK7aMY5iP1i3InKJ20UckUTXTz2R+2EcfmZBSxvXIw1IGw3BdYHhsyBJ/wJub83O8Nekgpa3oK9QUYV6CuJExOzA=;7:OEzWwI+4w8YVq/zdTQC/bZ5coxVYaSyxfLbamYZagVI1u5voWNxTJOswli6D+lFB/LAyRA0d78d59fZ9eMegKvFQAeCuqAMWIyFUA4J8I+yeKv8MaeVbBipblfY83WtBjjJBAWYYBx9hdgxuDhCbvuGb+Rkq0c/s34FRVgFdE8FRSBknX4k9C5kFMtIn0uXBP3H4GQL5k4Bv6ogi3ebG9fDRI6YM8rM21X1TRov8DoEcHeDn7wKO/FptkrNRVx2Q
x-ms-office365-filtering-correlation-id: 0ec68b34-9ecb-4dc8-d2eb-08d610d6121d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741577F02DF4C28E05BE0ABFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BYXf8lPOM3gVwMB5yvCvt9rTAv/hKHJIqAi1ELV2sj/60xxRmVBE0XHV2IVzHH3bEEThkb4Y0zxwUY18YcoRR/gfkOgv5JzXlMCMfOE9wHl/AJ4c5hz6yJoaf8ANFZl6qMm61PwHMnbOFLV55K8wz+YJLP6v1Az6TMV3LJYv1AlOaCh4IqeCOEEj3g6murxosFR38+ClGX6Qi86asYNSCVaz29Qra7qPmaVSN3KU1wyHPXaF1anqomJqIRVs8SlQWp4zmF/EdroPIRUS64YBa7iWh3nCo9P/ti+Gp9XrbgkYoe9B4yLtZz/8X2deiTOX85h9i8VzoWN+mJZMhT+6tCvvwRmnicoh9cePMypCgDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec68b34-9ecb-4dc8-d2eb-08d610d6121d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:53.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 08193d1a893c802c4b807e4d522865061f4e9f4f ]

The function dcb_app_lookup walks the list of specified DCB APP entries,
looking for one that matches a given criteria: ifindex, selector,
protocol ID and optionally also priority. The "don't care" value for
priority is set to 0, because that priority has not been allowed under
CEE regime, which predates the IEEE standardization.

Under IEEE, 0 is a valid priority number. But because dcb_app_lookup
considers zero a wild card, attempts to add an APP entry with priority 0
fail when other entries exist for a given ifindex / selector / PID
triplet.

Fix by changing the wild-card value to -1.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/dcb/dcbnl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 3202d75329b5..a1116701287f 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1764,7 +1764,7 @@ static struct dcb_app_type *dcb_app_lookup(const stru=
ct dcb_app *app,
 		if (itr->app.selector =3D=3D app->selector &&
 		    itr->app.protocol =3D=3D app->protocol &&
 		    itr->ifindex =3D=3D ifindex &&
-		    (!prio || itr->app.priority =3D=3D prio))
+		    ((prio =3D=3D -1) || itr->app.priority =3D=3D prio))
 			return itr;
 	}
=20
@@ -1799,7 +1799,8 @@ u8 dcb_getapp(struct net_device *dev, struct dcb_app =
*app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio =3D itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
@@ -1827,7 +1828,8 @@ int dcb_setapp(struct net_device *dev, struct dcb_app=
 *new)
=20
 	spin_lock_bh(&dcb_lock);
 	/* Search for existing match and replace */
-	if ((itr =3D dcb_app_lookup(new, dev->ifindex, 0))) {
+	itr =3D dcb_app_lookup(new, dev->ifindex, -1);
+	if (itr) {
 		if (new->priority)
 			itr->app.priority =3D new->priority;
 		else {
@@ -1860,7 +1862,8 @@ u8 dcb_ieee_getapp_mask(struct net_device *dev, struc=
t dcb_app *app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio |=3D 1 << itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
--=20
2.17.1
