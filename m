Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF855C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A553F20700
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iPDScGTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406886AbfBNLYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:24:11 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:62836 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389603AbfBNLYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:24:10 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="26269337"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 04:24:09 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 04:24:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td+MnSdr7EaUVSktSV1JUfvVbhtyqhDSiopXPUuFB68=;
 b=iPDScGTcrI2FHS/B4awgc/kt1630d/KrajqfPHl04OHFxaWYU0zGyDpBMzqRFULT05vEB/k2e6BwT17DHGbUi6YVRSOr3QOsk+uVtVCQ58U9Ovq/qUGHsSrAaWIBfCnHPOQLcODkROqcuJfZ87NxFMkwKovQJMZ+2cjcDmY42wM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1661.namprd11.prod.outlook.com (10.172.55.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 14 Feb 2019 11:24:07 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:24:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup capability
Thread-Topic: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Index: AQHUxFfM+pYGXoQlZ0u8Bc2PaN4VYg==
Date:   Thu, 14 Feb 2019 11:24:07 +0000
Message-ID: <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a23d251-2e34-4513-2d9d-08d6926eee8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1661;
x-ms-traffictypediagnostic: MWHPR11MB1661:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1661;23:4yI689/pdumiUOE0YzzMEIjdfu05KIbyCg537Ch?=
 =?iso-8859-1?Q?eGRY0FacJsGQpjfOlgn3WC7oTJAUtBkMTa84psiq0jDaa575wfVUJlhZVo?=
 =?iso-8859-1?Q?8a8xUAXY+ckYA4pYSDjcDL8n2UuuFOsWXVpmAGJBynv5FMb+SyCVlJLXd2?=
 =?iso-8859-1?Q?zDaqcl26PAGdwK7uotNAhqQZc1+rcQdfHoq/UBHGckFz3TdJtWGlIong6b?=
 =?iso-8859-1?Q?AxfyH4WMgc10OHxOyC8jDI74f+EzJE+lvWiOmOMnj7PJk9YO892E9Dnd6/?=
 =?iso-8859-1?Q?sk/+Ut+7J4whUKZo0W9/EtlrBaB8WmEcSOhfnaMctu4tFJ1Z7jBjLVeWSh?=
 =?iso-8859-1?Q?2fxyLIw/7n26RDtk+MRwp9OA9B7DyTAKyAgzFEm58HgUjaemj72iFcBk3C?=
 =?iso-8859-1?Q?MvObCfSFu6eC5pl3W0wYrDPIRtsuRpYSCym+perCgQ86fkzG4cdvPZ0uZ+?=
 =?iso-8859-1?Q?E/WE3ZQhc4bXe68L6qT6TR6kx29YPV8gZVOb4dL6p0QipJvjj4lwFgFjtt?=
 =?iso-8859-1?Q?rzeHQE3lJrswRVKoC5vzFvS3QktQYcQ0T5El4mjHPsz8EfZ9m4kWyKcIra?=
 =?iso-8859-1?Q?qXlVt9JkC3UEd7bOZYDYjcxuLdu7imi/NVOBnV2zQO1Id8WJPO0x6rwOw1?=
 =?iso-8859-1?Q?zA6kOk6XQC0DKTugTUlaN6EuqZJ2frpkKuTB42UFpvk5Dsjn238cWPpG6v?=
 =?iso-8859-1?Q?cnuaSrxKadef1y72OXPXbyiRlaPSP/ZZxWz7bkjy2RViPSRoyeT7TWjBas?=
 =?iso-8859-1?Q?DLu9rPGezwK8de5SO4Ox4jLCkmuIf5FdtocDBn8wDydQcqjTSKbr74nF34?=
 =?iso-8859-1?Q?/vkw40XsDlGoqgyXs1YZazO6wl+MpYDcBpV2DdyrFm62bb1xRurQ6ImM7U?=
 =?iso-8859-1?Q?ul6YaxSQSiaTmsI9MpFtpmFy1PpsNqh++MSkA+l9r+420lgKPhwqZ9s2T/?=
 =?iso-8859-1?Q?YWIWuTix4Cf8L+qcgkRLketLQYdUVQ58dGBcM7LxrSg174VqUYTmXl5S41?=
 =?iso-8859-1?Q?SKtpwIQVvZHVoyJW+tVfqmIw6E+DgEnIQ3gBXUV4HchhxCOK4aIfO8KNGh?=
 =?iso-8859-1?Q?yvsO7sXd5Kxt28h1UN2p9lDQQJrYsYyXb+NrMSlnhzGbBxS6SMjtaENoJZ?=
 =?iso-8859-1?Q?5Y+cSb/ApklSXFObaIy3oBuRQ7G98h6z1VUmlkwiKgyOUths6bP8Nkwncu?=
 =?iso-8859-1?Q?ReMHNADAA27d5WK/Kkc6c1sIeVRaYsSfpJFvNO2FKKK9EBGj3apyYSHsPb?=
 =?iso-8859-1?Q?TeUmtOlqIP6vPBbPpNQSFaMcsb7BvC7ztt1chmg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB166166CCA2C3037B8B4213A587670@MWHPR11MB1661.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(68736007)(446003)(54906003)(386003)(105586002)(6506007)(106356001)(486006)(71190400001)(99286004)(71200400001)(478600001)(76176011)(36756003)(11346002)(72206003)(6436002)(110136005)(107886003)(2616005)(476003)(4326008)(97736004)(86362001)(316002)(6512007)(53936002)(2906002)(2501003)(256004)(6486002)(305945005)(186003)(81156014)(50226002)(81166006)(66066001)(7736002)(8936002)(102836004)(52116002)(14454004)(3846002)(26005)(25786009)(6116002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1661;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wIhA3CQWxDBiMG4dPgsNwDGpmJcbeE5SMXjzQ/0vgUmhhjdf/7mSN9BNCElBH8ybV/j0m6b3lw9BIS5FNrJ3ygBSgr2lJoDakhDkiVMCCm5T7uWS7MQ+I8HP/3jk3dFsvAc/fPRVO3/y7y3hrwhA48z0EgR9q9vS8itgb8JHjGqSr/tlx3VarPkbhlXt3jMqbNbxxVvQxgbP5YX7fXU+AH4wCrYT/Qgv/kyWO/yLmrNmYiH4qwcAo2UvD++sy3t7j3heV9z3rP965+qV7i7kh9B2teNLF/ZF6bJlZQep93vjOmG++vSPIIZ8mCm0t0vNdrEY1wxJbJe1XCA8896LIkcaFHDaiWCkiligc1c/4DfzQWHErbfDGEM6uDfhE3GTKqLRKPmd1CUI27VVU3/SBZTIJYO3T9wVtKJp7vqH2lE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a23d251-2e34-4513-2d9d-08d6926eee8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:24:01.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1661
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add RTT wakeup capability.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset=
/at91-sama5d2_shdwc.c
index 2b686c55b717..0747e0cdf350 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -57,15 +57,21 @@
=20
 #define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_in=
put))
 #define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
+#define SHDW_RTTWK(reg, cfg)	(((reg) >> ((cfg)->sr_rttwk_shift)) & 0x1)
 #define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
+#define SHDW_RTTWKEN(cfg)	(1 << ((cfg)->mr_rttwk_shift))
=20
 #define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
 							SLOW_CLOCK_FREQ)
=20
+#define SHDW_CFG_NOT_USED	(32)
+
 struct shdwc_config {
 	u8 wkup_pin_input;
 	u8 mr_rtcwk_shift;
+	u8 mr_rttwk_shift;
 	u8 sr_rtcwk_shift;
+	u8 sr_rttwk_shift;
 };
=20
 struct shdwc {
@@ -104,6 +110,8 @@ static void __init at91_wakeup_status(struct platform_d=
evice *pdev)
 		reason =3D "WKUP pin";
 	else if (SHDW_RTCWK(reg, shdw->cfg))
 		reason =3D "RTC";
+	else if (SHDW_RTTWK(reg, shdw->cfg))
+		reason =3D "RTT";
=20
 	pr_info("AT91: Wake-Up source: %s\n", reason);
 }
@@ -221,6 +229,9 @@ static void at91_shdwc_dt_configure(struct platform_dev=
ice *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
 		mode |=3D SHDW_RTCWKEN(shdw->cfg);
=20
+	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
+		mode |=3D SHDW_RTTWKEN(shdw->cfg);
+
 	dev_dbg(&pdev->dev, "%s: mode =3D %#x\n", __func__, mode);
 	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
=20
@@ -231,7 +242,10 @@ static void at91_shdwc_dt_configure(struct platform_de=
vice *pdev)
 static const struct shdwc_config sama5d2_shdwc_config =3D {
 	.wkup_pin_input =3D 0,
 	.mr_rtcwk_shift =3D 17,
+	.mr_rttwk_shift	=3D SHDW_CFG_NOT_USED,
 	.sr_rtcwk_shift =3D 5,
+	.sr_rttwk_shift =3D SHDW_CFG_NOT_USED,
+};
 };
=20
 static const struct of_device_id at91_shdwc_of_match[] =3D {
--=20
2.7.4

