Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B6C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D02064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RenjQTgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52D02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbeJAHPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:49 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728940AbeJAHPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia/BcGkt7hX8MoQaVtvYMRcxkJu4tiDiUCspHs0Zwtk=;
 b=RenjQTgi28aZgdfn9vWx6XUX6BUMTWt1Iu9Wzj+3iks5McV0YTqgM4Gg6XIi8J5EIPxDfQxL0xLAWOg/znphQoTMAphpy0iwezhIQLg9bQq43s69JxVT3wNmP3Cpov0hXJS+U9Ap3CTXh7brS0Ld9tHwHLgIbuLFjR15LRMGIkA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hisao Tanabe <xtanabe@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/26] perf evsel: Fix potential null pointer
 dereference in perf_evsel__new_idx()
Thread-Topic: [PATCH AUTOSEL 4.9 05/26] perf evsel: Fix potential null pointer
 dereference in perf_evsel__new_idx()
Thread-Index: AQHUWR9bMTnQVguBvEOmE8M5uX8iag==
Date:   Mon, 1 Oct 2018 00:40:32 +0000
Message-ID: <20181001004026.147201-5-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:EDitpg6YvPf9gsys79EHR75pEv/8nGmSmMBboBKqwWJKyzNGv2KyR+hAuk3VJD2M2U4V6H1HPfTEjwr28JLfFgPlA8lBU4z3rgp1LE6fk5xaCd+nFuxHuCNzJRPwjL+6NDG8XOasrRn1qY3oalX+cCTOAE6+hoVUA32PsTBilGh3IZ5kxKERLsNO4t07n4nTxxRYiqSIQyf1ynKP34Z4ncyBs7KYzulaAu0/DxjClsdRjVuRgVElE1VcuD7VmxV1Cd/zmJNZIjmM4gmGXusbyCoGw++F06SG2hEcktkhpV5j/Sxeu7JhyQ7BiD7+pLisByakepjFUvflOl2gYcoMi1KUG1UVo9xL33786bvQh7+dqscOzbvLGS1Oe8S/YktEZkS72XToXHA+EbX697e6STM3vTyTqFBUp6p7R08mz+UrFOA0L+Q3bzfOMs9oXJ9D5SjU6x63Dn5rzGOuAvN0Yg==;5:Ejdp4Z84x5S3ailA6DGeUNstCw16rCUs8KCHnyPAF2LikqX4JY/Du9o00ezWzBKmqi/jHz1lihoUU6X5kuwckV7fdZaE69Q+josxNRGMKJkqUccc5yqnqyMUaZ9HUPgzMdkNNant8skKHzHdlWML7OqOaH/nVuqua8nYFE7AK64=;7:JqQezUEhrMuZSgNESbjrF2BRBRVO3aaeH/0PWYpqoDEWcftmQOVP6Zj5OIaHiKAqxmIY1AsJoYWsIM34fUxm6W5VenO0RSUZQWM43kTWRCMOakm7iTmtjdYr66eUz2mv81fHRIw4rf3w7T7S7GzAVr7BMI5yE5Uz8yKV9b2oFFI0u6hRxDOedOayGJSFEeBCzXc5t2MyM/tnZs2i+W5CxvG37GvFIbB+olyO4wO1vB4TZoxMymiS3i83spRs+ipH
x-ms-office365-filtering-correlation-id: 14c8406e-8f97-4efe-f9f8-08d627367e89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120AA2E898A6FB3F168F4F0FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(42068640409301)(84791874153150)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(6306002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(39060400002)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(256004)(966005)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: N/ducBmbaT9s/hOqycDKg4npykkvEylh4Ak3tI+eY4RhOl4MFIma+HxFPevh74cSBuDuVBWRmBWGct29oOSksuGsI5Ph6b44eaBuMWukM5oer1nvByhfx5idpa45Rw2IozQ11AV95GruEhysnU2r+vZ7ugv3TZTDkfCQCEJk0aXV+gmH/VwU4OVpacnKHfBc/tzA8lWSjVaOmMRnSKuoDi4gXexOK8glUz6ttRmjIFZn70e22fotQ3JbuxHYwT1bE0EgwSYLLV4VI6uWFfYd/fdhe+6lpsSWldnvUHhI14ruKX7K7nBENxE6fiCgiZaYYqkjlW5oryEujkUXswJnMs7JDN/vkmzjx1YRzlw8koY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c8406e-8f97-4efe-f9f8-08d627367e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:32.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hisao Tanabe <xtanabe@gmail.com>

[ Upstream commit fd8d2702791a970c751f8b526a17d8e725a05b46 ]

If evsel is NULL, we should return NULL to avoid a NULL pointer
dereference a bit later in the code.

Signed-off-by: Hisao Tanabe <xtanabe@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 03e0a7df3efd ("perf tools: Introduce bpf-output event")
LPU-Reference: 20180824154556.23428-1-xtanabe@gmail.com
Link: https://lkml.kernel.org/n/tip-e5plzjhx6595a5yjaf22jss3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f55d10854565..3be8c489884e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -241,8 +241,9 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_even=
t_attr *attr, int idx)
 {
 	struct perf_evsel *evsel =3D zalloc(perf_evsel__object.size);
=20
-	if (evsel !=3D NULL)
-		perf_evsel__init(evsel, attr, idx);
+	if (!evsel)
+		return NULL;
+	perf_evsel__init(evsel, attr, idx);
=20
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |=3D (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
--=20
2.17.1
