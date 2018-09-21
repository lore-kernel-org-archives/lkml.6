Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF03C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDF21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j8l+3t4r";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M6xWvm+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFDF21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbeIUXE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:04:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390951AbeIUXE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHBpxa022957;
        Fri, 21 Sep 2018 10:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JYOEhmrInLqMDzLo03aQjealPyB9iBXIgkUjDnfYUwI=;
 b=j8l+3t4r7wWAd2sSyuHS+vKPJW0XWXcZRqi2mNEN9Ae1s5fTzBUXV4Tj988ge+HDxKoU
 WXoYgQ4Jptb14LOoDy21IBV9ZIUjU0M8HJVXHFaMeootiw5dIG9XY8pi6R+4Z+Ahg4gJ
 3LPKrgl0M5JqbedgFV6XgeH3YS9PTT0iEUw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn2g88emj-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:16 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYOEhmrInLqMDzLo03aQjealPyB9iBXIgkUjDnfYUwI=;
 b=M6xWvm+31NIOMYIffiiX3BvW+ZB9KlOB5wq8wafWxH4x3AztskE4rFYR7eQIBNi+VqiHvpPn0kfarbrxypRbWSj8uGR4MBmKj5vaP+tevGAhD94UhArN7SEVp5csWtZ0X4irtXuuMLtDcZ3HmZcocrEc0QRiouu98/4ucTQmJSo=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0327.namprd15.prod.outlook.com (10.163.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 17:14:13 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 6/9] bpftool: add support for PERCPU_CGROUP_STORAGE
 maps
Thread-Topic: [PATCH bpf-next 6/9] bpftool: add support for
 PERCPU_CGROUP_STORAGE maps
Thread-Index: AQHUUc6EI1OCi67pD06wga6pFG+r/A==
Date:   Fri, 21 Sep 2018 17:14:12 +0000
Message-ID: <20180921171353.11050-6-guro@fb.com>
References: <20180921171353.11050-1-guro@fb.com>
In-Reply-To: <20180921171353.11050-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0052.namprd10.prod.outlook.com
 (2603:10b6:300:2c::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:15ea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0327;20:YYiyWjgBVBdzHIDju2IqlKqIwILhLjlmKhOHRBRFUWGPoHowY8c9hEkGn1Mtmqy9H80RNURB4khV1D3bcgzUTLYpcMalUjHFXml8rYuxNdzFYFAeZiwqdNT8LhrAIOn/lajCWicN8YKIqFs6JqoKHQmthtZxzWjsvepMAOzncjw=
x-ms-office365-filtering-correlation-id: 032b0fe7-9881-48ec-1122-08d61fe5a6c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0327;
x-ms-traffictypediagnostic: BY2PR15MB0327:
x-microsoft-antispam-prvs: <BY2PR15MB032745EE219638036832330FBE120@BY2PR15MB0327.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0327;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(1730700003)(2616005)(446003)(186003)(36756003)(5250100002)(256004)(68736007)(54906003)(6486002)(53936002)(81166006)(5640700003)(81156014)(8676002)(6512007)(8936002)(305945005)(105586002)(386003)(6916009)(2501003)(106356001)(316002)(7736002)(1076002)(4326008)(99286004)(478600001)(46003)(6436002)(2351001)(6346003)(39060400002)(14444005)(2900100001)(11346002)(76176011)(52116002)(102836004)(25786009)(14454004)(2906002)(5660300001)(97736004)(6506007)(86362001)(486006)(476003)(6116002)(71190400001)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0327;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SDIMWc6pRQiNzX2zfn5MVEeyvm9LyvQPfhukbFbqDIB80zLFqJw0gOOTenUrjyMaxba4nQi2siTwDnz5WzbsWUfAygDTRyss9tor1qK2eSMziyv8vJ57w8Iw7DaYaiMrJ/ChgZfHfFyCzJmHwvWLiMgxFdnxnXGgYsYYrehh0CmTWhy19miDQoyn874ANCoURaggnFC1bFQXDAXxdIbz7Rl5sO601Q3fRAcCroTQXR1QhHNqk9V5LJre27BkqZvijIt/Ky4QhrIq2ZJNIj/bXNw0N05h+Racj27ebDweTYPZMLwd5vznAtZZiXXRjFV3s9dPLllHYuirM+ya9JCjuQYa1Y9YMzObImeoBEZqls0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b0fe7-9881-48ec-1122-08d61fe5a6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:12.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
map type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index af8ad32fa6e9..cb8177593a9a 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -71,13 +71,15 @@ static const char * const map_type_name[] =3D {
 	[BPF_MAP_TYPE_XSKMAP]           =3D "xskmap",
 	[BPF_MAP_TYPE_SOCKHASH]		=3D "sockhash",
 	[BPF_MAP_TYPE_CGROUP_STORAGE]	=3D "cgroup_storage",
+	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	=3D "percpu_cgroup_storage",
 };
=20
 static bool map_is_per_cpu(__u32 type)
 {
 	return type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
 	       type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
-	       type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH;
+	       type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
 }
=20
 static bool map_is_map_of_maps(__u32 type)
--=20
2.17.1

