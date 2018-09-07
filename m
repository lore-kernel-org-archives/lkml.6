Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E824C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CGnR0EYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeIGFOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:20 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbeIGFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G0ao51ajZKQ9G25DRvlSUntjy/We+u7YVFNzZBAx/s=;
 b=CGnR0EYsX8Yq0OW1E5R4Gr176v/lwvvgUnfxLBeiXaA02kV8uasQq1kQM66A0mrTTEQHvlGHakOw5zHicS69StSrNdRai1//D07b25myacxsAMybpLM2d97fYPt3D3Nt2HOGYhYDpQnGdvgiLnBa1eiHuEhNwRo61EJd+39pVdE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/88] amd-xgbe: use dma_mapping_error to check
 map errors
Thread-Topic: [PATCH AUTOSEL 4.18 12/88] amd-xgbe: use dma_mapping_error to
 check map errors
Thread-Index: AQHURkLAToYAuEj3QEuY4tDqj/9CbA==
Date:   Fri, 7 Sep 2018 00:36:01 +0000
Message-ID: <20180907003547.57567-12-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:p493MaA7YFOldlcCYx9Flq+pzCLpclchWrdk5+B+Mlhz2NWXaCkTvFR03D8y5kv9Xz6jwiBh7vmzPH+PwR5Az/y7KinT7XWzUn5fxe4sE21CIGCJl/8PAZmrkKEpI47g5VegApOrfUMyD1KK8JQNZO98/4WCIr3VmJYBEU+af84Zb+IpoJfYhRYG9A8O5zfFJ5BLWspxfAbKWLzSNxR3rnlSPboJ3pyaMcMmO2hOkXkEjGoz9Coi2KW8ua0q+OiYohN8PfB7GvhZXxpshxob7UhhjOoDXpMi89XBm2OjEdPrs0JS+0JUEiFGS84q5JfL9D/j31GSIy8Q+9JzJTNf0BpQ2QoSp+lPvpZN7mSu/YKYAq9YFrNPpF9YdygVLD2JYG6fjBzLRCwxCfxgVAuLneRV4RMSXB5UJfUyyqLLDvKyiQxvoEqMkxPsYzhNwdG7fVxgCMD+YkFE0XahqAOy/A==;5:m3iQDqvj+WvzxjMcziHRSGSZstNjaQlvVegNtckdMfR7NJXiEvhZWcO1elHU2H2aURTdimyOINEhoFiDtaqg1QDgKVPoxWygE/k7cztQT2i0ub+Gyoe95djqmK3NskaTDOWkHAxbryQXi8S3qeWFifc9NYLxxwV/DvKl3Wpt3Kc=;7:g1dTZOh7Y8P3GWJhwsu2xTxGGSx9W3g56eXIT6t1Cf5Wgc33Vh9P3zaB7903iZEXv28eLrd5CZjVIxlFFmsbqvKstJu3mUoKSGOfpM83imk/ldNNosptLOCjUNid+EieQIaPgUM+R/kOMiJtIj3QU+kIAcgWUsoVjjty9mCkYwX4D1pYgLkRSrYaZxpfegm/+63xGVyKeftvC3unKMGPuMXAWfE7Nl9CtyWS1Wjs1NwRHsIE0m0fRp8alkrtwMIE
x-ms-office365-filtering-correlation-id: 2c2701e9-bbe5-404f-b097-08d61459e352
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077302B95B4D72A21EB6A74CFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0zqNc44RxHj+iU1KtpEIM0FL9ZQ2LRAm+sF8+tm8PG2qK8F4X6TS21e/l6ZeY7ehm3fU473qdzpo4XxrjTfuyH1xMplPJlvGZWIhJr/bDuxyFnjl4RsrnZElr7z4Pr9DIO7bGEpId4bFcoxj01UCHSKV4ZlbXlHNht67p8fLTQqYwaKNbdfJC+wUV9jdjfkJWuet5VGpMlGaBkkeggmSP990/8UT/t2WQyWs0QBFT+06G+jtbIzSGZYQnf2qfinw1CUq+4I/6BcWQbnZKSxkQUY7K+HPrXKxhjfW3m/TK4RMfOKFPhjSF1yVLfo2q5aEO4CNRqf1tbsNCvd+KJ6QjMS1H1yYDRolVKRtFbXk68U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2701e9-bbe5-404f-b097-08d61459e352
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:01.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit b24dbfe9ce03d9f83306616f22fb0e04e8960abe ]

The dma_mapping_error() returns true or false, but we want
to return -ENOMEM if there was an error.

Fixes: 174fd2597b0b ("amd-xgbe: Implement split header receive support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethern=
et/amd/xgbe/xgbe-desc.c
index cc1e4f820e64..533094233659 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -289,7 +289,7 @@ static int xgbe_alloc_pages(struct xgbe_prv_data *pdata=
,
 	struct page *pages =3D NULL;
 	dma_addr_t pages_dma;
 	gfp_t gfp;
-	int order, ret;
+	int order;
=20
 again:
 	order =3D alloc_order;
@@ -316,10 +316,9 @@ static int xgbe_alloc_pages(struct xgbe_prv_data *pdat=
a,
 	/* Map the pages */
 	pages_dma =3D dma_map_page(pdata->dev, pages, 0,
 				 PAGE_SIZE << order, DMA_FROM_DEVICE);
-	ret =3D dma_mapping_error(pdata->dev, pages_dma);
-	if (ret) {
+	if (dma_mapping_error(pdata->dev, pages_dma)) {
 		put_page(pages);
-		return ret;
+		return -ENOMEM;
 	}
=20
 	pa->pages =3D pages;
--=20
2.17.1
