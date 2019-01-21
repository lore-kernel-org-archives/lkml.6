Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39116C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F061D2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="Rl366dkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfAUUpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:45:52 -0500
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:47440
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfAUUps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewx7LARhK95EIlLwF3qFJIuQK+0vrT5JrcL1rXFLGjQ=;
 b=Rl366dkGWTwj+JoxlbPtZ30h3IFI0KpWI5ta7MxkSNVJsDKm7O+NB9KKkUF6yYyHAv1tZuUik8jzGWN+IRhnQ6OZtn4YK2JTD1myt6dK9xDqhuue/1DrHTgb74rA4HOLDT104GsUSiOIi5MDZhggiupuu55/nHufSUfv3Q/JUAo=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM (20.178.204.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 20:45:40 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 20:45:40 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Esben Haabendal <esben@haabendal.dk>,
        "martin@hundeboll.net" <martin@hundeboll.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH v9 2/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Thread-Topic: [PATCH v9 2/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Thread-Index: AQHUscpFh+km+iXtz0aqhI2t954lPQ==
Date:   Mon, 21 Jan 2019 20:45:40 +0000
Message-ID: <20190121204527.5548-3-rasmus.villemoes@prevas.dk>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::18) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [5.186.119.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2768;6:gLn+xSZ/Siz6dR7ELIoxw2rR9qUEoHnIb6plqzHDpB51aUMl6vAIDB9zqnMlxWQaYcJFT/gUr4PqewaneX/j8yqIlTqzcJW7mnASySHlsj0A9+3ZMWAgGOwYF2nkOGWb2k/oSBu03Z73PfULJobt7a/aaAzoFeRHyEaVzwoBrRdaTnspyZsxAjWJGi74elje8sKoIadvFREf8grWfqBfgJD3rlwlHC7eovocjCr+ucEfRr5U8mDF7L87MbzJRLeVW5K5WpAmR0Lt/0gYEbMntZ+pQ05NGewGblbEXzOTq1+mID1P7pKpw18qjjVxmjFYn4fEU20WTDt/dezdA3RMpuc22euL6aMrX2YwJ//IYihFkv1jOFU7fuFVtb2mq9S/+jqXurpWimgPcN24ZB3tgboh1ZLHCvEt6qWIGdh80wfWQ6OZlB71S1KKowu95SPhBb8anj8OLJV/apM5Eq3YLw==;5:t19yBVz083AtUaRdNRxXfr6mQsj3/7UQGdqQpQkksgEgDqIdqUgN4ixEE59CK9is+ZcLMo2eg7oGI8VFENgOLIoDIYHd6OnsUtstSa+wdItAdlYdLrVEZnuP0RbBeOClBTZR1v6qWqaCQeqYQGF6bWIy1jQPw8FLfP6HvVclPdzWEIu0BL4cw5xRJS2vc2Qcfnmk4ZGMsc5xemeEvYYpmA==;7:fMb0isux3y+6KYis9s2gbZODOwJ/stFAXDfXEPnMrlmLEMv52KStqJK8k7GPhjktxH+ccIcTi+H46QobTapDlhmSuSNgpRea6wq/iPjaZH8SGdxBIufall/2fKnupwCBbUFW82U82IvVN+QmtO7cPA==
x-ms-office365-filtering-correlation-id: 7432483b-9014-4fd7-1d56-08d67fe167a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2768;
x-ms-traffictypediagnostic: VI1PR10MB2768:
x-microsoft-antispam-prvs: <VI1PR10MB27683532BE4C7AEDA5BFA6218A9F0@VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39850400004)(136003)(376002)(396003)(43544003)(189003)(199004)(54906003)(81156014)(25786009)(6436002)(8676002)(42882007)(66066001)(26005)(14444005)(256004)(76176011)(6486002)(52116002)(105586002)(106356001)(81166006)(4326008)(8936002)(8976002)(68736007)(486006)(6512007)(478600001)(53936002)(110136005)(446003)(97736004)(107886003)(99286004)(44832011)(2906002)(72206003)(476003)(74482002)(11346002)(71200400001)(71190400001)(2616005)(6506007)(50226002)(386003)(3846002)(1076003)(14454004)(7736002)(316002)(71446004)(186003)(6116002)(2501003)(305945005)(36756003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2768;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AH7EYGNMA9cLTXU+fImISUs9/ozL4myPtZe6YbV2/55Vcm005XuCOqudQRACkawyPZ70Cqyqhh6GlWDzPccXL8OST5/HixDaFgEwPkO8VTq/QYNSRTLRReDTdzzP07h2iCyR4BiU5XZvgej3+btLMHw3BUbPyLgdRBpKpFO6IVIxsfT3HbOHIlNJj6tb/ELL4o7rLs3el+PFMAQUh4RjblCRX2xydIjqp6hugeaG13EXTcjuWl3YqmIDS38aH5J5otLAF+/HLaDkfkxizQ2CpXzYABp83N1t3TzplZTu9o9DtlV7AiWuG7RGecrqZZbIlQrc/ksOmN2KtkB8dY78ln6hVW6is6xt7nuCxlb0QQxjxrzFVztNVeVOLvGzN/ec9nxQaf3wlL1jyZZgfF0bhhAIyru6+1fTKfjRg07wcFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7432483b-9014-4fd7-1d56-08d67fe167a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 20:45:39.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows setting a default value for the watchdog.open_timeout
commandline parameter via Kconfig.

Some BSPs allow remote updating of the kernel image and root file
system, but updating the bootloader requires physical access. Hence, if
one has a firmware update that requires relaxing the
watchdog.open_timeout a little, the value used must be baked into the
kernel image itself and cannot come from the u-boot environment via the
kernel command line.

Being able to set the initial value in .config doesn't change the fact
that the value on the command line, if present, takes precedence, and is
of course immensely useful for development purposes while one has
console acccess, as well as usable in the cases where one can make a
permanent update of the kernel command line.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Documentation/watchdog/watchdog-parameters.txt | 8 ++++----
 drivers/watchdog/Kconfig                       | 9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 5 +++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation=
/watchdog/watchdog-parameters.txt
index 907c4bb13810..2fdbd07f9791 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -11,10 +11,10 @@ modules.
 The watchdog core parameter watchdog.open_timeout is the maximum time,
 in seconds, for which the watchdog framework will take care of pinging
 a hardware watchdog until userspace opens the corresponding
-/dev/watchdogN device. A value of 0 (the default) means an infinite
-timeout. Setting this to a non-zero value can be useful to ensure that
-either userspace comes up properly, or the board gets reset and allows
-fallback logic in the bootloader to try something else.
+/dev/watchdogN device. A value of 0 means an infinite timeout. Setting
+this to a non-zero value can be useful to ensure that either userspace
+comes up properly, or the board gets reset and allows fallback logic
+in the bootloader to try something else.
=20
=20
 -------------------------------------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d74a97..e1de5beb4e80 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -63,6 +63,15 @@ config WATCHDOG_SYSFS
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
=20
+config WATCHDOG_OPEN_TIMEOUT
+	int "Timeout value for opening watchdog device"
+	default 0
+	help
+	  The maximum time, in seconds, for which the watchdog framework takes
+	  care of pinging a hardware watchdog.  A value of 0 means infinite. The
+	  value set here can be overridden by the commandline parameter
+	  "watchdog.open_timeout".
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index ab2ad20f13eb..b763080741cc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -88,7 +88,7 @@ static struct kthread_worker *watchdog_kworker;
 static bool handle_boot_enabled =3D
 	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
=20
-static unsigned open_timeout;
+static unsigned open_timeout =3D CONFIG_WATCHDOG_OPEN_TIMEOUT;
=20
 static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
 {
@@ -1206,4 +1206,5 @@ MODULE_PARM_DESC(handle_boot_enabled,
=20
 module_param(open_timeout, uint, 0644);
 MODULE_PARM_DESC(open_timeout,
-	"Maximum time (in seconds, 0 means infinity) for userspace to take over a=
 running watchdog (default=3D0)");
+	"Maximum time (in seconds, 0 means infinity) for userspace to take over a=
 running watchdog (default=3D"
+	__MODULE_STRING(CONFIG_WATCHDOG_OPEN_TIMEOUT) ")");
--=20
2.20.1

