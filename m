Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24249C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC452087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W1KiKe8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfAHK4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:56:39 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28505 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:56:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="23118877"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 03:56:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 03:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jjXhJLdT1geE9ulSsjd5ZzNAHclKGpmSIcGE+hVYCw=;
 b=W1KiKe8Es9h+lUdsZ3AO4XeIgsiM6jfHLG8bYPiKwoHdLRBMtTJvH274odCLxV6/YmoKC+wBYzAI7jHtGk3KiSai0JAkO/nqvrtSAv0k18zJ197tAZfJ/wy4QTzAlNPA9yLaX/tHrUHt2Bp5g0YBK4/REQwb/OhmKl5SQuXo/iY=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1399.namprd11.prod.outlook.com (10.173.17.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 10:56:35 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e%9]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 10:56:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: at91: pm: add support for .off_in_suspend
Thread-Topic: [PATCH v2 3/3] ARM: at91: pm: add support for .off_in_suspend
Thread-Index: AQHUp0DSqhp6gp2dHEi7kDW5NVtLFg==
Date:   Tue, 8 Jan 2019 10:56:35 +0000
Message-ID: <1546944944-13911-4-git-send-email-claudiu.beznea@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1399;6:CfO4UyLDMsICUQSx7Vytv4w6cSTqKrNFUZTHUn0jau9qjKgJzqTVqBKAkHtMqUSwfX5V/WzSMep37sITZiVmVw0lxnKmnFjMuXbQQZTVR+aSbar6GiQKPCd/B13jaCI//c3B66Hr/QVHELKKlX8M73muAtuCenNWclPVeryeTHkBBoSnL0MvochQJUHC8md+nf09q+PbF12cS8y9LrLigRgsUBRDr/Vv5oVSD4X0uCjHkfGCXXkb499g156AeonjBGLTrdX9YNdFi12nlhhwJnXfQv0Xcci/gLYJE+L4YLrIizRDmJr9UzOQXUYNCZzfEYgxHtgZhFnkpV4G6IdjL9KjNd5UQvRf2jpQHrZXr2ZSph8UksDBWQ0wB1SZo8pn78wmg2rAGTvIFBZD5poAmpsPmjOtl811tka0m/9II1I43vh9OQrg9SpYUyLuqHek9FSsP0EEOurl/BF/GOIPRQ==;5:2jFMTt5OtCb0pbsjo7ZcXWJDU2NsRbKutlH4c9+K42TO8vKXefF913BL2/4hc8zgFrDnmJuswAuJnT8Tk0nFq2K97x0kJMi9mGrPiisdMkEyqrZ9OXmB7C/Z2uk7yxuf8Uk+QOu/DGn0swpqmwWZ/NOR7s/uhyQ488VrcSacnGs7BtNuiEzBvfVEnVjO3XYlYxmbW/S6eSxG+KL8uC0Spg==;7:/xne6YrQbRV1JS1LSLxpwIB4obPNG/E27+DC7Kbjga4IggDNHF4YDp9UzPhuBbcrKbi+i+8sBHSPAeEv6cqkstN6Li4TAYo3JW4yr6JeHG2cHZCPd2BZ3Ly/7JmMYsN0AgQ4ZpoiB1eYoqNoEOKS2A==
x-ms-office365-filtering-correlation-id: 550574c7-b04b-4ab8-0090-08d67557f4e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1399;
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB1399AB8F25AD97F56E643167878A0@CY4PR11MB1399.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(6512007)(72206003)(8936002)(2616005)(476003)(102836004)(478600001)(11346002)(97736004)(36756003)(256004)(14444005)(86362001)(71190400001)(2906002)(71200400001)(66066001)(3846002)(6116002)(2201001)(316002)(54906003)(186003)(2501003)(110136005)(305945005)(7736002)(14454004)(446003)(6486002)(6436002)(8676002)(7416002)(6506007)(386003)(81156014)(81166006)(5660300001)(25786009)(99286004)(26005)(39060400002)(107886003)(106356001)(105586002)(76176011)(52116002)(68736007)(4326008)(486006)(53936002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1399;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4rvXcTFMV1t9ioX0fK9bLxaOH+pdyDCzqRpU3l0vuh8ZCNrM7Vo325Gfajk98eWZqn/E2F/4lUjFZ5LY0mBLEnb0GlqKVwAfPjxojAzEP+YkGsW0WO5e7ruVakl6GaR5tj/QFkAdcxMQuBxcoV+/h0ShvELIOgTHkfP1txej7/cctjaVVOZQoVmrFRXrq2MkzwpCOYYALJcpN8u4dq5i4wFQwi842itkR1D1VgTDRCKMhdbV+Nepll1aKVYQTkL+IVYXv+vdkhQCd7cSHqSOf6qTDlQWSge3AqpM4ggYc1KE8I6/rkEIdiUHERuQAaqD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 550574c7-b04b-4ab8-0090-08d67557f4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:56:35.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
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
index 51e808adb00c..be9bd482772b 100644
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
+	return reg && regulator_is_disabled_in_suspend(reg, state);
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

