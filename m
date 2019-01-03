Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA45C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08ED2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gvFbuHrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfACN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:29:55 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:8165 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbfACN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:29:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="22933260"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:51 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpSJewagfrs8VaVUElz5kkpmqguC8UIFUEOTNeJaI7c=;
 b=gvFbuHrszY34KSZL0ocv73yTtuZQHxhUVYk1WqqFJQkI8QA7yppHqVb2tn/NtQ1IvA1aKBQk5lnRTJYaKBN+LNnN6HgFdetBIOZE84WhuYExemP/2LGSVqSKOkRlKiBJEgcLu5SEfl4+Lk+GCaWdFq/RUFPsa0BuG4UETDknrIQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 2/6] pwm: add PWM modes
Thread-Topic: [PATCH v8 2/6] pwm: add PWM modes
Thread-Index: AQHUo2hlGTRebPui4EWivBrexXjs4w==
Date:   Thu, 3 Jan 2019 13:29:47 +0000
Message-ID: <1546522081-23659-3-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:awZjB8DGDkAfydnChEZ68RUVxYrBkW6C1IW8637vx0wEdf4leF4r2geuoUyDgwSRYpV3bpsCtw6IF+cFSpvbnRmgAEFQk9rG97nuybLiz8VxkZ/2eqsnoBp1ySBR4qQWGcZnccIYoQirA1hVp3/7xAOV0W4BXLTP2P3QiQhjJOKOpbMTonPbd163TOG2u8eNjlXikOwFAjOsLrYNtuXecgdlapBB6tZ3XsVBLZmOlUG228JjuRKzF4qglraNiIPupNSqnnyXvN/jac351czMf/7TjGdIV4MNFKtZ+4b30/WIH4DMc05b96o+DVZP3GmXJihNexU8WNOpqXRjBtQOSwpMv5+J2qnxQ/YLZVhAl9r+nTYQVWFVm3Q6lRL+NR/MtgsYX3Rw1RMyWA51yR9BXBMNOBsNYMcUZB0xPAuviF3hes6m3m2lOyr8KMJ0EwCUCV9wQi/UIooM7vVaZrx8qA==;5:LMHQfPC/L8k3E/Y7J/px5RBMxy/iSX8xe7MJzvMjgIsUmY9OncuOfwvAztNwh0QDilsm5M+6hrG6zm1u/1yaLh95hxeT79qDF43bn6EvgonICDTnoMUWTab79hRRv02NA1VhOiVR0jvO5+oM6e2UxBTFH7r8FGFUj3CsZxUDBXR3EKjMv+VGBiYHIj4IWLN+2MyqH/OSW1UzLX7+JjQ+xw==;7:icZTRBEypjAx5844Y5QdyhkGXLl0uV0YWZku3U+5VTA7E6/ZEkbP/xoWl8gj9uponfrrvW8VjaXWkCNZr/Bvvr3f3vwaCncZMvrCc5LBaWjZQ3nZi3ZVI4VV8l93siy2yw4qJRfVmswLkcqD6BawSA==
x-ms-office365-filtering-correlation-id: 50974f9a-eff2-4c73-9161-08d6717f87fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984D6B5F999826497064561878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(575784001)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IWO9mD4F8vqxVIkIEfWLXTz47Aat9JlEpV0O/zpsbfdBKUN70lSD8e0q0glMa5wu0jyN+DP+jgsnm5MAy60YyRBQMfk8ET92R45Pi9ZqmcRgiHvyEAENG2l2oMsu7clhG8k9cKkvksN1ZL3NAYSBNEuvezzwQJ45eBOvbEk0t3WM/Slc7aUzvSkPP9svy39Du9G4qiafZc4mp3ab0XlNkc90LW40jAmsztyIVXavqC0EVQKCwx0XXcSgJTYdybLa7+eBLqKcNGK7uiRcnqFFmBQ+KOQQ4kcAQR5qTQ17t6O9HzVpeNfXmjeWlm3H7ysM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50974f9a-eff2-4c73-9161-08d6717f87fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:47.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/pwm.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..669fd4c9cc8e 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -110,6 +110,28 @@ channel that was exported. The following properties wi=
ll then be available:
 	- 0 - disabled
 	- 1 - enabled
=20
+  mode
+    Get/set PWM channel working mode.
+
+    In the following description PWMx_y refers to output y of PWM with ID =
x.
+
+    Normal mode - for PWM channels with one output; this should be the
+        default working mode for every PWM channel; output waveforms looks
+        like this:
+              __      __      __      __
+    PWMx   __|  |____|  |____|  |____|  |__
+             ^       ^       ^       ^
+
+    Complementary mode - for PWM channels with two outputs; output wavefor=
ms
+        looks line this:
+              __      __      __      __
+    PWMx_0 __|  |____|  |____|  |____|  |__
+           __    ____    ____    ____    __
+    PWMx_1   |__|    |__|    |__|    |__|
+             ^       ^       ^       ^
+
+    Where '^' specifies the beginning of a period.
+
 Implementing a PWM driver
 -------------------------
=20
--=20
2.7.4

