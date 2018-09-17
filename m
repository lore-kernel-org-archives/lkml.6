Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AA72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J2lj5wrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA72147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeIQI0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:43 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729067AbeIQI0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spG4637xVuKUYe7/IuWYWBB48HVhvkbTY+lsCiCJ/A8=;
 b=J2lj5wrsd0JP+SLrKt+KUIGu330raeVkY9h9ThkkZc6v0m5zzRIOKXvK6shNVaj+BajecV/iNrwAeKA17O1kcUiscJ/3uxColhaJLdYmp02O/UZYxdIVfblAW+Q8DeYDZyKU/xPbKUZ26Xlt0eK+mzTKQH/mqXYCCQjC4LFi5TI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 059/136] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Topic: [PATCH AUTOSEL 4.18 059/136] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Index: AQHUTjKj9ZIkwI87Mk289tIwBjMjhA==
Date:   Mon, 17 Sep 2018 03:00:49 +0000
Message-ID: <20180917030006.245495-59-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:OxIeA+8zeFzSFN6b42sQokjEt+vHJDvXaWt3FWsBiYDUXXkDy81/HDnYgtnxuU5T4B8BGrxKwyfoweMll+wHwApeXX5MHLBYe9MPnWnrbYk6+7kRC9QWk9gwCPM9ebcA4Yap7pvgX23FzoryUBGripIHge6XZoJBDs4dgUJMiBTpuVrBN+8Sm66LUU6/YvVegvhd58oOuVaW7QGWrkXAxwZz/nyMBSRQV8pnsAQa20yseETSqEH5VTYg3JS3vwN65y9KsmhV/E7ZmHuVrxXvbyoVRSW20LT3pnoJHiN8wrgc8U+yAlpzaijioXoBUrtyB2TMFs9t0o1gGOecHl+xQLEM7Hdb9pK9mmnU4kW8doFVdU/iXaHoGI/V562UPQlrTVNLrY5f8ualxsnKeBoLqKv5gXjvGvJY7fRj5YbOxCPJhSV68HxA31s76y8n42fP+49u92CjVru3U2MZBrnzQQ==;5:C2KfFdN3a0E1nTBCZZP6DCWJyy38xwSw54a+WzF5e6jgFGBRn0T4S630am4G1QXZK5lynYXJHXZWbHNcwCGft1kXNz0OnoDfUC3+0w2BT0ltNB+Tvb+KteA+t9p4mqKFVvcBIitU4V7mttcL68BzZklWDhS9k63LeMU80/1zeHI=;7:INHaLwfC5p14iUKDwFFVb4YvgKqkCslQ7JGk78bJYXN1OFHHHAKDGrf/ZfIRgZJAIfhQ/DehhdPTj+SRLfKg6cF2WPQ/bp4AVZ6d2pu3GpqRhPzkbHYJmjZMftOUtgBzDLEd8XqFf+Be8/SDJ58OQF4J22hXFSnM+hZP1WmpzqR/2iH7gbo+JZAJh3juFxQ4/2bWAcjs38nEDgtFbqO+1m/SNvQ+GxU46EwLzb/j1C2H2KdMB5R3CNbfJi8IKJks
x-ms-office365-filtering-correlation-id: 5867c1b6-b7c2-4afe-0f5e-08d61c49d61b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01670BBF5D9C3F40263F3DC2FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(6306002)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(966005)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: k009wz5MYVfGmIMIyxlW9u0uAG1iV83mSWAQbEH4VTqvDHk5FCIevQh2xr4OnDq63DB3YC9b9biJeK8grEadue/Qbr8Z6LWlGFjUn6CY4QUNsk8KgzfLsUJCFapUNcZUrWrtqldeu9V7skjB698EkpL14d4/uhH0h4sxPso2/w+eZLKB2Q7UKy5belkpCivxyazEHLYxt+3YklQDzHl2p059ae3Ty+H+TvZ0o8m0NRePr/5bhzMHQfalfYmsg88bC0rIkqTfPVyqbDpKwD32OELiGGtFn8xd6T1mO+l2D/jaJqaDHgHQJbMAWhf9FKaMZBLqoY4c/Q4tJdC/dsRMGS8gAyxd7WeNfIY6TKMi910=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5867c1b6-b7c2-4afe-0f5e-08d61c49d61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:49.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 639321bf2e39..481bb6ca6ca0 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -808,7 +808,8 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
ck, int flags,
 	/* Convert (if necessary) to absolute time */
 	if (flags !=3D TIMER_ABSTIME) {
 		ktime_t now =3D alarm_bases[type].gettime();
-		exp =3D ktime_add(now, exp);
+
+		exp =3D ktime_add_safe(now, exp);
 	}
=20
 	ret =3D alarmtimer_do_nsleep(&alarm, exp, type);
--=20
2.17.1
