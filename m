Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE41ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA9521476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kylfeg1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA9521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeIOGsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:51 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:63496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728166AbeIOGsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNWrCrFOtp62E7IOxZDGqP6GKan18UHnPdpYfeQZktQ=;
 b=Kylfeg1w62PfgK5fTfPaTOVxGtSciW7FvPTf7pg6XB8/vtluWSg4TC47YyiscTc8W2FVZubANzjsLiQw/CeCdllyNUcZt/uyjmlonUMvGJ+psX6zYj5w7sCOYcBDTjnA4PGL0u2YJwfeQtDk+NlPAma3R1a1BtvqRxmmVqso45g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 91/92] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Topic: [PATCH AUTOSEL 4.18 91/92] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Index: AQHUTJPBPTDQX5DTqk6fnq3K42WTCg==
Date:   Sat, 15 Sep 2018 01:30:59 +0000
Message-ID: <20180915012944.179481-90-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:KOgPwe1TPCnfKED8Aom6WyuPWHPHiFMHSaCJVJeWdQQ2U6KVr4i0v6ftwAd6U0+MQnR9h61nibCOcZBUjojQhHi1W9n3/b4qlV+MFFsUFk2pSZ/Gkk0lI7QJZY3GQuGOziTG1Ocplyu+sE6kFH7NPZqC15lO/HkW/v12BSgmGX+NL2tLHzY6YJeGMBnT0GUWIOsGPYeKvQNaNhOeP9h14HXx5ImF35kXnToRg3McjeGpgY5vte6USmy7YMwTfYM5Uv3iSjqcgzUiT/fCVAanfQiuGWeQNO1TM6SvvFBT4CBIs4xCzjaSlUQiRBfYUG3mvFe7uNK7sCQNBDvrYjIV2oIbKwgrmKdAWCX2nUYbQNDIgnQoteWEFWEJpqNnCmeGmu3dVGEu8NiY4D+uFj51Sa/Q267mDaW4X5I6yBWHwBkiFD0010JMsG2M5IJcD3nlbO5tPXTW2lTuzaS/jfxaFg==;5:l3F6gZKSB/pP5uC0MQZLLm8vOFNCtydw4k0mZVsTSUDtuT4l4gaHSfg+pmh7kb6PX3rb0oNzoydlgylTvw36MAmdnhn31KEdZT0ySgInT8Hq85h8gL8YJcUOX5I9DXpzmPMEI5q77nq+xpk7x0RcWRumNZCh00YvOuUAtToAOTY=;7:wN9sCd+61/mMRNEA+uDNA9+1/UU6h2CU1dtJAXKNgl2N4JifWwWmry9xGahx6gOdzc0+7JSkLeWWOsOPFcTySJyDbhLttc96euSmCwMsYgdFRAVYB2Wn6fCbueXvCjCCgWr+P8CwVEfEnRozghcw05GQwRNxrNIlw6s4OnvXO/DEt3bH/y2a77vqIq11sO+80qGtTC9DRABlqGjIgyPoHFhlKHqwqVn/cBQLRECXTfWYg4dBNfsWd6dvy8P6Bw0+
x-ms-office365-filtering-correlation-id: c76fa4dc-a9c0-4a40-fd99-08d61aaafe1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117A8AA56EC7D68389CBC20FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4vyJhwbOQ8hpvKpXvlko/mQis1cyIq3fbaAhHJjMMj8nK9KBhSGVy3Egn272/F2rt0qH6Osl0uqfk7tiw5aI8jUEwLImeOkdcgfNd3ijH8pryOvAFpx2owDjgfzxOqwRdKGNEfC3O3Pt9NBCpJ+f52qpI6QI2S1VEUeoaJin3wrQL7+DYPx0MqtJkEva6X+KCl9shu8BKotHMlxahfWp3w53Eo+9bQgs4JXP7ZkLTiO2QaL3doQeQ8D2zunhtNAMDfPUQ1YxI/6JDec+lTv/wp7naw4XCYkYK1iP15TidKaJ8Bh1qbtoOycFnQ8oWACE+T3Y67TjI9UUdq+4I3OGu1EJcTI/W87wHkvUAvUKPxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76fa4dc-a9c0-4a40-fd99-08d61aaafe1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:59.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 1cf86bc21257a330e3af51f2a4e885f1a705f6a5 ]

If you do this on an sdm845 board:
  grep "" /sys/kernel/debug/pinctrl/*spmi:pmic*/pinconf-groups

...it looks like nonsense.  For every pin you see listed:
  input bias disabled, input bias high impedance, input bias pull down, inp=
ut bias pull up, ...

That's because pmic_gpio_config_get() isn't complying with the rules
that pinconf_generic_dump_one() expects.  Specifically for boolean
parameters (anything with a "struct pin_config_item" where has_arg is
false) the function expects that the function should return its value
not through the "config" parameter but should return "0" if the value
is set and "-EINVAL" if the value isn't set.

Let's fix this.

From a quick sample of other pinctrl drivers, it appears to be
tradition to also return 1 through the config parameter for these
boolean parameters when they exist.  I'm not one to knock tradition,
so I'll follow tradition and return 1 in these cases.  While I'm at
it, I'll also continue searching for four leaf clovers, kocking on
wood three times, and trying not to break mirrors.

NOTE: This also fixes an apparent typo for reading
PIN_CONFIG_BIAS_DISABLE where the old driver was accidentally
using "=3D" instead of "=3D=3D" and thus was setting some internal
state when you tried to query PIN_CONFIG_BIAS_DISABLE.  Oops.

Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller drive=
r")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 32 ++++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qco=
m/pinctrl-spmi-gpio.c
index 3e66e0d10010..cf82db78e69e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -390,31 +390,47 @@ static int pmic_gpio_config_get(struct pinctrl_dev *p=
ctldev,
=20
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_CMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_CMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg =3D pad->pullup =3D=3D PMIC_GPIO_PULL_DOWN;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_DOWN)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg =3D pad->pullup =3D PMIC_GPIO_PULL_DISABLE;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_DISABLE)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg =3D pad->pullup =3D=3D PMIC_GPIO_PULL_UP_30;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_UP_30)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg =3D !pad->is_enabled;
+		if (pad->is_enabled)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		arg =3D pad->power_source;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg =3D pad->input_enabled;
+		if (!pad->input_enabled)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		arg =3D pad->out_value;
--=20
2.17.1
