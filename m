Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957ECECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1CD208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WpmcquGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1CD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbeIQI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730190AbeIQI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKGWmoeoDyjIGDCMxZpxtfQpw6Txj3PH8+J5A11QSuU=;
 b=WpmcquGTqPfcsW2HRdzdVpoM6UA7dqkc3nl2TaYDTDwmRFmlH4fHfnWDnCPZl5uYsipJrcJVyyB03f/SPYplJsasYXOCzJc8dGCtE5zsJ6WgHZDheoUsseSi0ExjGdPFp38AzOG/r9ZBrllGSL+Zc0S8gOZLHzZT5VupXrntbgs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 49/87] posix-timers: Make forward callback return
 s64
Thread-Topic: [PATCH AUTOSEL 4.14 49/87] posix-timers: Make forward callback
 return s64
Thread-Index: AQHUTjLtjGZYjpGk1UmhvtSniuEqOg==
Date:   Mon, 17 Sep 2018 03:02:54 +0000
Message-ID: <20180917030220.245686-49-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:Rb9YyMKMvT16/OQQTwneRKBsXkPGbgIt8hitlagfizyeXyJbSEpYD3xREjkwKDUfbcnfgx7gNWdvxx7fTADAUSQ09lR+weHfxADalbDMBJ7GrVGTUeaBcnylceM785M/rmjScM7D9tJCOCzqjtFD+M9N6A4OZ4hNvH8QxaCN3qdv6zw38fAKI9UcKtYNoL8mfV6Fl62M2fo09a1hLDnrp/h4nlEwkVeh7j57gwczJ6m9LSve1q6nyz7dOqUo4Vy04WOD8sAtGPo2dK4iJqpuKfFoMe3YIa44QOhu1b2LkB3vqxHlaKLXY8E0Rck8K2EQjoLTXU596ickvSrPGYDCMQe4XuLMKl3D/nmc910iEAdl1CRXby0eJEEVC4oLIIwFZLwJMJm/S3PTzu2COHw6GaGHBaQC+ANyNXKH9doUb32goX+BWaaeO4lOr0TfnnocI4niOf0nfFYuxjP5xzYoVQ==;5:yG7p2LBijuXvmBV0hkMD6I1lxoHE/2tUXhYAIGIrb2eFgb4GxCHAgQWqBsDGT/r99SflpNwp8wZZtooBiB7fy6ZibiOX6fvJ2TIQKfPqnvSb/ya5uJFx0PvCOEPZWbJN3pkG2euwx6wKsFdo19LEyFmSDHXPBnUcuDwTDdrWKb4=;7:2O1HS+hY5qrz8u27DeXHv5x46Cbx/uv8+LgpQ+tYyZDMb3/Zof4N5Oj2u00fk3Ofyi1DAPdOQZOrOq42gaHn+PGyARPtt3+5ys8ofTCjJLy7WJj8GSTZry3Gzv788Yx1HOPGm0CLVpDZof4B4sUYnGuyOFeKhuyojWE8ZkRqKTWl//X3nPhPwYvibniBE9uZ+ZiXvOW5D8rgkqWLWk/i+oETvPv6MGPiD97mpCZg+xwOSRWyrcVMnn41vAMuOHax
x-ms-office365-filtering-correlation-id: 701bcea8-a096-44e8-f4b3-08d61c4a4290
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07744762B5383A598DA74835FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(966005)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(6306002)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oRUZZmEO5R1Q8oUdJtXrGvTa/3Tl5zKG0BuTWB7g1uS6vA4ZFdcZtoAB65loYc+XKQFIGUaddkMronXAP9eBk2rAv34QIOHuZHTiOcCTo7GrcqDb5LdTxu7tVHMAHYWuJ+1kxbyBeElTW22kTkAJ6A1Q3/VZaPaZPNp9K1HwAdm55kWRLRegNO9V1PxxFFQy8B0d2ZCNZtHz1ivw5jF+qiV3hwSR1c8skjGQld3f5oaAppA9eXMCjjaflxxiQxtqNiCrxeDldnUJ5if658Sv/47t26/R5iE5/hBY4/8L9NrCqtSXYEmNMyOuBosCkp8V6vAdYv69+fn/Wg1MxBbw7JMHxAxTmJpBNlmUBj5w1Cc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701bcea8-a096-44e8-f4b3-08d61c4a4290
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:54.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 6fec64e1c92d5c715c6d0f50786daa7708266bde ]

The posix timer ti_overrun handling is broken because the forwarding
functions can return a huge number of overruns which does not fit in an
int. As a consequence timer_getoverrun(2) and siginfo::si_overrun can turn
into random number generators.

As a first step to address that let the timer_forward() callbacks return
the full 64 bit value.

Cast it to (int) temporarily until k_itimer::ti_overrun is converted to
64bit and the conversion to user space visible values is sanitized.

Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Link: https://lkml.kernel.org/r/20180626132704.922098090@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/time/alarmtimer.c   | 4 ++--
 kernel/time/posix-timers.c | 6 +++---
 kernel/time/posix-timers.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 481bb6ca6ca0..fa5de5e8de61 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -581,11 +581,11 @@ static void alarm_timer_rearm(struct k_itimer *timr)
  * @timr:	Pointer to the posixtimer data struct
  * @now:	Current time to forward the timer against
  */
-static int alarm_timer_forward(struct k_itimer *timr, ktime_t now)
+static s64 alarm_timer_forward(struct k_itimer *timr, ktime_t now)
 {
 	struct alarm *alarm =3D &timr->it.alarm.alarmtimer;
=20
-	return (int) alarm_forward(alarm, timr->it_interval, now);
+	return alarm_forward(alarm, timr->it_interval, now);
 }
=20
 /**
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 708992708332..fb0935612d4e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -645,11 +645,11 @@ static ktime_t common_hrtimer_remaining(struct k_itim=
er *timr, ktime_t now)
 	return __hrtimer_expires_remaining_adjusted(timer, now);
 }
=20
-static int common_hrtimer_forward(struct k_itimer *timr, ktime_t now)
+static s64 common_hrtimer_forward(struct k_itimer *timr, ktime_t now)
 {
 	struct hrtimer *timer =3D &timr->it.real.timer;
=20
-	return (int)hrtimer_forward(timer, now, timr->it_interval);
+	return hrtimer_forward(timer, now, timr->it_interval);
 }
=20
 /*
@@ -702,7 +702,7 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
 	 * expiry time forward by intervals, so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun +=3D kc->timer_forward(timr, now);
+		timr->it_overrun +=3D (int)kc->timer_forward(timr, now);
=20
 	remaining =3D kc->timer_remaining(timr, now);
 	/* Return 0 only, when the timer is expired and not pending */
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 151e28f5bf30..ddb21145211a 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -19,7 +19,7 @@ struct k_clock {
 	void	(*timer_get)(struct k_itimer *timr,
 			     struct itimerspec64 *cur_setting);
 	void	(*timer_rearm)(struct k_itimer *timr);
-	int	(*timer_forward)(struct k_itimer *timr, ktime_t now);
+	s64	(*timer_forward)(struct k_itimer *timr, ktime_t now);
 	ktime_t	(*timer_remaining)(struct k_itimer *timr, ktime_t now);
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
--=20
2.17.1
