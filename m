Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF757C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5D208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dJMghofG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeJAHNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:40 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728958AbeJAHNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6+YZrNoSV0pTidtmsDBrg7DNQxTWUCUVUn32E1tnnA=;
 b=dJMghofGDTa9TjAQSTjmZWZwFx0lk5ieKdXKrCDLHUBxuKDZFYdR8i2FDmv8ljIB+buFhJZ7FF/FEIKaX8q5MJLt3rAESKPndlKLx6SqPRqCatprs+a0asql9xx2OFMKVmXLorPjJsTpVVlMJmRSItQF7VNbIxFvbxi4pubZN18=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Somnath Kotur <somnath.kotur@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/65] bnxt_re: Fix couple of memory leaks that
 could lead to IOMMU call traces
Thread-Topic: [PATCH AUTOSEL 4.18 26/65] bnxt_re: Fix couple of memory leaks
 that could lead to IOMMU call traces
Thread-Index: AQHUWR8MWf9vwTZ7cESlFMzQWeIxIw==
Date:   Mon, 1 Oct 2018 00:38:18 +0000
Message-ID: <20181001003754.146961-26-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:cAtuqyXn3wn1JIa+i+lreu9z3M0PWHz7Cx0cZcRmfTDiR2TcICCA8UQjKvWITTPhnFLflfIRjPW1qah+2A4C4JymtWuvTnFtAJEUXCQBOSfkMhFPXtUVMQ7yyGx4dkIhD4CPDZvTRGkXIImOyh9T3hAoh4a37KgCT23L6OF8qBfdmIcBhvZTD+hzU2lc5ydS9PCYYH4vE4MciSiTaFsb6iyPp871YCMfuF6TAUGMOKZjuJ+8BxNZ06+WnEpWwvd4YUQ4EjcNC8yxhP4vNugVnu3zzwTSZ3zyTjBuTIL2Vmeu1DrMZXHNTZob2TAJjmd7TVKZs7Wyl+did8codeiTIlUsTaY5upq+6sNIQ6Fw1v7PJRQSO4aldslQ4JYP6eI9QrIjL08efnysxoC0q/oDK92yc+Lxi9T5CzBVcbpXh4KGWcQZ1fxj3SfoL77iks4sVlJze50GdZq0XhPV1mcAIw==;5:fWD7QqnyS9tQQqkPpVSZ0BzjvZ7WPny5L/i1CBmoV23bC/GVeo08TGbSdkwc7wl9UGTX+OBNUEFaMEiw+/fXj4TYNTQpr9ZZOWKQ3aYI48nKEvc2YS9ugATSbMsjdij+vs9nFxJOsnhUda7Xo1UNsqaYUNYFLsnUrQIQOKYb4vk=;7:CRHrxClYO3r2ymMcR7peTq1iQcQHA0hFSpxa56GZPSmgiCiI0aCX+IcbqSeMKePi/qIE+eteWmX/yLDr5OUn+5lhYMUi2nT4rqEJW9D9wKirD3gC3WcR/HkNdbSHZTYTVGgaAfqWQwaRFlBmtx+4NJffmjACfTbOTlqdpHOt4EvTmW8PUpQxlzy+gvEs/m/2c+yWq60k4OwpYmFgdbf5XJT/fC/sP5ZECqucnccjGPFUI2OKNhYZvNeCUvdPTQDY
x-ms-office365-filtering-correlation-id: 8b619c6f-4e7c-4557-2633-08d627362f14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB04725167926BEC91958C3698FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: v+Qsamrk41Vts0z0b920L57HZDS4k1HuS0/BQFfvNIF0xAsUXapl7O9EkQYEnhYtK6M4GzIzymvxcMTB/Io9yfa0vYjEcWZvojtnJBHUPEX74pdvrmabUmkVi/JjQ8BISYvoJ1UD95sBNA7uc47zFP7LOvkEc8VJ6leW4cmf+BLiauQBwEWNPjrBFpZwM1bEVdb9citQL2ewM0mnGXlBuCokM0q9vwpi4DSS4KPEzDgf8qM5NH5bbO49f36iZuS3jXDF34GsijyTzalYPU1ome240hP85i5k9qcYa0dQ0hchD0mMiRHxvEwXlzuZwJuh9mwWyQdmRA3fQjvwhuqllvUBh52xCV+cGhc3Ohx9psg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b619c6f-4e7c-4557-2633-08d627362f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:18.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit f40f299bbe806a2e2c8b0d7cdda822fa3bdd171b ]

1. DMA-able memory allocated for Shadow QP was not being freed.
2. bnxt_qplib_alloc_qp_hdr_buf() had a bug wherein the SQ pointer was
   erroneously pointing to the RQ. But since the corresponding
   free_qp_hdr_buf() was correct, memory being free was less than what was
   allocated.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index a76e206704d4..cb1e69bdad0b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -844,6 +844,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp)
 				"Failed to destroy Shadow QP");
 			return rc;
 		}
+		bnxt_qplib_free_qp_res(&rdev->qplib_res,
+				       &rdev->qp1_sqp->qplib_qp);
 		mutex_lock(&rdev->qp_lock);
 		list_del(&rdev->qp1_sqp->list);
 		atomic_dec(&rdev->qp_count);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/=
hw/bnxt_re/qplib_fp.c
index 50d8f1fc98d5..9e453a61f118 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -196,7 +196,7 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qpli=
b_res *res,
 				       struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *rq =3D &qp->rq;
-	struct bnxt_qplib_q *sq =3D &qp->rq;
+	struct bnxt_qplib_q *sq =3D &qp->sq;
 	int rc =3D 0;
=20
 	if (qp->sq_hdr_buf_size && sq->hwq.max_elements) {
--=20
2.17.1
