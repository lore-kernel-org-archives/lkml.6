Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D56FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001DB2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ek6p/b5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfBUNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:45:53 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:60812 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBUNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:45:52 -0500
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; 
   d="scan'208";a="24225445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2019 06:45:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 06:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC9Sg3RKw34ixaN2S3M72KryUsEVfr17/Cjot5fMG3g=;
 b=Ek6p/b5BYEV/HPde0b/RH7xdfAyVoupmLUrmGJ1FGGSs9GIqxHMt45pOHLNlJDpQDI3ICriVtVcJ57fO02glwD3PJglfVx5qsuxqN9HfjPDTa9HEb4hpZH6V9fSIIjHyvf/1XVyC1eXyHhH7DGW9vHVGeSRAxQi6Q3NHTE++lgw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1677.namprd11.prod.outlook.com (10.172.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:45:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 13:45:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 1/3] power: reset: at91-poweroff: add RTT wakeup capability
Thread-Topic: [PATCH v2 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Index: AQHUyevAV4hXVGKMOUuIUcZK/AzqJA==
Date:   Thu, 21 Feb 2019 13:45:48 +0000
Message-ID: <1550756716-3032-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bda0993-3601-4807-1699-08d69802e2aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1677;
x-ms-traffictypediagnostic: MWHPR11MB1677:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1677;23:Fj/riKE3LSOBGRzgFiJ1vTKInuWlrITxXoxxN06?=
 =?iso-8859-1?Q?nDrIyMJEl7BOZsMzcdDHJmeMd4uvUk81SPdz5U3/rkCr7sGUz6xIP0es/o?=
 =?iso-8859-1?Q?F1C5y2yBkWrHgMTAtzHT7rJsoCDkQtCywDOcad66djXP5tkXOekBolLpYN?=
 =?iso-8859-1?Q?jFiVCibA72qHRpenwemM1prtiNjeSHfibMT3OdEx0j3hfjchHWQKLFTJl5?=
 =?iso-8859-1?Q?SEV/2+C21/aR1HZkXnakR/AmYYA1UtkXrXqLxgG95gs+AzXeS59QzKXQxS?=
 =?iso-8859-1?Q?FGhLq0/GntL4bgKFUxtPQ6D+apwlNheJCBiY9uaixBvcgV8ekPqS8eU3oF?=
 =?iso-8859-1?Q?7b1DPPqkCB68KlNEhA1hqNV8T9galCodqpsmpjPbblwKCSECkuVBnqCWxS?=
 =?iso-8859-1?Q?+Ws+0XVCsKiz0zsySn+UR2z1pRKEGraU9+EktJXob1tGwAcBZQ6BCwpoAv?=
 =?iso-8859-1?Q?osnCRPlw/nVSAu8EDxIpz/J3L0ehQYh6CPfrSptdn6T/UQTRVvsJfb2A2B?=
 =?iso-8859-1?Q?rOjfW40dkfj8z8kiZk7EkJQLw/7+x9vFydlGNQAnIXj8PBa/8OzQy3N/be?=
 =?iso-8859-1?Q?vNGWtDA3NoBRF1qi25usQmlynR0tIenG1CuTQdDPPbbN1mym9hpoRng+bG?=
 =?iso-8859-1?Q?S8SEuXhbZptU+r9/OFJZ+LXvEHEb/q1kqjH4UIqwsrg3wx53JRvpNKTnaH?=
 =?iso-8859-1?Q?vSh2vYotLF1ch4+9Oa5eelYq8MI7IH+I5PtNfPIzgW4SeJXNkJB1MiXqpZ?=
 =?iso-8859-1?Q?hOoMQIES8WJYCvpFQ1ywaoWJWJWGLG9JY30gfS/h6qKnc4JceTkB3T6ucp?=
 =?iso-8859-1?Q?DT5sKIux8IPEZWaV6oRkBwRvHkhDXnF3wrujXpufI0/t++HCblKKc7YoQY?=
 =?iso-8859-1?Q?czf4Nc9dBnAfFk4B8LIaYVtcp0QENhTwZ3xRyAHLu2v6Jv8zUXcWSICbQM?=
 =?iso-8859-1?Q?+yZQL+zHDQ6v4dhwictKDdmPbLrHb0xiXupbB4yCOVnC0gGv0xIfuZwbvX?=
 =?iso-8859-1?Q?yjuejj+SGX97eD4xWbmV0KGwwQNPWuPve6mcdDJOlCQdG4syQzZs0P7b+j?=
 =?iso-8859-1?Q?ePM7nsxBPMjs48C7HtKPuOwLvCumEXQ+OmPEBFLuMV0SXpEfAnzpRDB4OE?=
 =?iso-8859-1?Q?U8q21n4xnLC0jyrhk8nFPXr8AM2Yr3Xcrjm4TiUliOm4g6d3t8KudIZ3R0?=
 =?iso-8859-1?Q?WL5i2mNclh9wfDGss4KMWNAGvDnef3kdMLtmmLbYIO9vGCclqX0ZPtd33M?=
 =?iso-8859-1?Q?yCwDq3CbNs6Xj/bfLQN0jvwifPxO+6vQsLi3ZR9a5h7JLrQB80epLZetEg?=
 =?iso-8859-1?Q?V0=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB16774D76AEC5B02AD45E8DC1877E0@MWHPR11MB1677.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(6436002)(6486002)(66066001)(36756003)(107886003)(5660300002)(81166006)(97736004)(8676002)(25786009)(2501003)(4326008)(81156014)(7736002)(305945005)(8936002)(26005)(50226002)(53936002)(186003)(6506007)(386003)(102836004)(6116002)(3846002)(14454004)(316002)(478600001)(72206003)(2906002)(106356001)(54906003)(256004)(110136005)(6512007)(486006)(71200400001)(71190400001)(68736007)(86362001)(476003)(52116002)(446003)(11346002)(99286004)(2616005)(105586002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1677;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s++/JLV7L9qlIFqby6fqMBQIt/5c7uqy3sWq32RWcRltDhvT3fbx8xJH/k0FhbdZCt7xWq4FdU8+WhnrNIa2Jsu0zofH2sQ5xWFmQWOEDhJGd4WrQP2JWn9/vYOEfpNycVjivHpEy1FXxi1xKRFVdE2EQDtJtt0dNfnC6vmSE1TXvTURvAnLgs99N+dztJRqmmq3mnL5vwWaze3GL24DNNLp8/K5ftOQAx2Ywctnc5R+Cnatt8QwKsPYOiRJ3pwO4YRlJuOpNgMqS3ucToYGfI2YPFkUWloh6fDwMB/B40ay2SMrkWLogFq4DckkWYeSqSHaHM3ZYJyJIU5yA8BnbDlTYKRZ8l0mE52QHkfAR5QuPAIXW8cNEDDEFd6DiCObFhPSLqTys/IwVvsEBWu61SBM7uwcJHH6W+LjsNZ+cqU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda0993-3601-4807-1699-08d69802e2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:45:45.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1677
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add RTT wakeup capability.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

