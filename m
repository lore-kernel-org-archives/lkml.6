Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED40C21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IYEbp9ma";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GchmCAxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED40C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIVEis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:38:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725748AbeIVEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:38:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8LMlB9F020473;
        Fri, 21 Sep 2018 15:47:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=/Xk+yWNFl/b0eduIDOY6YrVyJO3H6Emmm9BDzLA3CQY=;
 b=IYEbp9maMGhf0nzIscDFzwZwKFYgJvVVZVVM3OY8+aXJ0GKDmMFujmCQ8kNugiWrEnFf
 NjbaBE3I+FA4JuXDTOsEG5Y7xNqkcwQfQUYjk9W7L0/BKQNmuEhIDCCh1OdFEoyX2tnW
 ZfpDd1LbSD/1EQxxQOKU8rTJ3zjzsLRxR4Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mn7va8a53-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 15:47:27 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 15:47:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xk+yWNFl/b0eduIDOY6YrVyJO3H6Emmm9BDzLA3CQY=;
 b=GchmCAxU9EpAdRr1agnmcozc8H8QC3MwkvN/G2lXmqvIhkaK4B7a7G1AX+2q6I3j1LhQuNYa3uXjPieGt/ulcJzXlaZ76mHLPMsYRB78JKcOcttQbi7DNGznagGoRqjRTZhrvNF0PE3nCJLQSgWrOVYsfwhcOmZsqkzk9X+/h5k=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 22:47:20 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 22:47:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] bpftool: add support for
 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY maps
Thread-Topic: [PATCH bpf-next] bpftool: add support for
 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY maps
Thread-Index: AQHUUf0Nexas855OLUy087sc5sDTZQ==
Date:   Fri, 21 Sep 2018 22:47:20 +0000
Message-ID: <20180921224700.10524-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0095.namprd17.prod.outlook.com
 (2603:10b6:300:c2::33) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:19f4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0167;20:hIEhICVpJATPsV4C9AIaab8TDmxwBpqEbtJDydSCjCUd5J2+RTbZyd4qz5hfB/Aoo7stfHWET8TgLtDmcnKN/SQdpBl1ElgUdB+acNtvX4/mh5HqVvldd7c83d7Op9WiXEwOrJUnm//hv26cCZBK0KO8Qm9AyrGnmYU/ZTvJo9M=
x-ms-office365-filtering-correlation-id: 8753ef76-18a9-4411-95ec-08d620142ffd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
x-ms-traffictypediagnostic: BY2PR15MB0167:
x-microsoft-antispam-prvs: <BY2PR15MB016765EC30308B78950FF7E9BE120@BY2PR15MB0167.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(81166006)(6506007)(6436002)(6916009)(5640700003)(386003)(86362001)(6486002)(14454004)(5660300001)(2906002)(7736002)(305945005)(8936002)(105586002)(68736007)(99286004)(52116002)(81156014)(8676002)(476003)(6512007)(186003)(1076002)(25786009)(256004)(2900100001)(2616005)(97736004)(54906003)(486006)(478600001)(1730700003)(46003)(2351001)(53936002)(4326008)(6116002)(36756003)(316002)(106356001)(5250100002)(39060400002)(102836004)(2501003)(71190400001)(71200400001)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GB7X4D6GnbvQPbQZxZJnaZtuf6P0zTbZt3jTNksx/Ou9oGzwRFLqilw6oJNnJrwJYEVw5/nvVrcfhSPWz1RQwNvB3+UD3zk/Oc1iYr7xTaEq5ZvUR9l4zy4G7pjz7Bn0zj6vZk7WafnsQOSEEV+rFKUStVESvqm4Ya4pbqRP3fCU5w316o5n1H0RBeXBYrOtD4MnMwGbue59725E5IlcuJjd/BFCBTkQEv9ZayZ36s4W2CFkXVl+EVJ08W2KBB+qkhktleL/q0S20aaJYt+09emrCRh89w0a00hwE7OE8PglhEpg72PpOqzAaL5sDnt1ytjw6lcPKlgpspuok7TTwB1W/GlfgVev/OAeXf9HL1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8753ef76-18a9-4411-95ec-08d620142ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 22:47:20.2493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BPF_MAP_TYPE_REUSEPORT_SOCKARRAY map type to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index af8ad32fa6e9..e22fbe8b975f 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -71,6 +71,7 @@ static const char * const map_type_name[] =3D {
 	[BPF_MAP_TYPE_XSKMAP]           =3D "xskmap",
 	[BPF_MAP_TYPE_SOCKHASH]		=3D "sockhash",
 	[BPF_MAP_TYPE_CGROUP_STORAGE]	=3D "cgroup_storage",
+	[BPF_MAP_TYPE_REUSEPORT_SOCKARRAY] =3D "reuseport_sockarray",
 };
=20
 static bool map_is_per_cpu(__u32 type)
--=20
2.17.1

