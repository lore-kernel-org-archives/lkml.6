Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D82C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C546208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wsev9dxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C546208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLFR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:29:50 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52658 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:29:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="21210888"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Dec 2018 10:29:49 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 10:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdYU5PuqQOlP6iiV4jYLM/lcjfo0GmsIvMyFEpTyrU8=;
 b=wsev9dxWBWQINsOWn6kWvT9LxGwKp/mq2Xil7Alw0yHvn5ORiQMWuQ3WG3rDjjQZy2HRmtZxtEHEOjNgqIJ/ltYFD4TUKKh8W2FCZNAA7wXQgZ9Es0H2pGJhsfsRNq0PhLq2Eskel6Mq1JziC+rJYnfF1BbKOVZUHv3fnt0n380=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0567.namprd11.prod.outlook.com (10.163.159.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Thu, 6 Dec 2018 17:29:47 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 17:29:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2] power: reset: at91-poweroff: move shdwc related data to
 one structure
Thread-Topic: [PATCH v2] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Index: AQHUjYlIntVT/JuI8UO9c3kqzQ3opA==
Date:   Thu, 6 Dec 2018 17:29:46 +0000
Message-ID: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0086.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::30) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0567;6:vKwdnyAXYW5RfBb+oB5EDrE7tbWBkmWiC+i2V2Lv28BCj1U4yt3P9VN+qXKVFRkc/jnLm3WtPAQlMYFG/ACGAwNljpj9XelR316EmVBfEfWAHq46aHJWI3A4SOzl/lBzUgQuuOGDte9sCdiFy5SZlA00wreGTlAx9ZLvieI0fIh314NKcsu/772Xx/NP35I5bwyS0wCkPwbefxQdQf64WMDRbeS9CFnFuz4P0+GgVbPoUPXry0AdHVIyGh79FipQpinRrGM9wC51y72USpkIMoFzjZsXbDEOUbkSaHz5U4gdxAijbkLp43sKc/Tn+vT8aupZxCVraNGZgbYZJCq/y4Cd0WQkw/w05yKPWrilsJinW/LzIfBeoNBVTaPiw9VlFN21sIHbq5hrGHxQ8UyD3Tpjow1P5hYwAyjZaCqqOOj5BV6UBMeyMN9vgaBUfm60GTAXECdcwmLDwhpjdTpo/g==;5:fpdIFOHNJdAUNe6OpOT/sTDl1qlT9hoi+tWQtOIElVi6uXZfpCNQHIR9BkKQ2sEHKWjpg1fliIwI0OwwB/RnJvsgAZ81uopUlofmykmpM09h5tqa51GzK/SrwNkp6T+6dHS40tENMu8Tn7FSOTT8anc624kq8vMISlYcQ/zekgA=;7:t8ZbC8r2h5c8xfLLOeSsVMtmJ6burp4yzs9omYLbqM0x7ZIj+ftZ406c+GnBgKnLe25gNnj9F9F0Pi+6usNAUOYd5m6HLmlHzB9qa6fEGFqpNrrgA8d1D9pa96RX4aCzqAvRHczaNIsbPk/awD+coA==
x-ms-office365-filtering-correlation-id: 17a98364-8c96-4020-dc3f-08d65ba06ad2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0567;
x-ms-traffictypediagnostic: BY2PR11MB0567:
x-microsoft-antispam-prvs: <BY2PR11MB0567B62BFB74E5353F8FB72687A90@BY2PR11MB0567.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0567;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0567;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(8676002)(478600001)(36756003)(5660300001)(2501003)(72206003)(81166006)(81156014)(71190400001)(6436002)(71200400001)(8936002)(6486002)(486006)(2616005)(476003)(256004)(97736004)(6636002)(105586002)(99286004)(102836004)(66066001)(106356001)(386003)(6506007)(110136005)(54906003)(52116002)(4326008)(186003)(305945005)(6512007)(316002)(7736002)(68736007)(53936002)(107886003)(2906002)(25786009)(6116002)(14454004)(3846002)(26005)(86362001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0567;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oF3gKyagah5kjcizgu7lPjF0D3P6mFkAHM8qW5EbjhWyIhNIkS914D8voQW4LCuA8ZqxhAs3+SigoYt96AkRfdlrmSCl3aB1JtvAeYdhGgIfe0Rv0xHZI8fZHu7WLZJzIFKRrludKKxBs2R5SjlyOY869Zc4dVYWPlMHmrJ549m+1OFjYKH2/lV8E3S7Y6lwItRznr0eaTyTLEOnWOKEE3LblZWu0L+I05KWE8nfVO4oJWsEe8guLzsrasUtUZJbGM29h8lLJca3PKu4NLEufhIBYQ1mdQEZMtZYHQLa/e0nSQPEZzv4wD0EdFpUyxgpBkaF3EJoqeJ+VrNxiUuchijpLTnxEYEE0qUwLwOKpUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a98364-8c96-4020-dc3f-08d65ba06ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 17:29:47.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0567
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Move SHDWC realted data to only one structure to have them grouped.
Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
mpddrc_base part of struct shdwc").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- avoid allocate at91_shdwc and keep it static instead
- avoid registering at91_shdwc as platform data and use static variable
  instead

 drivers/power/reset/at91-poweroff.c | 48 +++++++++++++++++++--------------=
----
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index d3d87af24e55..9e74e131c675 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -51,14 +51,16 @@ static const char *shdwc_wakeup_modes[] =3D {
 	[AT91_SHDW_WKMODE0_ANYLEVEL]	=3D "any",
 };
=20
-static void __iomem *at91_shdwc_base;
-static struct clk *sclk;
-static void __iomem *mpddrc_base;
+static struct shdwc {
+	struct clk *sclk;
+	void __iomem *shdwc_base;
+	void __iomem *mpddrc_base;
+} at91_shdwc;
=20
 static void __init at91_wakeup_status(struct platform_device *pdev)
 {
 	const char *reason;
-	u32 reg =3D readl(at91_shdwc_base + AT91_SHDW_SR);
+	u32 reg =3D readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
=20
 	/* Simple power-on, just bail out */
 	if (!reg)
@@ -92,9 +94,9 @@ static void at91_poweroff(void)
=20
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc.mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc_base),
+		  "r" (at91_shdwc.shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
 		: "r6");
 }
@@ -144,7 +146,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct pla=
tform_device *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
 			mode |=3D AT91_SHDW_RTTWKEN;
=20
-	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
+	writel(wakeup_mode | mode, at91_shdwc.shdwc_base + AT91_SHDW_MR);
 }
=20
 static int __init at91_poweroff_probe(struct platform_device *pdev)
@@ -155,15 +157,15 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	int ret;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc_base))
-		return PTR_ERR(at91_shdwc_base);
+	at91_shdwc.shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc.shdwc_base))
+		return PTR_ERR(at91_shdwc.shdwc_base);
=20
-	sclk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc.sclk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc.sclk))
+		return PTR_ERR(at91_shdwc.sclk);
=20
-	ret =3D clk_prepare_enable(sclk);
+	ret =3D clk_prepare_enable(at91_shdwc.sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -176,20 +178,20 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
 	if (np) {
-		mpddrc_base =3D of_iomap(np, 0);
+		at91_shdwc.mpddrc_base =3D of_iomap(np, 0);
 		of_node_put(np);
=20
-		if (!mpddrc_base) {
+		if (!at91_shdwc.mpddrc_base) {
 			ret =3D -ENOMEM;
 			goto clk_disable;
 		}
=20
-		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+		ddr_type =3D readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
 				 AT91_DDRSDRC_MD;
 		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
 		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
-			iounmap(mpddrc_base);
-			mpddrc_base =3D NULL;
+			iounmap(at91_shdwc.mpddrc_base);
+			at91_shdwc.mpddrc_base =3D NULL;
 		}
 	}
=20
@@ -198,7 +200,7 @@ static int __init at91_poweroff_probe(struct platform_d=
evice *pdev)
 	return 0;
=20
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc.sclk);
 	return ret;
 }
=20
@@ -207,10 +209,10 @@ static int __exit at91_poweroff_remove(struct platfor=
m_device *pdev)
 	if (pm_power_off =3D=3D at91_poweroff)
 		pm_power_off =3D NULL;
=20
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (at91_shdwc.mpddrc_base)
+		iounmap(at91_shdwc.mpddrc_base);
=20
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc.sclk);
=20
 	return 0;
 }
--=20
2.7.4

