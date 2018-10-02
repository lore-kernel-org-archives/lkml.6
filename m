Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C1D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cMD8ZPsK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="R01rnpVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C1D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeJBJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:22:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbeJBJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:22:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w922cCUg007812;
        Mon, 1 Oct 2018 19:42:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Nx5fSvtqqWBwk3aieoK1Q9Kynczj7Jw12EmCniBjR6s=;
 b=cMD8ZPsKIiWi2+EOf16+CLKFHQojosT+zBEDuKlLSg0K49rAt0mAFMex051elIwYLpSs
 3I8ipGIJN0CxSPA0iBaWWMlc/CEe3wEzkZNY0Twrdb+NMiGQgafbhbkNKnUXEykpu/L3
 o8PqPlTiVQuRRB9w++wHGxJ1M7IKRoihQDg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2muwd0gd8d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 19:42:00 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB05.TheFacebook.com (2620:10d:c081:35::14) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 1 Oct 2018 19:41:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 1 Oct 2018 19:41:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx5fSvtqqWBwk3aieoK1Q9Kynczj7Jw12EmCniBjR6s=;
 b=R01rnpVOy0sj1hjoNlrkAGhfP1ENE2ism4fUtVS9B/d28dLqJfPzn/U36g65U7M+hLXyF7IWP5C1x+1X04ktEIRNw8/v0KLZxUu3wpzF9qPrf1XF2iKt/m9N2hWKowK00wR/f6nGUjyT+9x03KaazejC9wXNe7LbKEFR56dR1fQ=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0277.namprd15.prod.outlook.com (10.163.64.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Tue, 2 Oct 2018 02:41:53 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%4]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 02:41:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: don't accept cgroup local storage with zero value
 size
Thread-Topic: [PATCH bpf] bpf: don't accept cgroup local storage with zero
 value size
Thread-Index: AQHUWfl6kgLxB4tIGkCQe79tcsX4iw==
Date:   Tue, 2 Oct 2018 02:41:53 +0000
Message-ID: <20181002024003.25635-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:209:15::21) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:180::1:620c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0277;20:s5I0f+9xht41Oe8tmGOcckNiw4uH1834uiJFj2VTHupTBk9hNb/Q82X1A36u3TQNo/rETpkQGzF+9ka+y+/9imIinlrbxJ6UUiH0tWWWbRZpVnbzd0kHGKTAGQbmT26FXYF1VHbV6AKJbMYPti8tiR0h8+LNxtgZG9K0anz3yeE=
x-ms-office365-filtering-correlation-id: 3759ded1-f67a-4861-9147-08d628109c45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0277;
x-ms-traffictypediagnostic: BY2PR15MB0277:
x-microsoft-antispam-prvs: <BY2PR15MB02779C99B7D6C8825CFAD897BEE80@BY2PR15MB0277.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BY2PR15MB0277;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0277;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(86362001)(6506007)(6436002)(99286004)(1076002)(71200400001)(71190400001)(2616005)(68736007)(486006)(476003)(105586002)(1730700003)(106356001)(2351001)(53936002)(8676002)(8936002)(186003)(5640700003)(81156014)(81166006)(6512007)(54906003)(4326008)(25786009)(6116002)(316002)(7736002)(46003)(305945005)(478600001)(36756003)(102836004)(2900100001)(5250100002)(97736004)(6916009)(2501003)(14454004)(5660300001)(386003)(2906002)(256004)(6486002)(14444005)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0277;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FAfr6EQA644FSnpTffCF2ZiTdBI1vBezdANMuukIqe//P1CJfOX+cZC6EMwsVT+IAxul4woL9Ez4PcTDENXk+zQzBNBvgbiqadv27wexAGq46/TA96a46LOGvklCU3jCJZdoZIwqJJB3BUjk2KvyX3OGY5yo0aNr9qHy0G0AxkfgNuVKxbHkQTUswLbDiF58M86Dxoo8pWTTnAx+1x7J0Q6PthXiCQdN/93GP3+oIPT++oNNTFf4LpczOJj4Qu7Jkg+IvmQMejTAhBDRYDISALuk4uMjr2H7gGRmF5J0HKiHDa9qYO6tug4uGjPJb8jUBvn1iJ72UwBIlqM8qvId7RbKh4MdJ/fAg3rnXqUCvAo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3759ded1-f67a-4861-9147-08d628109c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 02:41:53.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0277
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly forbid creating cgroup local storage maps with zero value
size, as it makes no sense and might even cause a panic.

Reported-by: syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/local_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 944eb297465f..9f79956bff7d 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -261,6 +261,9 @@ static struct bpf_map *cgroup_storage_map_alloc(union b=
pf_attr *attr)
 	if (attr->key_size !=3D sizeof(struct bpf_cgroup_storage_key))
 		return ERR_PTR(-EINVAL);
=20
+	if (attr->value_size =3D=3D 0)
+		return ERR_PTR(-EINVAL);
+
 	if (attr->value_size > PAGE_SIZE)
 		return ERR_PTR(-E2BIG);
=20
--=20
2.17.1

