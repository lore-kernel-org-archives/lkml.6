Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A375ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4723821479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="arzLuf9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4723821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIOHIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:08:07 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728170AbeIOGrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8VxcrUc8ZsLktq+3NSNDf6/HYTOHA8qWzHaf8uvHh8=;
 b=arzLuf9UO+4PDfcCjjbMGjNxcVxnm2TbAlYyvpasaY+ruHKQ8SoNjYCwAJbBhYr7KmdK84Y4x0ciXTAODIoGmCWQrxus17GXFZsXSWOoR9cCNzJ+2nibhgBgqn/lhnMbA54b3R+uXotInU3oyivjbyMQhmP8lW006z/RZF9IUZ4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:02 +0000
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
Subject: [PATCH AUTOSEL 4.18 20/92] pinctrl: rza1: Fix selector use for groups
 and functions
Thread-Topic: [PATCH AUTOSEL 4.18 20/92] pinctrl: rza1: Fix selector use for
 groups and functions
Thread-Index: AQHUTJOfcQ7UWPzMLEmKU3f8WPu4RQ==
Date:   Sat, 15 Sep 2018 01:30:02 +0000
Message-ID: <20180915012944.179481-20-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:5XMA5wOxhFs8IILLE8j4irccyQm7kzHQjJv8wDi4hM78N1rpvWpInykrD54vZwwNzV0+SimiUqVgog/ey13wdEEVweWsfPDAL0GtQjxn3xQJx95K3SweYZ6uxz1dUJRAQbnW0PKHw6VFBr/5kBYDxTY4GMqNHAEHj8PpghiWPQojcztRG0j3c5J5BmfqabI7ZDjCIixDTAh4sAfNrm5cS96aiiJ5SSubZ5oDFr18o6ikiITXxK1vpj4yhSIIO7BLcE0+Uzfbfdp/TYUa9wynrDJUje7YQdMNswEtW9YETYf5Wy8+Uw6doilmJywDs4attXLLQJlnqvi6PWhnpJCo2O0aw6wcDgwHvy7T2orBzcerCBpAw9QIiqZ1cjYlfFm8O6wpDIUnviwJI6GsQOaBV5+5HpPABhlVZrVEAyyiRdEJeOTVObBF9yK7wSdXQ/FkB/WUpXkQqqBz00k9Qe4XzQ==;5:BFiAAsz9PDUCe3Yin9WdRvOHSeZlYBZDsz5THem3hmxtakyz2IlNy5HS3PahiICtfmEGpt3AgBt7L+2KKaXVsrsHol6r7D0MCVemy2UNLqDisqnJ/AI/snaHDG1WF30Ew7ELu3NOUjotQyR9H9aJ45FsbQuvQnkVjbEnsHIVhVo=;7:9hWahzsKXiIJLfbpW/HlOCoPJgwN8ZDzinrYQNl12i9rr0vVe2eh0KGxrfxU1QB3ZW4P92vfh18lvX2EAK7jMVaJo++1Vu/B5vf1nSidBZvkjbulpDDo/KG4HueKWn1NZ5FfkJcb2tz3V7TMuEGQU9CdBinQkdOZl5JHMZGrlb+igYb8ctLTuo9ImUetM5uFPUH6pxTu7RQTVZWif79P7VrogWjZzsY7ay53jfjwSJM+iCGFWLHwRjrXLEffx8c2
x-ms-office365-filtering-correlation-id: 811b78e4-8f69-49da-e33b-08d61aaac249
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824649C7DDA7F4078503860FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(39060400002)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(575784001)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zeuU86XW1HYCz5YyFnSHr7MKKkdhLVNoWQviVP4ZUCvaiXuOkca/MU72xBXdB46eohvWr45qeRarF5MtN1nakds+w3eVN0k1BZV+u4i05kx4OIHlaCuiPhSJK3d9tcXvZ/tyNIWZsM8HY/ymXOJWA8F8tF1/HEVCF0Iq9aA8vxh9vXhiruluyDXfPIF3pRBQa4cfsnGNg/xFSGQrVAAIT7vAhgt6UQ5D1DqoofUBbCUgM+FN8QS3NoEmfJDZZ3ELCvL0bV7JzGw+afteXSnae8JcQRBbAKSXDT4npB4081ioEKq0uxEspjLQHBS5AMtb9hWkflWUOLE2z1gBjQNgPi6pESLAMm1iGL4/J8H9Tgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811b78e4-8f69-49da-e33b-08d61aaac249
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:02.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 717c0f4449a0..f76edf664539 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1006,6 +1006,7 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pc=
tldev,
 	const char *grpname;
 	const char **fngrps;
 	int ret, npins;
+	int gsel, fsel;
=20
 	npins =3D rza1_dt_node_pin_count(np);
 	if (npins < 0) {
@@ -1055,18 +1056,19 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *=
pctldev,
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
@@ -1083,15 +1085,15 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *=
pctldev,
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
