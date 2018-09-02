Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447E204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dXQnea/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7447E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIBRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:07 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:27920
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeIBRWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd2yjo9n0XPMbNU2P3k5YbaW0d3+yMNWa8iQmXQvJMM=;
 b=dXQnea/0H0vLW/7cCn9ZaO/3+6Q9RHYRQ5/toSeIn0OwKaKh+Gk+TCmNjdrJQazx9sfLKehCUON6Vp8HwZn4M/Cn0xIY/qcHoRnRu2PYuUtzfkMU0X3akw87Cms1/Zl7Vw4T1c5zpgyrE1CbHnTGO4XJ+15CiC4OSEqqmaUq3Cw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lijun Ou <oulijun@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 122/131] RDMA/hns: Add illegal hop_num judgement
Thread-Topic: [PATCH AUTOSEL 4.18 122/131] RDMA/hns: Add illegal hop_num
 judgement
Thread-Index: AQHUQr2kbqe/RCNkkU6y8U6TQx9lxw==
Date:   Sun, 2 Sep 2018 13:05:37 +0000
Message-ID: <20180902064601.183036-122-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:2m2ryVQ6riz27Rf1+rfwgs9Xm5rzsxX1Ax/Ylgf9WKZGTVEOSiP51nAx03CZAKuF8ckeNNS0lVQi5LlFe36Zryo7Pfkvpap1rFt93d2Zu0SMg34ku16MqPJ6cEq/SAwCM99L1H60ZdJFP8akyZn9TmI6UFod+c0EwEaJ3ugnuu1eY0Z4ZW5O8zxFPCd9fu9j3xRJQIqEc1KPiDD142J6DPDKfh5T4N10vmGnKuRp5FGs0ZJGCyyZyEWuY1AZ1wQ+zzo854aYZj8LIZUX0yijidx3XNU1XRiFBowH/+UFe3hOThJjFVMMUtafy8MFJTaYNYLAU+4eKacsYegn+lCvUcwVVgAVR3pzG25GXICuTA5L7Z138b/fV9JpmEixlatlnfc6LxaF/wOCR+KfVEQib28+8VYzc/NWVi5gbtt0EVB/Ti9xK0wyRSf1NSpYMxsJRvMoMUp7miCETA5yzabcBw==;5:F63wM/De6lKpMnd5Ml6GToK6zu4ghavXYpXW8qZmv7BPV1VgoYYLlSPkPTIn3Zq3z8mvebOsddqK+w0KjHpDlmKumO4haQbqpF/y6ereGj+GBUv+bu5XTxtEGDj8enS+CD3/Z95A1jyZwEtL5ha+Sxr+UL+ZUob4jfcurRi9lbs=;7:grvgrEIbFl986BZOq6Sx017iJ6aRuLKwll2EfbFeAYKXr+upXXrb/7j3w0Kj6ZRFHOfjy6hWQ7Jx3TqlDLBQyxaTHVaJqJqULeZkJ/ph9KSVJi6OFdH97kusMMUPF5LTyh0O4nAwM7n+mmHZkt9TqHgLNhK7UlT7nlJ0nXtvvzpkN4nRLrh5rP+BxL970y1Jfo8CM/gOxY+oGLKUXYelaGO3yijQ0StIzBMnyS7l4vyUzo1A7Q7x+J4ZCAoYm3qm
x-ms-office365-filtering-correlation-id: 21f47340-43e5-4782-4d16-08d610d4de18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062908E5246CFAC023D5D615FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2kW4fCX1PmuSsu/ZFaiqdTcwzA2gI+AL43041mZo6KAiMd47djnomA019BUHVAXtvygq8O+OU5w6EtEf6LFR3J4H6YwCU1ui8dFzKOqPXmitfBhQ0w2qUQs7ShFXIi+k8QVsF6ChJfwL6Q+sc2VHwv6EwXUuN1uI8+sycr5DiJLeHqomJ/RkbNyXrQ/EhLjsH7jKHZTqjQKiGB030yjm46q2oQPU7/R85yC0f9YWOzzY1pPUVjWuqxMobmspiqTLGyaoq5w/SzwHh7mhvhk/uYj6jgZ01YBT4t7UYsrggKgFpovAYcMC1F5ZZ375RPbVyBBJGuMZKBaU0yBnF+i/qmYp10IUxXqwpyCYc5Ha2kU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f47340-43e5-4782-4d16-08d610d4de18
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:37.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 26f63b9c33ceda12fb9136a1d0c80e03c9ebb514 ]

When hop_num is more than three, it need to return -EINVAL.  This patch
fixes it.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/=
hw/hns/hns_roce_hem.c
index 63b5b3edabcb..8dc336a85128 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -494,6 +494,9 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev =
*hr_dev,
 			step_idx =3D 1;
 		} else if (hop_num =3D=3D HNS_ROCE_HOP_NUM_0) {
 			step_idx =3D 0;
+		} else {
+			ret =3D -EINVAL;
+			goto err_dma_alloc_l1;
 		}
=20
 		/* set HEM base address to hardware */
--=20
2.17.1
