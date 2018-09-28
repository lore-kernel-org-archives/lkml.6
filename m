Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA620676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J+AWzi1/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jKAT8pV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AA620676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeI1VKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbeI1VKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8SEg0NZ026360;
        Fri, 28 Sep 2018 07:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DKQE4KaoSLggjrHH9967WJphq5XJHmVguXKB3c62xfs=;
 b=J+AWzi1/x+k1VJKr8Rn4bBA3Pzk3HAFboqDotKq+Hy/vVJ7IzQGb+uxwSuAp+1Hb1fh1
 2pzzOvz98l0MdmtMBAbgKE45z3K/RhYJkJLdLvujeNtiIjq64hD60nycLm3Cg5nYai4I
 13eLHR/7lDDVzCeUeeATk71adYHLz5vrRuk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2msp2xg274-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:12 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB03.TheFacebook.com (2620:10d:c081:35::12) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 07:46:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:46:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKQE4KaoSLggjrHH9967WJphq5XJHmVguXKB3c62xfs=;
 b=jKAT8pV6VeHcFWYCkVMQinMRPUi4SAa/K3sviHfoWUvhq2uYtQdt4TFlS0GV0oSDGZerEE1vJfLb4L7vWQ2UE+gzGwSYcjo1rC59gU/OgqBhIg6F662fri4I1rQYszOsaLn6s6G+sThgv+Xgcao9jFIpcwFICxkRuPnz0MzR0P4=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:48 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 05/10] bpf: sync include/uapi/linux/bpf.h to
 tools/include/uapi/linux/bpf.h
Thread-Topic: [PATCH v4 bpf-next 05/10] bpf: sync include/uapi/linux/bpf.h to
 tools/include/uapi/linux/bpf.h
Thread-Index: AQHUVznxk60VuDZ6NEyBWLXhxaUURg==
Date:   Fri, 28 Sep 2018 14:45:48 +0000
Message-ID: <20180928144452.5284-6-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:ObUaoMnTtvfzxj0re2rTfNB8cIqcJjH1Xpk8wjfuON8rSD8wUJJ3aL2ZnC3tlLnsnQa0jF472Ya1xlds8MuWF+jb/Vu/iaOue2Ik9uRbL+8WJtUJgisXu/oy2sKWggXimwaRlR3ypOSQ/os47ceVF4v00N+06xWScAr8xbirHCs=
x-ms-office365-filtering-correlation-id: 464867ab-1007-4158-c4cc-08d625511428
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB04532C9277B043FD8B2245AABEEC0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(478600001)(34290500001)(1076002)(476003)(7736002)(4326008)(25786009)(5250100002)(36756003)(6116002)(68736007)(305945005)(446003)(2501003)(46003)(5660300001)(14454004)(54906003)(486006)(99286004)(86362001)(316002)(53936002)(52116002)(6436002)(105586002)(2900100001)(6486002)(76176011)(14444005)(256004)(6916009)(1730700003)(102836004)(8936002)(71190400001)(106356001)(6512007)(97736004)(2616005)(2351001)(81166006)(11346002)(81156014)(2906002)(71200400001)(5640700003)(8676002)(186003)(6506007)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1jEPaEt3D5kUzJyCtIhD6zgJ7YWYyUZKmT/axiG59BwMYZG5t01WeyBNRPb/nnlX1I6+QbT05z6l4Fv9A8qpstmjeM664OOx0SAA9LqaBDs3bHO4PhigenD0aJ0ouYM2vwuFZgWQjoxDkNqpHr+MNoAScih4xmXhz9HleDKJV/X/uaiaKEwYUtm9jJex1Qq916I5Nbu5xHsQgd22kxItATbTBzLilkczIjy/YQils+Dlj8pa5J0x6rT4k7RJ5IXWZpxbOSkziQfAlZxJO2qa6za2nHEGN/t/Si7LruKL8xpxWW9ji3H9ruNoTtmqHmT71FhAck22ZcobIhFlsVyoHy5WjEQNygN8+pBxW9Cf26k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 464867ab-1007-4158-c4cc-08d625511428
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:48.5252
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

The sync is required due to the appearance of a new map type:
BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, which implements per-cpu
cgroup local storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index aa5ccd2385ed..e2070d819e04 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
=20
 enum bpf_prog_type {
--=20
2.17.1

