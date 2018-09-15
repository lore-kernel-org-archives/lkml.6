Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C070ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g2k6vZ8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2B7208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeIOGuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:24 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728664AbeIOGuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWX/24S7MrGf7HE6GMoXX7XOPeqI1+f8qGbMoeEdSt0=;
 b=g2k6vZ8OSzHlthPqB9vFLeu4sEx4Hq6dohqhbYimOYtA3N2lUdRqb3sI6mhkUe8Zh8SdvSyYL4hxaQEDV5SrD8DutVCmCR1LdG7xaSqZPZatyOrqa3FWgBz1fPsoJIhv/u6JyShsmb6Gp9qmSknJk83jBCzZ7UpZoW8+g12ZDHQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:19 +0000
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
Subject: [PATCH AUTOSEL 4.14 33/57] sched/fair: Fix util_avg of new tasks for
 asymmetric systems
Thread-Topic: [PATCH AUTOSEL 4.14 33/57] sched/fair: Fix util_avg of new tasks
 for asymmetric systems
Thread-Index: AQHUTJQDsBbIHpWrCEiBxNOOIeLy3Q==
Date:   Sat, 15 Sep 2018 01:32:50 +0000
Message-ID: <20180915013223.179909-33-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:yq8ETtG1jgzNRPpDLFWiyXnyxwm7J0yysNVTdTiDJi+mfFoBgr+8BC9T31BzMuxP53hYVPi2GdAo59s33e/sZVcKhaLbfOH8nnJOfsNd1nz09jv9jtodTUtwQip5weLRkFIQVpvfySEq802Iwet56mrZ10yaKBHcEGGuJkGm/FJ6hpCznYzp/wvafDXexoqZ4l7cfmlPfLJr2LEjwAe6QjW3mPgUh3K9MS7YaGLjniknJOqLGFKp8Z2cr26l+ROFtRrS3mGeyWR5uo1AbR6KW4mDNsLxWZoMvGdHvhfOMIK+gyfuLS6uMsJGZGthS3Ga6TB5hs+l2yN8+Wen4YJn0KI1yP/2JYi4N4gBLb4ZXDN3iviy3VQPI9G2R4VWsQZorfmOuvYE13+cV4NxfjhurhhbyZA+rqITK849ura/t4xHbt3VoENNsZxgtSmApT3cBUYWnoZ7xZGUdw7zdIPuLA==;5:XQ9ntEW8PPWGNiHfZUojp7Lmqf4Qxu4Ai2AuA8J59ki39zNKuyHRuZjBWNGN4mSLmqH41m/hz6IEguTnjvt50BG3nKaobOWEeTd6JwflyFFpVfrmZOcOgdKcwH+CqabYOEXICSYgw93BCk4BIOE6gdF6yk75lkDmK6e74kBSv8w=;7:O/w3V3iNXElKaJmcAxmX3RfV/5h3MfzC2CSLqeMixL7DdaZoN/Rq29BhsY4LO28BoEHGosOthmsrzh0VPiR+dQwW2fimrd+MRM2ODcQxxtWxwXIB2PTpbstB6mubdneB+VASoPDc23jb9PY0h5qq6hiTiLusR5UMXOsNzCqiuWw1TYCLK8pyEf7O+LGz0fAy81NOmwJ24eSjrOf+oPD5+KMwDscalxaa4kulP72ORKThK5njhl0suntNCGEssQzR
x-ms-office365-filtering-correlation-id: b9547da6-af57-4ca7-8700-08d61aab37c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471F610763D9E29DD0D15BDFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(7416002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(966005)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(6306002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(5024004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BzKlfa5B6Ljp/APEzmHShsjRFQ3tg9zQb7A/BvUJupE002zF6DPldh47L6tHUdqFqAQmj9iTknZPLSrXld9KFDgVM5YIJThmth/cgv4bB8Fyf0ROnOzmEdLjxDh/Q4ANr3V7e2eFUSH1xdDh3eF9CmA7PgPoGhipnbCBUheInAyk+Fo6Z9vrmsLBGrHPweyyMeWj6cPjEb7agSOiMEb93+xUUmIc6W4/KPQT/lMFMGYx66mFB8j39gAlFcQoOkWqo9MC9dj2c3cqYTAAJYm9CMoLaui6TjzHUsKnzLyQPfsJ/gzpjiYP32CV88A1qQB8qAcGT9NEeDb+7QVDqpYzptlfnfMX1UPvnqlZOj5sdtc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9547da6-af57-4ca7-8700-08d61aab37c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:50.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 0cc7098c6dfd..a5e20ceb0b5a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -757,11 +757,12 @@ static void attach_entity_cfs_rq(struct sched_entity =
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
@@ -773,7 +774,8 @@ void post_init_entity_util_avg(struct sched_entity *se)
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
