Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599520676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aYWnSIm6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gfGmRK7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599520676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeI1VKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729541AbeI1VKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:43 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8SEg1o1026366;
        Fri, 28 Sep 2018 07:46:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yGKR59tOf4fYvMRDOzrrTTFEfyi6E6WueGxic9GJKd0=;
 b=aYWnSIm6mAi9ShC6YH3eAYrin9uM9iFFP58T5eHtoFJuIzuLpHliXRzFZhIqkBDVoI8W
 zB0un7NhRQOPSCY/M62mobVZx+OAyE9nr/ySf4EWbzqXUARr6eDon5DE9rFYro6Tsiqv
 hIAdjqLNMO0QNmTq0q2iinNlzo9x55PPx5w= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2msp2xg27a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:16 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGKR59tOf4fYvMRDOzrrTTFEfyi6E6WueGxic9GJKd0=;
 b=gfGmRK7QA+Pos5U0xB/ygfpAxVlbexjm9+QpVFJneWhwexvu8onSZOK5JVmJ9QayT4i2ZIcpwRt2jSpTFVtFtX/XXCnRAPRi5TfcUxU9/dZkMLdgbAOXqXB6l/AVhUSQsaYjeYhJOhfA5rLmTrvo0J8NRqlXvGbfpHbKnZFO/Bs=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:51 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 06/10] bpftool: add support for
 PERCPU_CGROUP_STORAGE maps
Thread-Topic: [PATCH v4 bpf-next 06/10] bpftool: add support for
 PERCPU_CGROUP_STORAGE maps
Thread-Index: AQHUVznzP975m0AntEGzF3W3ZhUoDA==
Date:   Fri, 28 Sep 2018 14:45:51 +0000
Message-ID: <20180928144452.5284-7-guro@fb.com>
References: <20180928144452.5284-1-guro@fb.com>
In-Reply-To: <20180928144452.5284-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:209::35) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:180::1:8a29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:YGea4OwvjUK6fCbaJ0Pd4kM+cMXCEhwhMdUJdHEVgtg3xk0d/T/OQcZFILAWBs7imVZXmM9RdbxyOoei46+eNN/ysmiP66IW7uKCA4m9wZp4M7uEl2jPApxGH/ePKPUS2jX5tXuX/aeQnVyBzNSwplmD0VxTG5JmP2JIttmsVV8=
x-ms-office365-filtering-correlation-id: c9895ee1-dad9-4171-372e-08d6255115a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB0453DC7B2725740833ADF7EDBEEC0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(478600001)(34290500001)(1076002)(476003)(7736002)(4326008)(25786009)(5250100002)(36756003)(6116002)(68736007)(305945005)(446003)(2501003)(46003)(5660300001)(14454004)(54906003)(486006)(99286004)(86362001)(316002)(53936002)(52116002)(6436002)(105586002)(2900100001)(6486002)(76176011)(14444005)(256004)(6916009)(1730700003)(102836004)(8936002)(71190400001)(106356001)(6512007)(97736004)(2616005)(2351001)(81166006)(11346002)(81156014)(2906002)(71200400001)(5640700003)(8676002)(186003)(6506007)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3gQfPxCE7mauROWF558loVJV+WgerLW0JGI2zdb975ia3xJ6gLnAa7Kr8PkgMsHlF5o42N9zyPlidI/msF4isdzQYknioR25OJ/4bmn2H9POtoeOyOIRS6LNwdWctTxxyIaH7JVj3seh7eS6M3jTYw64DzocHRGkhslGqIHZbm/AMF4zJ18KPXvC0rHaDqJlTymdQYyexfSxn3K2uTJ7bEaNS9Ay+2Omar6MdVpBk+Tww621cWtBCQZxCUvSus+Q3iatLvJrd41SWh1cZtn/eqpX1jwJsOWxqVGXi0/4Ophv8kODGIyb7fqijfbU3wisJWREBl8Vvx/4GtzBTZlk2aGoXbX1+KAVcg/ybGekOjE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c9895ee1-dad9-4171-372e-08d6255115a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:51.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
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
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e22fbe8b975f..6003e9598973 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -72,13 +72,15 @@ static const char * const map_type_name[] =3D {
 	[BPF_MAP_TYPE_SOCKHASH]		=3D "sockhash",
 	[BPF_MAP_TYPE_CGROUP_STORAGE]	=3D "cgroup_storage",
 	[BPF_MAP_TYPE_REUSEPORT_SOCKARRAY] =3D "reuseport_sockarray",
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

