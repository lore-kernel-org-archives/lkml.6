Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2629DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C632D214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h5KCjD0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C632D214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeIQI1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:13 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727726AbeIQI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ow6sGpx1fLC3G/Tfzy+kDI3vVvW//FnfCCE8fcYzTE=;
 b=h5KCjD0o1itt2ku3Ec9rSf7slFhVUZfTIw+8MJGbIFGHfSP3/alryM+tYEX1eePh1Hmrj0xAPKFewEoqPFTmVCRR2OqbKcRJtcL3tAIrfsva6LZY3FQ09A6EKyT2swd/q4l7cCxuvhagS1AuK4M8tJU6Cnf1deymSqXbj6Hy6hg=
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
Subject: [PATCH AUTOSEL 4.18 065/136] posix-timers: Make forward callback
 return s64
Thread-Topic: [PATCH AUTOSEL 4.18 065/136] posix-timers: Make forward callback
 return s64
Thread-Index: AQHUTjKlXiCC6+s0rkmaZZPFVFDJlA==
Date:   Mon, 17 Sep 2018 03:00:52 +0000
Message-ID: <20180917030006.245495-65-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:ki9WvyE4w5IM1e7rfVRwSdjFghkp5Y/W/G96i0392/6KHGNdGpc7XWVKPBjz0gZTWeFP+RUSACdnvecHAts8qBkpkq7AiFIcc5OGLtuAXBiOJBAz+15G8kMye00TOh1v2jUzYYZFm5NsLKBaa93HMn7tvXe1gnta/dNBhMZwQjHM+Muk4uyKmGwBMDb8mCQamFX0vDpPlRYhaTbPD/EliRgBuGc+G9mAHQFp/+pIXDw6MzXsSakHuXV6NHyBtHSGApniIC/vDWmheleEZAm62EbUk8giuOpr+tDAZ5G5W1uvTlwo8R/Q7z9X3ZQoIlSGsGGxdoVa2tkYNcdBQWgY1uei0omaiZjbBmEHHQZGTZdvbJ9fgasd6J7krOTKZnJBCTfFF9aStxhLd7sfUcnFVaJ+fwdpDTRZYuF9c6dDK03i4p7l9dNnmpNBFLvOQZiiAh414vdK0xRJJ+XsnyEvBw==;5:znuyzxSiTBSbdiw/62zdhsYdkG4rDaeTGd0zeRlKIvOX+2Nhd1DcQ9oNoEbFJ90IpWv1FwuyCKbHg+xkVFWpd5pgOJ0avp6NktnkAHUrG2kTwLKvC2ea9kvVTF9aE/RpSY1Cv6vVjKC7FENxrHeuyGDI+JefUXP35+w6yCYE+uM=;7:NIQrAIAvKTAWu8C3dzvX3rG+r21BAcaJ9GK5ucZlM20rGfn1APxGxjrg7OaYxJ3wm6DQ8t/y2kcowpKGluUpskb7Dm1+kVdK9F1TienJNgNWoW0viOO+hD+EQHw78aNUy/1TMcjCiRn3385O79Ho0ZB6gYaZTBcHopGmTtu8CgtlHSLUjqIOvznPMN68tNBEYRNcvXZSAFXdUaHpLU2OeoyrRnBsxEZAJO1uQPS7l11AHRX8gfKLfX3qewz7WWIk
x-ms-office365-filtering-correlation-id: 1904a83d-ae34-498d-f6e1-08d61c49ec61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB050245F4A08BE4A0A881383DFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(966005)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(6306002)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G2Ct0CbJtUOSsyTbl6o4MLUVGbLcSivu7GiAgxRpgKRMJ9NzH4EoLPAHqyXajMd1T8gxr2tXa0bswouLi7N0JoEEPedZA2FN6Vc2pFQzqUuk/HsrPbgeU+db9Byd08/P0K0O7IEv4Azt08EtWrC4OBSaQnoT2P0fKFMLZvMiBgII68SawVxUHWQPbOjI4VxW3zE8qNQYtPh0cb0GSSoLKkdW13/nsGo+b1GhSiUVGjOVLFuQOuMxsgf8hDJ8JCEB35HcQSiyhaT4QVCfnLjYJ94pnXbykiIzEp3mQf86UtZ9KthF1Qkev9t04gwkT2ytuet5hEG1cUsPlnwbKEfTUYbsTZQnipeK73KcRlEGsH4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1904a83d-ae34-498d-f6e1-08d61c49ec61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:52.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
index e08ce3f27447..638f5cf86e5d 100644
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
