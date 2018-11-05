Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93820825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fX9IIhMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E93820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeKEUdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:39 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53540 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbeKEUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:38 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="23617408"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 04:14:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 5 Nov 2018 04:14:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtW5Ne5FbgerYWxnSAGvOvBx/UIH2D+oUYimY67ADd4=;
 b=fX9IIhMXmH2a3WTmBbow/IjjLxFyFZnYQU95iKROjqUH95fO8HGXKZ9szkeWurCr5mHCuQ9YKnvyYzqDpDScWNTtLA//090OuQy006gkaie5R9vnLuMmNTh8Kj/mbWa1aY8c5jIxuBgs/74K1m7tbgX+Qi1IjoC+vETU37gTFJc=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0630.namprd11.prod.outlook.com (10.163.159.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 11:14:24 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 11:14:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff function
 for at91-poweroff
Thread-Topic: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff
 function for at91-poweroff
Thread-Index: AQHUdPi1lxBGMWHwnUWOeydr5fonWw==
Date:   Mon, 5 Nov 2018 11:14:23 +0000
Message-ID: <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0630;6:C+Lva8xp/AU7q3CFGFwji+k+ctvrJDcy7U0y5SaKVblSImYvTLU54wfuGpCiQJdGFhmMLO6RSYXJMJwHBMprm4ChFK2Y79JjdtFL7ba5FRIQk+CImy5n7sMdYwMefjh9WtZKxNRmJiZYe0OE7KL8WrqQ/EoxnnDYzCA5hXE1izDoCR3Hlh5esL+34l70Rxq7Khn4sfElvWHEVjf+FS85XZYqFEpFP7ne6ckYmCGT7buJUwQigcU2MMViGABDaaDlqXdGOVnx8mnG1Q1zbDrV6BDOYGXyeP6oUZY+EUSt9Qz4UqcJwAeSGyjWXlxiHOurG1lr8M0dy5JLNcagUWm+Rf7z2PyUTzNCZlL4obu3/fDd4EocpdtvIezlF9VQMkzLyrfVT5DSQGlWQBNaydZvcSXQNujmFX+/PkTPAqH5eu6AFKGtmDpcUlQvhMAALWkuXdf9wq+OP+3bwF6XZyY8QQ==;5:Oujzp0xyBeo2zFnUE/gHtule87PU3nBDskzhIhtfIWc2TKTjtq+cnZcSGAjEgqDcx96mQInVYeVCL1X50poz8CHyunTdZ6wXwpLKAYUe05Ly2IoMKsEN7Pe1iBCXsO1m8HB/Qt7V0TWMPSPbgrvtVzHZ12dqAgkLjKP6C0L0yRY=;7:OYZTzmrPh3ddvEs9sv+AnrfQRBaGZhMIOoFFKWJ+5crwRahLQKJzXk9ZZJ4ipKFPbft458eEga7yfaW0BhHwqSRIKotnlaZcjXsXlq6hIwdRFNo0d8mmvKhuHOSp5DtKIeUlkouqCa+Msc7J6P88rg==
x-ms-office365-filtering-correlation-id: 7140facb-a940-435b-e3db-08d6430fd75f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0630;
x-ms-traffictypediagnostic: BY2PR11MB0630:
x-microsoft-antispam-prvs: <BY2PR11MB06301344BFBBC46FA1489E6787CA0@BY2PR11MB0630.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0630;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0630;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(486006)(102836004)(5660300001)(6506007)(6512007)(386003)(86362001)(53936002)(25786009)(72206003)(2616005)(476003)(186003)(478600001)(26005)(4326008)(36756003)(2900100001)(446003)(76176011)(11346002)(71200400001)(71190400001)(2501003)(105586002)(52116002)(97736004)(8936002)(8676002)(305945005)(81166006)(81156014)(68736007)(2906002)(6486002)(106356001)(66066001)(7736002)(6116002)(3846002)(6436002)(256004)(107886003)(316002)(54906003)(110136005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0630;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2A0Sf9b3kUodafHP4GGnef5NlKs5FllxCLibXE706llKRXSaY5woLw23jWE/o/eT5PBF0d+WP3jAf9ww82wL1+eITOOC0OU/oUCCybCOknJXgHcDOmPmgvMWZ9+ygjWRziUxC5KmYBTEgFMPD8BxBYmZrmJWYD5YZBoGM3FW3yf4KOD8rJARWLwxMzEv1ZupYGrstXCB4ZC9Qjy8T3hEjzuAsGYaUFlyEhVuNaDbmt0RGCD5qUe7s01M3U4oKBmqUHQSC00iJf3FQD9h6WXJ7uj5f+b8wNTK/aPawlvlFEStpJfdeaTLMIHyteGBxdokdtgpn0VoREIO5lTLsvjvOuvSi78I7iAzdCs9AFPp1yc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7140facb-a940-435b-e3db-08d6430fd75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:14:23.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0630
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use only one poweroff function and adapt it to work for both scenarios
(with LPDDR or not). The assignement of pm_power_off was moved at the
end of probe after all initializations are OK. This patch adapt the idea
from commit 4e018c1e9b05 ("power: reset: at91-poweroff: use only one
poweroff function").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 49 ++++++++++++++++++++-------------=
----
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index fb2fc8f741a1..82533f4c72fc 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -76,11 +76,6 @@ static void __init at91_wakeup_status(struct platform_de=
vice *pdev)
=20
 static void at91_poweroff(void)
 {
-	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
-}
-
-static void at91_lpddr_poweroff(void)
-{
 	asm volatile(
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -89,9 +84,11 @@ static void at91_lpddr_poweroff(void)
 		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
=20
 		/* Power down SDRAM0 */
+		"	tst	%0, #0\n\t"
+		"	beq	1f\n\t"
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 		/* Shutdown CPU */
-		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+		"1:	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
=20
 		"	b	.\n\t"
 		:
@@ -177,34 +174,42 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	if (pdev->dev.of_node)
 		at91_poweroff_dt_set_wakeup_mode(pdev);
=20
-	pm_power_off =3D at91_poweroff;
-
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
-	if (!np)
-		return 0;
+	if (np) {
+		mpddrc_base =3D of_iomap(np, 0);
+		of_node_put(np);
=20
-	mpddrc_base =3D of_iomap(np, 0);
-	of_node_put(np);
+		if (!mpddrc_base) {
+			ret =3D -ENOMEM;
+			goto clk_disable;
+		}
=20
-	if (!mpddrc_base)
-		return 0;
+		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+				 AT91_DDRSDRC_MD;
+		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
+		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
+			iounmap(mpddrc_base);
+			mpddrc_base =3D NULL;
+		}
+	}
=20
-	ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
-	if ((ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR2) ||
-	    (ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR3))
-		pm_power_off =3D at91_lpddr_poweroff;
-	else
-		iounmap(mpddrc_base);
+	pm_power_off =3D at91_poweroff;
=20
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sclk);
+	return ret;
 }
=20
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off =3D=3D at91_poweroff ||
-	    pm_power_off =3D=3D at91_lpddr_poweroff)
+	if (pm_power_off =3D=3D at91_poweroff)
 		pm_power_off =3D NULL;
=20
+	if (mpddrc_base)
+		iounmap(mpddrc_base);
+
 	clk_disable_unprepare(sclk);
=20
 	return 0;
--=20
2.7.4

