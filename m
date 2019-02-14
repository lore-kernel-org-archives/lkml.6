Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C2222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YWZVTdtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502424AbfBNPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:55:14 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60050 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502404AbfBNPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:55:11 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="26740823"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:55:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRa/h1zYdTZeiJ05Ejj5rqzRvyQdmKUHvESAzkGGIds=;
 b=YWZVTdtjDne2vGUyGiPm5A+DXVjlO68WIktMY+o1PV0HCzWeU8pHmNik3m+U3jK506GxJBrGt2/wxvL/iwnIk7cAx7WYBgrcnQfmDe081vtUWku4JkutAv0lsncu/U6SJjZMXezzFRhXOUvjWVwrbMvpF/ugB/cohq8lrU59ucw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:55:06 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:55:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 8/8] ARM: at91: pm: do not disable/enable PLLA for ULP modes
Thread-Topic: [PATCH 8/8] ARM: at91: pm: do not disable/enable PLLA for ULP
 modes
Thread-Index: AQHUxH2nRJoXfPACgkOWEfGtZU7tFQ==
Date:   Thu, 14 Feb 2019 15:55:06 +0000
Message-ID: <1550159642-26878-9-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83a06ccd-b288-4d9a-18e7-08d69294ca05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1472;
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1472;23:PbdwCgU7WpEgnqpxZW4PqoFell2pZ43Fag0VF5z?=
 =?iso-8859-1?Q?ql5nBND69hkvSbZBrZwP6u6esRnANbdY38ILzELbDFg9gb0XmxbYDDp01X?=
 =?iso-8859-1?Q?vuMq7BCT2fkc/xH+CAOCGn8Qozy3B37Y1ByPJWI+f/n495KUL4gYAZ2VRo?=
 =?iso-8859-1?Q?bAe81oq1KDTWz78KXNzI3a7xuzEY7/2111axO454oc6053vjL3JPy9kCL/?=
 =?iso-8859-1?Q?hWisb0zR6IbSmaJBHNK/gVStmrBAjCetETDjp9vgiJmJh2Xpi2Sl2Q3JVe?=
 =?iso-8859-1?Q?9OgWKPqrIt0Gunyt0nJWlm1vUwtqk31zhWoIoEPGQAtyTHEPiOo2tHDLKU?=
 =?iso-8859-1?Q?v33Zkhr4kObmcsW1qCUcY0/JeIuUszD+IF4EBqHpe8z/M+ZRyJOwpX5j9V?=
 =?iso-8859-1?Q?NSQczo+NtYt9w5CTN6EbgTOTYclxSEqGGzVLbSmuPezJNt28TS7ZC9NPSq?=
 =?iso-8859-1?Q?YTCVqJ5M/8ettqg8UOgxEA1s3klqkcundec5OTNQ+pgPTgJ7gEs0o5vwb+?=
 =?iso-8859-1?Q?mLOcBbXGnnMzY5uFOmlJ6fo+GMWb+8Hf0tDfC2KVHd/zWkfXmTHnubpdrB?=
 =?iso-8859-1?Q?+eGF6RQKfqsQJcCKFobKMaNihEqzWmeehpx2yiODE2WgO9Pl7iKTiT/uMI?=
 =?iso-8859-1?Q?ny1E5J6qRD4ZhsUqWI6oMNlhehM9o9Vr9cSI+yqPOmUO+Y6rKAg+3Ki+fk?=
 =?iso-8859-1?Q?KME9IdcFBCwKEevlm3X1Y6A+hLLfnv5m1nSkPXecAur5h6aj7CZdpD4hWY?=
 =?iso-8859-1?Q?saDdZEvNtVA9NRE02Pxh0LKubEzDyQ7Bibhildd3JhXekO9K9HHnBW5WGd?=
 =?iso-8859-1?Q?nqmId131TqXJfGomBgr7TFTxrsGuQMveweuApU03se9Xix0A5qqXnLbBdq?=
 =?iso-8859-1?Q?WN/nlMhyL1b/EkdmEmDcFv0jTJNWm0xz3DCvSCfVGrNzz2KrAicYhzygpI?=
 =?iso-8859-1?Q?J51uOdi0Csrl5B+sezgTvdAIwwOw0JnshdTWoJ37g6yA0pWaPsRYd4o1ZA?=
 =?iso-8859-1?Q?KY3ks3xQVbJfPrP8xxd41lQ4iEcd6jwFMggYZ2vJEhR1j0JK9iLnY/DPgD?=
 =?iso-8859-1?Q?A5GhanH1dDysTaitheF2uM0NVPXLV+iBHxEIrHAo3bRib0hCANNoCRThvZ?=
 =?iso-8859-1?Q?baZhywV3OrRETDZsb3hLyUicHp84EN78ktOthI2x86Qtl7jNCAhsBrYusD?=
 =?iso-8859-1?Q?CaKPdDJKFKDHwdijXcAlE+5y2E5T3tMslu34QKWZbulflG0UiLdqhfR1dM?=
 =?iso-8859-1?Q?rh1pnuU7C8nkyPXVcUyogWpdDF03ahJH6J4pyYfxy6UQC6QXNJnTL0QBMG?=
 =?iso-8859-1?Q?tFUtOo89/uvifF4I2HmYMC64XE5CZPBDLrTRhKBJWqiHZHBdQUIZCDG66K?=
 =?iso-8859-1?Q?HGfYvq5I5fsDkMZK2xXQvlybhl1FA?=
x-microsoft-antispam-prvs: <MWHPR11MB1472EF597F4FCC534F8DF0D887670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(43544003)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(14444005)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Csapf3tNHVgnLXfF4uobOhlOg7qTnSl56wgEvdPwsmQXF9xXQretvosl2YMoj2jTdosH5mndVJbYiVRteDxIdNV57Jhb3ouJGP/S5cfniyppJ3Wu+cIiT2m+1yhmrQ6uwwSeJkJvWSvycHE8diVB73BOX44bOtcHhIZ5lcAXwY4UJ8oTvW1lXWBmgNiwD7b7JBQsrNDK9fPawsjJzn92HuriaXWp8/qp98BaWk8/1tVvCo6SmUFYy+FPmralpozJeRgYYy2AjgdUBKcAwDlgTwb8HaIPlSZwNgu0N8ds8uxCTjmIFgmmcb2cIibam/mpW++hODIhfqPg3JiRjLV/FAq3KO8XRcFNEYfHNJE8/Nbpw/Qe69i8JxOId+VpVTQMvGkOUMk3TrXguCyrs3M78Ssfnd9yHPUHTeQ4304bZvo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a06ccd-b288-4d9a-18e7-08d69294ca05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:55:02.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

There is no need to disable/enable PLLA when switching to one of the
ULP modes. The PLLA consumers should take care of this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspen=
d.S
index 5c33023f9129..77e29309cc6e 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -51,15 +51,6 @@ tmp2	.req	r5
 	.endm
=20
 /*
- * Wait until PLLA has locked.
- */
-	.macro wait_pllalock
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKA
-	beq	1b
-	.endm
-
-/*
  * Put the processor to enter the idle state
  */
 	.macro at91_cpu_idle
@@ -351,14 +342,6 @@ ENTRY(at91_ulp_mode)
=20
 	wait_mckrdy
=20
-	/* Save PLLA setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
-	str	tmp1, .saved_pllar
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
 	ldr	r0, .pm_mode
 	cmp	r0, #AT91_PM_ULP1
 	beq	ulp1_mode
@@ -373,18 +356,6 @@ ulp1_mode:
 ulp_exit:
 	ldr	pmc, .pmc_base
=20
-	/* Restore PLLA setting */
-	ldr	tmp1, .saved_pllar
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
-	bne	3f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
-	beq	4f
-3:
-	wait_pllalock
-4:
-
 	/*
 	 * Restore master clock setting
 	 */
@@ -537,8 +508,6 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .saved_mckr:
 	.word 0
-.saved_pllar:
-	.word 0
 .saved_sam9_lpr:
 	.word 0
 .saved_sam9_lpr1:
--=20
2.7.4

