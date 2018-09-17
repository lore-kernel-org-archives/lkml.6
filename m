Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2476FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1912147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nyGbl/Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1912147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeIQIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:42 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731526AbeIQIdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPjlDd0Pr3uVslEyqScYZUJkFuOW+Sv1vfSYokLflk4=;
 b=nyGbl/DggIsIk/h532JBlpJsA2EaY6WC5hCgJsycF9rfXFRgseY+mttdDR4A350MObyrkfj9kmlDRpDNpjET+QrUNhf3TYRI9r/ae5mEbw5Z2Hfsx2MasNpG3HzPRlQkjRoYKnx1o/QBSGS7pjk9vptdjAQW2qJO8tHlK27+s3c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 12/29] alarmtimer: Prevent overflow for relative
 nanosleep
Thread-Topic: [PATCH AUTOSEL 3.18 12/29] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Index: AQHUTjNSyO/m9PhKA0WS5NjwvPObAg==
Date:   Mon, 17 Sep 2018 03:05:44 +0000
Message-ID: <20180917030533.592-12-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:BEmnveK2MBKhGtQF8Y6RUIaLzyPlFc9zt8GePIVPfSloRa5E3pCaJL8NpxYenEnv25IWVTLj0nLldsx3UqSULlzGFhg8oh8e4Iwi2ftw61Jb7Kl+8SgQR1cDbMMle8mLDG5swZ+DOT4KnrnH0LuhoNcHVb8+RztSLmNly6Hyewqugqdfu0UJ5ZIJgy20KEahXC8bycSL5fJL8A1osQFDozkT19iqjI74Lr0xo9LhLF0JwP7WNwWa1wTfS1JZYUilQNWCJDD3a12GbM1KmWqqcFpCZxKSDfwHEv01YofL3MSdGfY6/DdFbF9qnDq3Na20ZHJX/fV35B14ur3jJ+3dLsr0L6CreodvK/PXTsEypWsIZZ51tviaNi3V/DrydM04+VL91YWu+RRDDXgcNcf6LlGmyHtcxd0cw7HG5ExOQKMzwrqlY9e0vLFHxRFHPT+tmJSjAGyEuawnFkTiuQ+04w==;5:1OzO9ci8A7Qv4J7tXOvwDgg2ku0G84f1YIyDVdXoo9kHJbXJvaZ6+PtJ8ur2xYRV3GFM3qJyy5TesYFHo+EkXY0TTyVKzNFKs3g+SRLLvtFdPvslGiwLOExzFyUqD7RxY5dCnK5IGe/+YSoB8daZLCVZqeBRIR8S2IRXqUy4kGA=;7:toknzsQwYsXYP7RoZX5f0PoDupOneGUJp9Ry4Y3Hfnnu4bnQmAfXsxJEAZ569j0jfHkZXoGY+nLDs7OchvkOMFfT4z0vLrQxVFBVRJKmuwLMupIbRD7296E06Y6QDSAmGyepsXXbTFd/2xah8fvMlw0aS+yk5MT3VLDYjBRRLYK3UxXfM3Ht3m9ZVp4RZK8zANhiPbe3M3Z2hhpG1dJybiOV204yjZjH7AxIIVbFeCfDmXXREJhTM6feqWeeBBhm
x-ms-office365-filtering-correlation-id: c5a80831-7af1-4e64-d184-08d61c4ac192
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839BA4174F129E9E22D76AEFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YjG8+Dp6FkUGtzmn6Xj2HZUqXhJbCxt6QBpcyXFO2Dyra7C7X9XUi1hViCbSZczybmzpVzC5QiloCRcgyPOYFH7b6bQi9PMy9bg1xOan4UOT2p0nqR+ScVAPGNdOQJF+6fnN8Fb3Kbe+4RrZiR+3ShLwZef5PX0+XbqybzkorPP3mUyCITE9RXTNqwEgOdrc7cv5LnoVR/tcuFYYnRhRlNn/hS8AdZ4w6yq9hHc/QqIc8Uq7UeWs2S1bfn8FSZplT5VZ4HgOTxNXYdllERqHmz6m8qbjU6u827Lb9ZtqrPdKv/7jS2+oj1bKb13oCsCCEvSW3mf3u+BdowN5v/GD3NR3SxL3JGNvZRr17ARXxOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a80831-7af1-4e64-d184-08d61c4ac192
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:44.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 119847b93ba6..0436d5edbccf 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -776,7 +776,8 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
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
