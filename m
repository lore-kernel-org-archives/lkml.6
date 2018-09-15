Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA06ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD7F21479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JzpyTqHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD7F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeIOHJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:09:12 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbeIOGq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x8MTY+xPKpK71OPKuIYYlR2P4EqJ2p8N4zqyRFdoZY=;
 b=JzpyTqHWMJNh0E8zBM6bvFOgoba9tTje02epMyA9649XWQ7pYS1KVFcNGoErqzzw+RZrF75J/rzGVl6Kz5Jd+gCZNFczLcU7FcZpiag3RVItHq7I46l1X71jwjVw5v8dgJOLCleoFTkezd1baUm2KyM/d4cGxoJxvjlxRplYH/I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 07/92] bpf: fix rcu annotations in
 compute_effective_progs()
Thread-Topic: [PATCH AUTOSEL 4.18 07/92] bpf: fix rcu annotations in
 compute_effective_progs()
Thread-Index: AQHUTJOaypbDArmPhkChjqLZvbfSPQ==
Date:   Sat, 15 Sep 2018 01:29:53 +0000
Message-ID: <20180915012944.179481-7-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:6vsP9fSNzTTM7IZRYx0LGhl4h8Zw6zGc+kEJUfXRHJMyJYIIwZaRQ/wUswPdOZQo2V3f2jOM+ZCStlirWeRXpUngGHRUubLuGr1ucBul5ZbtRjft15f/a2onZIdASzlExYZY6i39hPnk45omn4COEAeBHkwDuCAQmeghU9RFE2RbI7qlkn82o3+usD9zq9+k3QceTl21hDBylVoivCLINuXw0A+HkYNfSoppucSuDq47PBNXPVJJs6IrSuoRWUzeouIA2gPXTz1OQ8N9oUCXsvpmDZEuZPzgIMW15ZncXM8drv/CuMhi5ZIRsUIvRELCeTTBh1VRzYahhN1MsXRMnYliFtx1LuIaLupkATwKEXsWQrlhstI/vIFRDYx46VKSk3/3w7P7QzgaSmtpqL7H7QnyT4HrSRro75u2eeI8PfN56Og61ku3p0/lewHKhCJo/vtFU3jxWhx2SQfGkIBpPA==;5:mJF2T0q796YqpAlV/WBxXlXo7CMj0ufQkGespV6lu8st21PGtFaB55D3fp8G5qzCkN56CZmm0ynuUdvJ4Th2tExDUnGiDGYQcg8/S1gfnO4kadCZmyBO6RPqHZQe+KEcRKBmkfKuvnR0RWPcZLRby9q3hkNiBJDK46EAfUjR/Cg=;7:O5p0F6u/49gIwQcxydDOj49VF6s2DFTZM2XMWbjIUOU0/Pjw0rCGAcmxma65ocScuukP1quJv/RUWHW5OlDP+s2Plhwkp/AyxInmSikrh0bGSbRyFaP687QPClutLHG7B4TS0JveciaYxr/Nk3cswkAyMCUv1GY7shbwrlvIzcFQDkMqDqG/8VW5dt4XgGEW92eznshiS2ySH5QUG5HTTFc81MotPtoPUL08fIxYT4B8BUq1gaofjE+2+yx2NV7S
x-ms-office365-filtering-correlation-id: d7605c18-5f4e-4941-d470-08d61aaabd06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084081FA5CE7A1F75C67102CFB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(5024004)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4qLQ2OOtPPRZrHfxIwJuCWqoxCPbmlYMydT9qm5q7YdmKB+GEBkNcS+xG61tt+BZAzhFldwukZv3PJgH6OfDocK35wcbWCM7O1SpkNAz8nsH7IHptSFPIHbOpn44Qf5fS1Srn88E6UPEB93VRrnJX7cq/zJ1MoYjTE2FHz6jCZA/50ARFzV6Z6RykfKx97hgBBXbHc7Fhqd8i6KrbuBISQt4j4N1YoFWg9/wydYBvpKJ2bm/KA+8Jwjb1wos1Gbl1Cj4hclam40ZbQf5v8Z0tbdv8t5l3vNA6dgFbFywl2omCaV5dfQdAA3XvrOmcvDF8m4vyHu9CNUPrXxhHd7DFQXGRslkiUVFF8iRscV8YTI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7605c18-5f4e-4941-d470-08d61aaabd06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:53.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 3960f4fd6585608e8cc285d9665821985494e147 ]

The progs local variable in compute_effective_progs() is marked
as __rcu, which is not correct. This is a local pointer, which
is initialized by bpf_prog_array_alloc(), which also now
returns a generic non-rcu pointer.

The real rcu-protected pointer is *array (array is a pointer
to an RCU-protected pointer), so the assignment should be performed
using rcu_assign_pointer().

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 3d83ee7df381..badabb0b435c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -95,7 +95,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
-	struct bpf_prog_array __rcu *progs;
+	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p =3D cgrp;
 	int cnt =3D 0;
@@ -120,13 +120,12 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
 					    &p->bpf.progs[type], node) {
 				if (!pl->prog)
 					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] =3D pl->prog;
+				progs->progs[cnt++] =3D pl->prog;
 			}
 		p =3D cgroup_parent(p);
 	} while (p);
=20
-	*array =3D progs;
+	rcu_assign_pointer(*array, progs);
 	return 0;
 }
=20
--=20
2.17.1
