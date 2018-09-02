Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4DDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB59B20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fvAcC0II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB59B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeIBRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:59 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729793AbeIBRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnwYq1iFRXBgeqAXmFjVL9LypOwrX17Q+kd6JGP3Y9A=;
 b=fvAcC0II3VgZZxgwCLOphmVUROAkpeYSYzw8qHeaSRqUxrZLQgCTCtM1Hxm40Ij/0R0cFH4YnL9pm0Z/dEBWf9ZaKGMUgvn1zM6c1idRxwk9mpCoVFs1yV9iOfDth/156NMTFydCI4HyHHfW31e2mLY9w4aF36BAAILAT6omUU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gaurav Kohli <gkohli@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/62] timers: Clear timer_base::must_forward_clk
 with timer_base::lock held
Thread-Topic: [PATCH AUTOSEL 4.9 09/62] timers: Clear
 timer_base::must_forward_clk with timer_base::lock held
Thread-Index: AQHUQr4TnGlRgRMC+E+wxnvB9jGtBQ==
Date:   Sun, 2 Sep 2018 13:08:43 +0000
Message-ID: <20180902065131.183542-9-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:lWx4SpWP0J+UyHdm8vd+2R3qDJk05uQm7Hok0W/hILpqll+vuVNiLWNBdiWPTCB61cqfoi/xz1Gv7vnAnbqXrv/S/1vpbT2zJjXyIaCe/jz4VMNhDiay5ZYM+pHAvZtjI96V4GglDaPGZaIbhPuaqo1kHl2MaMtgc22uZr1eFTJmllffP+yN5dIwrkSVYldlwGF+oCOyo3mZNOJh6GDBAKNsnYCDnCx+1JGM//4ayoMydFH+WlDhbscHIb+Atli7fcneaIxwx5R18IcVkTIi9gFxpGTzu3zzvD1XjB2eLeEzN3rga0SToDZBgPB831yVssMWZWjUyeYUvd9rAczC5l+DNPC9LaEbzrXqOxaNehIHEM4WQJktaTxJUzNju3wrvglsB8xoV6OSf0IWYLDB2fAcpXJAEgGYdh1hoMWyA3ccQtCToCByMZMSMyzl8QhyOSnk7WfLTOJnJ99wn/NWhg==;5:YFrcPYk0R4ZNthTmG8wSfAmJ1ry294O7en12FGAMGxJj1gEk43FbOt0vKT3ywZzot4o4RaVqpKFU5ATy8e1EZ+6811XSYqEi4dsztYZsAzT6b6kS3nFAtJDLnWmhTqOUmUrHdhlCfHhJmWk8ivPMqTc7hVOYRWG50xs9/8L7efs=;7:50sNGfmpNK6Y3n+k3yegFUnFUWJqXEHbAt1P9SenpB35zDz3dsVs4i4mLCdqZj2WOsfRE8tyurhXB0wc9z/VoXtf0AdrDqq9jTznZVgiVz87McYtOhaVnVbbadPqmWC/igbFdzgY9mH5Lwe4qTBmO1T4T/fM0mG/vHHmAGTZg/9N/fV/njuUPb6mYoTiGrgnVGlN8398xXXKc0GozI0oWALfFKCHff+rpfK0ryOGdaQ92utrQovueQfMHBQjX/WN
x-ms-office365-filtering-correlation-id: 3ad78a15-17cb-490d-7b35-08d610d53d59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469500FCC924EF56B202298FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(966005)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6306002)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KK+CA2cXilpIMeR08lujqQaNipFvg9LQ6H8HodUQoliVaOzi4ymzVhlY0Yv3kQC1BjsqHgAKNBQ613ErlVCP+aGar+c2YIVii3yi2kGVjD8EGcUfp3zdY65BBbeflVfk3SMDtMy106TNbKOSPePDUt6bybjFjahT1knxhFZkgxSgO+iUEDdSnkLi0AsJXU6DQtTwPSMSfhqbSojS2rEfQ9j5tS8Gl5qNIosXfhvhv0doJNzQoUCik1d7BTYdlCeDbOy03AjKfpy9vIZFTcLS5o+B/Bu+R+OJ8Lj517qpkX1Xkwq7STbCqu+KJGVyUnAtsRuW1gG7zPRJEF4O0kl/d1KWCsnIW9UZGOsA+vKGkMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad78a15-17cb-490d-7b35-08d610d53d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:43.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 7c477912f36d..b625cc7fcc1c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1649,6 +1649,22 @@ static inline void __run_timers(struct timer_base *b=
ase)
=20
 	spin_lock_irq(&base->lock);
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
@@ -1668,19 +1684,6 @@ static __latent_entropy void run_timer_softirq(struc=
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
