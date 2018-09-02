Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069B204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MJ6u4E7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A069B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeIBRWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:19 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:38064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeIBRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5sUguPWq5uubJvEpX+1/jYOpmj8W/S4S+Zg2HnWlrs=;
 b=MJ6u4E7VbazDSD7hDvWTuNNjd20LUza/9o0r/AtOtl3TIPdQwDovq5JkzMs3dRfGHRmltRCJqr40we4AbcMU/VsdbLfQSseEC0nu9TPOQQvwJyfjGQfo2WvKlgw2gbwzGeZ45VUCPTAKboBOeN/d9gOhLfit3IfwMPm4FzVSVNU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gaurav Kohli <gkohli@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/89] timers: Clear timer_base::must_forward_clk
 with timer_base::lock held
Thread-Topic: [PATCH AUTOSEL 4.14 17/89] timers: Clear
 timer_base::must_forward_clk with timer_base::lock held
Thread-Index: AQHUQr3DBPLVSiaDIUuK3U/F0pj9Bg==
Date:   Sun, 2 Sep 2018 13:06:29 +0000
Message-ID: <20180902064918.183387-17-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:N8xRNm11s91B0RwTMpSoXzSYvFLtm559f35YqcY1OSsHQk0yJ3v8+V/TYsQTm4Xbn2O6q/VA/M4NxyhkdGy9Q4BURrmJcHRkxUqLaXhGS+x/WlS1UZ3Ai1L87qkerTXbsGUye42J3R5bh/AO578MDQdqJ0wF+IhTSgtFz4YLncovwpR+V8unYmdV9Kqi2acor5RPJlwqTAGu65kgpv/46leniATU4tGxUwbY/Ae3Dq2WRAmtIhcpkEbv5qRgvtfWUNahRNtUTUqHoOooWuJCXqKTKS4L0169ziNmWK/k18y3AZmaMerG/MyqveqgcFrDcVaPnHEoj5T2yu0+HTDnx/WMQrTPUDsXymv8VeXMg0IlLRl95msdJXciMQMs09K3aY0w3Ijvyz9wR8dLUpTdJU7B6VZFQFxX6Wp+jGT6Drb4FNpSKgojavgfQ9aroVeYb5aYn890BNk5Vj9pBlk2ng==;5:LKmM+4aZjiB8r3J166FAq66BaJX9EPZo7d5NSbZ2Kv9NoB2Iu8jsaDIWrP2ziu6uyz0r3bxiizdSD2D1Dx9sfavk6gMEU5vvxF6Tfss8eV5nzwmsmjAOBRJHuhVkCLc29c7Eb7/XYvE9YbAttgCCpVZVH5EGn1PbQhC/xxaw1yY=;7:Z1Vq5TCnOsoa/RBO1AIuyTFTjNaBnrGy983qqb5wf3ivmE/CK0QCxUVW2r8+2/X6VjbiV6oPXDVYU5UJxQiTc3ZiLF9FonC5GVPc/s9oPKOfYnV+w9K5ytfcCeizRUUhE9wd9ieH/oUA4cz1oLrRAT4bK1WiTO73tvo/wyWUDAV3og4knKbwNwjYOssg+1IHBjrGibstn4cHqDXb/f2voapv4YlHlIpm8LKJB7gT2PDEYE1TdSTqm3XbM/lJOFuL
x-ms-office365-filtering-correlation-id: fe909299-a418-442c-8ceb-08d610d4e5fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06298C3B60D6A0AB80A61883FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(6306002)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(966005)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VzVndDUw0hp90En412WV2BhLWMvd9JzvqgDj/LAyWd+WQiBZVT+Jqi68Ef7YSpRf2nxHNR2odM0yF3W4rz45HgpgGTsbE+BbgAsSARCfduJg3mV7TBFKytMTP057kTi8hMZGzrj3Kd4Bxc/j6VSDWAYWMRhArQqhFd/eZ3M2VGeNkiTYlo0VHsrYcezQQI345L71HG7mWc9E+J9TWWv8z3adENgRwlOI2DgM697TZbc8zdmsk0hxZrgpwN7CYGZMKg7WpWM0a3G0f/rRXUGq854qgpj0fUtTASJYVU7agc5CJ1FwavWREsxF+5wCPeo+O+4TW+FjEyd4XOW+uGTtZA5Q8TPVb2+nZC5cpy1ghAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe909299-a418-442c-8ceb-08d610d4e5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:29.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 9fe525f410bf..f17c76a1a05f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1609,6 +1609,22 @@ static inline void __run_timers(struct timer_base *b=
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
@@ -1628,19 +1644,6 @@ static __latent_entropy void run_timer_softirq(struc=
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
