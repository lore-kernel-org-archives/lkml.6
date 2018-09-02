Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09509C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB5620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A9/p7kQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB5620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeIBRTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:36 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeIBRTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4jHx47NtKnncj6ZzjqnZNWwIcVcppMyU2J0QBHMmlc=;
 b=A9/p7kQScdq9opmJUjEWmi1lx/MLbspUgDzEiG/qN4bcHWcBiT/ZaJasAJD8FE3ZOtItwjgdHNUDCkvwT1WGT8hy20E2f8d50aABLRxvd1eEyVvcLLsG2iDG4eDN9bnQ5vaWOm8bUFGGB2tdUw6PdlE+0WTqFMEyTkab3i3OoGg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gaurav Kohli <gkohli@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 025/131] timers: Clear
 timer_base::must_forward_clk with timer_base::lock held
Thread-Topic: [PATCH AUTOSEL 4.18 025/131] timers: Clear
 timer_base::must_forward_clk with timer_base::lock held
Thread-Index: AQHUQr1YB2oGADKO80emED/U7OSKqA==
Date:   Sun, 2 Sep 2018 13:03:30 +0000
Message-ID: <20180902064601.183036-25-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:K7OMZBuxzY8//HQqglyh8OQL5lNnyr8Kl6QIx5RIp71u9nxcoXlimuP6XVlgaQC+j4xoQ/8zCkSoSuHO6yHszw3Zvx7yqzJnPG5QYBf1BLpjKALc4YmTaWwQVAtMtOhr6qfIeVBKok8Ith42Rog01KKAKXWniIgJkAKFXMwppQeQJgWL3fTcpWe/o1zVsmYoXB3/4XdVhAdF70MS6d6usPfa9jWWo3bPImPOBz5oqmJgN9JEnIVZ9YS/8l1w78UzVAadi6b2BV5yZURy7ETevkWaMrUStiPpeItmf+i/MlRSfh/yPOli+D3UtbvBdGyKSvUA/OGikM1qlEMmFYMKzKw14GvT3ZidZtfsI9dVNdnOi7AzqxG+abquIhbcJcpalbg7/LLcxv7WHTx0M7lQYjOZG9lU9V3M2MPOxPL4W1dfZb/cgbMr/15Nja4FCyHgu5U6DzmEoPT+iVMvJG6cHg==;5:UOPYk1NHbRGQZWFKuQDdmmaGd2QVBzCxRcoClD/kWKJLVU3xS6hQqkLcqXJLCeMNm3YiSSBxm0PWa3CgaG4D5wihEyFFzThpw/RzKpP8DBY8b3dcmgkYyZix+kOo9FW4xkOs/q253Wr+I+xu8tFyTZW5spQ3iygXjMJYWiWK4uo=;7:/Z3rA8NYazmmcsUArnu4LvLA3B+O43LIYjVfhr0A/+6F5zgcSFBZjN4meHRw78eSg5A+iz8flK50+SKROT2n4WQrSmdGhina0wjrZZemmpyh3rU90V95pIFeED4NwGhYszKfnfw5SCGZx5iSSHBfKy+eKHRk8BZeNY+jpTh76hA2Pi5zaUSVjDccJojmcWogvyjff7pBNMIS6V+GBx3knWNk6krGiNBOb0WUoc40BkHTN0h32iSZWuqrv0IL6gRz
x-ms-office365-filtering-correlation-id: 4c703536-d458-4c68-c81c-08d610d47b14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150474A38029D2A4BB546E7FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6306002)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(966005)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ny7mTKksamCT5aqNoafMRswRnZLrnY0/D1O36DCA9ypeY14/LweNN8FNy2S7q76EIVxDO+ADUPegH0I2X+dvM4iSHrI+rAk4g3MsPRKqs/+66tji/oyaI50SUh3eM9wegKv7xXvKXOisSjxF+6TUguyCWpxL/Wl726FJe6xAcgYs9v7wwaJkpq/oeLRZ75APKwZYd9aOCWuraTGCb40vlG7/K7YcmE7zpFxnm8K1V0Rjrvr4Su1DAf+xCmcWqUtlHC4LAbQrm2mw2qmnc2SSoz82XnR1hmUOgCs2IKR+C5uwcCCtCjl/SlrufL9B4Jm7s4rTsDzTLY7x3JDMrsTMolRttsF7dntHOW9gfuxGfzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c703536-d458-4c68-c81c-08d610d47b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:30.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Kohli <gkohli@codeaurora.org>

[ Upstream commit 363e934d8811d799c88faffc5bfca782fd728334 ]

timer_base::must_forward_clock is indicating that the base clock might be
stale due to a long idle sleep.

The forwarding of the base clock takes place in the timer softirq or when a
timer is enqueued to a base which is idle. If the enqueue of timer to an
idle base happens from a remote CPU, then the following race can happen:

  CPU0					CPU1
  run_timer_softirq			mod_timer

					base =3D lock_timer_base(timer);
  base->must_forward_clk =3D false
					if (base->must_forward_clk)
				       	    forward(base); -> skipped

					enqueue_timer(base, timer, idx);
					-> idx is calculated high due to
					   stale base
					unlock_timer_base(timer);
  base =3D lock_timer_base(timer);
  forward(base);

The root cause is that timer_base::must_forward_clk is cleared outside the
timer_base::lock held region, so the remote queuing CPU observes it as
cleared, but the base clock is still stale. This can cause large
granularity values for timers, i.e. the accuracy of the expiry time
suffers.

Prevent this by clearing the flag with timer_base::lock held, so that the
forwarding takes place before the cleared flag is observable by a remote
CPU.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1533199863-22748-1-git-send-email-gkohli@co=
deaurora.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/time/timer.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e6ff61..786f8c014e7e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1657,6 +1657,22 @@ static inline void __run_timers(struct timer_base *b=
ase)
=20
 	raw_spin_lock_irq(&base->lock);
=20
+	/*
+	 * timer_base::must_forward_clk must be cleared before running
+	 * timers so that any timer functions that call mod_timer() will
+	 * not try to forward the base. Idle tracking / clock forwarding
+	 * logic is only used with BASE_STD timers.
+	 *
+	 * The must_forward_clk flag is cleared unconditionally also for
+	 * the deferrable base. The deferrable base is not affected by idle
+	 * tracking and never forwarded, so clearing the flag is a NOOP.
+	 *
+	 * The fact that the deferrable base is never forwarded can cause
+	 * large variations in granularity for deferrable timers, but they
+	 * can be deferred for long periods due to idle anyway.
+	 */
+	base->must_forward_clk =3D false;
+
 	while (time_after_eq(jiffies, base->clk)) {
=20
 		levels =3D collect_expired_timers(base, heads);
@@ -1676,19 +1692,6 @@ static __latent_entropy void run_timer_softirq(struc=
t softirq_action *h)
 {
 	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
=20
-	/*
-	 * must_forward_clk must be cleared before running timers so that any
-	 * timer functions that call mod_timer will not try to forward the
-	 * base. idle trcking / clock forwarding logic is only used with
-	 * BASE_STD timers.
-	 *
-	 * The deferrable base does not do idle tracking at all, so we do
-	 * not forward it. This can result in very large variations in
-	 * granularity for deferrable timers, but they can be deferred for
-	 * long periods due to idle.
-	 */
-	base->must_forward_clk =3D false;
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
--=20
2.17.1
