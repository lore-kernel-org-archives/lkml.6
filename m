Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FDECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6704321568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MBhiLhQ3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="POa59e5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6704321568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbeIUXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:05:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390891AbeIUXE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LH9K5j022561;
        Fri, 21 Sep 2018 10:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=llpyVK8+ryi5pVZjPNAig/m3fC7f+jG+/JRGh9yV3ts=;
 b=MBhiLhQ3PgPm1hkiY7LCXsbjubwOZy0zEzTNxKdUzFNRB3a8JE3I5iO0EptG/XH0iocz
 zAlsAhLcl2YyINRr45u3/LGKR0yWR7w/paUaGXQ6VGmCucjWc1IWXsYTx0ye+6hsRCJe
 vYzd5fdjs+C9kfF2AYYCTm40Idt4YnXuoy0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn1fj8kwr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:16 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llpyVK8+ryi5pVZjPNAig/m3fC7f+jG+/JRGh9yV3ts=;
 b=POa59e5ZTwX5wltSUO71of+StsMGjnOfsUiLD3Ha2kx3x8n+fcai/ris1ambVIHtVFkrpe3/lZoBjUhIsWsiVgwWuOp1hFBTx1txmLlweShSucPmA0b+wYFy5tO94OUoQg8KYIm1k78ON/zLIpB0dVamdlt2AghxB9+EGXJzmDI=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0232.namprd15.prod.outlook.com (10.163.64.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 17:14:11 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 4/9] bpf: don't allow create maps of per-cpu cgroup
 local storages
Thread-Topic: [PATCH bpf-next 4/9] bpf: don't allow create maps of per-cpu
 cgroup local storages
Thread-Index: AQHUUc6DsXzphRdnBUul4Ah4Hr6Peg==
Date:   Fri, 21 Sep 2018 17:14:10 +0000
Message-ID: <20180921171353.11050-4-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0232;20:ApdlnXl4dUnaePrpg+bioF1UAsXDJK1CFfjwCijMTCbMbLNbbulUNEnIgfwC0QPmj9q7d4A6OCK12zHHEofCySOfFHGOqHuMe29Z4Vav8upfmUM8US23akWJieba92C9BoFX/tG6i5H/q19ekKWwNyYGxK6pDzOz8CeOZiuDd5c=
x-ms-office365-filtering-correlation-id: f870cc57-abb6-46fb-a54a-08d61fe5a576
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0232;
x-ms-traffictypediagnostic: BY2PR15MB0232:
x-microsoft-antispam-prvs: <BY2PR15MB0232A531F5FBC826DDEB7E8FBE120@BY2PR15MB0232.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0232;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0232;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(386003)(5640700003)(14444005)(186003)(86362001)(486006)(6512007)(36756003)(99286004)(256004)(6436002)(6486002)(5250100002)(54906003)(6916009)(71200400001)(71190400001)(2900100001)(476003)(11346002)(76176011)(102836004)(2616005)(52116002)(8676002)(46003)(81166006)(305945005)(6506007)(106356001)(25786009)(2351001)(5660300001)(6116002)(97736004)(81156014)(53936002)(316002)(2906002)(4326008)(446003)(1730700003)(1076002)(478600001)(7736002)(68736007)(2501003)(105586002)(8936002)(14454004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0232;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7w+RAhUC9+3DgG/Ma2IowvIg7pI2Lx9kxEXJNI45qFxsQaB19TxTYNIC8U6kWmLQgtDbqrB9d9polDIghsJY9NLKgPCGqBp5t11xRDB3oIJg/ZbU1eLTVqwEeE5ssQ4bQq3LnsBSMnPRW4c2/dhjo4uMrunpZdo6E2d8uokbk/mV5f8+P8E+HpawjGcyBkghPKawdgZJhcq+rq2JWfVHkL9J+pco/lW9fRAykbuMVRfoaHRaogj8rX7OwEICwzqPIQi52293Wg9UvK3mIUBBKB1yYR17q/GxVjtZNQr9xXuKaljQUoYgpcB0jg55hpoVRDpER9kIKu1Da+rMriu19aSyzcv/n0YsuNVMXi1IY1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f870cc57-abb6-46fb-a54a-08d61fe5a576
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:10.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly forbid creating map of per-cpu cgroup local storages.
This behavior matches the behavior of shared cgroup storages.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3bfbf4464416..99d243e1ad6e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -24,7 +24,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * in the verifier is not enough.
 	 */
 	if (inner_map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY ||
-	    inner_map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE) {
+	    inner_map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE ||
+	    inner_map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
--=20
2.17.1

