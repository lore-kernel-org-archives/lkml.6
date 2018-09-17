Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86973ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DD2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mx4EC1Ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DD2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeIQIuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:50:06 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbeIQI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6AKmadwTRoNfNVO0ir7FWXmkUl/PydV77hT6S1LGHI=;
 b=mx4EC1KeO+83pu3+HlVkoYSGdAgpxprqHRs1m9CZZ80oAsV8VQ40ebuZfB7ss/ZGj6BTYIO+DGh9Q7NnXlq6xNou2MzmNJttV+fWvRCWq1AhHOBTEA5pdGoeS4ruifLan8UN+THBSyBtsZI23yNrYo9zmL1m4mugBkDtSt1j48o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/87] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Topic: [PATCH AUTOSEL 4.14 23/87] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Index: AQHUTjLkFSAJB09PjkGH7YxR7bF9Tw==
Date:   Mon, 17 Sep 2018 03:02:38 +0000
Message-ID: <20180917030220.245686-23-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:bWJU6q1p0x634J9W+5loHQ3HdXsmgmvEdlCvTWoEy29/W7LSCWn5JVrr0yhtg78PXxSdvmQvCEKjtr1dY8dHUlU4Z8ymSuGEdmaN+b1droi5i+NJGvJG+v0jZdBh0Rz4QPWM1lf6voy+m9y72kx4jr0iCDBTizJXyqj27TEczUb8vir2IDxZZNbx2vfjDvkK+BfpPlBut8tSG9WBGLqiUFtFHbTZRaCxmEEhH+9iG63cX90bzkNTs7tzy+1nWOWm0DT4HXEdoXJ3fQX44TXI5HKDw9x1/ambxZlWv4SX/TSups35hTMnaeS3x0mooYqzr9csQu3eBZ12tO1l7Avk2syREI81TY6lyB2d42gdu6MbPkqHnICaQAeXQQuR8i241RvPlVN2X/llPa/bIkY6Sxfm1jyWHyc4Xw50etEJRCjMXWkb9IctxgdIE3mxa6I2fUbfS8uPhTJZKmyzvJ5cCw==;5:cZTRyf4eC+DZbGGtuYZDyvYTsb6CtXBNb5Somf7n9/JQelf+BRBYlJV/iSvMaTztUHNdeQ5+Q+TQYFTN9OpnnSP6UlxN6xL5FNrNkATXGtAwW5HyBoc0egikh8lhsiFOtsuv2RehM+PJ9YBO8aRVvtZxHrsb7ioFGOxuSdsv4aA=;7:KNRXrw/TpIB8ndJiPcGRCCOOLgZcvzbTJ003OTpG7mFALV6MwZjlM3pX7IVbQbGsikBLP+E9vpRBRSR/sw78oH3+V0YW1rm6J2M9zTApMKxaLsqhaaiw3IE4M6EnEcp0niFHaZJ/iwACdvIbwtGdDrwxMDYnxOIxcUfuLrMxrfcsi0KAagyiOwW5ymTocblz8Rxg76X3DIg+Xdn9bMrk/AnN0t344FGJPZwbCLxl3P8O4orrTwpyO68uJrEw+T3R
x-ms-office365-filtering-correlation-id: 9b305167-cb85-4df6-c339-08d61c4a2a57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047017DFCD3CFC8DC0F3054FFB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: k5P9TEfFsrkFpYeP6s5e0id1JcDk3TOtBm2d5HM8TM3eWR7qDh6lgqR3EMwr6R2fcIqsiRPedfdvYGnXf+gpfFT39iN27nId7tDNowCKySnjHP6P9heAs4+TA7bmVGIAPe7OQjlYNDqvjLbsmWQGPtJ6Ts++5y4OJZeNZPTKM4QGMAIjSJ4VqkZ9Nlry8Ou8cJzng0um/25y5OkNEfGuOyuLLYn6nYtNNJIFy0yvGyK4u7Crxn3cvFextMFNpRV1b1Nls83B0Ph3+eX0UUSfUv95D04ZJ3QlWK/Kw7QMO/t9GDFD5iXQaMpxybMGKQl8MnbhETlW8vZwdPgUKHAiRO2QdmnE5NIQeTH7p2lGuac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b305167-cb85-4df6-c339-08d61c4a2a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:38.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index 6ca607e8e293..9939dcfb1b6a 100644
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
