Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0EECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9334721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cHN38DSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9334721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbeITI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:29 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITI32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBFARI2JSZ9LovBRvFa/+MgTOhGxVQmuvAMjtPQGZRE=;
 b=cHN38DSLyeNaF4CrZQ8Q9HcdTdc3d4fJuTqEPvOvZXpgNyixwC9DIcKcXskiTQKEaEvd6T1KzsRN8y+kDD1lanbDUUtZyKKH0Sn2rBRHTh0zJ8Efpi+6TJeZBzJDnVPuvh1ixu+d0faN4kn9LzmYqhiwwhMlV5x/kTazXG4G3P8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/56] ice: Fix potential return of uninitialized
 value
Thread-Topic: [PATCH AUTOSEL 4.18 35/56] ice: Fix potential return of
 uninitialized value
Thread-Index: AQHUUIxTAI9pD17RkUG3q8uSJYlDtg==
Date:   Thu, 20 Sep 2018 02:47:52 +0000
Message-ID: <20180920024716.58490-35-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:s+gwOPloLqRYhYhfdDieQwz6pAK4inv3wrKYrX1upRlJbcIT+91kzFX/HWucXgxKfukPDTSMAVh2XhwhdiKlRwX8pan9UM4GbfKuhitggIFHdDrk1lgJauFYTzi7jDdJPZhzIiZJVEOEAQvxE4BLJnB1gWsnh2rUODghhfEWw5RiKZE9RMXrTv896uzsItwEvm3W5B1/NNm7A3ZytqYlfU5Dz/Ufa6IPNXDoe5NACV9Jj0pQlMhHbwL3EFp/fvtz1FTlxQDQDYk+Edf6FYq8GUVcq5tl/S0HvRTvBtRKXP7nLp1XwxIVF1h6ynhY2HftV7VkeiNeIrEfHxK9H4Oalky8igNomClUiHVvXdy4H4fTZ7Lf8fjVHysjysdk5/i8cuUftLO4Qt1fX7oBrqdsBNEprJocb+hJrvMF6YB/cHXmL8p76VXOJkk2v4woQF6muLFEc0nuAww9PZSKAn/8GQ==;5:ADJez8uXFYajwok3xSGaHemnA+M4fzYqQR4uEuBnQc/gtCo9k4lXDVekZlST0nfnKHkfKqPmtRqtu0GMoi/ohjpS88ZieLNI7g4tpi1p1Gst0Q3L5lIeKPqquXh/TWxqnHoFWe/D+qRL0XuQ8YYMjOIXZC3joyNuCr2ag62S6qQ=;7:hkDzDYZKkRxrDEc45089M0s3fgDnxyySI+zMVlbzKUi0LEEBEW685ITQNgorq47VMBgnneMnlFy8D9c/7DmRlMrwAp7BFXeMMKu7NoQbEK0X0fHfxGZhzOaGWkGiidZ+3StFu0Fpprr3Y0MmArRShm1JIOxPn891qaQJZMSJqJtDFM/nDXUdfw9ZCRewLqcBU5K+ZvtHIa+1lphkfqe/qbDj22HMGnCN4Yrz3vkzobJWuqoRzPKpwu1aB2kGRLTW
x-ms-office365-filtering-correlation-id: 94355663-e563-4f39-1e8e-08d61ea38755
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165E2580C2A3CEB06612A4BFB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1a9CsEbPq01yjnrI27Q1FdMq+lYbDOmkyLTi10uPzAJ6u8SY53f90u6TmDlcWPBJ46Xc4U1JzV9FuJBbOr+iWpeFnb/rWz4S3mcoCoD+jNtxslvqfJ1MUL+AQvVE9ifEE958lmVeXfZZO3VNSET+6fMaWZBbPbmLnF5VmLuqJVbai2INJmlO1aP0HyHm1DrXansXMeDJserKOnr1QbsufZBBP6z5s5RVPwxWIbAm8m6zKAwIdK2MFClULXUMb2/JY6JBYQP0EXfOBWO6e2ZRFfJtlVoeLMMV+pS8fOLiZpvmt2QgKVB5WaVeojxtKX3rRU4DNNPUW1Lin89vqXGpZMBG6L4QUL4WLF0WbpthYCM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94355663-e563-4f39-1e8e-08d61ea38755
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:52.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit dab0588fb616c1774bbf108eab1749dda4ac6942 ]

In ice_vsi_setup_[tx|rx]_rings, err is uninitialized which can result in
a garbage value return to the caller. Fix that.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index aaaa1e2a7df6..27c9aa31b248 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4888,7 +4888,7 @@ int ice_down(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err =3D 0;
=20
 	if (!vsi->num_txq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Tx queues\n",
@@ -4913,7 +4913,7 @@ static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi=
)
  */
 static int ice_vsi_setup_rx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err =3D 0;
=20
 	if (!vsi->num_rxq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Rx queues\n",
--=20
2.17.1
