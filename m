Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA01C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8280F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="kg/8vknE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8280F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeI2D34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:29:56 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:53696 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbeI2D34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:29:56 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SKuAAM031249;
        Fri, 28 Sep 2018 16:03:53 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0119.outbound.protection.outlook.com [207.46.163.119])
        by mx0a-00010702.pphosted.com with ESMTP id 2mqyx8bbvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 16:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQszOQENfFXMW4S7wYKbwWeNi6onKWiNOGTF7AHnkzg=;
 b=kg/8vknEt1X8NISPgcaVJn64i0BctOqmyvb/F9Pp+8htMnIIDsjynrrt//Bdu2ovZjul19Fx9eBYZY0yXbdj/HCma1t9mdMXQDsTFz0Eacle5LDgbiiPWyd1sEZ1ESWgjiEBbKDmsfgbpjcETnZEW/IQO76tAPUGpvgMvx7lwaI=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB1237.namprd04.prod.outlook.com (10.174.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Fri, 28 Sep 2018 21:03:52 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988%2]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 21:03:52 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Thread-Topic: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd
 wakeup
Thread-Index: AQHUV27Clo0p39J5tkqdZEnvx9ujKA==
Date:   Fri, 28 Sep 2018 21:03:51 +0000
Message-ID: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
References: <cover.1538089179.git.julia@ni.com>
In-Reply-To: <cover.1538089179.git.julia@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:910:4f::45) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR04MB1237;6:zhCDEfO0r3MH1ChFx+D2VoUhhy7+4nWh4CQ+N8frcZi69Q8YKB2vxrV+9l264S7Szfc8xs2+x0xpjfGToPoh7O5ZHXjhEtzAyAo3QWD/4E4PI3jPkc63El++aYHZugp0nN7L9TB/Ye8Dp6/kdk8DkehzyLmJqWd00kf3mBLuXlUy1vIOiorcBU7eltXERze5viaYxUaMbWr7j+WahDmVd6WR5LUfhIeghoTT5qybs5CTSfngzbyNR42iVDTLqQYUOsJm9A7i9d0BGdUKx9w+fVNo6dDOqzeTnAYHPXhzFYeiIicFlLWFeJUSTQuPzKtIxbbH50fOBxRbh+VuQPCJ7WROkVm5Z1zpfxSwUt3XnRc0ml0wwpb6L4mx8HSO9GsCULt7cIB0ZJVMdE93gKFB+Z4Verg3o9K21pW8GL7+6yhRmrwMilqEjhCzrb1vMbvS5jEZmY4M0TFKVZpqwziJug==;5:dyLlKXImpcp3XEBR2skJFVBvDPmv+ya8nxN0tS8hJz1Mf82sDNYJXM+gNx62pSMwfxnnZ5COkGgwfNIhLhGFsAAa3fY38zX3u5Ux1bV1LWA++1Jr2pBugJklR+/2SbKvZJNjSFYccW97eB2ws+2Ne22IKhvrh4zu9RtWkls28k8=;7:6mnkEHegMl2A/cNxEiIbOoOWIU6GPR2EJ4AaM5SetqCLEeTAcn0YHjmm1DDhYrHs7z9U4qxNW7ozTk1lfIm5o5Ox6tF+ZDgC35EDFpGHvDOr18XHPq2oe5dalLkb+5h4b7V90pegkJCE24fizjNt7ZK/oDYpXsp/4YBZD4qCFzSsKGu4A8h8FmvD6qroo+gAGsmsZ1ZBgK+O8RTXcKIPOXWJP5GzKKR27C5Qt7QOoflBu/iTdQNEIeqLwd2ihGXB
x-ms-office365-filtering-correlation-id: 8c053b31-b1b8-4780-d914-08d62585e497
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB1237;
x-ms-traffictypediagnostic: BN6PR04MB1237:
x-microsoft-antispam-prvs: <BN6PR04MB12379AFC760BEF4FAA8D38A3F4EC0@BN6PR04MB1237.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BN6PR04MB1237;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB1237;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(186003)(102836004)(26005)(486006)(66066001)(476003)(11346002)(2616005)(105586002)(118296001)(256004)(14444005)(106356001)(81166006)(71190400001)(71200400001)(446003)(76176011)(5660300001)(99286004)(68736007)(6486002)(8936002)(81156014)(8676002)(6436002)(316002)(52116002)(305945005)(7736002)(54906003)(25786009)(110136005)(4326008)(5250100002)(97736004)(2900100001)(14454004)(6116002)(386003)(2906002)(3846002)(53936002)(6506007)(478600001)(6512007)(36756003)(34290500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB1237;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 32BjF4EOBjb+NyYNlfkVOfplvCU64gcpxzENkkINIfr+dWH89WVXykEYqYC0hK56xHDaB/C8WD9WAhJhrODRMmqT+KR7DAqzrA3Jys0C/MyFtlXI9eK3ZJyjzh7auhH7HUD78PKd23T5mA42FOuLekhE/888h0ZGQdgmiL/qk8bPDg+G6PwV2oC6IPztfFq3TKDcLrvqc8m+pM5FwWcphBZyyAK2qntdv/AcYI9RpvLH71JMZCjSmE2BIbkHYa1MVVuD8+WwPchMY0jB76FWwgn2j+A6flSrvMwwtf+0wECMUL2pi5223wmK3DxE6c/UC6u0eVwwBqOuiNy1uEw1ujP4kx0TA+KLEFhRE1ohEPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c053b31-b1b8-4780-d914-08d62585e497
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 21:03:51.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PREEMPT_RT_FULL is enabled, all hrtimer expiry functions are
deferred for execution into the context of ktimersoftd unless otherwise
annotated.

Deferring the expiry of the hrtimer used by the watchdog core, however,
is a waste, as the callback does nothing but queue a kthread work item
and wakeup watchdogd.

It's worst then that, too: the deferral through ktimersoftd also means
that for correct behavior a user must adjust the scheduling parameters
of both watchdogd _and_ ktimersoftd, which is unnecessary and has other
side effects (like causing unrelated expiry functions to execute at
potentially elevated priority).

Instead, mark the hrtimer used by the watchdog core as being _HARD to
allow it's execution directly from hardirq context.  The work done in
this expiry function is well-bounded and minimal.

A user still must adjust the scheduling parameters of the watchdogd
to be correct w.r.t. their application needs.

Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/watchdog/watchdog_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index ffbdc4642ea5..9c2b3e5cebdc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -945,7 +945,7 @@ static int watchdog_cdev_register(struct watchdog_devic=
e *wdd, dev_t devno)
 		return -ENODEV;
=20
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	wd_data->timer.function =3D watchdog_timer_expired;
=20
 	if (wdd->id =3D=3D 0) {
--=20
2.18.0

