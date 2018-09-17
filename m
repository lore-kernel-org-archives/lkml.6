Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75130ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252132147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X8fjJ9PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252132147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeIQIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:30 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbeIQIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui0mTgZxxqbUtzFc89c5hXYtjmNr3k1oBztZYbW9O6E=;
 b=X8fjJ9PLIN2foU+nTxucHET43JnDiJbpQKnl5apoGxxhZ9irEcj25je6fzQ7d7p29JbXeb2aZGCmY6srJl0stR8J8MKwXfyzzOrIY4pwmByCHY0QLl3ucdW/e5IpdydHw8Ckdv/of/PLCHrM9PxP3JYaYSqwgs/Bt0v0OJoKK4M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 22/43] alarmtimer: Prevent overflow for relative
 nanosleep
Thread-Topic: [PATCH AUTOSEL 4.4 22/43] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Index: AQHUTjM6JSfiuH9CnEqSZHf772VI0g==
Date:   Mon, 17 Sep 2018 03:05:02 +0000
Message-ID: <20180917030445.484-22-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:Pb0Z3n/ZAN1wAeg0w1X1xFUB3dLw30IAr1/iXWUjV7v1ZBPmm/C0t1aR5WdA2mUW0E+2WDceYh5wItnf+PHWbDigQAzaG64CC5S1FQAcG8Slvwhpb6SShOAV7BojvF9cnruY7KeFWoit0diQXNPCvjr7vHIeisivtac7rrUIIjFmiixavoIdqwE1wYKPNgHvy3ZL4o2Pmurlj2u2U0/kv746s3WvJMJ/Ja6fK8d+ImlAhZYQehVLsWKaWd+ERVs+gObUbVoz5BXdW/y+jec3J0D+/UqWRi+fhwOXBGs/Ekl40jhIm53yqwjOfA1Kz/SBNungam9GXUrFk80SP9fySpeUSWjM110akTwRCjCQ9FtC/+9sHtnxGgeNuZFy4LrrM1Kue7e0YRunV1djFV/WCI3pKiyTrxCfOtXdGXzMQscJBBmU318dVoKkgx+3r+RwBv3KkFucP90jmCGeJUK1og==;5:TMgO0gq2eCYuOqSKJHXRd5TqwOVYiBY4XVrNzBTwvn8kdaMEZG0JuGd9iWyRgx4U+t/v6A/OVozRVQqRCnxBC/azWpwu80noXXCurIAfhlX9ith+pZueDDvcQsY57xvGKPEhL0ofO/sZM2QZyBm3jroZEEPo0LHaQ5ufaHl8s6A=;7:j0JuKySgSd9VjAzXzGB75iCkd6v0KtO9N+DKT0/UzTgf0ROrOSCAO1/EXSNt4e/evdkUZG8rqybpVNVN59c7pSck9X3kU8Rgadz2mgvWE9Mi1JTNSi0hptlVkBI5zisplHb6HyRZw8wTv9e0KVe4PHvlZUuCjVKFWVVzeZCj4dUlSu/OM/5jxmsWUa2wSoyNyHec2J43qO74ZrjwBHmTCRqC96QsyLLHWaNdEpGfocr4AVR6KKAIzNWVOdzuiYMy
x-ms-office365-filtering-correlation-id: 97400080-597d-4491-ee43-08d61c4aa86f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07594F98B98265116CA2206DFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(6306002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(966005)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KQSpTfv2C4wI3F2vvHWOS04c74eM5ARvnIR6eEz3YRp7tMaxeqmuBd8n4gjE4lvbo9bZXHnVn22vZce75v4MfjxtNANNT7ixLxISmySTjF6RUaqZhUPL14o5mnAjTodOt7p8J0xI1QNqWEZrlQw0dnBw17oNrtfNGvDQfJps6flPZXrVDSjI/kQorHgS0TJl/yJPq1UpB/WCQoreW/TP4HV/myqx2zv3X0SweJCTB/CmUiVBSKG20yxE7/rJXiW7iaOACjlcAwZIRaShr6o8NV6aQbh+Y8+QFOweGgdyFllTy5gpc15XMykdhaAP61DDc/cif8GsK5BssL2ALNwyV85Tc/yajnFiGYUzsagu+V0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97400080-597d-4491-ee43-08d61c4aa86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:02.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 6fcc367ad531..e78480b81f8d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -773,7 +773,8 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
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
