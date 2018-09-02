Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84528C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE3204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gNaJKE+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBE3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIBRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:14 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeIBRXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIQ1zfAkl451sq2NXxus4SPAWsG5Pd6VgaBONmzxAo4=;
 b=gNaJKE+JMxFiy6HriouJRDCC48drfXuh3EDbRVXCfx2uKRDYl79cFd+oiIOWm2fQd8gLcecZwXkvJSmXQd2uXO0gh7/bY69zgNsVdYvwZYNOlNnqWjPnMKgThLb3frjBqMoMHozAQzB0U70ATeOxa5uo/OsjivCOF7wM11VOSxE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 33/89] perf evlist: Fix error out while applying
 initial delay and LBR
Thread-Topic: [PATCH AUTOSEL 4.14 33/89] perf evlist: Fix error out while
 applying initial delay and LBR
Thread-Index: AQHUQr3OegGZfIRP6EiBgXWDyvEeBw==
Date:   Sun, 2 Sep 2018 13:06:48 +0000
Message-ID: <20180902064918.183387-33-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:zAGnePpLed21JZTfae06t+5u8/0OAj/3S4U5iespRphHM5ThJpqh8OogUyWmTfT6nzatNz//jdSqa9bLb4cm0gg2B/q/1qAkBTUw9PZ5B5u+ORY4WoRB5nAeyg3I9FXgHnvk699YYPAmG4ODIQnackf1xrXxRjqoQXdgIGCzPMOwhYedblL62ekYPKHsF26Dm79OV739lqKAPZ2lfYUSXCu+N4B9i2VbGbsookummBLHbRWKBKvWD6t6YebvDQyS8aRkXUBndeTupB3LctvFdzvHuyCZLCtwF+x94bA0ku23Bll7VlaoSzb78HsLGII9koGv5sT9I1BA19qDq5ats3H2Y5fSgFT5wtfIxnh2tIDPm0U/IV7pfsumIdar4vhYQjmlsQ44CoqjDGxr0BA3Qz+dG3SZzJBofPIw9vbMBDgoKR6KGxvrECpAJFGu8UYaPkPSMGBU+fuHcJnw1hvcQA==;5:rZ8NO/I+WhM5OGU+0XM1qxnHlCyGWMy7rEmyM9bav86i0RychSVbqjUwb0Q3uLy+Aba7muZb2vHDRR/KhJzRk8oCCOYZW7SvM2zmgShB0G0yibCbWreGRFGi0OR5kwEzE6LCift0JRjRTL5teDmF4hTLljgNqfU5Qq5TWEl55vg=;7:d/efoFIzbGH/7SzuxgHC2AMhX9BbNJEf3he9M1aNdojAQnR6Ti4FIxpAs2v40kdR98/sljQjnTFNqTxuU9OsI3dqd8wSPbScueJkwBV35ATbeTOxZSss5QL1ayFivYp83qylYEuQA5fqzxxC7DuM751mXDG9twgVlsYeMU1JiRBdpkJF53bc9OqevK999AzdHFXY2WkPz/rU2Vp67WBPh3EFdgtQpBd04ZHjz+jrFOUR4y+S6Yj8QpRl6O0A40KW
x-ms-office365-filtering-correlation-id: 215ef969-1780-4d81-bb1f-08d610d4fce5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08561405EF04E73A106585B9FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(6306002)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(966005)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7TR74AKNvSIBuFPjL95zzhMAnbOYbtxj9VJR/8AUBCz3m2JjWCP6nabTTZNXjvRVlsBxk6SRPbWrxmPAvipNQkFlO077gGpV2w9Wk7yx9ofRujGPDHgVRS9p3Y1u3iUkOiEAPU+Vl8T4teQ+1mqkp4vce0JhCQAxsAL2/V1r3vpW9cuzwzXosAPyF2SYrtSMbxiZuCeiLJAzlcEVecBnWa4issHoUm4NeD4jgVM4qlPZsT+r5nRNF1YpR9MBhZWYLoNTVDSJTMaa8Ad/jwSDUpCz5PxuJswOOSfmmfkDaKC5KybQeAF8AZVoTvXxdjMoUyoUClwO7FJ1A5CgKu7dLHxTszGeVWYPxP5EiVooDHo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215ef969-1780-4d81-bb1f-08d610d4fce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:48.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 226a9245d1db..2227ee92d8e2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -824,6 +824,12 @@ static void apply_config_terms(struct perf_evsel *evse=
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
@@ -1054,6 +1060,14 @@ void perf_evsel__config(struct perf_evsel *evsel, st=
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
