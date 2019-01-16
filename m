Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F372082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="gZU3PZi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404176AbfAPMPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:15:02 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:6116
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730413AbfAPMOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGTObNPg/mRLyfZHQcxH+Xv666mNSdafhU8ca+oV0rI=;
 b=gZU3PZi4z74gqplbKOhZ/3FyP8G1Pc/eSRGy8Ulg5E2RfKQXKJAQfL2xtXZH38B4a1f5oZ3Ppt6zPYykbBJB7JEsJ+EMdEZ8i7//ea02jhz+w/omzKYVVraJD2kH4RJdPhI/j5zqJQ6zJMGQj2LK5Mxnq8TusAJYoUF1AlczRKg=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM (20.177.62.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 12:14:44 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 12:14:44 +0000
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
Subject: [PATCH v8 2/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Thread-Topic: [PATCH v8 2/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Thread-Index: AQHUrZUQd+iTHOdbz0qapDB2+iUs3g==
Date:   Wed, 16 Jan 2019 12:14:44 +0000
Message-ID: <20190116121432.26732-3-rasmus.villemoes@prevas.dk>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0204.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::28) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2272;6:CjLtDY3y6mrUPNX/Q7iDDvDdSjUrBeq6Ip/trZfDxuI8tuV/wkBmrz5PvkbJuqcYlfNoFqvuXeeC3y5CFmdxmELxCuZF5/z0hIghK+LnqnZPhyVWfrmiP/kkmqHmd/ivUzpjaQBKbZpCokI3vAwKEVux+lsN/0ki3RROhaTgYrt+g59EFx7Ib/EzE2vcRiBMbmAJHCXcXRsfEMLKChXnG06xoLV7Uvi2KEXIWlkzVKBVyiLCIQP3cuytC7ha5VHLj1bZ7woDKEWljKj5DyuRcbSj1K+zdnMyXEf8TCBVcFTKuLIZwnvO+u7HxuUJcRYc+qk25vTx4laIeG2s+xNtfYnKCdyOPCuVRcii4SOh4M3wb7dGYbEWuRGKYwkYdHDkn1MJdUIecR81MA2VxYAyd5A4Yajd7MHpDWxyQpDQubm7tcb5KFr0srnVDLRh1iP9oYuiFptspXLeFd49IniXqQ==;5:ctgFNwv10mRYso1nAQbt+oTWczixrKw0QJGC0h5+CjeSr/i47e/agFh0qjdrjeAmu+Y9IRJcSdNi+haCDkC9PcoqX5w3hkfLRSlb3QSwuihxdeROuSP4II7vPdX7T/QBUctsIm0hQu5VTvsQ0ZEQwwWxBUD6H+o1SOI7yMJRDKpG2QZ2y2KD+Xq7l6zFVulULhWAvF3/SneuNcfbm9h0hA==;7:je24AXDdcKeCRx6eSQolWUnmxVK7xBpexStTzhNNBE7S5iZJjjaiaiBYAv7BLS9gR0wVH2AbdRdxhYYfP9WadwfHItJ6LrCGGQDlDTarudoGHtZUHU3ehbWRSFi33BRj1EDcqBWEQGXNSxR657ZBtg==
x-ms-office365-filtering-correlation-id: 78016e40-81ec-44ca-278a-08d67bac32ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2272;
x-ms-traffictypediagnostic: VI1PR10MB2272:
x-microsoft-antispam-prvs: <VI1PR10MB227251550D28A91431A28CBD8A820@VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39850400004)(366004)(376002)(199004)(189003)(43544003)(316002)(478600001)(36756003)(6506007)(386003)(7736002)(50226002)(71190400001)(305945005)(74482002)(4326008)(71200400001)(102836004)(52116002)(68736007)(76176011)(44832011)(110136005)(97736004)(25786009)(54906003)(1076003)(14444005)(72206003)(256004)(14454004)(5660300001)(53936002)(42882007)(2906002)(11346002)(26005)(2616005)(446003)(486006)(476003)(6436002)(66066001)(81156014)(81166006)(186003)(107886003)(99286004)(8936002)(3846002)(8976002)(105586002)(6116002)(106356001)(6486002)(2501003)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2272;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: usM/C2WtcdcPKaGo8gW6j8o8CUsSE9hS0dh9+0M04yaZpk9xCb0iAer4tRcGYiA7oabbVmcAa93jCMu7JvgpbxKpFyV+0+fxK7t7AzgayV1A8fFt6pFGnaQc8wggoSds4/mp+JdtA/yk4yvLVRdZVMreJDFRRxXP0pggUImWQBAMl0nZU6EOzEBUEf6ws1vnDHRS3arNQivynyvhmx4QQorJf16KheGci+ltq/pu4Z0aly3mpfyYi+XwJwaqiTUG5yAVPAidbj4jHCc+JgUQHVvOF6EuyizK+eoV61gxFititEcTwDiO5X8UnboyibVUA25move+2gl3wDKDlgZtt6EycDVxl3093FHsbuSBnM9yfrh5fekPmUbAtoKKZbfsx5xIs+/PO5AIvc1yzHEUgymMsDcXwGs+C1r07djg8s0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 78016e40-81ec-44ca-278a-08d67bac32ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 12:14:43.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2272
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
 Documentation/watchdog/watchdog-parameters.txt | 3 ++-
 drivers/watchdog/Kconfig                       | 9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 5 +++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation=
/watchdog/watchdog-parameters.txt
index 5e4235989154..f550f4fb831d 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -11,7 +11,8 @@ modules.
 The watchdog core parameter watchdog.open_timeout is the maximum time,
 in milliseconds, for which the watchdog framework will take care of
 pinging a hardware watchdog until userspace opens the corresponding
-/dev/watchdogN device. A value of 0 (the default) means an infinite
+/dev/watchdogN device. The defalt value is
+CONFIG_WATCHDOG_OPEN_TIMEOUT. A value of 0 means an infinite
 timeout. Setting this to a non-zero value can be useful to ensure that
 either userspace comes up properly, or the board gets reset and allows
 fallback logic in the bootloader to try something else.
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d74a97..289d13fecc27 100644
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
+	  The maximum time, in milliseconds, for which the watchdog
+	  framework takes care of pinging a hardware watchdog. A value
+	  of 0 means infinite. The value set here can be overridden by
+	  the commandline parameter "watchdog.open_timeout".
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index a9585925458f..804da5b2ce02 100644
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
-	"Maximum time (in milliseconds, 0 means infinity) for userspace to take o=
ver a running watchdog (default=3D0)");
+	"Maximum time (in milliseconds, 0 means infinity) for userspace to take o=
ver a running watchdog (default=3D"
+	__MODULE_STRING(CONFIG_WATCHDOG_OPEN_TIMEOUT) ")");
--=20
2.20.1

