Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F46C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD5F20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XMPp5WJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD5F20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJAHNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:43 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:62504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbeJAHNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHc0tNT3Ga59e8PhNdSpQHybxey8gocL3Pd463MRgVI=;
 b=XMPp5WJ3xB3cpRNFjQSNLmoX3lO1Zz44xnen7vwFnDAiPWJPdoaQ7N9faaaw+/NceDtQKpvfov/qkuCUksxtgqjcgUXn5CDR1LimZl7ebTvP94m/xMCCL5p9stGz9sDFC/bINWEcNVF6EMwjVFmdZfsVmvEVVqeilCplHj2WuUY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/65] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Topic: [PATCH AUTOSEL 4.18 20/65] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Index: AQHUWR8KCuC8scS8D0KB3uZT6TdIUA==
Date:   Mon, 1 Oct 2018 00:38:15 +0000
Message-ID: <20181001003754.146961-20-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:1PYAwOXBLjRnRKsULW6dI12N2Gjp2f0BGc4fatgZ4JcrdHCRWO139CSycfplJZXBaOZ5Rg5eUNdps13XEuB5//Xw8EqTbSceEp/A2alcjgbp/5x5zSgLRiDQ8YrfgwOMipAN/+K2sc9g6ykFQdIdaRROrwOfhhHUzSpkNPzhirEIZ+nfe8f0CQAoQlh4cedZOrnLrvoxNYMq4eqiAERia5xb87M5QDWBCkyauRgqStsHCucc6qOOqs27ul8e8D9e6801J1f8xuBiEp8Y1tZWFVB8Oy4xKhKHgTV+yU9agZAfW8VgQGwBjC9bZL9XBg9REgkwhj+4FcDUqYMSM3Ik0bAfqabpOdV1l08tKbZTXwDpCQEMAIPFB70Hj7PNHc2sf1o7ANWtTH9j81mzNKhEEMpfZ3CyH74iTqE8LdrYZQKrIanYLNjgCcbr05GEF/jqPwqrPF5CVNFtez/Sevme5g==;5:PGEOAdgkk68v8b/3soxAtFUEPK1HCtoM2HW9H4cocCAy7oON1AmRtdaMLRnnaj0xtup9qCaUK4fGJsgqIlPgk2xgZF4xatuahd3izJnrkkNcL7RYh/u7blPQX11CUjUg/OO3DRLA2lV44tHFK+w7sj3hM/vQCdVwYZxtfLNjoKE=;7:Ibj1Kds4sExLvrkvHyhIijE+qeDEgI+I01uGeqx4sslDb8TCP3TTBEgzTwr/gz2QZ1QsF5E3IoZbjBx0wfqg87AwdT4F7xnEPuN+0oIpCMX4s5ycHf8xRs+1yrCND3Ckb01fVptm4fYNkK7/VyH+C7dascn0qGi/W03lLQr3IpGjovsR5ymnlttn0ODM1EzC+acSPEfbwBSI2z5qhCyW53vhxzIQxaNNMMrbO+BVKUTBgLKBUPy162Bx7gCdTaLj
x-ms-office365-filtering-correlation-id: 9dbd87e0-c4f2-41f6-ca24-08d627362cd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472CAA562A8CE928C916A99FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7WqQm+kPQWechF8knHoRTlmlCL28fIu2agYOvFg/akB0x93rEaQW7AYqvtu8BiY748ZF23vyEGhFazIxKpXjDLWUR31WNse9PpMNKolbA/P2S2T2LPARGhM4bLCB2msX6x7iSh/fRHnd1g8bOG6foHJMEaC28keUgP9JXzZIzDfYb1jhzAMA6nlezjP3zLVhzxCD+JK/LlQ6ZvCVdIMGGhD+ujb+ovk/7e3eWxAhDu+RClAb+MKA3LPzB7bRHvkq3r/lMZ40Ue4mY15g3ri8PES5B30O/HfD/h86eMpjmbB86gj2v2cPntfXgA6avgAxvP5Y/tmvpy6h9sgsMzUKBeOOcsTsqUAyeC/DQVOdOsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbd87e0-c4f2-41f6-ca24-08d627362cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:15.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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
index ec8fb289621f..5f437d1570fb 100644
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
@@ -1581,6 +1583,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
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
