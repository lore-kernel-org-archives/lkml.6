Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E1ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1170208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FSvzxf5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1170208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeIOGtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:43 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIOGtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkFDpbEUAACF61PGi+ChLsNGYHfUfWuTWXg4lnfjiKQ=;
 b=FSvzxf5cpmxt+LsfzM2QAta2mOZGk+7caSUa/QhWMIYN73E3UIrP64PsEUyYNYG4ZnayV5v/cT2RU7fMEC7+11r+DfxPc7Ze8sGRqSy5RJBafayetyjAIo8oyt6B8UPKMcSQLuNdzHoiQhZPJyUM1GraJAX6WaBxPNGTtWaDaus=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/57] pinctrl: rza1: Fix selector use for groups
 and functions
Thread-Topic: [PATCH AUTOSEL 4.14 15/57] pinctrl: rza1: Fix selector use for
 groups and functions
Thread-Index: AQHUTJP8Zqv1kFM9VUOa4nw9QtAe8Q==
Date:   Sat, 15 Sep 2018 01:32:38 +0000
Message-ID: <20180915013223.179909-15-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:8Co/md5nP/UaphO/2rIJTJDplWw6gaRytSrKKH5rENiJQ3iHd5FnWgWIKEZy0clKRQYkWBagPlWcN8UWmtNQr0v9Xy4Qg27oxD3wUki3EqNqwaCE9BNuQ3MVeFhT1ru7bPnWBdJiuCPbH3mXMPonhnjPJZbtm5ToiFxQwT94AApVbKbO9ePl69CP6yHGZKTcl3cpCyiD3xmNfG1OIdHmqiviz5iwNrqaUwH1zRHu2jGz1/iAxsf1CGRPvY8OON24nCDlcPx0VhV2n4mjXtU/6UyatOFB51IYzFYyROKYLW1QsCe0j7OJANA7j55Cjj7zD2RNQV0B2WGpkqT15Nvp765ErdqA9Sv9J5yh+W/v49HUkzAktmRdJ54cnETkVr/693I/MhzXJ2ktkA7HYZr5VENNWvTZaX2ntSxVbSXnJaobyrdsxDQfPBo7SroJUQmw+Ckh8U5UEOIVb8MXMhx6Ew==;5:ZAJ7hxxhPaW8u3w/+8aDLVm4w8Ytewgb3Vc7pPl+U9jaeakScF5azdP9LMatyhlvpzAKZqfHeMIyU4tQdk7eM2LHZ4yRQE7pCqZul9hp3O4Kx4Gi2ZymMICZlJ+eGn9FiCW5XQEh4qr8QChc3PL001jADCrA0Tex8Egk2Dcoq2A=;7:4VE1sh/QZYG/hM+014sD22bVDmD43T69kDsNXtlWxy3JmwA7txyZvUvWw0mmlnuAKwdmeT5f+7sZl93uCPhDlXBq+pOsTPYMMGBBtVVDWkXqP55OJj1FLmn5bxAV1v9uRZ32IyXtZRdvoDe6ICp5l6feZ3Wraa1bB4Flg4QlUUdJ0wOF5FMhNdnO0kN/PFNaIKikoiLdXm8IQzEHqAYzCOQVFVGejokOzAB9VECfSqqeJbcfpblFK+hnMwosDkXI
x-ms-office365-filtering-correlation-id: 1f48c4d3-19ef-4418-4868-08d61aab1f51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822A7AF32D9A9074B3E7E14FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(39060400002)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bx9b9UR/D8Svj8J5pq/RHxE6DWq3Eq2kf6SMlWYcbz1xQnbDDWLA+xx70krMz17qlD/+K1Q8UjMWaErRZOf+5KRDd8/xq21zUFIgx7Np7ugxOe53SpK4gDFoZA1eeFCxudDoHT542ztqZAgkqglQlBKRtJ0TM+SnrC0Upi5wRCx8Y3gIfImMwjtHNDbPq5Ij8pULYapY+C5KMjxpZ3/4uY/j/gXeTiX6V0XUPUrOEjJH2I6VeQhZzKoA/7h9KC58epz9vZWxcEDBrQwreC/oSt8gYRtrJFfH86FE/YEhJRa3yOeRPpWPQ8oUy8GqDibxG+NXE24r/jAmlUe1phMQ9dRxe9sVikSPsZa+WQk4yUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f48c4d3-19ef-4418-4868-08d61aab1f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:38.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dc4003d260594aa300028c3c5d040c5719abd19b ]

We must use a mutex around the generic_add functions and save the
function and group selector in case we need to remove them. Otherwise
the selector use will be racy for deferred probe at least.

Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Christ van Willegen <cvwillegen@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Acked-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/pinctrl-rza1.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.=
c
index 04d058706b80..a865dc56a491 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -878,6 +878,7 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctl=
dev,
 	const char *grpname;
 	const char **fngrps;
 	int ret, npins;
+	int gsel, fsel;
=20
 	npins =3D rza1_dt_node_pin_count(np);
 	if (npins < 0) {
@@ -927,18 +928,19 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pc=
tldev,
 	fngrps[0] =3D grpname;
=20
 	mutex_lock(&rza1_pctl->mutex);
-	ret =3D pinctrl_generic_add_group(pctldev, grpname, grpins, npins,
-					NULL);
-	if (ret) {
+	gsel =3D pinctrl_generic_add_group(pctldev, grpname, grpins, npins,
+					 NULL);
+	if (gsel < 0) {
 		mutex_unlock(&rza1_pctl->mutex);
-		return ret;
+		return gsel;
 	}
=20
-	ret =3D pinmux_generic_add_function(pctldev, grpname, fngrps, 1,
-					  mux_confs);
-	if (ret)
+	fsel =3D pinmux_generic_add_function(pctldev, grpname, fngrps, 1,
+					   mux_confs);
+	if (fsel < 0) {
+		ret =3D fsel;
 		goto remove_group;
-	mutex_unlock(&rza1_pctl->mutex);
+	}
=20
 	dev_info(rza1_pctl->dev, "Parsed function and group %s with %d pins\n",
 				 grpname, npins);
@@ -955,15 +957,15 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pc=
tldev,
 	(*map)->data.mux.group =3D np->name;
 	(*map)->data.mux.function =3D np->name;
 	*num_maps =3D 1;
+	mutex_unlock(&rza1_pctl->mutex);
=20
 	return 0;
=20
 remove_function:
-	mutex_lock(&rza1_pctl->mutex);
-	pinmux_generic_remove_last_function(pctldev);
+	pinmux_generic_remove_function(pctldev, fsel);
=20
 remove_group:
-	pinctrl_generic_remove_last_group(pctldev);
+	pinctrl_generic_remove_group(pctldev, gsel);
 	mutex_unlock(&rza1_pctl->mutex);
=20
 	dev_info(rza1_pctl->dev, "Unable to parse function and group %s\n",
--=20
2.17.1
