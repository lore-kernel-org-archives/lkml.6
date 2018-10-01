Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7ACC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D312089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H81+ZdFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D312089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeJAH3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:29:16 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbeJAHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuYUfz7vyWb4si6V7ahYkimhectL9EjYQZMYUWKoO0U=;
 b=H81+ZdFK6/yaiznTU3jvTrqxRJs/JwDjyGqgEQKrMThyemKfc3ImPuAeXAIsygaDP/p37mDhmMwbYOGG9vm9xQ/4RrAiDE/hYZzJaQrnIJTIfO5dQway0gZ4dW+64P+Luc77DDqx17wH3TsyhhnppBlBkb+1ha2xaK5CxRUgv7g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hisao Tanabe <xtanabe@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/65] perf evsel: Fix potential null pointer
 dereference in perf_evsel__new_idx()
Thread-Topic: [PATCH AUTOSEL 4.18 12/65] perf evsel: Fix potential null
 pointer dereference in perf_evsel__new_idx()
Thread-Index: AQHUWR8HTjB4xWIpYk+0oHKGT+GmNQ==
Date:   Mon, 1 Oct 2018 00:38:10 +0000
Message-ID: <20181001003754.146961-12-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:X8WfvzER48xB6aOXHzB+VS6y+el+q07QS3E9TZVTPI6jwmrPBFMSH9zW2GEqai1yeVUi4hoiq4x6iS/ku7o1Sx70t7M7v+wIX4Hq0LgClVLpgvZ4o7Kw6KbKCEa8oWzzqQBfdbNMRuK42uw8ol7fTqEqwolhP6KQBdnylA15+PB9S/SMjWmJBMPvPs+S/SVnwgVfpOB+ZOipzB1bWyu5WQo4zw3gHUcS3T5RkyOZlW0ER2S/MLw0CFm5FwDQeFKe3BlJg7dCWnZUYnLUT4vZRdXrqbfZ2eEqUiWY45KfkjOhu16aylkdTjwwMol2V2+w1NtL1ScRK/wo5rWD10kt2r57VGe9OMn58VPKtWbKPcsym2bj1vc2kO28xLnfot7UbhUpiixv04TbM9SPrF2r4IMRawrg3/qGqH1n5Ruqto/lfNGFTYfd6pdJ16xegny1BqlUYlI8GDZFohZ0cq5nxA==;5:m88pf08uafGAL3NIVqq5ZyA4WDhdpZ5r8qZ/c4vGV4fiJIdh+HGm0ZnowFP++EFwpnnouHj4G2LJysRF4cfEC0PMM+99JWKqtph1PcQjHKwCe8QUfF57TAeqqC2RUVAAS2xVqxFZY9enRKy/TltupAnZwJQxuIRDwb7IhpKxPDw=;7:O7E4Su5sLwk/zelzB226bqPSKNloWV6IqJP7A/4JCiTscijyzO0bUQMORjc+k36CAgHMyo9u4Sy/Z1l9c9AW3QSVn4NAPAw5MxSd/7zBWLo5L29uGuUC0FTWzw+hbivOXqV9GwSkC4y+3IrWsfjZnnJ7sUR2EQ/AZa4lBK74IzA2iOkkDQnQqUpNBTY/culSY2y7kkwc2wS/NE0YAYnoNM9poTqbdYJrmSgSrtZdZDqoLY6zFvZ2wU1eKvVt1hFs
x-ms-office365-filtering-correlation-id: 813f3298-64d7-4bf4-0ba8-08d6273629c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472E8240995753D8B80BC8EFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(42068640409301)(84791874153150)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(966005)(6486002)(6306002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(39060400002)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ohF5CRzaDkLue8Q4nF7diHL54Grwo2JgPhuzl6HIKn6J9NHexTd5qHuyVeG3gqF4eCtsWgX0fYTAWQqG8P3eG2fI0oP2UMFRDS+Z5zlndAHtb8b6S+0M5m4HhxwN1yK/lRwWMY6GXIFSRBiYo3DTTlEakuOsm3e/zU1ySQ8lguF8JU7C4qIAcfG/NvBNkTIVStOVNFcGFKUrY1y0c1BUKpTtKtbB85NscSR5MIVKgalx9QPglm9WIUTcYS4+kpjFdkY3tavJG0ms5GSy7D5bh7ed9/GO7JMeOu5OqJO4HJAz1Xf/uV3eZ4REmsb9y2yfLZnAVV9QmxUXyJULHNR7zbxz5DHpASG4bZscr8mZY9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f3298-64d7-4bf4-0ba8-08d6273629c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:10.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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
index 0d5504751cc5..6324afba8fdd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -251,8 +251,9 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_even=
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
