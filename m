Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C55ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28BB2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jCD5HcEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28BB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeIQI12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:28 -0400
Received: from mail-bn3nam01on0129.outbound.protection.outlook.com ([104.47.33.129]:2800
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727726AbeIQI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xpdqXB2ONldecm9YvreiMw74pGvvcoXOMFS1m/yQOY=;
 b=jCD5HcEHqaPSbIe0z+MVma6Mi6C+qi1vxD30i/zsYVoBgY0Aoujhq6y2j17WBI1dJ/tulI7tC+zVQ/XKhOlgnyGtzRdjmd0MRpcancG0N/BAG2lU0kEAbxJVyzJblPoj7cgdME78rJlIQ8/0riDmM4Y7qsdpOU4zkKHoxJrDtzs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 066/136] posix-timers: Sanitize overrun handling
Thread-Topic: [PATCH AUTOSEL 4.18 066/136] posix-timers: Sanitize overrun
 handling
Thread-Index: AQHUTjKlJI2s15JZDkGvLehrR/6DkQ==
Date:   Mon, 17 Sep 2018 03:00:53 +0000
Message-ID: <20180917030006.245495-66-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:HsggX6TtdS1MmU1mW2J5C+bL+2IjT2wNhABbefjl0vjO3adg0ZFQDFTBiIqbxASQ5tdV89liWYLQ+dHxpSHbJ42MavGjkcc+jtxd4vqxJ7v+MLGigpk2kLFwTrEcJcNUbs4agjsLmx14LS//UaF01+1gYRYOBbMqgnlsuZNZb8oyZPZmVnPeqPHqu4YAWnLLpCbyVAJT5KHzKiqrG+GYZkIg8pP1wmEG94Srmr1+lq630FU0aCMDFroqqbVfm9JgBAINIuX2g0TeIhh0MZlN2EwyKQ8CxhGeC+7bf4yZNX+dskZIkA5Vc6VZfUWJNbMKtWsPmfZ+CHkiotZ4BIObeu+p6YjRmu035P2VSBJiZ6DpUIJfbodpq83B4H8GKBWoKGvF0jBeX+7F7V201uvqroE0Rl3HDIl8VMGa5FAjbvwOyKpa1UUVGTW5ZS11g93A5GUqaQY17MIxuQWWTQTQSQ==;5:AgY1y+p/wapc1XScbNIb5UGP2uaBFy2uB1dGqks/trM0CMk/gjelF+BBcD8+yfLo5wYbd+xJ60lvRS6SZYTU9LT7hM/LPZJOmO0UKByrevPamMHpM5+oJQEJ5fmp4juF2V1jP73SBZw5XXEeO4GNwu5OqumvhHE0TlQqpknbVtQ=;7:4V8kBuhUjDOLvqVrsdRXUhUZJJPH01DBBgZ74dMxo/nV72lKemQBRoWKpspofy48A4FdzD1Z6tICYeo1jQGTmrEh+Wvm9A/mCiz3y7/7thfaCvg6Xp7PruiacbNOc/BRM53TwX0aqIq53g9lhycuBNWNNI0yJu7bDwPTl/yhRHs20hKcu5NqTJgieCqIuLP8UCw7zuvrhZrFVE/akd5ujxChXzWWF8JHzt91PLJKOgNxU+fUefVy9ITrF0Ta16AF
x-ms-office365-filtering-correlation-id: 5703b3c9-2fa4-459e-0813-08d61c49ec94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502363B7CD7DFB85BF38CC4FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(966005)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(6306002)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qCZEVoZXnInn/QhWXy0kedXy+VkkUPhbXo4Lv1/YzxNX84SGcfpjyU3L7hHtgsdHA9hXscK+Ye770wjE7rToGzMRa1mHbUbi3Q8oEtmvc9hBtTz7XMZBadpsBfXXWnKvuSUg7UPkz0B8ei1jpCJQze7Jr3lPLASC6zCcYceaxaihQhXFqOBKS+WCHOoBpy+CBsSJv6Rbv368WlaTDlZLC2feE3bZ1nn/6Z7KO63GhnvAUQGScYyPgv9DuYPZ//NOb1hxJ6031J25oWjTxaTczb51TKVhj8Z6y0oRmxY3AXdWnDWci7C1MygPKo7b6sD7tpbw5/ZbwLOZN6atJIMYEmb7Gd3lbO/CzXm7cOmILUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5703b3c9-2fa4-459e-0813-08d61c49ec94
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:53.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
index c85704fcdbd2..ee7e987ea1b4 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -95,8 +95,8 @@ struct k_itimer {
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
index 9cdf54b04ca8..294d7b65af33 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -85,7 +85,7 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 no=
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
index 638f5cf86e5d..e475012bff7e 100644
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
