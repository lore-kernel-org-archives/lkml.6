Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932B9C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB6720652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ym/4ntFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB6720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeIBRc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:29 -0400
Received: from mail-by2nam03on0116.outbound.protection.outlook.com ([104.47.42.116]:39210
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbeIBRc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMDFP7xD7zUW/8SobB7VYmSncWJGdxpl7S6xtt8BdWI=;
 b=Ym/4ntFj8SRZi5IcGSBxMgw/LUCQK5fZ+NVFHaIIJEnZfCqh6v+iJb57qKzsZkauX55vUBgKQIOtK3yYtE33zD2H6/brhVOaLG5pVLI5bdGKhPoZe7FiZP9edkZvedYsegzwPgCU0r499GCH8OIjHCL019bjq8arTDxqyYBrAFg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 29/47] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Topic: [PATCH AUTOSEL 4.4 29/47] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Index: AQHUQr8gF5M9IYA5JECAPtx2hdZrWA==
Date:   Sun, 2 Sep 2018 13:16:14 +0000
Message-ID: <20180902131533.184092-29-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:UN2Phzr5i/cvToiSNM67QojBFvlUJxSy+TSrca0NQvySQSbdpDLdYxpGWqjXbBy/f9LpKUMlJUNZEYvCtT/CzFJfBlro+/gBJ1Tez6rJFhFUVuyaJ6RleKDQBlg2UC26YA+TJ4W27o3NYus8FpyWDnY64Z3eqDAtBgzFIvaDuCB07ywZgtu5UY5sE1zqFrHsiqPbMuVopFgY4qVy+TtxlEMBOvgAxazikFfleriGNn78441LAIHjla/lkSVOCb7P0lCbJL4I0W83h/6MPtz1VdEobmYb+MsVmEJxYzC6EmICvYP14f6J7ppwihEwpL38PATRIs60EeQPZ2e/CF5TrOhh7mk3DKvg8zoIXxCCKZQDXFFV7Hqug+EWX8YyrsqOfaJWX0ZLowiPgR85ZBf/FABPVlj0gqwua44DSMU0JeMMo5xwRokY+0wZbsk9Gbf4ZO9G1piZXzxyqZU6poyHYA==;5:juJiV8fnSR1JoKOddA/ZuDaUZ2Z+phTjmKWnXMKk7tDTvrbo4BcGML8q+4SLm+dLIV431Qb4u6kdF2Vq039+DnSWmm9XLN/XgfQnercu3htTqnuz3vAeCodYiM3OEuGnIlG97EJITLPpl3IqXZdZ2q0FY2S/YVu56FrL/CAqqBQ=;7:mRx962TiksrNN+zZoUvHwRaf4F+F5JZJGy3eGXHDUVg2eaCDtJ/rnYvOQFRqj0/3bzVdm+xGkQbHrcyZv7N9oFn0zsJEOrsWN+Tt9VlQVMItrGsEbKm41O+T68OrbJpRygvXc7vCDUgfiX5wC9HCQVdcKT2cPV3c6EbEObe8Ml5giSIHa25np3pbA5op3rrgNvT8oSWd3H+R/IhI10dcX2bf5ftPk6G71VXGyMcIE2ZbV2u08O8GGBnTfb5iWWmJ
x-ms-office365-filtering-correlation-id: 5b146d2a-800d-48d5-ac96-08d610d649f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167056EAA482DC5BCCABE61FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 338vO5OkoO0p5HPUyFiVAOzrSkjuUakWtanresmSRT14/LVg/u4d1JhLL29HoUIhC4/bmS6IlozK6yyo219sews14ECS5lrgbMuYxN1WJGJrFH4gE/jWiiIoESt7GAIFwYM0Z3ppWJ3SEok/TY+7Xrm4fWmo+Z+VqdiKeb/mvpLcvcBUWkGkA+yqMlo0yFUMyj/nTY8UYOA9SZynPBNeNJQ850IH6+JY7eOBnw6/TNj1nUy9vNpuz0j1Df2ngsN2+mIxMnb9tbAz4dPVwKkR/NWT0A6wZ2Oirkjg6sOLP2xirDH1JRryV8vqQ/zFH6eyeNbcxg7aQ+U8WBCB545HNTN+WCiPYCP79IQALA1nuk8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b146d2a-800d-48d5-ac96-08d610d649f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:14.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 4f6c1862dfd2..6fe2b615518c 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1763,7 +1763,7 @@ static struct dcb_app_type *dcb_app_lookup(const stru=
ct dcb_app *app,
 		if (itr->app.selector =3D=3D app->selector &&
 		    itr->app.protocol =3D=3D app->protocol &&
 		    itr->ifindex =3D=3D ifindex &&
-		    (!prio || itr->app.priority =3D=3D prio))
+		    ((prio =3D=3D -1) || itr->app.priority =3D=3D prio))
 			return itr;
 	}
=20
@@ -1798,7 +1798,8 @@ u8 dcb_getapp(struct net_device *dev, struct dcb_app =
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
@@ -1826,7 +1827,8 @@ int dcb_setapp(struct net_device *dev, struct dcb_app=
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
@@ -1859,7 +1861,8 @@ u8 dcb_ieee_getapp_mask(struct net_device *dev, struc=
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
