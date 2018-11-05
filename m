Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6644C20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0hL3+Git"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6644C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeKEUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:40 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24478 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbeKEUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:39 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="20663186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 04:14:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 5 Nov 2018 04:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+JUJTO53rYb9O143bSdfJq9Q30g+BsmInmuHssJtY8=;
 b=0hL3+GithIwePhw9c/iWkO4lbW6mDySIezO4isgBAUJ8Zx2LbvKFvyuasXTGWb9wwwxN8rdUAc4hqkEthW6hIzlTv4BvN1wYvpW2pVruSnxU6ST3vhjchEPKIX8NDxed3SQ2fFBVO/VPKLHy7a0kHal3augleYwEXQWSxvtKuW0=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0630.namprd11.prod.outlook.com (10.163.159.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 11:14:26 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 11:14:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data to
 one structure
Thread-Topic: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Index: AQHUdPi2R8S5SO7XUE65Fo0kFeM8lg==
Date:   Mon, 5 Nov 2018 11:14:26 +0000
Message-ID: <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:802:2::35) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0630;6:OxCOSNsScSj8sIC2nphFA6vcDgwrwL7/XbHOsgEWAFsH5FreCwq0dwkL+BIrGHrtEnXxaWuB/ZI/x6gInZ+mdVmG8XT1s2mHQQhjPzuqzguLxAuFQja/2QjQDF3+DefB/rWSYS1NJxDd163ylFGMqFqdb9oaF1vVlTDC+OUO5JWa+neUxefDyTPuyMLWAfOTPaXCXJCCpEqcMbSCTz32o/FgcOJK5n+PQ/Ck8sNfZ2FktSZrBMPsldCcq0C0aSl1kQh1fgZybGinuL/8bRzP91JMY72MBGbO8129plv8m9hgHkglNfiiE8ite+R1J0PF3/MIQo61XOhTyo2aTwPQbNHepLaIJBhK4OA0HBljUiu1H8HOkMg5JhsNEBsclsceKHlF7uFaMePlL9kpd3u3rCbyWjiYFrKCt/yLzPn9SDsWcRHXLEWTfypP0mXFK2W9BeD1ysXzigKtoNvO4n8x8g==;5:2Jvg1BiQKnGEdUR56UPLnprhvcgA/o+9Qdv8n2E063hts8eSdG2pir6Udb4LHcX5OOnO2a7V/+8KstwJsp69u9jsUOZZZ9Qw0VNibWdVvY+surYoId2ph6FXySRmOodezh2O1g5vHJuIzZ1iyHF2bA2ujMuWiWVH3mNyrRfWEAI=;7:WTkL/Vnt97BLD0eds7OrHSkKUFfFyIDBCtSCMbQTKyQApnY6a+c9w9Dobz4Idv6gjYIICpC75lUoKgGD48kYg5dlzATRPVv/2R5A+012Retw3sue+yH7oHYp2yBshiT0ASnY2WO73w545eUO1yny/w==
x-ms-office365-filtering-correlation-id: a5358e31-8ee4-4cd3-d565-08d6430fd8b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0630;
x-ms-traffictypediagnostic: BY2PR11MB0630:
x-microsoft-antispam-prvs: <BY2PR11MB0630EF2494484AB9D1191BFA87CA0@BY2PR11MB0630.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0630;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0630;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(486006)(575784001)(102836004)(5660300001)(6506007)(6512007)(386003)(86362001)(53936002)(25786009)(72206003)(2616005)(476003)(186003)(478600001)(26005)(4326008)(36756003)(2900100001)(446003)(76176011)(11346002)(71200400001)(71190400001)(2501003)(105586002)(52116002)(97736004)(8936002)(8676002)(305945005)(81166006)(81156014)(68736007)(2906002)(6486002)(106356001)(66066001)(7736002)(6116002)(3846002)(6436002)(256004)(107886003)(316002)(54906003)(110136005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0630;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NaOG6omT+Zcx9Gzk/a3xI5GNynOG5r6SU0luF67gd+DXctzhCOjwR1NjkgsCHmsu6RrJ+NCjtOvZAmmdJ/SvQmNmiArwYaqlWx4e7roEEe0Hs8jxLDSs8eDfYPyV0pvReDcjJSJReDMSPI+ob/PDaBls31aoT8I9rowDBsr3AwFi6SNWxcVpmxws6anW3379EKM/FFjMWC6I/hRdFRos+9NbfjmhXIrdewqNQyeA8xm3HdhAdNQxFihGxV9HVSBsU1QzyPodQCFpvGO/m9Jj8b/s+kv05KDQtUEjjY/3ol+WVTMVeCoq5yDJXXxeH60ruRJhLRZB+I7wb7JtKiKrjmAXkl6j+GG6UdUsIi1IOpI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a5358e31-8ee4-4cd3-d565-08d6430fd8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:14:26.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0630
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SHDWC realted data to only one structure to have them grouped.
Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
mpddrc_base part of struct shdwc").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 60 +++++++++++++++++++++++----------=
----
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index 82533f4c72fc..48661e04a3de 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -51,14 +51,19 @@ static const char *shdwc_wakeup_modes[] =3D {
 	[AT91_SHDW_WKMODE0_ANYLEVEL]	=3D "any",
 };
=20
-static void __iomem *at91_shdwc_base;
-static struct clk *sclk;
-static void __iomem *mpddrc_base;
+struct shdwc {
+	struct clk *sclk;
+	void __iomem *shdwc_base;
+	void __iomem *mpddrc_base;
+};
+
+static struct shdwc *at91_shdwc;
=20
 static void __init at91_wakeup_status(struct platform_device *pdev)
 {
+	struct shdwc *shdwc =3D platform_get_drvdata(pdev);
 	const char *reason;
-	u32 reg =3D readl(at91_shdwc_base + AT91_SHDW_SR);
+	u32 reg =3D readl(shdwc->shdwc_base + AT91_SHDW_SR);
=20
 	/* Simple power-on, just bail out */
 	if (!reg)
@@ -92,9 +97,9 @@ static void at91_poweroff(void)
=20
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc_base),
+		  "r" (at91_shdwc->shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
 		: "r6");
 }
@@ -118,6 +123,7 @@ static int at91_poweroff_get_wakeup_mode(struct device_=
node *np)
=20
 static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 {
+	struct shdwc *shdwc =3D platform_get_drvdata(pdev);
 	struct device_node *np =3D pdev->dev.of_node;
 	int wakeup_mode;
 	u32 mode =3D 0, tmp;
@@ -144,7 +150,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct pla=
tform_device *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
 			mode |=3D AT91_SHDW_RTTWKEN;
=20
-	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
+	writel(wakeup_mode | mode, shdwc->shdwc_base + AT91_SHDW_MR);
 }
=20
 static int __init at91_poweroff_probe(struct platform_device *pdev)
@@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	u32 ddr_type;
 	int ret;
=20
+	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
+	if (!at91_shdwc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, at91_shdwc);
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc_base))
-		return PTR_ERR(at91_shdwc_base);
+	at91_shdwc->shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc->shdwc_base))
+		return PTR_ERR(at91_shdwc->shdwc_base);
=20
-	sclk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc->sclk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc->sclk))
+		return PTR_ERR(at91_shdwc->sclk);
=20
-	ret =3D clk_prepare_enable(sclk);
+	ret =3D clk_prepare_enable(at91_shdwc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -176,20 +188,20 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
 	if (np) {
-		mpddrc_base =3D of_iomap(np, 0);
+		at91_shdwc->mpddrc_base =3D of_iomap(np, 0);
 		of_node_put(np);
=20
-		if (!mpddrc_base) {
+		if (!at91_shdwc->mpddrc_base) {
 			ret =3D -ENOMEM;
 			goto clk_disable;
 		}
=20
-		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+		ddr_type =3D readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
 				 AT91_DDRSDRC_MD;
 		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
 		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
-			iounmap(mpddrc_base);
-			mpddrc_base =3D NULL;
+			iounmap(at91_shdwc->mpddrc_base);
+			at91_shdwc->mpddrc_base =3D NULL;
 		}
 	}
=20
@@ -198,19 +210,21 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	return 0;
=20
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc->sclk);
 	return ret;
 }
=20
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
+	struct shdwc *shdwc =3D platform_get_drvdata(pdev);
+
 	if (pm_power_off =3D=3D at91_poweroff)
 		pm_power_off =3D NULL;
=20
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (shdwc->mpddrc_base)
+		iounmap(shdwc->mpddrc_base);
=20
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(shdwc->sclk);
=20
 	return 0;
 }
--=20
2.7.4

