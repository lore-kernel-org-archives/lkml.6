Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA715214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E+eM0GTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA715214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeIQIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:46 -0400
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:12480
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728537AbeIQIZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7QplqAtlt4hbQN3i8FeyAnzlJJv5C3Lkn+RDVxnAAk=;
 b=E+eM0GTzvQPD9shvq+UEt1heCJDGQB+Bz/o5CNFRmThuNEjVqsEzIRW5qnqvWooAgOaqL1xHPbg4KQadFNiHXW5I2owAr2P6GoCV2wKJ181UN9xBVygBD7l/wuSfuuhIG8W0Htun8CTyaAH8RZXgahOaPM0L5elpVaifTIn3x2w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:00:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 029/136] RDMA/bnxt_re: Fix a couple off by one
 bugs
Thread-Topic: [PATCH AUTOSEL 4.18 029/136] RDMA/bnxt_re: Fix a couple off by
 one bugs
Thread-Index: AQHUTjKX/6jJKUIwkEyHgQzMo04jBA==
Date:   Mon, 17 Sep 2018 03:00:29 +0000
Message-ID: <20180917030006.245495-29-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:S/e1m4l+WJQlx2KQyTRIEzB0VgShPSV9erS9X3isQc//uRZKczwKlstC/kAHIVn810OwgXfcFUzFN6rAB+0qeslw8MSg1PqW6Iam3lycUsLqiBGwV5iD/9OEoRL/ibTkJcxaRlv+jy4WhCN/ZrXHnb2wPrHUiYCLHAsd9hxrLGKYJhEUfew/A7Fjpn/0/iFUiRc1xlrw5Nd1Sfex4hvr3LA3aJtQrSa9RPb/LreP3w6tcrhRcqD1PUNf6eGDSIVJ0JjL65aApEzRavHwfi/vHPgzYQ+ubXNqn6wMwzQ8pdqXkeRzA8n9SG+XU9YMNtNQA9s1ebEn7shJB6JhlrYMl7+HD8nnPwf01821atWoF1J8rhmAmnSnvXf13E56vxrB2oSg5rQqwaphDaMNsfBI4Ilr3G4jxv5nC9W1Q4SQuUQ6x2iegN61P53lj5vb+uoWLBnhCqZIstlgjvN5JYAMpQ==;5:tHAbxtonWz9lxM1kQQgV4QdRi/8Znia4bEi4wZM3JArlPvfaUIQ5k1brBAtoL5GeLDYjF906jJFUjlqkj1N8H5jOQRG1BEqka3P+3XlYKAqDMVp+QLBKZGdZm1mglk2zWioOX1nam0TrGIEpc547enuxLTNEXnXRMjzDiWstncg=;7:IMAolb0W9hhH6poHpqRG7NZLQRY2wiAgcfbf08MIe5MJCQjplmkiewubhigSG72v7MDfGnhBA/qE7kWLzndHSktWkMZQH0X1rb0Xh1dUspMzJnDno3XuuDjRooSnWmfYQbTuzkuViJ/ao42Q6uoY5Tq5zn6bt95jAVgxpBvYAgGWTTRcW2EoljY02SS6sCbdVzVwUVtoK7bcQPHAzstsfr34Q29ruxxnIWPytTyPcPigLZbCjc4DWZQWWa4f2mK1
x-ms-office365-filtering-correlation-id: 0b1eac16-483a-4045-fbfe-08d61c49b9ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB062928958CA97F18E4838FA4FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LFA3gKD9g/qxtHmJa3vb72+2+BaqPHxl04uBmU9pXT6sUHuE3MgHqlXcv5J/jdfJpEVaePIRP13hJ7q+uIqphk0CoLCYAMzH8dqk2euBC4JuIw5lJRp5FZijD99sJcvhAOQzB6mG6asdSRZzsUflpXonh1yLT7bFJJizm3kWn21WbsL6qHal9ZNhdgP3lsannFf/y7bP0+e47E8WIhza3p6AayVUSkqVYQa2ClrCowefPXkzO9uNxvp1Kmy9nP5g3xB5C1/RiFMbIFZtDFcJvrj6IESaFXkrgC1t+VOLo8x5eW/Uua/TlxwKd/erztFfLnb5fCAw4e7xri5aBlAmu6+lqUYgx7qFWQfMBhuc3TA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1eac16-483a-4045-fbfe-08d61c49b9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:29.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 2f3f32eaa1d5..4097f3fa25c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -197,7 +197,7 @@ int bnxt_qplib_get_sgid(struct bnxt_qplib_res *res,
 			struct bnxt_qplib_sgid_tbl *sgid_tbl, int index,
 			struct bnxt_qplib_gid *gid)
 {
-	if (index > sgid_tbl->max) {
+	if (index >=3D sgid_tbl->max) {
 		dev_err(&res->pdev->dev,
 			"QPLIB: Index %d exceeded SGID table max (%d)",
 			index, sgid_tbl->max);
@@ -402,7 +402,7 @@ int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
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
