Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F80C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4BE20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ov96QXZK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KUca1P8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4BE20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeI1VKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeI1VKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:18 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEhNPP016456;
        Fri, 28 Sep 2018 07:45:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ujdyUgCT1umjLNchBwoaYWRjaGC44CVDnEoGdfhqCl4=;
 b=ov96QXZK5Jn/IzAUqX9XXy3IUW7YrAjbzKbe3AU+YkxijLXfRP+itDgyfKtL0QRbLHpN
 k9g2QdIuH+jSp7sIVxg5imilF/pZHWXMawAwubohIENV1McCw2rZpfT4+9fiOtj55Agb
 iSThf0RJWYra8IseHzosqU9dgiWbyoCQCgQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msj270u7y-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:45:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujdyUgCT1umjLNchBwoaYWRjaGC44CVDnEoGdfhqCl4=;
 b=KUca1P8O9lxsIzxgMM9BPZdPTT+uIVoNYAAeltJ1t9Fl2Omf04SrLPcQgsnvoCryKk7kVQAQSazB7K1vhqecCr1ux9sft7FMdSwUkNdobePJ/MPPjjGwQqFU5gYJdPJHEHGDTUjZFh+HWywGO9rL5yPVCaXnJex9AjozX3LgIpg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0887.namprd15.prod.outlook.com (10.164.171.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:46 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:46 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 04/10] bpf: don't allow create maps of per-cpu
 cgroup local storages
Thread-Topic: [PATCH v4 bpf-next 04/10] bpf: don't allow create maps of
 per-cpu cgroup local storages
Thread-Index: AQHUVznwD1ZT/vxBZ0WS+Rve/qGrSw==
Date:   Fri, 28 Sep 2018 14:45:46 +0000
Message-ID: <20180928144452.5284-5-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0887;20:WcyS5PoemL5QKv8f3ivjyAv1FKjQp/Crwt5MWTvbJlOAQarMpdrdD/gdKjrqvo5X4EF+sa//dGAbhMM9IIbLOJhKlawebbUCDUqA02jaTNw8vgmZPF/ftLE5Idjk5k6K2FYB38GnMlm85D+s/GWHL0LK+YRuISRP6oGWCqtzV8A=
x-ms-office365-filtering-correlation-id: a7b72089-d23b-4333-2c60-08d6255112a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0887;
x-ms-traffictypediagnostic: BY2PR15MB0887:
x-microsoft-antispam-prvs: <BY2PR15MB088784967D74E55A8AC167F4BEEC0@BY2PR15MB0887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0887;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0887;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6916009)(476003)(2616005)(5640700003)(6486002)(7736002)(305945005)(1076002)(54906003)(6436002)(486006)(97736004)(46003)(53936002)(6512007)(11346002)(446003)(386003)(6506007)(2906002)(14444005)(256004)(5660300001)(76176011)(102836004)(34290500001)(86362001)(52116002)(186003)(99286004)(6116002)(36756003)(71190400001)(71200400001)(8936002)(81166006)(8676002)(1730700003)(81156014)(68736007)(2900100001)(316002)(4326008)(5250100002)(2501003)(106356001)(105586002)(478600001)(25786009)(14454004)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0887;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7oXnNgpWWnsmvCWBdpQIcKk0MKL+qPvi0hmbIZlXAw9sG8PEarMbpdVLKAnW2ZOTHLTVfENiIPt+/I8kUTUUdcsVKQKNA1ZR3UK9hIeo1p0nWCGYfpOibZ8Fay79umzUIu0egNzcYmgZab5nMpRWwzXj9nfOpvSwpV5WjdUn8utK8O+XAXxPW/t3UJTEemqdvWRwh4j/1QnivrhcEa94n2QAAkgoC2a5poCLEAEciKOSNfQ9sE8cAuSpS139MLknMiLrvDPPYu4HWkLf29VjvVAmXKiWTTt1+mntHy57GObSFLrCaR/72DeuiAKXiQv4rNc9MOnHRLcvK68wCaoGr3hVTtYnTAQFZt6OHz6lspE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b72089-d23b-4333-2c60-08d6255112a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:46.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
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
Acked-by: Song Liu <songliubraving@fb.com>
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

