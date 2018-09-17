Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nvCgEE6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D75B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeIQIbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:10 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730776AbeIQIbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ug/8FwLmwaadERk9zpCeEWqkwc80wxqrDkE0MgBe6E=;
 b=nvCgEE6XaR5vqJfNzNdAlMx8pKFWVUMMBkGe1Lg1L4nuouPnGRD7zvLqrgpubZSRoL50rKUuCM10YfRAqYzhLxbG16KHa3c3nhVnt78qPrNSITowYWfDC4V8lIWR5CDHYHqukFVGa/6vmoNgZoo7D+qlpxmZRlYqSauvFsBgnnE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 29/57] alarmtimer: Prevent overflow for relative
 nanosleep
Thread-Topic: [PATCH AUTOSEL 4.9 29/57] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Index: AQHUTjMV949ZmbvD7kak30etibNipA==
Date:   Mon, 17 Sep 2018 03:04:01 +0000
Message-ID: <20180917030340.378-29-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:egNMGPj2GtEecQajiuQLo9PwH6PpD3N6LknTDOUg0yKW4uaARx2ibgYlHXantyDwz9bPKbn7MeGP0n10ydgCBIfcIFTXQEG3hLZrDYr2B17zNcsnzc97HD2459cl/kTNMAjrP1t4ApmDw594RDtQ3pZQpMa4NS7Ilxiq9MqQEXmgkWF/uOjbE+GvfGAvaVGJ3LSpbsoZaGKwVjVoGZwZhjZOUH+wc7IG8m9PBHdzZ7wKww3+ZDji3x5ko0UeIxTyYHAcYWWOaMGZrE9VjN/mqjPsQOAEyMLftgJD3H3RWvcER+PpP19wmnROnNRnK/0qf2HcUanKtPI5xGNAM0jEjhdD9By/TIYC7C/vHz2UantCx0XvvEhJ0Vkpf3LXjo7HJA49vr2DJEpcDV5nGYboMPJ0zan/ffZuNZPGOjyt5tC7IoxUi/892XcZq557ObWgIZi78oZm9SyyvE/QIgzhZQ==;5:Zuzx9pO2Fh2doCN/Y2grDAySggXsQnY2WIRANrFbqO2Iy7/FlXAgvoUmNeM9nLN3f5ofDYkxMWZsR37i47h8rZtLk6Y1sdw9MlnsjB7GIlYH49QOrL86t7+zv0qil44l68LG1nMQfpwoQQR1ZgytqbfFpVKD6u6YrQalZMlBuLk=;7:l2DWeVAgA305Kd1tP+uIdltXMCgTWm6ZfgfptN8URfF2JNxisjdGYNjWA7UDVIbbSQ/jaYOnMp8Zzjj62h53J0c6JJBXy8j7eXWyeFa7p6jYcIx6cc7If8aE2Tqv+TO0tGq8BoxbBZFiVFcOwK+PVG8oROWQAnCzYYSYKPgqJxnTMeg4U4NleMkIBG2JEQVmopNLqzHwx7KZgPFoikzrIUflj6YUSwxmOUYcRaxXQKNuhA314+snqr8cEUUz1qiA
x-ms-office365-filtering-correlation-id: 21d2ac4f-2ddc-415c-f5a6-08d61c4a76c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07577AF38904E3DA8371F2B0FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(6306002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(966005)(25786009)(6346003)(6666003)(5250100002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UIV/WvK69LmPSUkTXwiLJ3Ryikb9jNn2CuBm7R2AWDup4yTzmrp8AbQWn61tt3lOw0j9wzLy3IVERdC77Uoia1USUX2bgNNfAQ2j4vd85ep+RAuVrX87Rd6LU7zXzNI5uWeC/Kz/QFpsZOkrFggjky/I79oItFqMNxHpmz9EmgNIX1b5QMI8SdSq33g1JeMiyv3kqUxiSswUNSaVUIN3JNjrZ73q+SzD+7DtkrgCaYnFfLFDGkPLHuXbBmQ7Z8/mMU3JZBdXiU5CuSIzlv+xz63h23XR5n1vC92iXQHDqH0d82Sp6Ui5zINGS56irEA0z4ZoXVQoRXPtnQSr9Y2QRD4BeglU3Co4tCUNKPFZovs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d2ac4f-2ddc-415c-f5a6-08d61c4a76c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:01.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 5f936e19cc0ef97dbe3a56e9498922ad5ba1edef ]

Air Icy reported:

  UBSAN: Undefined behaviour in kernel/time/alarmtimer.c:811:7
  signed integer overflow:
  1529859276030040771 + 9223372036854775807 cannot be represented in type '=
long long int'
  Call Trace:
   alarm_timer_nsleep+0x44c/0x510 kernel/time/alarmtimer.c:811
   __do_sys_clock_nanosleep kernel/time/posix-timers.c:1235 [inline]
   __se_sys_clock_nanosleep kernel/time/posix-timers.c:1213 [inline]
   __x64_sys_clock_nanosleep+0x326/0x4e0 kernel/time/posix-timers.c:1213
   do_syscall_64+0xb8/0x3a0 arch/x86/entry/common.c:290

alarm_timer_nsleep() uses ktime_add() to add the current time and the
relative expiry value. ktime_add() has no sanity checks so the addition
can overflow when the relative timeout is large enough.

Use ktime_add_safe() which has the necessary sanity checks in place and
limits the result to the valid range.

Fixes: 9a7adcf5c6de ("timers: Posix interface for alarm-timers")
Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1807020926360.1595@nanos.te=
c.linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/time/alarmtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index d67ef56ca9bc..a0ee81f49a87 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -786,7 +786,8 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
ck, int flags,
 	/* Convert (if necessary) to absolute time */
 	if (flags !=3D TIMER_ABSTIME) {
 		ktime_t now =3D alarm_bases[type].gettime();
-		exp =3D ktime_add(now, exp);
+
+		exp =3D ktime_add_safe(now, exp);
 	}
=20
 	if (alarmtimer_do_nsleep(&alarm, exp))
--=20
2.17.1
