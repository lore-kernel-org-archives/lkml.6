Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D06C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B2B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JWbdhNHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfAHJxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:53:06 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:64538 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:53:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="22333610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 08 Jan 2019 02:53:04 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 02:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uau7BdXq5QSOlLW/aKr0JEZHPv8bSClmeerllYQSBZY=;
 b=JWbdhNHWAx/v+fCQ3ZkkC9aODwiI7xggfvjEVtSaQ9YNhpMqwlH691YvzemieW6w3woHUhkNQsAM+OvFCoM9T4g0vSKGckyZ/j/0hxSTfmAtabX0ZBREb+WBsLc9e2O7d6/2nR3QPwMDZdtfYrgy0ZrNRLkg5haO/Swjts35iw0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1838.namprd11.prod.outlook.com (10.175.53.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 09:53:01 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 09:53:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/3] ARM: at91: pm: add support for .off_in_suspend
Thread-Topic: [PATCH 3/3] ARM: at91: pm: add support for .off_in_suspend
Thread-Index: AQHUpzfx8DbDgJIZCk69o3YuClfTkQ==
Date:   Tue, 8 Jan 2019 09:53:01 +0000
Message-ID: <1546941147-18410-4-git-send-email-claudiu.beznea@microchip.com>
References: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1838;6:1Vq78gbFZTs0egHpUw2jz5XH0nckaT9KBJIrgjRPolSjd0WQhXG1++bVL+4c+bApTbN5YQQletz/HlSvWSDrCXOVM9weTgdHCd7UejorTWdYX9SYj3SE3UIMLXXiLHibmm75xhw4ho1egPOoPmIflPsWUSwfPGuDkyn+1Thpkqbzo04b2zCsQnXnj+dLSvaf1RHiKPDJ5DO6XccZLVtsjTIKBfm2UafWSjQj5QHmAxu6A/t/d9zYaFnusfi/CjLNGTji6sekuyNeeYpnLju02Wmakyce+9skL6WQpSIEzb1uqoNUOwu79ougu5ptgS5Qlnu26D8X2oFqmYhX9Zuxfjm4lgbR1g2UtMm81B6Ofq1mvCC2gVQsP3ULtW7s8vWANuwvgQQegAxEELAVYMynW40j03SQNSffdpT8lyrOqaUEzV+hd3ktWiOLYnUGX1SnSlqXpg8UQ7ZxizFQI/LZFw==;5:6EWx5AakByioqhI2RrmW+ZZkga1w68w97GXVPjHWeR0vKWteWFq8a8/8BMhqeBynNkpIBvZ+Ke/PyaqKbbR/7qwBGfCuphXFIqyPMl641nNs9gTRemxXrn4h6+WiEur0iCL35DXKQnNwKkbjArf/svzE2UR5TwFYb6vnbUTeJRcfPsWie+YoAfHVlQ6BK/ZlmcyFsugIntOFQ3qLlBd2bg==;7:Y9wYHRinGAy+4TpjSQ3EIz9nJqT6WlP2esirzRE7KfuK75ds/ZGi8/+hbzKpkuKOqkKjtneC4XcD89x/l5pYvc70ciWihZQziyinW5Vw6UMvrbyrDQIbPK/yS/FJgo7hVT88g+D5puq9LkyaTtBLtg==
x-ms-office365-filtering-correlation-id: 5f760287-8539-46ac-7d20-08d6754f13a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1838;
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-microsoft-antispam-prvs: <MWHPR11MB18388902C2BF796DC17BB891878A0@MWHPR11MB1838.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6436002)(110136005)(305945005)(107886003)(54906003)(6512007)(76176011)(52116002)(99286004)(8936002)(105586002)(53936002)(5660300001)(81166006)(7416002)(81156014)(8676002)(4326008)(39060400002)(7736002)(316002)(106356001)(25786009)(97736004)(36756003)(14454004)(72206003)(478600001)(6486002)(66066001)(68736007)(2501003)(486006)(386003)(6506007)(86362001)(476003)(2616005)(2906002)(71190400001)(71200400001)(186003)(14444005)(6116002)(3846002)(2201001)(102836004)(6346003)(11346002)(446003)(256004)(26005)(142923001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1838;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TgSauvBeWI+ueMtKJ0o9dcUL97nCBbSkq/CvL2qJUatiiOUGFvdRTSF07maDjPdv71AfOI4lFyrqMwOhTFAHTKM0U5/dYxcmSSCh+RbxJCRYsOtKMYrKgRa7R95P1kv1M0rwL8vONzRSH69ImCgeFD2czZZwsjB1U2RVxbquJ9RuaKYXlkC5EpKOQgTSU0aiwFG22WvWHRnA5Ioo34c75ZcUrGotHjlEiBqm2fAi1iEEVtYVXi16SJQgc6Ixiu0/c3aiaN0t+//rZ5COuJctHo7Uja5Yf22fAiz3pdFbmFSnM3taqTEIK7knso9wvdYL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f760287-8539-46ac-7d20-08d6754f13a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:53:01.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1838
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support to check if platform is off in suspend. The check is based on
pm_data.mode and CPU's regulator which will be turn off in suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51e808adb00c..c404d92aa297 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
+#include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
=20
 #include <linux/clk/at91_pmc.h>
@@ -164,6 +165,47 @@ static int at91_pm_config_ws(unsigned int pm_mode, boo=
l set)
 	return mode ? 0 : -EPERM;
 }
=20
+static const struct of_device_id sama5d2_cpu_reg_ids[] =3D {
+	{ .compatible =3D "active-semi,act8945a",		.data =3D "VDD_1V2" },
+	{ /* sentinel */ }
+};
+
+static struct regulator *at91_pm_cpu_regulator_get(void)
+{
+	struct device *cpu_dev =3D get_cpu_device(0);
+	static struct regulator *cpu_reg;
+	const struct of_device_id *match;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	if (!cpu_dev)
+		return cpu_reg;
+
+	if (!cpu_reg) {
+		for_each_matching_node_and_match(np, sama5d2_cpu_reg_ids,
+						 &match) {
+			pdev =3D of_find_device_by_node(np);
+			if (!pdev)
+				continue;
+
+			cpu_reg =3D regulator_get(cpu_dev, match->data);
+			put_device(&pdev->dev);
+			break;
+		}
+	}
+
+	return cpu_reg;
+}
+
+static bool at91_pm_state_allowed(suspend_state_t state)
+{
+	struct regulator *reg;
+
+	reg =3D at91_pm_cpu_regulator_get();
+
+	return !!(reg && regulator_is_disabled_in_suspend(reg, state));
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -182,6 +224,9 @@ static int at91_pm_begin(suspend_state_t state)
 		pm_data.mode =3D -1;
 	}
=20
+	if (pm_data.mode =3D=3D AT91_PM_BACKUP && !at91_pm_state_allowed(state))
+		return -EPERM;
+
 	return at91_pm_config_ws(pm_data.mode, true);
 }
=20
@@ -321,12 +366,20 @@ static void at91_pm_end(void)
 	at91_pm_config_ws(pm_data.mode, false);
 }
=20
+static bool at91_pm_off_in_suspend(suspend_state_t state)
+{
+	if (pm_data.mode !=3D AT91_PM_BACKUP)
+		return false;
+
+	return at91_pm_state_allowed(state);
+}
=20
 static const struct platform_suspend_ops at91_pm_ops =3D {
-	.valid	=3D at91_pm_valid_state,
-	.begin	=3D at91_pm_begin,
-	.enter	=3D at91_pm_enter,
-	.end	=3D at91_pm_end,
+	.valid		=3D at91_pm_valid_state,
+	.begin		=3D at91_pm_begin,
+	.enter		=3D at91_pm_enter,
+	.end		=3D at91_pm_end,
+	.off_in_suspend	=3D at91_pm_off_in_suspend,
 };
=20
 static struct platform_device at91_cpuidle_device =3D {
--=20
2.7.4

