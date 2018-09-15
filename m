Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8DE208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UVXdLiTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8DE208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeIOGrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:15 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:49315
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbeIOGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svx+quOcdsUVX5EkIMkaOwGtvQpGIwN9h9282BM55kM=;
 b=UVXdLiTve0qT4p6OvAW/wDZbEOFiD6POE7gOy3Ehg5OKLKq0hDyY9FENQgLtuXDv6q/5dTbHULV8Q4FRX1mPEsm7jfQrMIHmNvQKyjwCqF31DHZz/XFPa/GI3t81OM+Rg3USAGJTelq/wrE/y1+l9Pqn5yzbLyg3gfQE3Pyr2mA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 25/92] net: hns3: Reset net device with rtnl_lock
Thread-Topic: [PATCH AUTOSEL 4.18 25/92] net: hns3: Reset net device with
 rtnl_lock
Thread-Index: AQHUTJOinklkILAigEacmLP1sb/4Bg==
Date:   Sat, 15 Sep 2018 01:30:07 +0000
Message-ID: <20180915012944.179481-25-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:zl9/kZ++GGDOjJzZhl/XaKVqptM+eEEShErdVzsMhla0X5xQoKXB/mDjdd/bwV5MQdtzqxUIMP7XYUOs0+ysIjdxwl8snL2QVc1A1rAtoakg1F6HPit5k4fOyrlzhoNekMZcBmMzPEPS3yvhlWcVTcywiZRSRn5CTZOYG5zuKywKkIF3yKaGgluldGqZfWHDpxrOTsdugl1C3oqjBkbPixQadHnYkUgi087r7sQHX9Coxdazx4cedbkGBlcHCAdVT+PIAx+5tz8Q8yZYY+d109WZ4lprEXtFM3M632n++W+RZoeaqmG0+py/SckID2itaJtDg+eRTRwPSzNVF+ZFxzKuH7RkNfXNid4nLSH3R5vLSKxEUXTgAIulN7acI8sO84uAaHxrSBa4Oaq+Chbc0NfBAB9AYrR+ut8q1awEvXWjZHuHBCGk21z5t8HIJTaRBVJEm5nQh97pAjC4baAmUA==;5:ZMF7vT4x+8ApZdD+n3fzkmFEc0zie181021+KWvQF6BpU7tCPf9Qx0mjyoEZ39tRitEsHTzf9DWV7ZFLyMn31JuJVGJQYmGV0kg9+du4TGI+MBCDJNkoZIXiPwZrhN+lhjyEv9t4dSXL3RoDINkrVq0tLdic70+NF3ifQ6VBoGY=;7:eQoRQKKB21bac1wRiZyvQ3LusMjmxf0tnHVi3FqkiqeK1/TNx0qKQYn+eR/2qKfR47ToKMrXRaQbtG/FVsqCI2hUgJgVhu138enQW+k8PXPsLf1M85XKRvClKiTOX6WSbv3G2R9sVgFkl9iWvVTlGGClyuUZGDxItCZF6RMibj04BCjq1RGsIJGKYpZI8nQldnOqpEcEkMw+O1GScI4GNG9GXrmU8xFJ7dXWmOEMiF6Wjk1jHtvqvFGU50SOdhcZ
x-ms-office365-filtering-correlation-id: 6cd4b71d-05a3-4b59-5c01-08d61aaac54e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB082480F446C7A28E555BD165FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4TeXUrslDiILpDB2KwTzyk5INvAfeUMZIVUTBiltixs+s8FteAqeRYhz+Cmtkxvs3fr7vMqwb44uZadNLRACyupyOhEsd8NUj9UsohFgjEdeXcDThfL7AKQifYDivwI3YjM1yoljCBsENaYsrSmsy/NQT1bM4ulHJqIfzx9Phiwiu9uZO+fF5uHYzYVx9lK0P0B026OdAOybtSGemOrc3LFWo/J/Rn+1uj+t7Z+S5M8w4wf5ib8JM1ylNf5frgvdgEVwZesSfKamptmWjBrvFGv6PtvdLqBRXj3JNQCL8r/V+28S7aq2CPwZdFrJ8EdoP7gzld3YamjL79HGPKQse/epw7JR3iz45K+/H24+6rw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd4b71d-05a3-4b59-5c01-08d61aaac54e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:07.5732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 6d4fab39533f1bcd933d82d1667ceea93e4de260 ]

Since current locking was not covering certain code where
netdev was being accessed or manipulated, this patch fixes
it.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/driv=
ers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d318d35e598f..a7e0999d1777 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2825,15 +2825,13 @@ static void hclge_clear_reset_cause(struct hclge_de=
v *hdev)
 static void hclge_reset(struct hclge_dev *hdev)
 {
 	/* perform reset of the stack & ae device for a client */
-
+	rtnl_lock();
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
=20
 	if (!hclge_reset_wait(hdev)) {
-		rtnl_lock();
 		hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 		hclge_reset_ae_dev(hdev->ae_dev);
 		hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
-		rtnl_unlock();
=20
 		hclge_clear_reset_cause(hdev);
 	} else {
@@ -2843,6 +2841,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	}
=20
 	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	rtnl_unlock();
 }
=20
 static void hclge_reset_event(struct hnae3_handle *handle)
--=20
2.17.1
