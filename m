Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD57214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f7ej7S6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD57214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeIQIZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:39 -0400
Received: from mail-eopbgr730127.outbound.protection.outlook.com ([40.107.73.127]:59536
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbeIQIZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTG+YkSisKfUtcmgU1Tz5yF/ixLcRI2Cp16EftZAYaU=;
 b=f7ej7S6ctn4sKTFNj7oEnGp2JJTXZmhhYhn6hyiGVLAv2snc1wJGRlldoZ8lT9+WldGgEc9H3nBRcHDPXts1mZyg8YZA7/q5zTwd5Ayd53MVkNrEXkdrNvLZllYrQ3oP7HJ7OxD4LLUtFvncaWJXBNP4UkVOx9ZAdB7E873dI0A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:00:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 010/136] net: hns3: Fix get_vector ops in
 hclgevf_main module
Thread-Topic: [PATCH AUTOSEL 4.18 010/136] net: hns3: Fix get_vector ops in
 hclgevf_main module
Thread-Index: AQHUTjKQUBWYguYUckC3qs/a6sdM0A==
Date:   Mon, 17 Sep 2018 03:00:17 +0000
Message-ID: <20180917030006.245495-10-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:MKNPn/32pwQxRoXq2uyGxQXfG0LCGZL2roqHmc/k23BFyNK0AXzNVRZD/qGWOT1gJxl3fyRGvnD0BHCuihqm4lqtnTpiP50TWIeNN/2KIBkySXfr+Yii5u0QKqFKlIowwiCTD6iwZ2KBT1nxgk+ZtPGAhwK56j57jHRHo033lBYIjopf8RTImWcgUqXFUFQ4kAPqP4+doAyywun5u/z0Nt9HoYYLzzTgowARBKojZD+1tr5r3N7e6AXaBAgYGyR9ClEJYYFtgVMZTmB5PS4dWmHoOALypEiqlnEJbLr5+LQzO1GgKbuZUWP2lJR9YJGYbWfZt9Mmns+H32VqUjsg7nQxzz0nXKNHvaI0leJikxE2aNiqhF+ORgKzX8h6MREsEh6FOoUDHyIwur8sJxpbuVaRYD8xg0JxvOmldkbZtepo6EajYIhv299tu8QC7sl3lqCTh6K/XxxfExicbAIV8g==;5:h2mjGh/HZnPr1HfE2jYO5Yq13ths//WhbgAm4kLZDkP+UNcPnCCPJdvkspdQU/bv+sXnHqKTX/HJlP4aWdXusiLdfp7Ylq6GiZCSU/nlLHoB4eyTvCFHlhIjnIBDKUv3vrk7mv66WJkZiY/3AssnD6hnTLnGFMbebOY7Qdri/64=;7:e3iYIkg6KtFDGhxECH8VSbjgUnAvmkWu/2xE4XNflzVCSQ7WOl7mjVXK9pORXJTfCU+qFCrOmhB9QfqxjTCEeyn0xebdBlRkr4KqUjRmwXCrD4Xos6SvO+XMe6J4m7mRz3TvjYT//wwz8Yf4wHWAF0jY5dlWGZen/ecgQ1f9IJMH75yo9XeYglRpkjNpG6kUPIK5pX6lEjF9/z4O0OI0/2n7Z9YvIXWwJPNc0qPbaRAF723M5B96u1lX+fm15D/S
x-ms-office365-filtering-correlation-id: fc548153-f63c-4c6b-5cf1-08d61c49b55c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB062972E9EB3A38784ABECB67FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vdhwVggRK3YL/sUnY0ad2vHVleybb6J3CaUkvvpSfMGwKrV2Y1gDDCGZfJy2oxFRAXJaFaZriyOr3kuDu3jnnZfr6o9G5RiUN1kctpX10mVllmFgW7Q14XWD+Akxbm3AiI1TTD+x/F+v9dPdq3k+6iGi9SquPIqNa4zKOc+EdfCr5ItOaYPlTjsPG3J/ffEgus/+sVBjmXwHC1A5DCfBvb9QZf76caY4J7TB08s1AFPix6M1izMhpdM8AFUOlezl5NkBaqSGDKkHhkyoKfiTbajTJXXL9pOVdFVzr+Q/80cYlBeGvkkHhtg84m29oKPN4HWrheGEC86aKLtLMAaT3wecTvEaz3h4x1hBhxzgM+Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc548153-f63c-4c6b-5cf1-08d61c49b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:17.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 03718db97bfb57535f3aa8110f0cbe0c616a67c0 ]

The hclgevf_free_vector function expects the caller to pass
the vector_id to it, and hclgevf_put_vector pass vector to
it now, which will cause vector allocation problem.

This patch fixes it by converting vector into vector_id before
calling hclgevf_free_vector.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Lay=
er) Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a17872aab168..12aa1f1b99ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -648,8 +648,17 @@ static int hclgevf_unmap_ring_from_vector(
 static int hclgevf_put_vector(struct hnae3_handle *handle, int vector)
 {
 	struct hclgevf_dev *hdev =3D hclgevf_ae_get_hdev(handle);
+	int vector_id;
=20
-	hclgevf_free_vector(hdev, vector);
+	vector_id =3D hclgevf_get_vector_index(hdev, vector);
+	if (vector_id < 0) {
+		dev_err(&handle->pdev->dev,
+			"hclgevf_put_vector get vector index fail. ret =3D%d\n",
+			vector_id);
+		return vector_id;
+	}
+
+	hclgevf_free_vector(hdev, vector_id);
=20
 	return 0;
 }
--=20
2.17.1
