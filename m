Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CFC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706032089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="SfmnKM5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfAUUpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:45:44 -0500
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:47440
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfAUUpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wp41fqdZtU/sR94vs8DY3ByPQSSrLtPjJ/chYEI/Jo=;
 b=SfmnKM5zKS0w2Ged4KJoIcu1eTB7YwFSA7j7CwYLQyhPpggQQe/BN8OoXhl1wb4NyzD1TO9SlqVvD4kdcewhXg+4gqFWFoPlu7NZLSYeiv8MSxpWct4vOdOolw28CrsiBXwQgDAAnIrpEb3nhpakmtfKNwptc72r1aYmCDbdB2w=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM (20.178.204.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 20:45:38 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 20:45:38 +0000
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
Subject: [PATCH v9 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
Thread-Topic: [PATCH v9 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
Thread-Index: AQHUscpDmplMI0yNIE6bua5CvRNO/A==
Date:   Mon, 21 Jan 2019 20:45:38 +0000
Message-ID: <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2768;6:Z2enTm1EX+zXU3j6f/tjD1Q7EUOP6aor6L7kDkr5UTzvLRO06FNfZN0o6EmSSmHmc4seI5UW8OvGK2Too3re2i5uqHcaO+u6MabhMpl91NxUPbDx0amVfP4FX5nz/Nl8rt+QiA1yuA+QlWWYftUirT6oABV+WTtdQjFhTVmC6KUoGEKYdqPLHhEHoY78/4QVt/wyvOLUDx/4KppDlwb0C2hPyBlpdZUrxxx3W9qOPKchB0+3G34kdd6MBXJEPDDzeeIYiSHYioR/Id3Op8IRvDElS59YFHtaoE28YsJr7G7glDRa+I3FRCP1JO+2xNJcBMph6/Hdszjb37YL+p+iR7p/wFSRItk6AiH3/Cj2goKTo4VXDlaaJ6jtQjlUkPD1V/fI0S+/3Fk19COesro3h7YNGISK4F/s9bbnVVpjbonc+64+7O33m7TiA8UXX9Ej5sOQtEy6bEKgB04zk8WvBA==;5:n43ug66rqRL41fPtilh09yGqLGoVZH8oreXQLw0oaZLYe3LfDfRJU0x/Fqe2txQiw9iFjB8wKkBqUOHEucuwL8grq7eFlCLDc9px0HZmnwfgJjAvS6EGuxeeLaiF/7/C3lRsuGN6/gJ1P3axtjCNXcXkwhc2YV77+meo+/pNPDykynH5GqXI9fFsWXa2w00p5uNBDe2K74sFdusrL95tTQ==;7:iRxu8RFhQnSamCelrT0vBpIBQZBeJHFGjf6dBajpcQqXbpSisqGyK6aAzFZag1DTTPJiyL0ilFYtHIls+4R/nMJbRJ1lhb4jT6CPfEce0z00gZvjUnig9d57Mxd42TmcZhGZ2sVDzkjAcgGu9b2c6Q==
x-ms-office365-filtering-correlation-id: 0bc383ab-97a8-4670-a239-08d67fe1662a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2768;
x-ms-traffictypediagnostic: VI1PR10MB2768:
x-microsoft-antispam-prvs: <VI1PR10MB276820DA51F87CDF9D31BBC98A9F0@VI1PR10MB2768.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39850400004)(136003)(376002)(396003)(189003)(199004)(54906003)(81156014)(25786009)(6436002)(8676002)(42882007)(66066001)(26005)(14444005)(256004)(76176011)(6486002)(52116002)(105586002)(106356001)(81166006)(4326008)(8936002)(8976002)(68736007)(486006)(6512007)(478600001)(53936002)(110136005)(446003)(97736004)(107886003)(6306002)(99286004)(44832011)(2906002)(72206003)(476003)(74482002)(11346002)(71200400001)(71190400001)(2616005)(6506007)(50226002)(386003)(3846002)(1076003)(14454004)(7736002)(316002)(71446004)(186003)(6116002)(2501003)(305945005)(36756003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2768;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4DaOjkXGSNJcVBw+u/E4zL6JVwz8gCUoiFNqKWjAp7IqQUk7hnjuITQExDhQwwURiIlHDG467/e/fXH76aKHSg32EIT77n41+9ce8f0eWtRmhjX+Gs7FAqfxysGuZ2jD0eHPCbI2VC/8OBQWj5HRj7S6ckRstBYIQpH6H5AUqm66ue4UNcGZhFopj55iZh72Y3Nc/0BKR1v6mwqXxU7zYS+QokWpjyHNhoJNX4ueLiuEYEfB0LwwOnkPjuOMm4FlYQGV+WHxmuggo1zkU69wYuy5kt2L5YTuHWRxTCmE523TlF15HN/KHK/SZGUrxbUX8l1mZJLciy4QZroG90X0K9krZyzGtLzh0XZ3Rpry79HsqMxdnqXMI/Pu3fzpucQ6HzY1tcqm7plL4iJ82ZUgAdrn2NrFq5UY6z52TlCOYio=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc383ab-97a8-4670-a239-08d67fe1662a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 20:45:37.1368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a watchdog driver tells the framework that the device is running,
the framework takes care of feeding the watchdog until userspace opens
the device. If the userspace application which is supposed to do that
never comes up properly, the watchdog is fed indefinitely by the
kernel. This can be especially problematic for embedded devices.

The existing handle_boot_enabled cmdline parameter/config option
partially solves that, but that is only usable for the subset of
hardware watchdogs that have (or can be configured by the bootloader
to have) a timeout that is sufficient to make it realistic for
userspace to come up. Many devices have timeouts of only a few
seconds, or even less, making handle_boot_enabled insufficient.

These patches allow one to set a maximum time for which the kernel
will feed the watchdog, thus ensuring that either userspace has come
up, or the board gets reset. This allows fallback logic in the
bootloader to attempt some recovery (for example, if an automatic
update is in progress, it could roll back to the previous version).

The patches have been tested on a Raspberry Pi 2 and a Wandboard.

Changes in v9: Make the unit seconds instead of milliseconds.

Changes in v8: Redo on top of 5.0-rc1 - in particular, adapt to the
jiffies->ktime_t conversion (1ff68820 "watchdog: core: make sure the
watchdog_worker is not deferred"). Add a patch to make the hardware
timeout at the deadline as requested by Guenther - which was actually
made very easy by the ktime_t conversion.

v7 submission at <https://lore.kernel.org/lkml/1511865350-20665-1-git-send-=
email-rasmus.villemoes@prevas.dk/>

Rasmus Villemoes (3):
  watchdog: introduce watchdog.open_timeout commandline parameter
  watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
  watchdog: make the device time out at open_deadline when open_timeout
    is used

 .../watchdog/watchdog-parameters.txt          |  8 ++++
 drivers/watchdog/Kconfig                      |  9 ++++
 drivers/watchdog/watchdog_dev.c               | 42 +++++++++++++++----
 3 files changed, 52 insertions(+), 7 deletions(-)

--=20
2.20.1

