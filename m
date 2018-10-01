Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC0C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FA420840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FAEAM9db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FA420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeJAHXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:23:10 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729495AbeJAHPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnc8GKDHMrPA4k+wTrfNWoKUhtZfJ1ApkDz4a3GVia0=;
 b=FAEAM9dbweHqoy6Hb9SA/Kh1du1PCJNoDiHqMgCSs9N42pYSQ/Gio+vg0AjHPHDuufPEBOF1lbKhG++5zCrSdxECF1A12wUEda9BxBKWQ0B7bncXb/a95z9kL1cJogzvK/4tgnE3hsIDMiLZlwaUaiLxFWz9j96CoFqBpy7m/84=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/37] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Topic: [PATCH AUTOSEL 4.14 13/37] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Index: AQHUWR8l/Uh6X2unI0WRcVUEdXeHlA==
Date:   Mon, 1 Oct 2018 00:39:01 +0000
Message-ID: <20181001003850.147107-13-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:sbqv2It+uxbtSyFagYTZK+agdyv/or+c+5P0GrxesWdXzWeJJhWTssFiDBnhnTXdEcfZJyxIt6XsPWgTNHRNiDdfQnYAeLbGVL8fXOhKX0E+ilJ/2zECJufxmTthxJ++kuTS5jYo6IqLwWItknEiFv9MJWu697QRCy88iyrCNwZ1ltdz359V5727w16NJWQ3tQbHk/vCXpth2bpIxrncoDgV+RUMGHjG3W38qUHqsRintlHlDA/AyF/I08aJrjNl/e3kDCG/RHx8kESFAfp/kppKuELYJuv5LXPQcWmdLq/jbyyVgL4Fzw9Z32FrSGAthoPEI2164HsADnG+HJMgJoqu5M09Nwx76Y9ZCfmnNOPK84QNEAdDlZq8s9sNiVnPgpTt0tGxNcovybsDr34Yh2F0GnqjEvjGwv3t6Bg07yPCWfEHLl4zV7Wd6Tcv8R3LPtTX8Vtk2aMq/fy7yfONrw==;5:HUNrikxBE4L9IDcrFxmv8dFn9sd0e7PiJWM9/tgwOZnlU6KMOhN7pjc0ngY5bY818WL1QMKKU9nHp+9ep72oA0wdXDozU55SuVRAqKWzg2JiCevqGkIRi6cfSeg48MfKsFUYSDaSPMkzRMLQS02HlOF9AQn9TrNXo/O6Ieki/CY=;7:2IBbfnSHGvKRnC8QqyDmcj3yTS+rLHj9KMugnvFYXfADgac2Pmp8ME4OMUVEFRmrBydHylAL3qT2tCYihgkv4AQKuM4P6BusvMeKALg7m0JjibVZ4gqHbaAvG20ADd9hwEIHAXJqcH1zXGHyIMCj0letQzi+D1ZYgOFgrgEtHNZ6IbuQvp4YuC7SmhGVWuYLZ7LSyYDEtyFFmUnI8EnS93DI60TTg54/3qHnd0sHVzMaKDsYbkV+Lk4k887u33AM
x-ms-office365-filtering-correlation-id: 4398d9dc-e5a4-42fe-f59d-08d6273660ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB069602ECE3534E2A4CBD4FBCFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 97GpHL6NJGHTtyJBTLR1Q1Q6Oj4AEqLaoyV7veXjTHMaezy81dHsXY9JVkPUDUD1u8CgA3ReX7Wxi6jrBMAGUA67lnp5Pah/pg0lh1BAHw7qcIoX4uo0iCVr+g9L5eGJg6lILXWWwdZvmkviO1ZIXvmeSR7YJEvd7+LTlj7gwJNLW6B7XUdh1wEiaxMq1ITlBRabxpmRbdlU3qpIE1a7dcQ/4O7nVcoBPddNo/p+AyYdz4N20uqBv3hwYVAKIV/oZjLUcHaDwyyEjpYj5wxvEZAtgCIF4sH4eC4AO4qNBkaiF/5ASg/WLEv1XBrZt3g9zuCq2bL7ZKLRUdgWztxWMVRGYahOuhZm+e3QBncpR1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4398d9dc-e5a4-42fe-f59d-08d6273660ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:01.6022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index a22b992cde38..16423d7ab599 100644
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
@@ -1564,6 +1566,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
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
