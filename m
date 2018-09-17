Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E29BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E110A214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="insXZm9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E110A214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeIQI00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:26 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:35844
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbeIQI0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMghwfYzdLf8Il7NAgGFEGCe4onplf8h1MGCRns/xus=;
 b=insXZm9bkmrrsh/4pfnYu1coyKsL3W6kPRgkOnoM63Cnk+fj4HMfkKH+30ZTIPJZ9YUrje4bCPkeraz7fnNw7oBuOr+1heKMBE47Qrs8OyZrbNKt+0oH04iaVDS2eukPZt6I03WudAyB59HsBP5vwwgrjW++udRpHRaKyiW+OT8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 041/136] IB/mlx5: Fix GRE flow specification
Thread-Topic: [PATCH AUTOSEL 4.18 041/136] IB/mlx5: Fix GRE flow specification
Thread-Index: AQHUTjKcsmiY+UCtoEGoCjZbB/ip7w==
Date:   Mon, 17 Sep 2018 03:00:37 +0000
Message-ID: <20180917030006.245495-41-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:A4D354QwfMhMAg/PqhL8idfvNlMOqACr3gbEEoj8bb/HZa97qKROG+CUiJwnrqU0kQcjixUI39IL9VXd0Eaj2EwM9z+uswNjF0RiQmPFDt2et4+ogaZdZ0H9w/0RrpmafMWXgbxrniYWHtQDT/wGDfyWjk1i+v+qwb3++Nt2zTXzZuNL03oAfmTfiwNAMqWPCFmvinxRkMA0ASB3nP3bxN+nVKF1U2VTd5Jw1+dA43N1Y2wGLb3LjTK6IQIota+qyxgPsPP3mKFkpDf7hgCB4fntiLNRDSUk9Lyma3HnxH34B/d7qsFLXeDiBHBJz1e4GtlXGtqPSKu4mFwii7ajKAicBgnZvupTrTFcJk1A8CUGdo3Ouio8/edYCQl9eOZeCNDTdRYLZHF7vWJy3WC7AmylvYNRlDQ71CHpz4I+ARMLYIKYDa8RNbAz6p+BgsG9eCjBYFA/31VLh4p6rnYKPg==;5:bSHisEhB/8tJTfIhDXxVN8rVneSL0lAkFBZmhEaDbxvvfhp7a5tfYl34UwkeuYqmM+jdpqPZdUxbaJjYmWZDK+em7EzJDMwuIPA2qjDPXfzUauK0y4PDBTDYF0ONErRnhmO2z+L+SVV1RnqKlR6rQM9YqknYQp9kEAN/wpCGwDg=;7:doXszVbL0nkDr1xkuI7iRDfhYUC5+IN/Q9FgNLWSDoT+LFxmeTfyawujPsxi2qHveGo/TSKpvbhxVHgglOrw2OLOS0CHBao58HIJDLZD1yqzpWrTB4WxXc4YY2ZIs7IvoUzKfC0CMs2SEgU1gCgL16qqYxj6vVA93EdVm9yTrt11rx4iCShEmUFjPNh50nC8eks2v9iJHaFBWTIJQIhsjEO8V77ZcKlqDgnP+uMHF+LVlpzNtjHJIm8SftJC9aDw
x-ms-office365-filtering-correlation-id: 1bae0d5a-f814-44ca-026f-08d61c49cf51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167C4DAC06C51A98C5930A0FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AWGDYmXJdKA7Dq4RPIDnoryyOg3seNjlNsT+d7jKZyjopv6yFpb0WNCxkns809is5M7nYrStsl6c5fO61MH6X2Tmf0/xmpwyF/TOarNoU9Py7T2WWfQleaySnlCXfUqHnCsw5sQxXvYnb5C4ZXp3keOSOHwx6ur2usikTS1+Sk63eujAS8iK0rG1nhore7sDfazpeaogIonnfK9tjLRqXV9wsU5UcD2hwC8qfFlhUnQBvxTaUBYIoYX2176R95nQ5EwkCDROFnk+oqZPSBEtdUbTykzJ0OJEYDuDSl7qb8F6b7iuZPzIPifLS9DOuTPi/iYin059sww+LHT9vdNDsVTaYsg8KjeJvWvHPqFWh6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bae0d5a-f814-44ca-026f-08d61c49cf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:37.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit a93b632c4531ff50c43d658447a45cbc11f488fd ]

Currently the driver sets the mask of the gre_protocol to 0xffff
without consideration in the user request.

Fix it by copy the mask from the verbs spec.

Fixes: da2f22ae7707 ("IB/mlx5: Add support for GRE flow specification")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Ariel Levkovich <lariel@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index cbeae4509359..85677afa6f77 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2699,7 +2699,7 @@ static int parse_flow_attr(struct mlx5_core_dev *mdev=
, u32 *match_c,
 			 IPPROTO_GRE);
=20
 		MLX5_SET(fte_match_set_misc, misc_params_c, gre_protocol,
-			 0xffff);
+			 ntohs(ib_spec->gre.mask.protocol));
 		MLX5_SET(fte_match_set_misc, misc_params_v, gre_protocol,
 			 ntohs(ib_spec->gre.val.protocol));
=20
--=20
2.17.1
