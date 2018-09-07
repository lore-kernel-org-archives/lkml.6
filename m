Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F8520844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rf0DRTfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F8520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeIGFQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:31 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbeIGFQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRxvu7C/Z1xNlbbxnOwvvffY7HBJ7FaeNQk7k7o01Tw=;
 b=Rf0DRTfCj5Nm/cUxUqEEzSpoBZ9jm5EC2zOWR1lUmk/90nLs6MkY9bdGAm/Ql5O1VQiZg/dU7dsV/2CJCjqew5H+h1qvCeg4LCEqjbS8ztulqTVEZ8ha7MxfALPu27rIauAoli+JaP0K3htu6yGuXhdKwFJ8PMEzrDIXBYImR40=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/67] amd-xgbe: use dma_mapping_error to check
 map errors
Thread-Topic: [PATCH AUTOSEL 4.14 10/67] amd-xgbe: use dma_mapping_error to
 check map errors
Thread-Index: AQHURkLzNfcCP739tE2vYPHJ5puNZQ==
Date:   Fri, 7 Sep 2018 00:37:27 +0000
Message-ID: <20180907003716.57737-10-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:Nav23kzwKb+5UzyhgEQplPqeuAv6dv+mspwaYmmAHfvhRbsuzsZ/donOzyKGD9akTDIOq6daxy0MxVkU1EALqlyBIf2kilY4j3I1PjoM9QRp2Bsf+N+cm4Ko0ZQAu2cDl3KTsyzB4c8TSBMuTJVZwzwp5CkqlaiG3dUeEjtOV+DycvKy8vxdaUMM1aX7P1Pkqct/IwxvhkAI3U7JgmA/bu1x3MCCuamzVOE45Xn6zya643NYf/NhapQBTXXRbIshuX7u20oYV1LNpHy7a/9R72XMEsSTkjzPwGTkMjM6ql93PdbL0KYMxk74wQDaNK8uCn/haenrfHdEWPcyUyJx8WFwQXngfUjUD+lvd8MWcZOJpW61hmV6bMO05Jk2bF3RKTkJLn68xYsHCXXtG+raOKJXtXhycMB9BNfaKTBV2P3oVWjRZtbcUt5s4Z7BDHsIFHgl6repbW7wOtvVaksHXg==;5:pCLgwZjcCNCCDRAWxfoaAzCpyEZdpojg9wCua1prAR8bHPXr14q5cI4iKPXpOaUE+jgHemUggWFPCYvpwdIAJiBLAVrp+Md53ninU791C1jQo5YLy0ziA4b1VdEEtXwVsfdsXQ12uU1wzdONMtwALVixHANxMmPv2fqvRPJ66Nw=;7:VSV0+DktnHRWapHW/3qgLQaoGgWxeRyDR7NTCGAHK14BEmW1pD4WKQf90Qf5dAj/WzezXfTQCp1MNMdJ0cpZFKwplNibzi42XEl2Cnc2LdxLqbGYm4nJqS36SzUAOvNDjbdubWJgsPRGnhZZghVScRUvAKmwkj1ZvZC1TtzN1NAnnyakq+XkJ9/7mUyXVGuXOLKpniVKPzeTYgdXZheORY24hxDPg7TLs9ph+iByFtxh2fbcSSlyHg/xfYmuTIAd
x-ms-office365-filtering-correlation-id: b4b9f4fd-9767-4476-5b02-08d6145a335e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839429D0E2BDD2B8E98E24FFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: scZgP8aASxyLjAIfYJRuGmrVPHdYKsSwqWC1vPR2wyG80SSH8/fvQoinrqIY4h38dygBC9GGbM/gUUaQOgbuGiC/HeyvvLyzc/9Q0theJ9B2Cehm/FOmPcEJSGOamk9+FoC70OTim/b0YsSVBE9E7E/ZnSchgEfmqvkL3iBb70RTnsQR5MMtkDm5Hi0G3IZepHsk2qxjfxYVev41uSyI0uMVQRMtBHLwBhHmPubfpsbvaGwBqKNINuEoi6PTwmYHwrGz6Jgt68yBVxdQh56qv4prJXtfwjRmVLvX+ovDGFdN4FyPxw1oOhQp0HSioR3TLsVjpS2ByNRhidaip2zR8TQKhezRkzVBAlwyH9SiVEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b9f4fd-9767-4476-5b02-08d6145a335e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:27.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 45d92304068e..a5eaf174d914 100644
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
