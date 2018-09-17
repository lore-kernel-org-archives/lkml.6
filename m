Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A443BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54097208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="acZecPjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54097208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeIQI0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:20 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeIQI0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mwst/sAXbM7Wks5EwCnVMnq/ZjQe/b9wfKjg1QkG5Y=;
 b=acZecPjyzHYuuH4ixXvM/gKnwevVlW0jzp2HHFHlGnvcecsK8CRA9nchW37I7+ynqcJ8Cuic4rYKLCnpgkCVJnkJK3LWAp8QZCIxiJm+7abX1OXDih6Vdymn0BBBtbonlxFtk4duJJ3wOjqLtfzCb+Xqnb4rpZrCa9ZOhp1/o4g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 033/136] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Topic: [PATCH AUTOSEL 4.18 033/136] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Index: AQHUTjKZBRuOg4ht0EGKc+Yn0mSNZQ==
Date:   Mon, 17 Sep 2018 03:00:33 +0000
Message-ID: <20180917030006.245495-33-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:FyTmvmdw3x8ffvvTWVGxBs5EoM3XsTKd0PXg3m0D/4mjIVn88765VGAZwnqtixSb3ijgjK0ixPM0PCKQwzb3+EW77jeOrk/o3Pjcw3rIT2/KEaiKrLeRJ/vo++mSJKpqzJeU1088djV19fyqP6wSCskRIJioyxSQir1wYbvJjBqZ9xtpGsaz7SUXiBt7vmGuzQrJhBBro/Gb/gfVzU+MsMRotFF+spSEWItCbrLeh06WJVc/sC8i0Nfn5atkkaYPgdj782CA27vIKl0CcsLK/kDOJKHf2qy41CU0HxNZu+UfjX08l2kxpnfgObCjtkb0RDDycp/jWtTE4qSJi1cnG+AKI32fb0O36dW+UI1H7iAZgcejaD+hd7LgX991aGeePjQ1Gcksi/x+PhsHyFkrvNraNK2pCBrLHUb86MGp3yATebNf7xst7EDdsxO7VK+umZUvt3KVt21nJBWjsmaqHg==;5:DCC+XmuVPxHmStgqEv/YADDv/w6K8D192pewrvPhcFaodJMaQea2wYaOTFmGP90lACF1fDzGjYuwNIPrnJhzLM7byavvJ280MQE0PNsrkEeJigtv85+gyiWqSSeGWF5bSTFwlFyPVVp7HfcUh3q13vA5h6bcjhPwg3FQXYa5cXI=;7:jJ7IhD2etUQqvQOqT7X6LWroYNRjMPHroLNx/eeYhM3CnP4AP0lhabeYxSZnfiWJrn8sgG01GSDtGZjR9XTg5Y3S/a40AkZ826btHWAPdSpqYTlCObvyDeIia9e5UtpD159Hy1lfTnf7dOzZHAKODMH7Ctv0hKVgFCgI2Oz57qGRM8Z1ocsuH/y75sFGml+tQxkg5qKJkOMDK/WJf90Od45zxaeEANz644/1ORwidrJhveJGSKv1O8GP3zEqVUGl
x-ms-office365-filtering-correlation-id: dff74d83-6f62-4510-0502-08d61c49cd8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06294DE20F5675673BF0A200FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GYkgG+/11C6s3VCr9qXHE+v7uV0sqTFuSrF/q0/cdODvfyoU/EK29vvdHeD9jn8jaWWi3n6DfY2takUvu1plynUEVhOj/e4LGFsMJP4QwTQerj765x6OBEIgpL2gELoFJK2EeGuOc9wG6hhtSAimtC6VsRc23MG3DrBWYpq6QUq7IxIjjVBGvmR06tx2gpUOTztxMFPCjFA4ptRKBxhB3pvyc75WrHnsM2JgWQhooLzBtNAiibfpCvZ2wwdi4kYXjL5H9c9uO/PoWlTIlRVujgeYwHvJMHpEmwk40xn4wqUP6al53iGrLmPbkH/w77yzxRBaNHlNXj8GLLQK93ltp43S3rGHheplWSHXV7q5qnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff74d83-6f62-4510-0502-08d61c49cd8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:33.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c2d7c8ff89b22ddefb1ac2986c0d48444a667689 ]

"nents" is an unsigned int, so if ib_map_mr_sg() returns a negative
error code then it's type promoted to a high unsigned int which is
treated as success.

Fixes: a060b5629ab0 ("IB/core: generic RDMA READ/WRITE API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index c8963e91f92a..3ee0adfb45e9 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -87,7 +87,7 @@ static int rdma_rw_init_one_mr(struct ib_qp *qp, u8 port_=
num,
 	}
=20
 	ret =3D ib_map_mr_sg(reg->mr, sg, nents, &offset, PAGE_SIZE);
-	if (ret < nents) {
+	if (ret < 0 || ret < nents) {
 		ib_mr_pool_put(qp, &qp->rdma_mrs, reg->mr);
 		return -EINVAL;
 	}
--=20
2.17.1
