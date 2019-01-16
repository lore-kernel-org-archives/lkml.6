Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DBB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="CNdRBu58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404216AbfAPMPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:15:08 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:6116
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403926AbfAPMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8pFRwvk7HT1VcS+h2ldOUo2fOk0lp4NAvzXOikb8Zg=;
 b=CNdRBu586RbEpeeRcWQ6RWwCGuSRc7DMFtiOFFcLOVdA617KZkHOr8Uv/FcWhyFlTuyR15qWg3/blNyC12U1FuyZs9b8TJ3dE2Bj6jPWOFXWRbY8JKvVvfAsjXVoGjyPvhcTgeklYAtBQQcLMNXFVguFOiyksJq0p/xGqu5MtU4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM (20.177.62.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 12:14:50 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 12:14:50 +0000
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
Subject: [PATCH v8 3/3] watchdog: make the device time out at open_deadline
 when open_timeout is used
Thread-Topic: [PATCH v8 3/3] watchdog: make the device time out at
 open_deadline when open_timeout is used
Thread-Index: AQHUrZUROWtDlErPEE6b7Pi4Fknjpw==
Date:   Wed, 16 Jan 2019 12:14:46 +0000
Message-ID: <20190116121432.26732-4-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2272;6:5cwEC+a4SsSqtXkU04wHm59K7MQ1VxLqkZa8ktS0pqO9Yid4ef5ceoh1ynwm/p+7i8o28krfGUrSzDGOr6fQaorDje9BsANo60vAuBF1lUaVE/dvtNvbzzLKnblhGFzKFWueKj8n80DMDePUoW3UWgxcCFRjzU5uCJdu6CAZQfIcitkJTTXLZfAIlMG/5ih3g+s2wWSJ7lYAtsFj6sIvMjCowL11loroutja0vv0ez+9DFCqudXyFw1GwFXuM7Ptr1RtmMkTdl1mNg0vubeC57h+HcB/Un4dwBILR6JxEge7cbWzjO18TzRuSgD2IZu/dyIiRDUh1F9JkihmxqYZov/u6e5novEBlR71zOVwG7kdnBci6fyctzjtVfA1AhIjDyzxuZRIfIFtQP8Zu+5VZK7H7U7RZLUY5ElisT9bDHPdFVZDOaIl6BLaLsRl/sAgo+hrr+mf8xFI2HW6sVwdBw==;5:9G9VDvEY3089Upn2XktYmlEHPO8NIsEEqV+CibMUPN2nuW7U4jOgKrI3kVfWVMHvFpY6V2JlPhHZTcXRiN0zv/+bkXpEPS45GHUt/jBnmlWjQ1+9f/gdipM8iGCBYjNdH6bsKOTThUefWELCPBkTflbBp5yjZR9O1AOM/WeMPzaqDG4FHfkcnzMhaEjSFzS0B/8wxdwUnjugz9Df8NgT6g==;7:u+N1Y83qvbX5VVMkXzy4oFOBV7+Rz4tHw7TCQJDiECzHwY4oIiNVyaaUiqwxbxjDrk72VEfA+5IDcduIG33dh/sfioYGyWNWMdWcjgeRlzFbcfjXq9AEBQrPnimlgZfkho86tXk3q1LHL/hyY+ickw==
x-ms-office365-filtering-correlation-id: bab13ca1-8df1-4e11-636c-08d67bac3413
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2272;
x-ms-traffictypediagnostic: VI1PR10MB2272:
x-microsoft-antispam-prvs: <VI1PR10MB22722B830EF1C43E3884F2BE8A820@VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39850400004)(366004)(376002)(199004)(189003)(316002)(6666004)(478600001)(36756003)(6506007)(386003)(7736002)(50226002)(71190400001)(305945005)(74482002)(4326008)(71200400001)(102836004)(52116002)(68736007)(76176011)(44832011)(110136005)(97736004)(25786009)(54906003)(1076003)(14444005)(72206003)(256004)(14454004)(5660300001)(53936002)(42882007)(2906002)(11346002)(26005)(2616005)(446003)(486006)(476003)(6436002)(66066001)(81156014)(81166006)(186003)(107886003)(99286004)(8936002)(3846002)(8976002)(105586002)(6116002)(106356001)(6486002)(2501003)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2272;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3zNMKnY6zwQxwyWwrwMsI6eMddcS83enlMmg1wWtcldnYkS3wl1UUlSleMlriRtjbdk/bMN7v1hztYVjhzZX5vvkHXgjkHFPHBYQ3+XFxXKzC0aYZQqSjlPIyeYamx3WQ0vybaNjx7pa6JWxRuqwkCjgnvz26y/j6Mkr4L/0kyWN2UUt60Dr8Qa7d0O2UgR0vxYE0Lz514Dr+77P3W85x7UFaUhXJDoVMz/79BSnHok83noGRex1oEZHMj5USCD2YONFKk1YLz2HWdIZpjlu+Y5ZB6NUe9Lo3ae8Wh0rLfoPEwTH9aDjQylGZyPqjkHX09dEw9BFvlOr10FhlLRsZ99tBxAGbt7kP95y0VZKLNW4D2shdHDGbYE4YmlJ6WkKwZWKsiwyrKiajyutIEGYDKucySRiJUAdolTglOEvS7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bab13ca1-8df1-4e11-636c-08d67bac3413
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 12:14:44.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the watchdog device is not open by userspace, the kernel takes
care of pinging it. When the open_timeout feature is in use, we should
ensure that the hardware fires close to open_timeout ms after the
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
open_timeout (including fractional-seconds settings) and timeout-sec
properties for the on-board watchdog by booting with 'init=3D/bin/sh',
timestamping the lines on the serial console, and comparing the
timestamp of the 'imx2-wdt 20bc000.wdog: timeout nnn sec' line with
the timestamp of the 'U-Boot SPL ...' line (which appears just after
reset).

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/watchdog_dev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 804da5b2ce02..39dd2329cbea 100644
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

