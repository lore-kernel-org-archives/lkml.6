Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C19C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1216020857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G/1ENkt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1216020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeIGFQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:33 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729874AbeIGFQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZxAV28Fr6edep36A1xcUJ5pV30jZi8cF0j/pP9quN8=;
 b=G/1ENkt3bC5M91ugRix5Tj3RYs9gzr7BrLgophuBLw8Qu44TTvoLNQHyKacvG+W4Y0tN0p0mCR446otttPi1qs/dgjUbwRMNt0g9tBwDkvim8OpP6qlXj0hsQH9e/RLcyfzbGTPvlG9DBtR32FOP6naKK44lGUUC516ASUhAV8Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/67] perf tools: Synthesize GROUP_DESC feature
 in pipe mode
Thread-Topic: [PATCH AUTOSEL 4.14 28/67] perf tools: Synthesize GROUP_DESC
 feature in pipe mode
Thread-Index: AQHURkL7y+B7vuhlzUGNza+w1pWlDg==
Date:   Fri, 7 Sep 2018 00:37:39 +0000
Message-ID: <20180907003716.57737-28-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:SNQK3bCBdXzoBSnTWHbtKNziXHHqfFgOL3HHuJ55vkh8jDlELqsJaToXKRIufxDmv9nopqQvKw/mZySUt6u3nkBwgESTDMTEIx83DJaBVsgWGLFRsiDVxEXBrJzNmM7fNZfWtgYCb3Vq7myCd5cTECYjz7gricaD99QLOuIEbTjQGB7vOjCqNfzLhqc/9V7obMprmd94xxiq/+7+TWebsdJMSHRC+lDczAkuKMAWNM1HHbu8MlXhzEpqoMSxtn5EUEsVMuHOB/NADzewTnNYsWFkW+qpHYUWmLuLArWgbaGitcRKUQGbJ3lqw6ra5m0MTdOsx0DO7uzdoDCQ3VTPOsY0jXeVaKJv5QpIUZO/A+6E1UALX64uTu/a3U9Big9O1BUGFiOKH4U3JowTHQBnx89v+JO6PA0v5Q8vCBAQC90AGjYV8OtAe14yZV/z8QfegW1KXYkfF+AVsPGvCuveJg==;5:tI0eDqx9Jc7/9zu8EBVjD/YjhtWyz1UeXSMYh/6D2DAsbdaUTdEyoGvMOvcHJ5ljyaFyus/GHBfPDDQSiBcS18didOWtT9SWUnlV//fXxlF8VuB5EppYJ3tq4Z8xD+2Q/cetDnTDFTqE6kstVmVbTvmwYSc05v+JE8q8WkTZk9I=;7:60n0i7jQ8ym+OTTYfnA8QW+EEgYoZw/AYPX016UOWc+kU5Cn4SuplSw2aAXOiw29S1/Qm1l+ygthNAFFxAydLnCf0KQ4uz/hztDrNLDbQDjB5enrk9msc7rb+P3n1wL7tbdNySSeovnKwukIwCKAe26NyF3/a7cDBEmeG6xSICVOuvh+z6u/QTMCjnhPFHF3s1F/2oZllZQ6XiIDQ5hILEhjQSzvKIzPydJmW3yZVQxycnxsBHNDLuRR2WrxlqUz
x-ms-office365-filtering-correlation-id: 1567fc12-ceff-4763-bf27-08d6145a37d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840CB98A03B3B3B5C6435ABFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(6306002)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(39060400002)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(966005)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Pz5bSUz4NxeLWrylFRkxM1Y22CvRBUaA4vJz8B8I5/uou2zdlUvhdnx6JGRRIVArX68CJ9U4EVLwPiZIkrM2z22C8Lxl5XLBDYRDI2uHiOc9U9p3wTzlqZIJ0o5D8vFfnIbu/sxzG11jBpBdWhJN8vowNUqQ75Z0aBE2kegE9erAMyEEu8hWmVO4cL+0pKFgUFHcpyrDYL9IeOPnBICmc8G6Tp2wnkaVN3aVOy6pUR4QslKgtO+Pqu+F2LuDXyEpPlzRb+uacr/228fpEQaWcRcrK0wim5ZqsuDI6IcJgRcJUMYDsCu6pNNafKyRdbh9PAmx41VGycNT+lXhiLuL0WlzjbvjSlfnNszQu5Isr0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1567fc12-ceff-4763-bf27-08d6145a37d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:39.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit e8fedff1cc729fd227924305152ccc6f580e8c83 ]

Stephan reported, that pipe mode does not carry the group information
and thus the piped report won't display the grouped output for following
command:

  # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf repor=
t

It has no idea about the group setup, so it will display events
separately:

  # Overhead  Command          Shared Object             ...
  # ........  ...............  .......................
  #
       6.71%  swapper          [kernel.kallsyms]
       2.28%  offlineimap      libpython2.7.so.1.0
       0.78%  perf             [kernel.kallsyms]
  ...

Fix GROUP_DESC feature record to be synthesized in pipe mode, so the
report output is grouped if there are groups defined in record:

  #                 Overhead  Command          Shared    ...
  # ........................  ...............  .......
  #
       7.57%   0.16%   0.30%  swapper          [kernel
       1.87%   3.15%   2.46%  offlineimap      libpyth
       1.33%   0.00%   0.00%  perf             [kernel
  ...

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180712135202.14774-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8a678a3d5a2a..1ceb332575bd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2209,7 +2209,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_=
FEATURE] =3D {
 	FEAT_OPR(NUMA_TOPOLOGY,	numa_topology,	true),
 	FEAT_OPN(BRANCH_STACK,	branch_stack,	false),
 	FEAT_OPR(PMU_MAPPINGS,	pmu_mappings,	false),
-	FEAT_OPN(GROUP_DESC,	group_desc,	false),
+	FEAT_OPR(GROUP_DESC,	group_desc,	false),
 	FEAT_OPN(AUXTRACE,	auxtrace,	false),
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
--=20
2.17.1
