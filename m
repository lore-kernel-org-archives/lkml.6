Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F527C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10221019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="g3sFtCWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAUUpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:45:55 -0500
Received: from mail-eopbgr70091.outbound.protection.outlook.com ([40.107.7.91]:43168
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727683AbfAUUpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qFAm6lxISZRfLE/T0rTKWIZr0yICn69gME6Xr8JYE8=;
 b=g3sFtCWfKR5GSx6XOV+SVuYE2Eal0V7LwovmqGwUMuUAAi51ixBVgLfEWKOiJWhfENGM3heUSe3Sk69PU1UInYNCssPnMWenrPYQgwyaAxY4owAbjkrPC4Dxecl/UeYceDYCVPakT+q1MWsdMFEgX50D/P6AqLY6FMZDhN4dXk4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1853.EURPRD10.PROD.OUTLOOK.COM (10.165.195.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Mon, 21 Jan 2019 20:45:41 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 20:45:41 +0000
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
Subject: [PATCH v9 3/3] watchdog: make the device time out at open_deadline
 when open_timeout is used
Thread-Topic: [PATCH v9 3/3] watchdog: make the device time out at
 open_deadline when open_timeout is used
Thread-Index: AQHUscpFORoQuv/aTUCs1CPJKNt4Yg==
Date:   Mon, 21 Jan 2019 20:45:41 +0000
Message-ID: <20190121204527.5548-4-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB1853;6:YLjt2amarZ7Za5aMOv5IQkjlLjPCiKObmN1SmD4hCNkFPF+HLaT+g4NBqTTNNjHbvoqppThTwsWKItjKrWn7tSzkx692UuS1V/iR3NN0RdwNUyQaVzbQ/4mpaNzNjDLk7PxqiMrPnh68hXp4DF6HEl2C5rxHuzur/FDtRpOeZGhj7c+ooVygTE488Ahj/oDQVlHnaolccGS89PmHzf6ZRvaQKGMyHqMFQ0q7Af36B7ia23kXK6bgKPhSqD9cGJEVfO0qxTcDUzI+VMB2xhqZPxGcDqRS/m0XkG7175aFsMyXLoKMD3eCUJ6rm7T7p/ERTDwkAZkelqcSFy1TQymhLr1sCl+QqxWQTTsjlNFt5tFhCypKUklVyAbmeHug6TXKu865Csq4KzbeyNvD/Sxs/7oWBAwPuHmwIq7U9tDVVOqIJA+LrzqCv2bSv5t8OTj21zrdtr9pyK1jTtfcCr0fhQ==;5:5E3CStaTZ+OlpYlyrJM+KudxnBo30UBY/+5CHQeEntH9Lmst99J32a/ru6/u604krxNZ2QSiQEqJMf/S0boOD2UuotLpeOd0TlZ40w9HE6D+gaBuTyPP1PJWvnmWi1657qvjN38PT9XM7hy8uFH6LSgzFDV+vUDB1TA1v6AeXKw811J/mzroi/nlHCVFex4kCjaAeRQmpgE21wC/bxzcCQ==;7:bpDZGijTDRXfX0lM3QBeZP/1xl9m4kfWKt3Qd9l9PUAO0z5sfdU3A8vMVVrdhuax/b4udWhnIC/nDcZAD9O8YTTudeGONRUUbBEKxRmVAk18C6NvwhCZFuGd81x6lf7EeBX40VZIwei6OorhCQe+SA==
x-ms-office365-filtering-correlation-id: 1237bfac-91aa-4999-00ee-08d67fe16840
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1853;
x-ms-traffictypediagnostic: VI1PR10MB1853:
x-microsoft-antispam-prvs: <VI1PR10MB1853C84353BB4E1D5AEA8E848A9F0@VI1PR10MB1853.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(81156014)(3846002)(81166006)(6116002)(8936002)(71446004)(42882007)(8676002)(107886003)(25786009)(99286004)(44832011)(316002)(36756003)(2501003)(4326008)(54906003)(476003)(52116002)(26005)(186003)(110136005)(14444005)(446003)(53936002)(8976002)(2616005)(256004)(11346002)(76176011)(50226002)(486006)(386003)(102836004)(6506007)(305945005)(7736002)(6512007)(97736004)(1076003)(68736007)(6486002)(2906002)(74482002)(6436002)(66066001)(478600001)(72206003)(71190400001)(71200400001)(106356001)(105586002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1853;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 07Rpnd6/jzXiEeuo83ClIOTE+gySsBYI4eLRRFUj2ovcWIDJxcwmIElW5ERHinF3BkURtPsscLvhFtkFWCTkobKuS0+SipWyO7SzisiiCPqpogJzKoIRi6MYsfTRgbqi0v9W3JGN5ntRIcmf3F+vTtHUwVGQQ6yKHIcAsZ5aIozI3TEQezgIzAb4/cQN5bKn/aMvD/aRsMdD0GN+rNct8Ko69QNA3fEhpJHEaW/vudk/bTKlV+r3Q4VT+lvG/GCK7g2qH/vX+DByS8qB12b6feRi8HrMobhNVS5wXJiU7mulctSgz9Etc1h0TFFjAdSprCl5makTMm17GIu/mx6KzHTDfjsmd61qv4kxEZGBxAd0qY7pajK2vdXKGAcXFKzP6QJ+EwahRR4cL8k1kYi+EVMUvBFOxAVWi5DWLd81nj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1237bfac-91aa-4999-00ee-08d67fe16840
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 20:45:40.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the watchdog device is not open by userspace, the kernel takes
care of pinging it. When the open_timeout feature is in use, we should
ensure that the hardware fires close to open_timeout seconds after the
kernel has assumed responsibility for the device (either at boot, or
after userspace has had it open and magic-closed it).

To do this, simply reuse the logic that is already in place for
ensuring the same thing when userspace is responsible for regularly
pinging the device:

- When watchdog_active(wdd), this patch doesn't change anything.

- When !watchdoc_active(wdd), the "virtual timeout" should be taken to
be ->open_deadline". When the open_timeout feature is not used (i.e.,
when open_timeout was 0 the last time watchdog_set_open_deadline was
called), ->open_deadline is KTIME_MAX, and the arithmetic ends up
returning keepalive_interval as we used to.

This has been tested on a Wandboard with various combinations of
open_timeout and timeout-sec properties for the on-board watchdog by
booting with 'init=3D/bin/sh', timestamping the lines on the serial
console, and comparing the timestamp of the 'imx2-wdt 20bc000.wdog:
timeout nnn sec' line with the timestamp of the 'U-Boot SPL ...'
line (which appears just after reset).

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/watchdog_dev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index b763080741cc..8ca310c4a9e4 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -133,14 +133,15 @@ static ktime_t watchdog_next_keepalive(struct watchdo=
g_device *wdd)
 	ktime_t virt_timeout;
 	unsigned int hw_heartbeat_ms;
=20
-	virt_timeout =3D ktime_add(wd_data->last_keepalive,
-				 ms_to_ktime(timeout_ms));
+	if (watchdog_active(wdd))
+		virt_timeout =3D ktime_add(wd_data->last_keepalive,
+					 ms_to_ktime(timeout_ms));
+	else
+		virt_timeout =3D wd_data->open_deadline;
+
 	hw_heartbeat_ms =3D min_not_zero(timeout_ms, wdd->max_hw_heartbeat_ms);
 	keepalive_interval =3D ms_to_ktime(hw_heartbeat_ms / 2);
=20
-	if (!watchdog_active(wdd))
-		return keepalive_interval;
-
 	/*
 	 * To ensure that the watchdog times out wdd->timeout seconds
 	 * after the most recent ping from userspace, the last
--=20
2.20.1

