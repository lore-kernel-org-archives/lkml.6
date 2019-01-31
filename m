Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45CC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f/U0Souf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfAaQSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:18:08 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38453 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbfAaQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:18:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261719"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 09:18:05 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhChX10vwbYxOclrTUsmMFyts4oFCatbv6zC85rEGJo=;
 b=f/U0Soufn4ki67Ucyl3htnuvAqa1vWwn140KdffW0deX4NrCP/bvSYiTDIq4G95H5a3V+Jm+xgTsdLeKViKrH4V2lPTE9A+CYjAkWT7j8Aburk+e7Gk/3IrkIsn3XRXy0JMIyx8fA3QI56wsRztf50mx5CtNa2et0UhAufCT+JA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1823.namprd11.prod.outlook.com (10.175.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:04 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength bits
Thread-Topic: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Index: AQHUuYCLA9fU9IUpL0SQqk5ieOzKJg==
Date:   Thu, 31 Jan 2019 16:18:04 +0000
Message-ID: <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1823;6:MhysTR68d8v30xIYoO03Ppd1/JU9jJNHWzt7x+Yt/KGQSSPmSGkbNNjwSjYWrBEpo6lrNk0tFOdosNOYBULAt1PTtKjaQbCLOLfr3+vmwimccMUlvAnFVDXA9P+01VjZ4ZGpxQ5BQESIWkEgxjC+aVa1W0DorBCCzrKYpPIlXobB+b9trMF/6p2VlJa0MUe+SJ5SoA7bYMV4sB4vfP6HMNRAMRvttfyX+lttsdiKT3NoafdxmCSuZdm4pZl1pByBdYySexGPAXeBPcVYf1LdW9FHFfDQ7u9e4VUmOq+4sGa62ZJb50pVU8gNw6Dxq5MgQQfdZ/quOZ3Ok4FulBz4+TMGgpRi26uFHpaOH/Fh8mzCzAZk15z3BoPS28GoGTaO8CgEwO5io4XbtSHAG6cUBuAByBSadejaKre660wAOzV5xYTaGMeXXA525N9rXqK0+6idip4F++NC8t5SQlJ4YQ==;5:A8FEZfGgvHLW8GLgWZwcKwBm18KNUuACKHjAPj93cyRItdz86jcA/qnPvicOlzmxGIWkeb+bguA59jjpvx7M7L3SpKVK+oNFCM49AiljIo53VSY68RS2ml+TIsbTohcZF+ITpfO4lBY9rejmVG8ESTny7yz/fBM9my3/lwokZUuJWU26LV7SMDCytAg06Db4k/z4W80hrb22r8e0YlYOyg==;7:uuoTihpW6+4KXTr2JXsuf7X9iabPjj7eufy5qPbpidgKQT3vPXiVjKKCR0gGcDROjej11b/WWAZPet12fAR9TiT/f4FgCdfaMCfy1juVJ3wmUkwz5WE3GD+lfr19uAr7eTJ5BF6kpqyyXryKYS1Lsg==
x-ms-office365-filtering-correlation-id: 0e8e5993-2f03-4fcb-2278-08d68797ad53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1823;
x-ms-traffictypediagnostic: MWHPR11MB1823:
x-microsoft-antispam-prvs: <MWHPR11MB1823DD813AB4FA6F903DD87587910@MWHPR11MB1823.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(8676002)(6512007)(8936002)(7736002)(36756003)(305945005)(478600001)(6116002)(106356001)(71200400001)(71190400001)(86362001)(99286004)(72206003)(76176011)(3846002)(486006)(52116002)(14454004)(256004)(6636002)(2501003)(2906002)(26005)(6506007)(25786009)(4326008)(68736007)(81166006)(316002)(6436002)(110136005)(53936002)(446003)(81156014)(186003)(105586002)(107886003)(6486002)(54906003)(386003)(2616005)(11346002)(97736004)(66066001)(102836004)(50226002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1823;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6hRjeWpS30QB4O5ToPDvMOSx3zARnHD6sq3mp5e3d6QQCbRo4NucdCNRkY8X1W0epBzQrzs+mdfYhLydYj7du2mch1GClH5SLuCrz89A4iESf9pFgTV1UQfnvGY/GEbqG9Qh0BPg9XSi2UTj3zRFWAxqNLfK3TB9e0Fpj3XEiD+OXWkQDNptGh2KjNSlv/7iBRHkijA0P9XNPql7NjKpHGqhUpduu3EZHbZGtiEP1NpyhKzCGdAF7OjT1HW80mE33Vn25q1PUkan67DEdSMf/xRygFDU1E1d255dwBlOH4PeMkaiG49unLMuq+zmjfJ5NLEk9YiodGYgu8Q5TD1cAtr3VHUch74H0xztD1w3HRUcGYRBB6FPAETDBl368FKv9ryM9qSUtBgC0n7l4vMpdIrzjrm9a9RVCgOcjrp/GtE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8e5993-2f03-4fcb-2278-08d68797ad53
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:00.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1823
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9X60 uses high and low drive strengths. To implement this, in
at91_pinctrl_mux_ops::set_drivestrength and
at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
drive strengths (1 for low, 2 for high), thus change the code to
allow the usage of drive strength bit numbers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 3d49bbbcdbc7..31f06dafca2e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -72,10 +72,15 @@ static int gpio_banks;
  * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the driv=
e
  * strength when there is no dt config for it.
  */
-#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
+enum drive_strength_bit {
+	DRIVE_STRENGTH_BIT_DEF,
+	DRIVE_STRENGTH_BIT_LOW,
+	DRIVE_STRENGTH_BIT_MED,
+	DRIVE_STRENGTH_BIT_HI,
+};
+
+#define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
+					 DRIVE_STRENGTH_SHIFT)
=20
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
@@ -551,7 +556,7 @@ static unsigned at91_mux_sama5d3_get_drivestrength(void=
 __iomem *pio,
 	/* SAMA5 strength is 1:1 with our defines,
 	 * except 0 is equivalent to low per datasheet */
 	if (!tmp)
-		tmp =3D DRIVE_STRENGTH_LOW;
+		tmp =3D DRIVE_STRENGTH_BIT_MSK(LOW);
=20
 	return tmp;
 }
@@ -564,7 +569,7 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void =
__iomem *pio,
=20
 	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
 	 * hardware: 0 =3D hi, 1 =3D med, 2 =3D low, 3 =3D rsvd */
-	tmp =3D DRIVE_STRENGTH_HI - tmp;
+	tmp =3D DRIVE_STRENGTH_BIT_MSK(HI) - tmp;
=20
 	return tmp;
 }
@@ -600,7 +605,7 @@ static void at91_mux_sam9x5_set_drivestrength(void __io=
mem *pio, unsigned pin,
=20
 	/* strength is inverse on SAM9x5s with our defines
 	 * 0 =3D hi, 1 =3D med, 2 =3D low, 3 =3D rsvd */
-	setting =3D DRIVE_STRENGTH_HI - setting;
+	setting =3D DRIVE_STRENGTH_BIT_MSK(HI) - setting;
=20
 	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
 				setting);
@@ -959,11 +964,11 @@ static int at91_pinconf_set(struct pinctrl_dev *pctld=
ev,
 	}					\
 } while (0)
=20
-#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
+#define DBG_SHOW_FLAG_MASKED(mask,flag,name) do {	\
 	if ((config & mask) =3D=3D flag) {		\
 		if (num_conf)			\
 			seq_puts(s, "|");	\
-		seq_puts(s, #flag);		\
+		seq_puts(s, #name);		\
 		num_conf++;			\
 	}					\
 } while (0)
@@ -981,9 +986,12 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *=
pctldev,
 	DBG_SHOW_FLAG(PULL_DOWN);
 	DBG_SHOW_FLAG(DIS_SCHMIT);
 	DBG_SHOW_FLAG(DEGLITCH);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(LOW),
+			     DRIVE_STRENGTH_LOW);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(MED),
+			     DRIVE_STRENGTH_MED);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
+			     DRIVE_STRENGTH_HI);
 	DBG_SHOW_FLAG(DEBOUNCE);
 	if (config & DEBOUNCE) {
 		val =3D config >> DEBOUNCE_VAL_SHIFT;
--=20
2.7.4

