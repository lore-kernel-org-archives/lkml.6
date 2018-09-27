Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB14C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228A6216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BU8IVmNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228A6216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeI0WLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:11:31 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:4746
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeI0WLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIcWzJatu6c/GEoaRJXpLhmf0Sj+efdkH4mZ3d7sIF8=;
 b=BU8IVmNfx6kvu6NRJ2a+ZYDVwTxw3pbXgYVXDJr5wvazJBgNVP1/r79ktMbuHuVk/tZ5CnIiEoP1RWU9DBbba2EaQV6H1jVnvQmaWgMIJsitRuRoGBqbCjZGxb2VEhu+eDyJmh117fC1hPKqP5IxbRlzdAZ5Jo/jftTdxX4EG+Q=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2686.namprd12.prod.outlook.com (52.135.103.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Thu, 27 Sep 2018 15:51:55 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfa:d467:f32:4d51]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfa:d467:f32:4d51%4]) with mapi id 15.20.1143.022; Thu, 27 Sep 2018
 15:51:55 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2] perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3
 Cache perf events
Thread-Topic: [PATCH v2] perf/x86/amd/uncore: Set ThreadMask and SliceMask for
 L3 Cache perf events
Thread-Index: AQHUVnoDByvC4FTOs02df5FQTZn2Yg==
Date:   Thu, 27 Sep 2018 15:51:55 +0000
Message-ID: <90030694f0e49c0f71dbcf5d104cc3e3f94641bd.1537891794.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:404:151::19) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2686;20:ofc2pqc5CKz3KW+PUQyDQ2wL48G7ZzsiHgNKDcqIoEylvCCcM6i88Wa3sidnm3Tam1oXCMPyzDCFGavO1QOdxvQxcBcH0SbMIIc7/BzY8eLvA7+bh1oaf/V/S6GONjPnaQ5MxucEF9rD0HX82zqZk7rLeSdfqv7AtaAsyzKUWhdLiSRpvcCq2+dWvXM16/eITq7Ukrx/EXiuTCI2YkIkFh/JLOn+KYtBWWVhMAeAihm+5JtKm8Ng6avKQ5Ube2Ow
x-ms-office365-filtering-correlation-id: 467dc5c1-1219-4e7b-9672-08d6249125fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2686;
x-ms-traffictypediagnostic: SN6PR12MB2686:
x-microsoft-antispam-prvs: <SN6PR12MB2686A2A5E34248ECB1164969E7140@SN6PR12MB2686.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:SN6PR12MB2686;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2686;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(7416002)(2616005)(4326008)(6116002)(3846002)(5660300001)(476003)(7736002)(25786009)(66066001)(305945005)(2906002)(72206003)(68736007)(14454004)(478600001)(36756003)(118296001)(2900100001)(86362001)(99286004)(106356001)(105586002)(486006)(52116002)(6512007)(6486002)(6436002)(110136005)(316002)(53936002)(6506007)(386003)(71190400001)(81156014)(71200400001)(8936002)(97736004)(81166006)(8676002)(102836004)(34290500001)(14444005)(5250100002)(186003)(26005)(256004)(54906003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2686;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mIaK68GyAGA8zg1GhqYWBRBOs+BkS6K/RXOQp602BrliXerFvYobgrOxgWa6QczgVoy4XmMAGt9Pz0FTtgD9b7V6RxK4TmWE0VvYQAgP7HS1F29woiPaZVsGJqzgStZK2kuZIx7bz8n1B9VNMY7U3II5R/xlL1P8czEVj7UqINqc3lNkkFN+2zIQETStblRqtRYC0IeRvsRkZNYUZDjuey+UwkxdLqc0fOr0BKOD9kdCf4T0lAAMs3WTyflUAs4XHeknPPLpwYtChw6ot5F1S52dEfmnae8zt6f1UTquLVVuh4U5WIih/dqH82BDuSz1qRtPB3y0Qu4zV4pKPLJ7qOysY+JLvS/KtgtWe4mBXtc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467dc5c1-1219-4e7b-9672-08d6249125fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 15:51:55.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Family 17h, some L3 Cache Performance events require the ThreadMask
and SliceMask to be set. For other events, these fields do not affect
the count either way.

Set ThreadMask and SliceMask to 0xFF and 0xF respectively.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
v2: Changed L3 Slice and L3 Thread mask to use unsigned long long instead
    of unsigned long. Fixes warning on i386 builds.

 arch/x86/events/amd/uncore.c      | 10 ++++++++++
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..8671de1 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -36,6 +36,7 @@
=20
 static int num_counters_llc;
 static int num_counters_nb;
+static bool l3_mask;
=20
 static HLIST_HEAD(uncore_unused_list);
=20
@@ -209,6 +210,13 @@ static int amd_uncore_event_init(struct perf_event *ev=
ent)
 	hwc->config =3D event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx =3D -1;
=20
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events in
+	 * Family 17h. For other events, the two fields do not affect the count.
+	 */
+	if (l3_mask)
+		hwc->config |=3D (AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK);
+
 	if (event->cpu < 0)
 		return -EINVAL;
=20
@@ -525,6 +533,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  =3D "amd_l3";
 		format_attr_event_df.show =3D &event_show_df;
 		format_attr_event_l3.show =3D &event_show_l3;
+		l3_mask			  =3D true;
 	} else {
 		num_counters_nb		  =3D NUM_COUNTERS_NB;
 		num_counters_llc	  =3D NUM_COUNTERS_L2;
@@ -532,6 +541,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  =3D "amd_l2";
 		format_attr_event_df	  =3D format_attr_event;
 		format_attr_event_l3	  =3D format_attr_event;
+		l3_mask			  =3D false;
 	}
=20
 	amd_nb_pmu.attr_groups	=3D amd_uncore_attr_groups_df;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_=
event.h
index 12f5408..78241b7 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -46,6 +46,14 @@
 #define INTEL_ARCH_EVENT_MASK	\
 	(ARCH_PERFMON_EVENTSEL_UMASK | ARCH_PERFMON_EVENTSEL_EVENT)
=20
+#define AMD64_L3_SLICE_SHIFT				48
+#define AMD64_L3_SLICE_MASK				\
+	((0xFULL) << AMD64_L3_SLICE_SHIFT)
+
+#define AMD64_L3_THREAD_SHIFT				56
+#define AMD64_L3_THREAD_MASK				\
+	((0xFFULL) << AMD64_L3_THREAD_SHIFT)
+
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
 	 ARCH_PERFMON_EVENTSEL_UMASK |	\
--=20
2.7.4

