Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9282ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E3E20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S4weSjEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E3E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeIOHD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:03:28 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728317AbeIOGst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lfDjw3FawA4h1heA6ApaMEjehS49snUePtQ3w4ccVY=;
 b=S4weSjEPz81XiaRG8MxCvd2m3uFRgOUE6bK0fxnFKK1of1oVKxl4CSprAv3H0Zi/81EvE4vEEk0/sc+pHOlAno8AHx+14Ft8y8OetyZYRbAf/Wb9FZi2Sj4goEPEA+OPtYsoKVK4gw2E6KtbqKLxOCu+VxxGl85Q2DKDFCz/HYg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Carlo Caione <carlo@endlessm.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 76/92] ASoC: rt5651: Fix workqueue cancel vs irq
 free race on remove
Thread-Topic: [PATCH AUTOSEL 4.18 76/92] ASoC: rt5651: Fix workqueue cancel vs
 irq free race on remove
Thread-Index: AQHUTJO4HkwRsZ9CTE6uJcUlAQNpDw==
Date:   Sat, 15 Sep 2018 01:30:43 +0000
Message-ID: <20180915012944.179481-75-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:Ks7Hjciy+d2kl/XFZuzLfU1rNvWep8jN5w3x8kdTe2x0d85izmU2kQhLCsMqRV9OagibowFaDya3UGb0UdgfOfoQ+1lm1YxdbvcgFP9HIom54VPeUdaLzvGLZ9DEj3/bugTlMlfxDblFnudetKPsOCDJ03CZ3e4N/ZKLwFhcGHoQ0mhNVSa+fPrTWeC09p5Wpdd+Qf1iBnZXiYVvo4jMD/axlQdh70/c4WkN+UjY5Uhv0/s3aRBrfaNdltrdDYjYYTf32mjC8KXLDaVfjA5D48actKkzMfiHdC8S5wgfQqIf5lew9KUPxZxU2rmMBKaa5LqAwwnXFmXnY7UZRAGR7XzuKuxQ7F9OcOJdG3ZW/DZFu3bdXICtcn7s7TsmHAEYm5Lbd2CSN5LlRN32yoev/1+I4AF8lVNaHPdQ30I6RmF3qP/JyPO8f/rYkT07wE856T4Sxl64e2c+RuWttvBFrQ==;5:+PzzAYB2DHNmjsFpYyEg4ws7EtVNRJYbEi6EvHUNgmtF2Ro83r77iQKhbGApBEvzcn+pjjFq08gmfwRLlzfkLffMhx6Gv3ba+OlOqxoMkqLrEi8qgXXOH5CVyC1M4SfxCwyJ0RgqWJlvGknlK5JM8HKZ270peD4I48lc/fpxMhM=;7:2QoBzN6oaR3sZtG5dHJBnHBEzrfL+QifroynJcar8HYeVEGmNXIhraIFBfFgXy0VN/PN62F8FBchUos43+z8g06oH2p3FNyao4z7QdKh1AvzASmHEHVBvdME7KjG+qCwl8GrSocvabSs5JL7FVy9DT7h9OWCdsExYjq/irrdQ2G5mrBnW++hB52Saob3WUfroOh6n2B/0/nv5ofkJ/KMa4HSvcDJM8JdSD/9SeRK6CfIXzxH96vRJTIK9XCN2iMS
x-ms-office365-filtering-correlation-id: b70b17a5-ce9b-4c23-1596-08d61aaafa88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470F12D5ACB5410DD367C03FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MOJEb17oCXr4vjYJxXg3ezBunTUi40muVG+XRDz8AgnueItuSIFsW2Th1dao4kM93n22r6tkeaF+R0O5NlXr8dGnUPjsAClkKUpBVqgODE4NkSitdmQoT5WK2y/gHQLcZckZmnrrMA15W4ZFJ10T6sj9Tkl2a0Zihh4axIjr+rxi/rZQRGskvLf2XMHw7KeUJRiYhwPS29VqMPcHGX3koXqFQMFL+LIRQoKDn/ggCLGG19jpV/CeAayV8SF52/nTwhPJRobPkeFfD+KsCzyCpfFCBjZa2WiGJWLYiVJ18H40s1Hia+A9n8xvdN7DMQo69cv2Z48a4Hf/9FOwf6Zs1mnIeaqRaOU6otqRbUJZ/pw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b17a5-ce9b-4c23-1596-08d61aaafa88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:43.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8d2d7bcdc1645dc243f7735278675b083c0e506c ]

On removal we must free the IRQ *before* cancelling the jack-detect work,
so that the jack-detect work cannot be rescheduled by the IRQ.

Before this commit we were cancelling the jack-detect work from the
driver remove callback, while relying on devm to free the IRQ, which
happens after the remove callback.

This is the wrong order. This commit uses a devm-action to register
a devm callback which cancels the work, before requesting the IRQ
(devm tears things down in reverse order). This also allows us to
remove the now empty remove driver callback.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/rt5651.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 6b5669f3e85d..39d2c67cd064 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1696,6 +1696,13 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
=20
+static void rt5651_cancel_work(void *data)
+{
+	struct rt5651_priv *rt5651 =3D data;
+
+	cancel_work_sync(&rt5651->jack_detect_work);
+}
+
 static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
@@ -2036,6 +2043,11 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
=20
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
=20
+	/* Make sure work is stopped on probe-error / remove */
+	ret =3D devm_add_action_or_reset(&i2c->dev, rt5651_cancel_work, rt5651);
+	if (ret)
+		return ret;
+
 	ret =3D devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
@@ -2043,15 +2055,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
=20
-static int rt5651_i2c_remove(struct i2c_client *i2c)
-{
-	struct rt5651_priv *rt5651 =3D i2c_get_clientdata(i2c);
-
-	cancel_work_sync(&rt5651->jack_detect_work);
-
-	return 0;
-}
-
 static struct i2c_driver rt5651_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "rt5651",
@@ -2059,7 +2062,6 @@ static struct i2c_driver rt5651_i2c_driver =3D {
 		.of_match_table =3D of_match_ptr(rt5651_of_match),
 	},
 	.probe =3D rt5651_i2c_probe,
-	.remove   =3D rt5651_i2c_remove,
 	.id_table =3D rt5651_i2c_id,
 };
 module_i2c_driver(rt5651_i2c_driver);
--=20
2.17.1
