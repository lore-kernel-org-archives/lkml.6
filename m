Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39CC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFCC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mo1aje4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFCC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeJAHVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:21:08 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729043AbeJAHPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQHsVPw4SfZu6CTWyd78lNDBrlT0mcTnEB3b3TvAjPA=;
 b=Mo1aje4PMu0iytVECL2imJtWMeQnRdOnCiCM8DyZX6vbH9nuej7LGyt/7icfxme6f/BcWEYm4p8C3a0AyDm6w17je/5wOXhs8QIfd60rxA5JCx5Q16Xw88ViwB9ik14/3OAyMjtjP/64i0EbDcSXDOglFLaFTMUZTW2s7A+J0z8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/26] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Topic: [PATCH AUTOSEL 4.9 07/26] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Index: AQHUWR9cZqdJM4vHuEqB0yNWzRsuPw==
Date:   Mon, 1 Oct 2018 00:40:33 +0000
Message-ID: <20181001004026.147201-7-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:zO+zOwnuquBkiqt6XwZwuZPg7cJI6263f0MSsbfhIpYyV+Kl8ok+bk0IaoyUftB4j1yNReAs6QNavRKdk/XKgPMHWXFJwUJWMy9uUq+lfGPFtR0b60K/dRwCZIkY2z3rf/WIIjk/TSMNwzUcMM92Fq99oUJ6DtZTQCNDJZMQkldk8/NjpBqZN2RAtGyWifOmabBtsMZe+jddY5VTcMF05pYhZr4Kf515BCY/Lk80Nhe+fc5cJn+jdOgUIxV5qtp18D5g6qxqzsvZylV9LtANWNlCWEJM+YorGswPyfJusHXkz16hmvvzis5PTUImD0gmkFwR0XX7TupW8vPLD5eyylJdgoHOjro97sIweP03X92h8+LBILwuOBW3vIWpppol3z/pAOJKG+VzdmYlTh+gGKGSyrn1e62ZPcMayopAL1t0noXd4Qeblw9vvQaAnyIKUpkfqs0qKe9figCCZ3gArw==;5:bR+S39zB2C/SavkCzZz+103ODKKpsi6sHlROjGd9RS1NOKM43O+wcYEhA3XXp/W11I5MendHND5wxmxbshQWRJUu6Nl49DHfGXVMV6Drm+XYxyMB03Aw+RREDdFN6bOEMk1BfqMezvW2hJ2EsaBC8gjHYMr/Nv1bQa7/psPWgyI=;7:Pw7k/ETsrUhJ03zRURbuMA9EHDe3MGryvv+zC4jw7n1MBRjtJQvprSwp3Fi+j6xdTnvQvYc4jMoQKc79jQ8yn5jzWqzjT1LApHENQdnMxKKVmYGIt2g1FyES2Gv0jSqf/MJtde4BF2A+sKpvyF3skbrX2tu63fRKSM0tKvf0WNTmXVgyELGF5Z1yrIGOEN6D1ZidoQPF/dBb+/7sSWgxhooiJpIVsI+ya/PyGAko/kUQ5uzhD2svpHnE4ZpIA87U
x-ms-office365-filtering-correlation-id: 18ab59b2-e26e-4716-cb47-08d627367f3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120FEF1EF8A4E028F89E0D2FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tzqeOSfjsiOgJ7MYAIzK5xWpubPVRlGLVYbfbDlHkbrFaBTJ4a4vjM4NuCk+nnioIHoa714VpXfxCyMb6/MSrRRubORAnQlwp4qHynyeqLjEmSANs8WUh1Be1NjdNYbsv1fO65MYUFXVFV5j/1d794l38rJOxiJ+UeJaS4GIakry84gkIpxA4ElNkQ50idqpLosn3xvcSzPUqSQgflA2OcF8c+r8/JwZ6Y4AK0JI6sSQ4+py6tsQYFwWxC4ecbu7fN7C1R/iH32/+6NrCY0Urrov+i/8oU4SX4kRYOf2IBBhslIW01hrOuc/6tHlsF3EJMDVq+K5LKmdk9Bj7VRxvpktWbGpWbRMPbmi+iMkBCg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ab59b2-e26e-4716-cb47-08d627367f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:33.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 0d23ba6034b9cf48b8918404367506da3e4b3ee5 ]

The current code grabs the private_data of whatever file descriptor
userspace has supplied and implicitly casts it to a `struct ucma_file *`,
potentially causing a type confusion.

This is probably fine in practice because the pointer is only used for
comparisons, it is never actually dereferenced; and even in the
comparisons, it is unlikely that a file from another filesystem would have
a ->private_data pointer that happens to also be valid in this context.
But ->private_data is not always guaranteed to be a valid pointer to an
object owned by the file's filesystem; for example, some filesystems just
cram numbers in there.

Check the type of the supplied file descriptor to be safe, analogous to how
other places in the kernel do it.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/ucma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index 3bef6d4ffe6f..0fd0d82f80d2 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -124,6 +124,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
=20
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1545,6 +1547,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
_file,
 	f =3D fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op !=3D &ucma_fops) {
+		ret =3D -EINVAL;
+		goto file_put;
+	}
=20
 	/* Validate current fd and prevent destruction of id. */
 	ctx =3D ucma_get_ctx(f.file->private_data, cmd.id);
--=20
2.17.1
