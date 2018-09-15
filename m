Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC15ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A43421479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ouGHohN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A43421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeIOHG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:28 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbeIOGru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfgNZiqLbaeKGiKIj1cKcCbENcDoRoW/E4rsiRRwjzQ=;
 b=ouGHohN/WFp+sqH828zKezeD4aPBrYy24WX7upuaaQW7ucALbXBKJjKlR82teaudpK+dKuDSfF8WG6lIA3JaXO6MWAX87bHrICsbFkHAW6htZPCio1FmYozJMumvZc8h5oUadsC1h0yGJrlkIVkzUGi2BWnvyhEC1JO+UOJ87q4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "patrick.bellasi@arm.com" <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/92] sched/fair: Fix util_avg of new tasks for
 asymmetric systems
Thread-Topic: [PATCH AUTOSEL 4.18 46/92] sched/fair: Fix util_avg of new tasks
 for asymmetric systems
Thread-Index: AQHUTJOrsDhsXd0UaEmKRWNw5xTqRg==
Date:   Sat, 15 Sep 2018 01:30:21 +0000
Message-ID: <20180915012944.179481-45-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:iFHxcW1hziPlb4Lnfi1gqOwboapFoYV8pZWQjz3oMrzyq7uLdfh7afoOEmGlODADtojbYRy4cDAc8gbypXa9ZHSEWQZpaIMKh3PVXyk0xVBGQFTSUynIc+bF8+mn7D4mYjuLxfCmZWvarZ8ZXJGegkzdaeWqvXyJOTh1sLdHsQpfB6ce5YwqBtbaaNVFSUqpL6uSMOJczrbHYanLUeqa268kvYKxZYBzSxWpdMVT6QzmyMCpcNyT0kci1fn3eQ/s8jHji1S27uBSLEYTIOnH8H8goM0FW2PW1mgAUDilC/Gs4Zwq9Z0LQPXzN9kP7K7a4K/iOlLNm1c4OdFsyhPm6sx/3vuXif+MWyAyO85EQ73sYqhjgr84wCXci4i1UBiE1YwT6S/oZ7nyNy8Y44opStYQqT4gPBqdI54kcOK8gDniVgFwDWF8wKQcRJ1UuWerFIQLLE4kiXRCl2JG8VFheA==;5:Rct6GN09OmHW6tExWaYDah7fK8e7v9M2fFDk9hBEjYTVZn0M8Ux5y7wExapY22aST+8Dr359XrZBlJodLaddNnjH7A2DWPr9rYGuOf98uKiPxs2YkKn8EeOEXvRzzLJtsZGh3h/ZRRep+Dx8oQET84k2ZJLnEhajEifOEJuo6WY=;7:k10BFKHFjUQ1OZwBsts1V11fmDXmNKBu6lrB9lDDleWoqmuNuMoPcNLZm0pnTvRqBDqMieWOCqt2+7yredZI+1a67HaBzWM49JK9KT4DVuaWTXmhS1h1XbdWmBwq1rFYSGeoGQltXXdh/hmAbpCUIePPaU0K9CbJEPCali2uIMGd69Z1uKVCRHlg/GY3KMfzfgVxiemA/jUedRUFV0IVIqxHQhJUqun4/L/HjDAIOIVeOSce2IKL6gHL7RP3huHu
x-ms-office365-filtering-correlation-id: 9c0e459e-330f-4572-805f-08d61aaaddd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856FF3FAD136FF18EB7CED1FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6306002)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(5024004)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(7416002)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(966005)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h5BfCEouzavx0w4KG6XAQnsJSXhg99/zmdFdX1ceuHEQJavB2mcwVWFYVloeI4lTXyYwa/FyR1bco4NPbjTa1r4XJjpOA+IvHRr98McEy3ztGJ8rmOP3Uv5jjkQsmIP1/TUiXCDTg3LdnJJXycgs/pJdwmEapb6gUQoIWYrG6suDm453+oWB0MHSPTjHt/pVEzn47XikORDstSsk4izTVfGS7E1+E2T2lULyJX1f012fqB7BBlSdJs2W5OAxF55mkNF//2W77ZAOE9kKo3R917dxUv25WMuBhr0o4wIO4NAnzCtitTWjwvbvT/37x5jOVUiQ1VVHDgo7Wl9I+vy9m2uq310uUEmRkqKVPC1vlqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0e459e-330f-4572-805f-08d61aaaddd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:21.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

[ Upstream commit 8fe5c5a937d0f4e84221631833a2718afde52285 ]

When a new task wakes-up for the first time, its initial utilization
is set to half of the spare capacity of its CPU. The current
implementation of post_init_entity_util_avg() uses SCHED_CAPACITY_SCALE
directly as a capacity reference. As a result, on a big.LITTLE system, a
new task waking up on an idle little CPU will be given ~512 of util_avg,
even if the CPU's capacity is significantly less than that.

Fix this by computing the spare capacity with arch_scale_cpu_capacity().

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Link: http://lkml.kernel.org/r/20180612112215.25448-1-quentin.perret@arm.co=
m
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9c219f7b0970..478d9d3e6be9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -735,11 +735,12 @@ static void attach_entity_cfs_rq(struct sched_entity =
*se);
  * To solve this problem, we also cap the util_avg of successive tasks to
  * only 1/2 of the left utilization budget:
  *
- *   util_avg_cap =3D (1024 - cfs_rq->avg.util_avg) / 2^n
+ *   util_avg_cap =3D (cpu_scale - cfs_rq->avg.util_avg) / 2^n
  *
- * where n denotes the nth task.
+ * where n denotes the nth task and cpu_scale the CPU capacity.
  *
- * For example, a simplest series from the beginning would be like:
+ * For example, for a CPU with 1024 of capacity, a simplest series from
+ * the beginning would be like:
  *
  *  task  util_avg: 512, 256, 128,  64,  32,   16,    8, ...
  * cfs_rq util_avg: 512, 768, 896, 960, 992, 1008, 1016, ...
@@ -751,7 +752,8 @@ void post_init_entity_util_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
 	struct sched_avg *sa =3D &se->avg;
-	long cap =3D (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
+	long cpu_scale =3D arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cap =3D (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
=20
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg !=3D 0) {
--=20
2.17.1
