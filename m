Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32916ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AD2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ELQaJTB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AD2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeIQI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbeIQI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spG4637xVuKUYe7/IuWYWBB48HVhvkbTY+lsCiCJ/A8=;
 b=ELQaJTB/KlPY3yr0Y1IRnBApklQ9n2AHycp02vqt3QUW7UtjdxQHYeQmFtZQpVpNFY+gcpnyIM4o3iN7MExT4002dKCL806EMWuSmwHzkv8m0dy2C7iQm5KwaP45bVQ6GwggbW1E3vLlF0Ze+kVYOV1w5BW/kA4hAJNnARt9JV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 43/87] alarmtimer: Prevent overflow for relative
 nanosleep
Thread-Topic: [PATCH AUTOSEL 4.14 43/87] alarmtimer: Prevent overflow for
 relative nanosleep
Thread-Index: AQHUTjLr1Af/YDV+uEyIKrrmkRuT3g==
Date:   Mon, 17 Sep 2018 03:02:50 +0000
Message-ID: <20180917030220.245686-43-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:CTCDM950MnBFIXrfbzX7YJuF8jkZUXBb63wS+PrQ9aUoFppwB1+RILCrOhaaauUPOOMFLIj0PpcyFQ3ORII0f59GV36gYPpXCIxTsFl/5ElC8yx7AxFpDO46Omfo7YQ9bSEtx0ouiWxcJny2Ww1ADHePCVsdAhaLEs03YdlHk4L8hluLs/CKTJIU7LpRWtQ7oVfdnvRTSfJwT8Tbns7mSZwOoQIx1FqCq+fEk64PYiIREEWToGfy0W6MsFj3b0aH1+oMLNvO2V2bsAYN/Wo/IFv8v3+VKC29+lGoObtAY0M0igvvfZT2CCRX6SuQ+U4DcHDG21wmLj0HlWtnJ4FKgQ2dAgIROnqREwS0W/91R3SmtfQrExLPQq2MZ02XYGRmhLciV5EayZKVgqy7/iIjaQondVYuWZ//E5UzGvnPDbjzqRnEQePOgg0evDYyohWiNnlhTm0HTh8HJu9r0TtzyA==;5:MifGWIuhN81HCdGNo2Ri7FmXmWMMAFLguEt4UP2c84M5GKIxUxqqfdEikPLaMPTj+RoI5NJn2JiIQRUBQAktXWk2qfVBPsgvEevEBhqfmgXDvRJ6hYYcAEecl4d/jskP5AEG65d7SL+29q0neBwNTKb4m8ivsVuTRUau+XzgAGk=;7:ZXyyc82XdpUPbbB9Zrmk0PDYsSh/niUHD97f2xAhrRYcOUDc0Mcf51G6xY+40KjgsZwUAoQGxXr2SCMseQEWV9b8KHQAliZ5nc2O4+etsnZkAiFDBP07IQYmkB11UMwuhuDKZ+u36ujzkmAzrbmcztmGOXMPmLUA08gDKDEIVOneUiQdrbuSnrimjkTJbdxBEirRRUCyaY3HaYuMUUBPya5tkIiqSb4JU0/pa+g50f/X6+wbiflCjOLM/UaiPMVG
x-ms-office365-filtering-correlation-id: cb4f79d7-eb3a-49b7-cbab-08d61c4a4121
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB07764329B4B314CFAE8F73A9FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(966005)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(6306002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yef57MCkv0mD2bOf7UOC7T2+ZK4jYFVVdLfpzT2hge+JKR9jXi8ro+MwMhB9QWhgyzdkvvdtkvXJLqbulbKeetblKWOrndTVFyISuPktlTcSd36Cp82g9Jk/NMcMDH6u36ZcGQs58jP6rmnrdX0gKzS04BaHXDMYIMgtPnLDeZeOyaABqpQgTVI9CdtLsu+M3iRctZbSMq4HGNyD9FYIk7LrmpMNA3brBmLxNjCQzCRrMvMH/YxdOZcQcB/nZOHn2Vh24Y0KG+6OoJxa/+BPL9vKMwKWWxFk+cIaTo9sR/IPZT3T8jA1oKI9ISzrIIAk7nRHg4uPCHsmaIqnRiysswtcjCAwcdutcXOUFiarlW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4f79d7-eb3a-49b7-cbab-08d61c4a4121
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:50.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
