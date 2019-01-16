Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0C820657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="KxE4/nRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392648AbfAPMOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:14:48 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:6116
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730413AbfAPMOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZNyw9AdIYZoHJV0vFeNf4d7/yyzCxTCW0cWa5gnvdE=;
 b=KxE4/nRtYeG5/RrZo8hT3mK6HxqC4PhpoaT6n8PzR/0I84Gtn53ykt2Q4g+EcLDmkep2Qrt9ttnqY9Q81RC77FmR6uEr8EeqebFHGfFZtQ6R9pNO60IrWeokD+9hbFKW95Q25dJ8IOFItFni4ZLIQ12XmLzRVFFhZiSKy94FGZk=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM (20.177.62.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 12:14:42 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 12:14:41 +0000
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
Subject: [PATCH v8 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
Thread-Topic: [PATCH v8 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
Thread-Index: AQHUrZUPJyzqo8ukKEK3ybUZ8MCGAQ==
Date:   Wed, 16 Jan 2019 12:14:41 +0000
Message-ID: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
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
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2272;6:jCrZdSgES4YIrZVF3T+Ovc8g4ZDkpWIUmqZ37HsxptCAwI8PU168P438pwgHzCvai7Bnoi7YjjYORM/YoXxDK1dNiNHuMsIU+kwrCVYcK4U0h1RelATA4ktrihpe0j36JQG0L+TU/Vd0PO+rItXPM8rpCDVOeBg5EWIau36Aqz5WCluMfK5gBZ79JacSG2+3pnJApRykKTH/zgOgY3qTSh7hfRqoHpza3EYnOvnjJEZB/5dUwzYOsUuiRoGoTSp+LFQFpE6xuc7nLPssDl3Sl0ar+88HCfB5F+jVA2zwvGgROGZ+GLbk5nA3z5+ak7UhBORyEmoBAuhbMy8Nyk1rVzoIEyZngGv7AEgbJ/ctdrn+Jk57Q9GCQdusyNbIJp7M0keTdZExyJae1RsqzREcQyquYnlAqFJdRtDjNW276tDJ3nHNMJtOiqrKH2lqA8IV76hUICsYNct2CnLePUMgjw==;5:u7jVMC+v40AXW5sfLsooy+dTd1M177/+YlX0nCPC7Dn96i9fBubjn968Cp32R62NpjHu08lsG8zFDY/KWoGvQ3Q0D5ZyF9RxndV2ECWix1exAOcgK5KEGqlH9FMaqqqNKpCltEHBHFT0Eqzggh8EyTRu8Wh892eFt9NLXVwQ2AVeqJwQSazIPCi3VbSjFR0IyKEpOuY8flM2ACDmtHDogw==;7:3H6fBnG99l7Ogg0W+8xkjmpDvYyAovC+LQx79kCm0hijmcvqcO2JEPxe5LO+ByOzm4tIaZqwJsRgC94geK/hLklPpg+/WS75vxBaZXriyCOemz5T8w8mr8iqTTGtWfSn3C1u6EsywCOSsDMGoRRUvw==
x-ms-office365-filtering-correlation-id: 7ee95f89-5612-4373-7e90-08d67bac3175
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2272;
x-ms-traffictypediagnostic: VI1PR10MB2272:
x-microsoft-antispam-prvs: <VI1PR10MB2272659A6960E1DF7906A85F8A820@VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39850400004)(366004)(376002)(199004)(189003)(316002)(478600001)(36756003)(6506007)(386003)(7736002)(50226002)(71190400001)(305945005)(74482002)(4326008)(71200400001)(102836004)(52116002)(68736007)(44832011)(110136005)(97736004)(25786009)(54906003)(1076003)(14444005)(72206003)(256004)(14454004)(5660300001)(53936002)(42882007)(2906002)(26005)(6306002)(2616005)(486006)(476003)(6436002)(66066001)(81156014)(81166006)(186003)(107886003)(99286004)(8936002)(3846002)(8976002)(105586002)(6116002)(106356001)(6486002)(2501003)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2272;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dKWCAUkUqu/3MqJSrP+WhUstZjNK+RnjNAPmV0m4l1IIZmJmPbtgiiF8RV/h/Crbua8BZQ7gbrSeWjmCOggZq4vMir290pvn38zVRsju21giNa9u7UIypac9mqlHrljt6kHCHOgyePnPgd+Ny9LQsRps2grR3TUKAIuLCQJ/IhCJ0KOTTTxTrOuhxKd7b5oT3qI5i2xEGm+9Kt4XEG1OaRjPjsqtia1rshI2z/nHQJQokEycuxTrLahApuZEz2pRAwxHyzR5WKYKofuSJdPtAHrLmfhEq6q9y/7PLZ+reXloKFVY1MRnwVTY81T2+J5JE8oA+ovZLZu/04kTKsOFqzpOPD0J+oOmyWE/A4Jr8zS6yhQV0SQ1d2GcvoLcyMGMkS0zSzMySQTruzMBtZo31pIbFavpYxHPsowSeJJnRVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee95f89-5612-4373-7e90-08d67bac3175
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 12:14:40.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2272
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

 .../watchdog/watchdog-parameters.txt          |  9 ++++
 drivers/watchdog/Kconfig                      |  9 ++++
 drivers/watchdog/watchdog_dev.c               | 42 +++++++++++++++----
 3 files changed, 53 insertions(+), 7 deletions(-)

--=20
2.20.1

