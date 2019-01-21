Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ADC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="Oxk8Rg9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfAUUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:45:49 -0500
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:47440
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbfAUUpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTYKYyq738/poTyTSQBHOa1HotxkKwLzCdY0vMeUyNo=;
 b=Oxk8Rg9zmKoRrVPShaEHeJl3im+jTMcMx5BrqiVstzhF7BS2qW6qqvUzX7Az5Ad8gomurmjogHjXZ9+Lx1acMnhwiTtYR0M7sQjjOISUf1c96KA8DR2zTf3z7++LG6bdqV03WFIyVkgVElvJDLHk4yNt33aFBxse83oVAzKoxD4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM (20.178.204.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 20:45:39 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 20:45:39 +0000
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
Subject: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout commandline
 parameter
Thread-Topic: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Index: AQHUscpEwvUxada9K0KrXhhGLz87qA==
Date:   Mon, 21 Jan 2019 20:45:39 +0000
Message-ID: <20190121204527.5548-2-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2768;6:2hp+5xTsp3a8cMzKQEENQFZfLEni8p7ZlP0KZERBmqiJ4i2DJF8ngzztJc37Z2k76/wmKlQbPtDCzvZ4B06aAhT/i5kzGQZoBNm/czDJWljM0FIi54pXPdu9eyQS9Ko1FY5fwc3JOQsa0EwbQi58ki64MtitvsShT8lAgX2bTDJu7Qojl7o+kQKPovHOTUPpDrAt5ja2h/n6O2H9hGlXAVmnU9Kt2M8tCNSpiHVFdpO2vcSLsgaU7F0isCFw5wD0Kp7Mn05ZaWRYzI19m6H9RCtdAtGoS303C4cFKQ3d4T9HFKSVlMDScfxraSCCoLeKhYGIpYY/a6zHOI2+XK6DWurNFe+InfZebHGbe8WbnKY7c6AtlsQuv0DWDztGdSH6qX7A3EMkrj2jb4l7wEE92I5h+45jc263WtI3DzFSCSpV+N2lP5Xb/8hT4RO3jyQapAIjaZQJGWvm1I9lTPSbZg==;5:6e7cvo5MraM7EFMn45AG4G8JkrWg8i86hOg+9wS4SsYWq8+uR7IX3Jcfm/GerQCaZj54WMoIkcbuiFKU5PjF5T7RmSCTisyvhdf+MS1R/3MROEaNKGx33HpxJcb68Xv7JeLyzimA4XcgQfBuXRXWFPs8wnqa48/EboxrOdOUWlGdfDx4ZouNOg5mdOwdpXx5eZI1K140Zpkjtjmq00FsOw==;7:iKGGrNINfmlXushbojDNTN5pzxH0J/k6jT7QphSdO4rLPEdO+5ZgnUW20h3BYqnPuf+s9vqEPlvbKVEXtebhZiKFNJLTPSVqNFwHR+n5MX7HPxpfwnXPlBJ8JD9IbjpZPIsL1vxPd96pVj4Ys0h6WQ==
x-ms-office365-filtering-correlation-id: 3d890c1b-f02d-47a0-557a-08d67fe166d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2768;
x-ms-traffictypediagnostic: VI1PR10MB2768:
x-microsoft-antispam-prvs: <VI1PR10MB27682B378DA436D45DE484118A9F0@VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39850400004)(136003)(376002)(396003)(43544003)(189003)(199004)(54906003)(81156014)(25786009)(6436002)(8676002)(42882007)(66066001)(26005)(14444005)(256004)(76176011)(6486002)(52116002)(105586002)(106356001)(81166006)(4326008)(8936002)(8976002)(68736007)(486006)(6512007)(478600001)(53936002)(110136005)(446003)(97736004)(107886003)(99286004)(44832011)(2906002)(72206003)(476003)(74482002)(11346002)(71200400001)(71190400001)(2616005)(6506007)(50226002)(386003)(3846002)(1076003)(14454004)(7736002)(316002)(71446004)(186003)(6116002)(2501003)(305945005)(36756003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2768;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R2Qmb4IALJ4461aV9f02rEqSMN3AZHO0qNEpoeXWF1j4p4jpHqs3zyiNUUCcbsDITG3SLjd3aMl/q/GubOXSWluUZAeZ5zi9yMm/5l6omqk4G9oPsY53KYC2PdtmlvHTXoUx51TSA2Wz5txS4AA32RLlZ0YBVTHRKkgTxz8Zfh2XVREPp8bRpLx0PeeX372g90YccOzWQRQjQmLwq9cP66G/I/KwECjldBMUvl0hHVnyvxf512A2MID8kGPf+Ur8wkrFS+mSvtvSgHDVTbz9w1uRMkuHzDC+kIBrYaCuGUcPw+Q3UClghvIPY88LtAmLpFnsLkSAXvMtxMGtTKOtQy5tYYaBXc6RGJZ/ZK7HGEwpcTUc+6z7lXkLn0RVUp7LPH/XRVPzDxhczoVLItfcU9c0+DujdW9zrAN99IfV6Ug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d890c1b-f02d-47a0-557a-08d67fe166d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 20:45:38.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2768
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../watchdog/watchdog-parameters.txt          |  8 +++++
 drivers/watchdog/watchdog_dev.c               | 30 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation=
/watchdog/watchdog-parameters.txt
index 0b88e333f9e1..907c4bb13810 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for in=
formation on
 providing kernel parameters for builtin drivers versus loadable
 modules.
=20
+The watchdog core parameter watchdog.open_timeout is the maximum time,
+in seconds, for which the watchdog framework will take care of pinging
+a hardware watchdog until userspace opens the corresponding
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
index f6c24b22b37c..ab2ad20f13eb 100644
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
+		ktime_get() + ktime_set(open_timeout, 0) : KTIME_MAX;
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
+	"Maximum time (in seconds, 0 means infinity) for userspace to take over a=
 running watchdog (default=3D0)");
--=20
2.20.1

