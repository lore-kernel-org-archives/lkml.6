Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F0C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CDE2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hbb4bo/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CDE2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeJAHO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:56 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729474AbeJAHOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cje3SSpBzDOr52z7pi4uNnzV3jIzuhHRj5A8e8fZ8A=;
 b=Hbb4bo/+N/Dpq4EH0NEttFVsUJTovbEOfTvKCuCjWE5H4UlGFxxoVGyosQo2dQVnEHMsyanrhjSIdUBRVVJ5XW3WyJpsxxzyRJE+zY7HwfdkcdKpoqi+GoOMH655KXDoWdYY/EP8aRS2/Lra0cOA/jOekSLcVfNjqkDtml8YwTs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hisao Tanabe <xtanabe@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/37] perf evsel: Fix potential null pointer
 dereference in perf_evsel__new_idx()
Thread-Topic: [PATCH AUTOSEL 4.14 08/37] perf evsel: Fix potential null
 pointer dereference in perf_evsel__new_idx()
Thread-Index: AQHUWR8kqdMKwcGodE+VTCzSXo39zA==
Date:   Mon, 1 Oct 2018 00:38:58 +0000
Message-ID: <20181001003850.147107-8-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:HBSQyJ9RrRX1oaPb+uQXn8MhicdKc02ojl3YWJ/99nGbWaL1TXNmYeigWfQ9qH1dV2MWbXiRduMtXDe/sfdfQt15/zHYtSI4Bm4mvyQZekuz5eHdE9QJu3YTE4+lboI8tXiDtZK/RI9ngXmTH/zA5KFlUIxJWojsRwChn9morem9PsPXNYDqscxIVZ8gVLX3qgMOJd3wnw4lfylDXMtwwS8dqEO4wd1wEKupLT6n0NU7vs32HGLIxq3AVqFyOoebE2ebHqZdpAMh29njGpoND9fpoI5i1fDgU5ZEc8InnxNj5HZo6wLNRZT7ycjqKNpJZ3J6uAP3ZziIQxp7FKxmEmwBVxe8qee9QyYPhlJ9o+4QQz9f//8fiMvlUhKfTYByG21fdIseJftj3zTdlYSUQ3kR2bBCCqUE6J7uGseXFEtD3E635MUuDnD/q+PHoQhFdYPjTmvNTbKQuLxWTCj9hw==;5:eDgr+OkQfSPbpEu81JP4a9NXYREgQ0umczRZgC9SbEfNwN0xF94Iz2CVQKkcS6aHUq79ySJ7KFqO+sNz7wSzIw+TuYVd7u9raE9T5I4VsJj/9casUpybR7jErSYsG0UENOT80//+Epko5r4+X9cX6fLDl8uykLgkgMFbh58+J9k=;7:w+YlMQHRYUMv7oli5ZxxRLCXVqh5tGysnlGp7FZSr9CgQNssHVoGGGKWP0xK6dvwoC6mpBN/DF4Ogz3OhgogHUZAn+XNGDUdc1hsLi8pNhjoLbkGE4d4rfADe4oRfr5mMHOcRxnZ0lHMt3OzbYwlpizaexiIDPqglIVJHCZHEpObN3tclWRFsPS3VdePVHVNGN5ezm+yuznQvHBvJWq3uLoFM48LnoJlWXdExKu85RhaezJQ4ksWnjyNeKz7oMQp
x-ms-office365-filtering-correlation-id: 4f6fd0fb-e47a-400b-98ed-08d627365fa8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06963AC8721ADE64F147B0A9FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(42068640409301)(84791874153150)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(966005)(99286004)(11346002)(26005)(86362001)(39060400002)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(6306002)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qmJLxQ2cshphGpjpOrKilE4KKDkuLd7kaDRmsmR4u6UZsgTAE60O3365Jp7l0uOjEpQxQMkQV0HYHobzvUDadLZJ0MzJQigb9kum8GaOARzW4dOE9nKWtwOLRsPndrxKeLV5+fgpfR+DKg+061SS/ZG/m5VyBwZpd0oZcOvUfjgdo9akOctfBwxYuGAcxx2lPjCCgMm4AEAKtgakwGEbpNZEWyoNjNSL9aux7s5NKami6eECwfGzADzCmOqbTKQ0cuAwGz9t2JOM43ki76OlvyedMt+SabhZn3p4HP+iyQnNxhjZ/qWvckfCs/uBWwn9Ip9VO1PsUvbmlp0Az5Xt9kMgTDbNKhMNA0zA9pUpuA0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6fd0fb-e47a-400b-98ed-08d627365fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:58.5007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 2227ee92d8e2..44c2f62b47a3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -259,8 +259,9 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_even=
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
