Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B71B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="pR1pkYFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfAPMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:14:55 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:6116
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392521AbfAPMOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1mXh9GG2LSArET8QdHMr6w0iY6C/NybE/moYTagFNM=;
 b=pR1pkYFDl59pouOk150GfqNf0/+2/krX1cFcPxAbQ1/8zdOvAkDPVYwNuAvDTN+rWMCP6bq+/g8izeR3vu2FoyB7qarHGR8FCKslgUYEjAW2Cmnp/KZzZxKS8AX8Ls63iRPwJyCUM7x6NkY1lb+dRU36aaSClX6PZ433Tkg36Bk=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM (20.177.62.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 12:14:43 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 12:14:43 +0000
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
Subject: [PATCH v8 1/3] watchdog: introduce watchdog.open_timeout commandline
 parameter
Thread-Topic: [PATCH v8 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Index: AQHUrZUPj3aLVFXGP0mMo3BbKJytmg==
Date:   Wed, 16 Jan 2019 12:14:42 +0000
Message-ID: <20190116121432.26732-2-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2272;6:RVakLt3wX53pm7Ni/xivzLWZsr5xRCT/xQcvMSF60wQrxcyXMtHdn6pQJtcq7ZpAki2/BF1spoO25v68o1viBJgWJImQ+IOC5EW9VOFYQOI4ou++OBDsmMbyCXyqo36M/iHYdm9KwIrfEpv4QCyVl+rkqoIaZQ1di186WEZTFhEVmci0wkhcnAe6QwzNSWonp34ie+wa7LO0uOOheofDgmix079LAiipu004EU9LI+AsDk/BeI9AwRynJM/ZOtSMEOLgEeCvknm1QZaNK07zGMzGWwnbBvJMxfUQrfcD9sn88ZJrSf0jS8lR4exJXV7h0EcbwOySrDh3cpNW4NEhyw6J1WHr8IPxYaym18IGhCEx8ks0ENJZGUE/w9EwurNSN3m+bLpTokyEqFeXAUb9YtHVvNiZKBVqgs9FTGZg6tvKSG5zGc7AcySFoyB8GzuG/qkb3u4QucLJliQsMPV3pg==;5:QBg/CuBw8KDbdAQJcSVjle0QfTaeBBPJeZTVPWdARQ+W8vc/aVuk5etDCRbq/FJtoIT9J3JzHr824576dDjsLBAfcDRGtXedWQsnqmn1qUhjbyBJJ4HwUuGAdDrPUqjMJuKLw/OYJkx9lp51Q0JH4pFfgYQL1VAAEd6ZetT2JDGWGDRhWE+3VrO5aSm/lOucuDDOsz7M+cfnsdSR6/TndA==;7:dSfkGNo7zrWj7JaEIVup6G94iCleVUlCMsmgqyLuGEunRk3/b5petxaqTWoJE9UN6GVimOK/A3MN5n4U89uXs8yrZkzMtWwd7Q8fngfnmG4d1WuhpOtVLv0mO+lw7DW2vsbjH1ERIImmPfKfkgE3rw==
x-ms-office365-filtering-correlation-id: 4e6f00f5-8141-4324-2088-08d67bac3240
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2272;
x-ms-traffictypediagnostic: VI1PR10MB2272:
x-microsoft-antispam-prvs: <VI1PR10MB2272657F93D3B9FC8BBBC4638A820@VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39850400004)(366004)(376002)(199004)(189003)(43544003)(316002)(478600001)(36756003)(6506007)(386003)(7736002)(50226002)(71190400001)(305945005)(74482002)(4326008)(71200400001)(102836004)(52116002)(68736007)(76176011)(44832011)(110136005)(97736004)(25786009)(54906003)(1076003)(14444005)(72206003)(256004)(14454004)(5660300001)(53936002)(42882007)(2906002)(11346002)(26005)(2616005)(446003)(486006)(476003)(6436002)(66066001)(81156014)(81166006)(186003)(107886003)(99286004)(8936002)(3846002)(8976002)(105586002)(6116002)(106356001)(6486002)(2501003)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2272;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kS+1J8x36jCnqtLyheUkGcbfasktJnVGYzKSyzuxTsmMIw0m2uwwm1OpnDVGZ5m9SogMBuXr1TQu/cGwCnykrPawt+7IwpWKsuMm9WvvIzcFRGSYEIz0V7FePDtFlkJLf9r4PWcTVqQiWqfr87ISxQr/xEiJcyXSpPwLHws9YzZ3jjhnn8uj6Fg+jgKBV8BahBWpVg/T5upgnrIyTwwTYNBK9XdieV/sENZA/e7um/b9G/wQr1XINfG7TczfYCn/Y47L2sfQ4bLduSoER6bkDXZ8yyZoUDKcD5ov30EBmcX3EQEbfIkTinBoJ0tGcUVSO6ZFwklEn+c5rikqDhcKviKzL9c5GhCm3vdV9iVdsDFyy1GGlJOOKd0wUX2aEJm5uC2TxcUXOkD+WTZrntWn1uOMERSzUIpI/nNUiT3xjQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6f00f5-8141-4324-2088-08d67bac3240
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 12:14:41.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog framework takes care of feeding a hardware watchdog until
userspace opens /dev/watchdogN. If that never happens for some reason
(buggy init script, corrupt root filesystem or whatnot) but the kernel
itself is fine, the machine stays up indefinitely. This patch allows
setting an upper limit for how long the kernel will take care of the
watchdog, thus ensuring that the watchdog will eventually reset the
machine.

A value of 0 (the default) means infinite timeout, preserving the
current behaviour.

This is particularly useful for embedded devices where some fallback
logic is implemented in the bootloader (e.g., use a different root
partition, boot from network, ...).

There is already handle_boot_enabled serving a similar purpose. However,
such a binary choice is unsuitable if the hardware watchdog cannot be
programmed by the bootloader to provide a timeout long enough for
userspace to get up and running. Many of the embedded devices we see use
external (gpio-triggered) watchdogs with a fixed timeout of the order of
1-2 seconds.

The open timeout is also used as a maximum time for an application to
re-open /dev/watchdogN after closing it. Again, while the kernel already
has a nowayout mechanism, using that means userspace is at the mercy of
whatever timeout the hardware has.

Being a module parameter, one can revert to the ordinary behaviour of
having the kernel maintain the watchdog indefinitely by simply writing 0
to /sys/... after initially opening /dev/watchdog; conversely, one can
of course also have the current behaviour of allowing indefinite time
until the first open, and then set that module parameter.

The unit is milliseconds rather than seconds because that covers more
use cases. For example, userspace might need a long time to get in the
air initially, requiring a somewhat liberal open_timeout, but when (for
whatever reason) the application might then want to re-exec itself, it
can set a much smaller threshold.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../watchdog/watchdog-parameters.txt          |  8 +++++
 drivers/watchdog/watchdog_dev.c               | 30 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation=
/watchdog/watchdog-parameters.txt
index 0b88e333f9e1..5e4235989154 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for in=
formation on
 providing kernel parameters for builtin drivers versus loadable
 modules.
=20
+The watchdog core parameter watchdog.open_timeout is the maximum time,
+in milliseconds, for which the watchdog framework will take care of
+pinging a hardware watchdog until userspace opens the corresponding
+/dev/watchdogN device. A value of 0 (the default) means an infinite
+timeout. Setting this to a non-zero value can be useful to ensure that
+either userspace comes up properly, or the board gets reset and allows
+fallback logic in the bootloader to try something else.
+
=20
 -------------------------------------------------
 acquirewdt:
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index f6c24b22b37c..a9585925458f 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -69,6 +69,7 @@ struct watchdog_core_data {
 	struct mutex lock;
 	ktime_t last_keepalive;
 	ktime_t last_hw_keepalive;
+	ktime_t open_deadline;
 	struct hrtimer timer;
 	struct kthread_work work;
 	unsigned long status;		/* Internal status bits */
@@ -87,6 +88,19 @@ static struct kthread_worker *watchdog_kworker;
 static bool handle_boot_enabled =3D
 	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
=20
+static unsigned open_timeout;
+
+static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
+{
+	return ktime_after(ktime_get(), data->open_deadline);
+}
+
+static void watchdog_set_open_deadline(struct watchdog_core_data *data)
+{
+	data->open_deadline =3D open_timeout ?
+		ktime_get() + ms_to_ktime(open_timeout) : KTIME_MAX;
+}
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -211,7 +225,13 @@ static bool watchdog_worker_should_ping(struct watchdo=
g_core_data *wd_data)
 {
 	struct watchdog_device *wdd =3D wd_data->wdd;
=20
-	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
+	if (!wdd)
+		return false;
+
+	if (watchdog_active(wdd))
+		return true;
+
+	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
 }
=20
 static void watchdog_ping_work(struct kthread_work *work)
@@ -297,7 +317,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
=20
-	if (wdd->ops->stop) {
+	if (wdd->ops->stop && !open_timeout) {
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err =3D wdd->ops->stop(wdd);
 	} else {
@@ -883,6 +903,7 @@ static int watchdog_release(struct inode *inode, struct=
 file *file)
 		watchdog_ping(wdd);
 	}
=20
+	watchdog_set_open_deadline(wd_data);
 	watchdog_update_worker(wdd);
=20
 	/* make sure that /dev/watchdog can be re-opened */
@@ -983,6 +1004,7 @@ static int watchdog_cdev_register(struct watchdog_devi=
ce *wdd, dev_t devno)
=20
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive =3D ktime_sub(ktime_get(), 1);
+	watchdog_set_open_deadline(wd_data);
=20
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
@@ -1181,3 +1203,7 @@ module_param(handle_boot_enabled, bool, 0444);
 MODULE_PARM_DESC(handle_boot_enabled,
 	"Watchdog core auto-updates boot enabled watchdogs before userspace takes=
 over (default=3D"
 	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
+
+module_param(open_timeout, uint, 0644);
+MODULE_PARM_DESC(open_timeout,
+	"Maximum time (in milliseconds, 0 means infinity) for userspace to take o=
ver a running watchdog (default=3D0)");
--=20
2.20.1

