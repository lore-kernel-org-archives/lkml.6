Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0191ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED162147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A1NwHZs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED162147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeIQI0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:18 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeIQI0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Awwu17aGGFWPxaja3wRN7cYNc6hpg6PSesfINhIN8M=;
 b=A1NwHZs3zvpcGr6lRlDVc7TmGQ1NO2rUy3SZLrD5LX7DGaqJQUGaQkRvhrUDPoXYMYSj952DuTFWKzLLaVKBVhJC8+uNpl2rZOH0CmVCUfvvTK966El0s6oA1DIdDh21dmbxKajwSxhR/yODyQusN5onc9rVc6v6uZ0jKhMh370=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 031/136] RDMA/bnxt_re: Fix a bunch of off by one
 bugs in qplib_fp.c
Thread-Topic: [PATCH AUTOSEL 4.18 031/136] RDMA/bnxt_re: Fix a bunch of off by
 one bugs in qplib_fp.c
Thread-Index: AQHUTjKYF3jWMZx3YE+nYqLnW8y/Bw==
Date:   Mon, 17 Sep 2018 03:00:31 +0000
Message-ID: <20180917030006.245495-31-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:hKspYwCj0xKlgP9vk9W5jHLz26G+fIAbkA4hA2mxd3iq2Mb9YJsnCuheT8k9hgsAR6G36nSOADMrekRr3cxJtGJoBvRyuGIKjy5VLWUFIHPg82mbUMxb0dlKfedcF4mHlG6lN2LFtQJJFY7d0sk08WhjyYyHlxmqL9W2xrWwG5J/ZSx5P0NTo1jUmESYgL33gGklFg/O0Jd7hukAQFah6ZLm3/ZOr1yYfSMX08nYlZq6d17T3s213CiexlgDpFZNm2NNZXWdwqJ7bLkwU8zyfV9h9zs82A6eCD1giWUv9svFyEz/vyqAe8ilnKPQCv7TjPltHp/PF6BlXo9dTV+C2QPXw8vNt8ms0KsRNrRrFnY5Blx9CeRYJcxVyDasTbwBt14HpReCf9CMOB3WCe0zPfFhqSBg1f1wEDCA6qazjyNfz+C8WFC10O2DcFUw5USQ4L1h+0EpDRWg8aqiGN5Yjw==;5:H+zu+u/v8V5HoLeCHsStKlX2KVbSibgdRQhdrETWu2EBBblLgtRAlr7D7lIixGqICW5nhptzt0IvZMkEnGAsAxkkj3vfspPk45JiA6Jmyww1G+xG8CvLXB86hWPzaDJre2XftBuV8+FUjuEJYeCRZGZTK7WWdcyZZOne4WLLVio=;7:uoAx1vTscNJoX37twcADIXgcJy20kW/jha/0rihvvGELjhUF3NFbuq8H8hln1imKZyhYQtJQgNYjXdGMI/XbhIWmJX01OLXoSBIhkts8e1jEhnmNixLOr5C4afh8N7bOMt8ijFoTdmQCub200Ll/ZDdtGrIlIQFarPAnAFrag0jnTm6utMb4YZLgonRCLOQBfcEukUc/NW+r0hrZuRduOA2tI5eV/tsjHxDhmp5GOh+rySoSR7Cpvue300H9SXG7
x-ms-office365-filtering-correlation-id: 51385e81-57cc-43ee-1ddc-08d61c49cd23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0629E424AE092C41F001EC4BFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(146099531331640)(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6A0/80Wx+jz19kb0B6Hej7xMLSpXUHRbBB5wypn40C8XcR8pn5KQqo41q80W7Y6NUtForPrRZnlVBFfhyx7VIxuOn1SKSN+MJlktao2FsVe8lfX7yWUUhuSJJ4dEi9rkwhoH3LTpjcoL4H62Wq6kNmz1hNvXWBauvIY83kymdCZ5YKAYwwp3KmbVsbwYdg7dYRsXAQJbPifSJjA8bUUairzZW8o3UPQIDlOI9bwl+N2BJmklBtO0+b2hWifwSdFDT2fuMY+bGEATGiZZD6EXxKNhg80zJxWYB9Zmn4/3imdCGt8pp/CBytCt9KbXrlEZZD9MXkkbfzt7+j3Me4dXY3x9/sRcZk7yz/nwdtF5UMI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51385e81-57cc-43ee-1ddc-08d61c49cd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:31.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c1dfc0114c901b4f46c85ceff0491debf2b2a2ec ]

The srq->swq[] is allocated in bnxt_qplib_create_srq().  It has
srq->hwq.max_elements elements so these tests should be > instead of >=3D
or we might go beyond the end of the array.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/=
hw/bnxt_re/qplib_fp.c
index 50d8f1fc98d5..e426b990c1dd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2354,7 +2354,7 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_q=
plib_cq *cq,
 		srq =3D qp->srq;
 		if (!srq)
 			return -EINVAL;
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >=3D srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process RC ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2369,7 +2369,7 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_q=
plib_cq *cq,
 		*pcqe =3D cqe;
 	} else {
 		rq =3D &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >=3D rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process RC ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2437,7 +2437,7 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_q=
plib_cq *cq,
 		if (!srq)
 			return -EINVAL;
=20
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >=3D srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process UD ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2452,7 +2452,7 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_q=
plib_cq *cq,
 		*pcqe =3D cqe;
 	} else {
 		rq =3D &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >=3D rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process UD ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2546,7 +2546,7 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struc=
t bnxt_qplib_cq *cq,
 				"QPLIB: FP: SRQ used but not defined??");
 			return -EINVAL;
 		}
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >=3D srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process Raw/QP1 ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2561,7 +2561,7 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struc=
t bnxt_qplib_cq *cq,
 		*pcqe =3D cqe;
 	} else {
 		rq =3D &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >=3D rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process Raw/QP1 RQ wr_id ");
 			dev_err(&cq->hwq.pdev->dev,
--=20
2.17.1
