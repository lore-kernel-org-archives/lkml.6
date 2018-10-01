Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885992089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KIhN64L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885992089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeJAHQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:45 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:15680
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbeJAHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buUzlKK7K/2eM3XzBrM2blDZBo3ZXKF7qy5IReRscZc=;
 b=KIhN64L797Za0+Aasb7Js3pnxhSXeEqlEfFCKj79sqMiceR3VZwd84jnzQO++Cy33Zd8KXYx8WX7FkXMZgkA32JP92MPFCyFldBIcWGOaZ3eMmgS1i5RjGL/3OA8eRURiUnon5lbqWYv+Nrjn4B4nhkQq6CrACQQqieNRDKu3mg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/17] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Topic: [PATCH AUTOSEL 4.4 04/17] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Index: AQHUWR986JpRotp2XUmPB3STplPZ6g==
Date:   Mon, 1 Oct 2018 00:41:27 +0000
Message-ID: <20181001004122.147276-4-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:JoSEaL3rmPCCxGvjWyoMT/w7BmPyeSLNvlCrb84ErYIvg5rFwjPOXKIV+YwYgADLmsUXV6L+Ruiq1DvdaqzqdR2RrKJbHNE0eyibWkebeMQKbg8yzUk9U02Btx2QtR3Tw3BHwc3s6TLAKJP7lxaHNnj5VP0odI3CrO9odyLejTLzVIu4IlJDFJnEdn32HSzn+m+Tb63IXSAkSoaOqvNgGTSuwI0l9aFjd/MGJWcMRyGbewW/ToUjmC9EVzmdCTmA1I6mO8W1qyhip3BDhbhO1k26OiaHHlvu7CbJ9dI5p0W/rBzGutVRbXZSiJ+q3FJPsPoQ7dgsBq8M1b/9mNo5L2q/hL4s9PKfivROKtOSOaeklCfp0wyGYp7TmHBD6DlHC1Y/X29XoE7kZvOidHu+0ySrlQYBhZQE72TBSzIXTFrEDtTC77HdQxAslh2M+N+bjVOnTJoEDwGaMMFDxMVNuw==;5:vKZu5hK4Zjgku0Tqz5IGoWhM/atlJqeAf/SBdVPSuw71YtAj6Gj8JqiNf9x+J3UeYrhmcLrrI8kGgNvcNWAHxm6/1wt0OFZGGEUQXu8Yzk5uH4WomVfjuKHV8iVDSw2YWOlqMD9BM93/kuP1l1jTrCzpqglKDbFnQKJtLW+yvGc=;7:0e93s8u8QgoHmH5wGp5Bp6DnWUW933wIQK4mYKst8e4+rkHiPE5PhMASAGI0sKBQVrqaRn6mhzk/2P5ahb/gpDbTFi5taWcEi0TN3VrsysWXPdpCpTgjTPBqRCcGUc/phOLVFoA95swB71dviUlHH2KkgKOx07rK7nESKp3UT1cc7hslJU9xL5WYMM5fmtXvjbcdg2BD/9xWWy9AoP30oPlFHu+x+Bc9+f/GgJTPVuFNxLvElJxcWSj4WGVy4ZzE
x-ms-office365-filtering-correlation-id: 6b14aee4-86d5-4d19-34eb-08d627369f61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016567E380BCF30148FD2FC5FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vpRLc7PoFcBNjhXIpR//jKpt3dcn5y4rRpT/GiqCiQWJQmwNx5RmtfReV0ZBNXya1jpJfLsR++EGnR/G/EbQvdn4rFU2cOu7+JiiQ3cEVcMiakfvIuH/lykBRW6A6vl0rq6GAThVFxvMNesl3d+uwVhwsN6zzgeHGHOiU5qXdnvDJox1c9rPOn0Va04trGoxEK68mrHQ+h59ETKFl8o2QwQ64kFJN0yzI0O3wPmLJwNqXFVNbKtZRqZd1YX77DfwYiG/5/XzRfW6rTJmnDJ8xJIv6pXjOlgT5M6WS0L8XrYGOFiSPpHQdJD0RVOdi/uFv2m8I4LtxdGhuS6/GCOwMMsSzI6WjTa/RYMfh6StNsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b14aee4-86d5-4d19-34eb-08d627369f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:27.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 55aa8d3d752f..9712a63957e1 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -123,6 +123,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
=20
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1535,6 +1537,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
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
