Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB04C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y/OcdfeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfAHJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:52:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24195 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:52:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="25050721"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 02:52:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 02:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ypxnDuNXUxh1tSqLT/QnuKbcBjBZLpen7PC47MjcKo=;
 b=Y/OcdfeRp/VRonsmaG2jwCsT4saizdzuqGE/C9geqBLs5D4XOUx21drHPlMl7LWQWzzP6W23y3GFtIX6ylkdQAuJ3WJYeJAWwRjmpj2qsOtsbVKTi3IJq52SGo0J2Kr1zV2L89wu4HcW08kmj7aykwfpRuH/OyIdrMNodRkhiSQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1838.namprd11.prod.outlook.com (10.175.53.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 09:52:53 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 09:52:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/3] PM / Suspend: Add support to check if platform's power is
 off in suspend
Thread-Topic: [PATCH 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Thread-Index: AQHUpzfs93rBcN8fLkunLXYHWnxjXQ==
Date:   Tue, 8 Jan 2019 09:52:53 +0000
Message-ID: <1546941147-18410-2-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1838;6:kQRGG7fok3dmfdZq1INsIm/iJDAkIILN6nK8LAnM/oJ1R5Mdy25D+h8JcFmoLSLxEHuElpTEWZZetJJMHtkjY3P509XtNp99cQxxlNB77LkqiJDr/9hIRbKFI49WtY3gStoVYoVQST6z7Nl+41dIzmQgXgVdoYOB0stKlL175ovbfnennkw00cXPFJ5Jbn4KwuNJuPIeUqmPeTUNCgPfLX5O+I+WDjAOoDUIJRimGBI9JVDJ1m9kZsA4SbT6GlHf5oO3mt50Qkz9Qq8hzD5HPCZa15wwbL5faTIBSVyQ6sxds4YaoPSylm4VWU7EKbWfGVJuAKeCN2Wzf2avW2fFHP1hFsctf3OgWgv+pnd6T3O+iwGcVI91/nsj0GieY2A9BcEJKmk585GVsZcURZ701OCCtEy5LM2Fh5AA5HRwW/2GYFiHc/andXgspud04NQ/G23nj/FUvU2D83m65HrNug==;5:cKwpVYFRK4BSQXTfFe15GCiko7SZRKeuUIqaIKD+Irtd3k7q7kak+6LjSzMwBrVbeadalbA9LYDsJonlO96uyPiXIKyOcmLduhf0SuRWW64pahzn9IsDCjpfZeih1kzF766Kq3G84mcO+ID6tS5vsR6MQgia1wBViiwZBQqLfl9mGMQcekXpshBf63MDpcetq0OfK6rl6bgPRP/vSiM2Fw==;7:KRS8vAeISmuQWJG25cwFuhn4pA/JU8VRJftSIKg/jkDLCXs0g+703cZQnVrSNRuHXuYMHg0WaB2uG/7UJmgD5qOuFqpkVrHALiw3KgHBJb/jMqW4TKq6vIoKLmBXjQUDnBOuZnaqe27LaOARQUiNKw==
x-ms-office365-filtering-correlation-id: 81145ac0-d99f-4532-3e92-08d6754f0ea3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1838;
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-microsoft-antispam-prvs: <MWHPR11MB1838385EEF7359948F505DE0878A0@MWHPR11MB1838.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6436002)(110136005)(305945005)(107886003)(54906003)(6512007)(76176011)(52116002)(99286004)(8936002)(105586002)(53936002)(5660300001)(81166006)(7416002)(81156014)(8676002)(4326008)(39060400002)(7736002)(316002)(106356001)(25786009)(97736004)(36756003)(14454004)(72206003)(478600001)(6486002)(66066001)(68736007)(2501003)(15650500001)(486006)(386003)(6506007)(575784001)(86362001)(476003)(2616005)(2906002)(71190400001)(71200400001)(186003)(14444005)(6116002)(3846002)(2201001)(102836004)(6346003)(11346002)(446003)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1838;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KrudZr9xiBu89BgVPS3QMYOrtwg3ikhla3SW+HYSwJYhgTHftJp5ZXFwfuFb0qzomAePg0rLF5CGYNmL7e6I/wnBA1dtc9yJLbb0aaUl9BAg97HJGV3+aUVDnmZV/o5zK+O46zJuFoLZYWNFGkmqDwzbWKiBqmOUqs/86czMZYjt9YKVNsex0CsHGTd1gueZQGgOcpBMi6j4FcLEpgQCGFpdBxBExo57qhhtYerdPYykROBmhOdchxv96KGLxrZ28e9ytEQUa5qAwH6WmHYmR53JM2TwK6SFAMwYXQZR++YYQj4MVwhyYrD5bXAWEOeW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81145ac0-d99f-4532-3e92-08d6754f0ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:52:53.1302
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

Add support to check if platform's power will be cut off in suspend.
This will help drivers shared by multiple platforms to take only the
necessary actions while suspending/resuming (some platform may not need
to save/restore all the registers if platforms remains powered while
suspended). In this way suspend/resume time could be improved.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/suspend.h |  6 ++++++
 kernel/power/suspend.c  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..21f19b167fe2 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_st=
at_step step)
  *	Called by the PM core if the suspending of devices fails.
  *	This callback is optional and should only be implemented by platforms
  *	which require special recovery actions in that situation.
+ *
+ * @off_in_suspend: Returns wheather the platform's power will be cut off =
at
+ *	the end of suspend procedure or not.
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
@@ -185,6 +188,7 @@ struct platform_suspend_ops {
 	bool (*suspend_again)(void);
 	void (*end)(void);
 	void (*recover)(void);
+	bool (*off_in_suspend)(suspend_state_t state);
 };
=20
 struct platform_s2idle_ops {
@@ -275,6 +279,7 @@ extern void arch_suspend_disable_irqs(void);
 extern void arch_suspend_enable_irqs(void);
=20
 extern int pm_suspend(suspend_state_t state);
+extern bool platform_off_in_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
=20
@@ -287,6 +292,7 @@ static inline bool pm_suspend_via_s2idle(void) { return=
 false; }
=20
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops)=
 {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline bool platform_off_in_suspend(suspend_state_t state) { return=
 false; }
 static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {=
}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..e1f60c8a17b9 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -319,6 +319,19 @@ static bool platform_suspend_again(suspend_state_t sta=
te)
 		suspend_ops->suspend_again() : false;
 }
=20
+/**
+ * platform_off_in_suspend() - specifies if SoC's power will pe cut off at=
 the
+ * end of suspend procedure.
+ */
+bool platform_off_in_suspend(suspend_state_t state)
+{
+	if (!suspend_ops || !suspend_ops->off_in_suspend)
+		return false;
+
+	return suspend_ops->off_in_suspend(state);
+}
+EXPORT_SYMBOL_GPL(platform_off_in_suspend);
+
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay =3D 5;
 module_param(pm_test_delay, uint, 0644);
--=20
2.7.4

