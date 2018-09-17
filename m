Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C0BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366AE2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GXoGjkEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366AE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeIQI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:58 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbeIQI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbTn94v+vLLCNgoJDAQHEWvZultO6YDcE8OD+cD5t2A=;
 b=GXoGjkEi8+saM3HzYJk29txVO8fS5YtJvi1DJ3/cQY8MxnDWxyGe/6s9u6TU9wKQWOlWwF69RW4U7q9TTEPXHY/GLIi9GrOGaYhUJeO2hlxQ9GL9OdasDnGggmO7M6ntec31yHJupoTz5K2jtgnb1yElR7mGSLFBa11WtYJHWgQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/87] RDMA/bnxt_re: Fix a couple off by one bugs
Thread-Topic: [PATCH AUTOSEL 4.14 20/87] RDMA/bnxt_re: Fix a couple off by one
 bugs
Thread-Index: AQHUTjLjnLMNxfEu10iibswmZno5tQ==
Date:   Mon, 17 Sep 2018 03:02:36 +0000
Message-ID: <20180917030220.245686-20-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:mu12hYsnApCfGZYGymmE8xE6qmtAOqfy2j/EgSXDTXYxWs3VTVLmpLN+Li7UNnYoDBXltITckKZMxMVt/vI300DpqajjdJgQd53SBNO7NkjEKPXpLYVZZp0mmofbZfCalBVYqFqee7rZ7zAgva7iia+aKdJ/4D+msOB6D+lVADxElrT9tPEX6sMpBjpc/T/V/VeoskqXzBlxwXWMmVQbjId0H76LmO+KgpF8ZVTVlqS3x7/ppqg+XxoBH2vj8u4f4kozsIBwVckxQqkCNlGEpeCTWTVGCbPvzHWIxhSLp38kLhL/wuQYzkrcZJfIcxpln2Fz21hrbcloF2bcIjNDln6/utcjP9MwekbkYQSnk+JxprPU6PeF9G+PCKotNcXjg3Iu4jKYV0vYRvErORZSeFqR27TpYpompyFDyk9bUIZkdanK0bbhRABkAg7p3pMZlgj4Qa66zFmhM/Pijg/Bpg==;5:DmMUDontajC0b94wo/526BV5e73KesJjHVEmP4Dm39P/a5WNNz5WqM2agdmvcWq40KMqW/pWfS35hqM8Xo1VWDjJ52YWP4ZuDYuWL4/1cSq16NYhxO6ueypogu74OzJ34/wIhdvaj0v+hyVL4FzQFjy4zctnyLAJYHOzesvTxms=;7:tp+Q67l/EG6NR3La2NzyTfRkA8G8zJSvks/Dzd3d/68xsFQnFspYHDGjJEn0EwBfpRwmOdy44cwUaLRyBK+GZAJLLqlBOcU4OexRNU8N4W/eZIT2PCVTfKmC3ng7QW4W4GlFga5qQTt5fNheHtr9nPXt1Ey89dMzx/UYuEQnhDvhsFVZjaUCI4M/LFJCAZdwnJvqgiaMnlwUKcsmKyqUB8iZgxpVDPU4rlZM69C0VmxVPM4dxB7XOfP+R5YWgMtU
x-ms-office365-filtering-correlation-id: a356757f-fab1-4fcd-f681-08d61c4a2966
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047098DBE44BDC5357D9331EFB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vwfuEY7t4hVKNUDF6WEfDtri844HYzsrPWfMBjtfmVAhkB3MzcXyco/E4uknZy+nl4T2KR9sxEaChlpsrFq3QXlVixQm9KSfsPc5S7ni6Sn6XKtk1GpYHj0G1KjFP2f5IbvlymWEtqtzKwp4GdhNOJe8QqY5YwrTSdt/ZVE4h3bIEee0T+4QbxiIdaZH31wx4cP4TiBP1ZaGhfaOtH8FmQ3Z4J5mlUs/l7KEHlUgQS4GFpBAbeoMYMQMZD2iaJtLuwxdswL9bS6QmMVk49xK5Lk4d4N/5kwxaKFt4zPFHOBPPe83SKsjUza9ymgnBteH29ai4aeG73PDSmrYCiaSMvTNBqSI6PFy5g8bKLh5rEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a356757f-fab1-4fcd-f681-08d61c4a2966
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:36.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 474e5a86067e5f12c97d1db8b170c7f45b53097a ]

The sgid_tbl->tbl[] array is allocated in bnxt_qplib_alloc_sgid_tbl().
It has sgid_tbl->max elements.  So the > should be >=3D to prevent
accessing one element beyond the end of the array.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/=
hw/bnxt_re/qplib_sp.c
index 9536de8c5fb8..124c8915b9ee 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -156,7 +156,7 @@ int bnxt_qplib_get_sgid(struct bnxt_qplib_res *res,
 			struct bnxt_qplib_sgid_tbl *sgid_tbl, int index,
 			struct bnxt_qplib_gid *gid)
 {
-	if (index > sgid_tbl->max) {
+	if (index >=3D sgid_tbl->max) {
 		dev_err(&res->pdev->dev,
 			"QPLIB: Index %d exceeded SGID table max (%d)",
 			index, sgid_tbl->max);
@@ -361,7 +361,7 @@ int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
 		*pkey =3D 0xFFFF;
 		return 0;
 	}
-	if (index > pkey_tbl->max) {
+	if (index >=3D pkey_tbl->max) {
 		dev_err(&res->pdev->dev,
 			"QPLIB: Index %d exceeded PKEY table max (%d)",
 			index, pkey_tbl->max);
--=20
2.17.1
