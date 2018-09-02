Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BBC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1875020855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YZe27VoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1875020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIBRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:08 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNcESe+YOnsGjrp9hDYcgZdlO4OwaiXyagA8Xsc5NB4=;
 b=YZe27VoPhWZ3kVtt41ln1e/Z5NYlNIl7RE4/2+toGlwGbYfTWbLrA3cXS3DGe2zRFXSYGbOhQrK9AV9Ql28l4DPJHQ97LcHVCLrdZYGxdbqoYrMDJ+easVOibhMndHD3FLUTgqcE+XQl1+eP8IuXUbGeT6bEFJsI0qSA2k/oBPk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 049/131] perf evlist: Fix error out while
 applying initial delay and LBR
Thread-Topic: [PATCH AUTOSEL 4.18 049/131] perf evlist: Fix error out while
 applying initial delay and LBR
Thread-Index: AQHUQr1r60B84AuuTkiZupwcUHxXDg==
Date:   Sun, 2 Sep 2018 13:04:02 +0000
Message-ID: <20180902064601.183036-49-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:bFHi7KAx4p6FM6YVlz3GadxbV/llqX6I4z41m1Ffe1+9yID+DtPus2zDUOzAYKO/B7hOFqtjGLpzha1CDi0qLXDQJtrDgEHLcZ6gOyiCCbfP2DuRNjkvfLksGRgBJwUamnGXm3sPHjjUQWPlBjYPhwkxOlNyC3g0hxE4p2exAv3cct0zVQhWeJcLuUpPZoKqjcMdHYAz3ad6m2WnmK1KDXjwlLxZAcj8saU54F3FI6kR8D67EzrxikzAJppXbmNkClS/+45qPhf7jZIeduh4Xst+dNKxKyUVvpaxv3KK/uz6H5EGRrRq55Fp86EnLkf6KhTTIDBCi4mqhMg1Stt9cwhN167uVr7v6ilaJrZsYEuDAcg+Kg/iVYUjjVP50Z1sxGGnO2B2M712jNUbAmziTLVyRUhWxq2L75AbTqWRlry7VqyI7vjkh6LZ6s3luYklEThXo7HH/5SnHccNkL1LUw==;5:oHJY5chKkvNVcERQrS5cVBMNH06ZSf4v05Yl6SuBluNeuTVDs65U5XgtzGZ+B8Pq4uw72T96zB/Rj8nZ0b0f3tNxc2XiUr9bKSQ/8wFuXfc4qtRRAiZXGO2ZU3ZophB6zzDtCC7aSe0VeotSdtVvTo+Z31l6amPLMOShuveZE5I=;7:aQpFDYfN+SwR+K/NsvwAcCXhtqjZWP0AprtwBJnxMo+4dIhtnImF3lTZCyzIC0Xk1TabvcInsWYA8VMIBdayjVPxQ90XcQiczMlwbuW78vstTjmcdmleGLtDVGg6oVHTXbjxYamfbzmaotxBuUhI1B5lViS82/U8MLwb1uZgCV01w2d7X7kivAjqLDybMKDNLxm9kRhfOj/PsPzKaheAKZToSHsbPh5jkFySG1AO3ojTlEjSVBX0v841Jmy3ACAf
x-ms-office365-filtering-correlation-id: bcbe7f37-19fe-46d3-a025-08d610d49518
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013583322AB92D889A20A328FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(6306002)(2616005)(6512007)(966005)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ePMGP6udqs21DeQMtkk41QRpcYNl6w0MHRZD5vCmRVr/fXIPhmNwQg/Z6IYKa+r/c2+xZnZGpPSTl/LXcYQkcIDSEQsAGnI0sOhZMrxO6LBwlMJ9KJk5zePj5UqIj/2fedeXLXgudGtVK4vS1Y6Cxy1YA41JBBQSFjcG29LAapZDpcTHawhKGpcU8mL/Dogfqamx3uegku9xEUPaf9KjqW9/iS8SdnaUL5c9NWXR/IRVYANiS7SNykb6lm0YrRML2FxhGaLk0Tr8i77cZ95SBj+7IxdOqQCIqMYqhBGKv/vv0zNjPC+UVZcsLNuuaakcnKQixHl53dc1h4v4tJ6S3C6lxUfuCbAw9paw8AL+hwM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe7f37-19fe-46d3-a025-08d610d49518
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:02.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 95035c5e167ae6e740b1ddd30210ae0eaf39a5db ]

'perf record' will error out if both --delay and LBR are applied.

For example:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  Error:
  dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts.
  Try 'perf stat'
  #

A dummy event is added implicitly for initial delay, which has the same
configurations as real sampling events. The dummy event is a software
event. If LBR is configured, perf must error out.

The dummy event will only be used to track PERF_RECORD_MMAP while perf
waits for the initial delay to enable the real events. The BRANCH_STACK
bit can be safely cleared for the dummy event.

After applying the patch:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]
  #

Reported-by: Sunil K Pandey <sunil.k.pandey@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1531145722-16404-1-git-send-email-kan.liang@=
linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 94fce4f537e9..0d5504751cc5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -848,6 +848,12 @@ static void apply_config_terms(struct perf_evsel *evse=
l,
 	}
 }
=20
+static bool is_dummy_event(struct perf_evsel *evsel)
+{
+	return (evsel->attr.type =3D=3D PERF_TYPE_SOFTWARE) &&
+	       (evsel->attr.config =3D=3D PERF_COUNT_SW_DUMMY);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1086,6 +1092,14 @@ void perf_evsel__config(struct perf_evsel *evsel, st=
ruct record_opts *opts,
 		else
 			perf_evsel__reset_sample_bit(evsel, PERIOD);
 	}
+
+	/*
+	 * For initial_delay, a dummy event is added implicitly.
+	 * The software event will trigger -EOPNOTSUPP error out,
+	 * if BRANCH_STACK bit is set.
+	 */
+	if (opts->initial_delay && is_dummy_event(evsel))
+		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
=20
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int n=
threads)
--=20
2.17.1
