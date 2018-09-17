Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BEE214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TaqLSw9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BEE214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbeIQI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:41 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730225AbeIQI3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdcFur0xuSldlrjgHHbl5SVvOrHlVicIygNMn6xIQ2o=;
 b=TaqLSw9YRQZkfOofisTky/JhgI2bnIRLtW30bWDusjsGe+kM1GTNt/HNSSxvHL2PlSgQVa4K/MTl8oOQGzIB3Pe17IqGq1/Uzq6jd9gamjMoynxfUctN9y0aQvF21qr5yY3+M1fRQAIPK1jPlytRxUxuxk4V0Lyb4tEAEPk8Ijs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 50/87] posix-timers: Sanitize overrun handling
Thread-Topic: [PATCH AUTOSEL 4.14 50/87] posix-timers: Sanitize overrun
 handling
Thread-Index: AQHUTjLt7asPPsJTE0WP6hxscH9qag==
Date:   Mon, 17 Sep 2018 03:02:54 +0000
Message-ID: <20180917030220.245686-50-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:zG076RjnyMEbgYvaY5IA2xaKkMQXKqiXQcJHRDZKQHoPWLqpZrFoHLEaTO3DdkHMuHc3n2xIrtoKVgUQwi9s1yVuzzbeH8GZcSXInrnzF24L7Eo07R9peVO8heanO+9zbXgtjxm5DH7M75e1F/3g7GGFcLt52vQQtM5+IVJE8rcQFeHA2zYqPqFuaxpoMNja968CULuowHvxnSG3v/kEQnOGXNgzEyZlC1NxbQjtB83DXjMoZGsaQapvPjBOklkJlt4mTa3CxAlDDVzqZZ2xy9IQUrURC8onRqTWVWEnbc+Ir/gFmEU04d4XwmcH0xDFOerGFG1IrrhmHpgn9ry2rXSg26AbmhEiZQ9GG8BAobrdvPYwajmO8LgzxtIslio6mJUrP39rjQuJdSE6g1/GerHhsHW751QdUTEu8TZoLbz1ZTgnZkou27C1h8pCLi10PS5Zk+x/TFGnIxkGNEHGsg==;5:PS71iBJjxhGiO3d5SZFlYNtN6R4WQAJ5XpKpjZqztqAmGaiy2+mmSUdKWMOoU+vRvIk0Rje9kwe4arHHjMS42HlUjmHsImMlK83ICp7TfYYohrVvPCbYlY3CuUnS1UWuwE3B468R1LVYidXVLGc4nFTVJAzcDhXAVdCN56f6Qog=;7:80dWpSOTDXSfvubpHs2UmjozJMaXJmp1QQT5b4zCQy+DA9YZf8JqGTVivPyhFfw/gIlnsoHOp/p1V/rCq6wT1M1cvIxEt82lSqclh8xllIwR5hNj0bTpOa5Akr4ajORoaFLSDMGumwWydypZLkAvILsaFIaPW5CAMphrNnrHI9wDAPd/xUsbnASPyMjAUAMWhj3eRPugiEg56Lhs2OdLwDvTY/JA89nxNjmwxeLbLCVV29jXQ7zQhS4x84+AAAWZ
x-ms-office365-filtering-correlation-id: 79774520-16aa-479d-b652-08d61c4a42d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774172A10DE4EE1C033A740FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(966005)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(6306002)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: t1KvgByoih/nVuv6W7X1Lkyk0z/hBbYBGEQcDsyTDQ5Ee/lPlwaN/5bViaKOpaaFTFzU+0cSKEAA+YiBpuZbXfLiFQbFj8y8T3QYd497kfxhQvBTiyC2Ah2gwFHGO73LeDjXgcyK29fQXf188i/svMxjqpIH6veAuqjlVlX8ATJVDD73ip7UEDynLponGcCadMCvpp4fFQ72zSNguEbR5vq7BIdTwQxosocLr0gUXCLKyjREhNSrOQPlzGX7b1EFiCWHI0+ytfYVQs277mT2EStBUNrxVO7BOI7KzG4lSN3081wD2nIFwhzqZ5tLFrFGcl2uJxmxAKjxmDV5VZzWC31X2RL4notUltpoei+3knI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79774520-16aa-479d-b652-08d61c4a42d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:54.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]

The posix timer overrun handling is broken because the forwarding functions
can return a huge number of overruns which does not fit in an int. As a
consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
random number generators.

The k_clock::timer_forward() callbacks return a 64 bit value now. Make
k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
accounting is correct. 3Remove the temporary (int) casts.

Add a helper function which clamps the overrun value returned to user space
via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
between 0 and INT_MAX. INT_MAX is an indicator for user space that the
overrun value has been clamped.

Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/posix-timers.h   |  4 ++--
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 31 ++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 672c4f32311e..437a539898ae 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,8 +82,8 @@ struct k_itimer {
 	clockid_t		it_clock;
 	timer_t			it_id;
 	int			it_active;
-	int			it_overrun;
-	int			it_overrun_last;
+	s64			it_overrun;
+	s64			it_overrun_last;
 	int			it_requeue_pending;
 	int			it_sigev_notify;
 	ktime_t			it_interval;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.=
c
index 5b117110b55b..2da660d53a4b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -84,7 +84,7 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 no=
w)
 			continue;
=20
 		timer->it.cpu.expires +=3D incr;
-		timer->it_overrun +=3D 1 << i;
+		timer->it_overrun +=3D 1LL << i;
 		delta -=3D incr;
 	}
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fb0935612d4e..55d45fe2cc17 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -283,6 +283,17 @@ static __init int init_posix_timers(void)
 }
 __initcall(init_posix_timers);
=20
+/*
+ * The siginfo si_overrun field and the return value of timer_getoverrun(2=
)
+ * are of type int. Clamp the overrun value to INT_MAX
+ */
+static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+{
+	s64 sum =3D timr->it_overrun_last + (s64)baseval;
+
+	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+}
+
 static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer =3D &timr->it.real.timer;
@@ -290,9 +301,8 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 	if (!timr->it_interval)
 		return;
=20
-	timr->it_overrun +=3D (unsigned int) hrtimer_forward(timer,
-						timer->base->get_time(),
-						timr->it_interval);
+	timr->it_overrun +=3D hrtimer_forward(timer, timer->base->get_time(),
+					    timr->it_interval);
 	hrtimer_restart(timer);
 }
=20
@@ -321,10 +331,10 @@ void posixtimer_rearm(struct siginfo *info)
=20
 		timr->it_active =3D 1;
 		timr->it_overrun_last =3D timr->it_overrun;
-		timr->it_overrun =3D -1;
+		timr->it_overrun =3D -1LL;
 		++timr->it_requeue_pending;
=20
-		info->si_overrun +=3D timr->it_overrun_last;
+		info->si_overrun =3D timer_overrun_to_int(timr, info->si_overrun);
 	}
=20
 	unlock_timer(timr, flags);
@@ -418,9 +428,8 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 					now =3D ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun +=3D (unsigned int)
-				hrtimer_forward(timer, now,
-						timr->it_interval);
+			timr->it_overrun +=3D hrtimer_forward(timer, now,
+							    timr->it_interval);
 			ret =3D HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 			timr->it_active =3D 1;
@@ -524,7 +533,7 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
 	new_timer->it_id =3D (timer_t) new_timer_id;
 	new_timer->it_clock =3D which_clock;
 	new_timer->kclock =3D kc;
-	new_timer->it_overrun =3D -1;
+	new_timer->it_overrun =3D -1LL;
=20
 	if (event) {
 		rcu_read_lock();
@@ -702,7 +711,7 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
 	 * expiry time forward by intervals, so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun +=3D (int)kc->timer_forward(timr, now);
+		timr->it_overrun +=3D kc->timer_forward(timr, now);
=20
 	remaining =3D kc->timer_remaining(timr, now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -789,7 +798,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
=20
-	overrun =3D timr->it_overrun_last;
+	overrun =3D timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
=20
 	return overrun;
--=20
2.17.1
