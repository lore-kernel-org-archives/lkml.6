Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09649C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2A82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BaQPfL91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2A82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeIGFOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:43 -0400
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:6633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeIGFOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhVqBaqrjju4bEyNuUnY4ReVBr3Bx5cqVS890VItgr0=;
 b=BaQPfL91YdC6pxuGnhkiKctuUnc9aJbAimKoGCUSy0jt8hgskyqKDt5ShpE2DUYDDZNefVL0xlDAgGXN0ghPFiX3wKtqKQ1foKVGLohh5GH/xRhJunq2jT+GzypOYCV0NgFL74NIAPynRJSDyentaRt+DwYYlpyGFHbPAlSThO4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 04/88] iommu/arm-smmu: Error out only if not
 enough context interrupts
Thread-Topic: [PATCH AUTOSEL 4.18 04/88] iommu/arm-smmu: Error out only if not
 enough context interrupts
Thread-Index: AQHURkK8sHo1/Q4y9UqJrTGT5Mv7iw==
Date:   Fri, 7 Sep 2018 00:35:54 +0000
Message-ID: <20180907003547.57567-4-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:fJAs4nuo5ZKSxiGsqXJ6rxL1vRPnSx+5/oJRgWg2lXCmUerzD034vTQpMiGyAtMeU9E9gT0xribg157UE2az4+nSpYOr6X4lauZ3DZF8S7VODVVEuqBPanEEvMlFygyzwJQwALbV2W8eb4mFZN7SixET+39zdTZ+hFYSqWWsbN/NUhCCwA63dIXL5xLxTzmCMIpp22zFHduxfarti52CgtguQ/32gLPaJJYScHnsOLRgO/GiyhR2pN0fYThNXhQM5hXKhpCat+FIwMIWv0c7u9QvBZLR09mdoBNOT1HPXkgJqosSi2O+7QDNkFWIUbo7ZwUvBSb9JeaeSW/tezO/JBH6wd9YfJw7QoLeOBTCsWoQ82OJl0ibCay/kxse1rr0KQ5mDfsbxHyojRT//UTwReLuPxehMF4CzWlAjqTwWaChsmjUJqslcp2kt19k5cLDxtBnFdGW2nmDoP2sdrqlkA==;5:lJjBkeEdIYMBAVWRQWwqghAQib4Xc+r/T0HLjQZ8wnXyRq0x5PEIbEnz5XTPg7Vb5nfcChLBiX8cajFyKKjYe9s/z6g9zT3ywBhadLvBRRZ6uhIX7034tqwrKLqldmGOMu5nV+9lc1IQRA6cOfoLdE1KPc6lBo7OBYOwubXvn4o=;7:X+bHvMwjgV0DOjEghPLcs+msX1wOv8fpRqRNmnsThB3oItljx2e/RFNMDqMlnPNlWaSmwF9/Pz/+VGC11fGHXv6q9EKykVrjYMDc8wYndphGxRqhSxZoOQLnMZsLepO/K/0HUxkNx5/Jcfznzfsr38VLQyKSOy1mbqry59L3f3dSzJ1qetpwE66m35FRn1xFNIONQ9sfRYv+Msz9I5gLtQubHaTzWCJh2trXUxn3l8JA+wnqdWTS1qKqJQuiqlqX
x-ms-office365-filtering-correlation-id: 350f5bbc-c545-4b6b-1137-08d61459df30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773498A82795442E9EE8F52FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mrbaT6+LEpTK1OkSQsxxH+0aon1Q0+2oaw+EXqwyFdBQvGO64S0vSkSDKYDz6J+Y3Pu7jUcI/CB0phq8Qp6a896jGB69fDGqTXB6CE50yl5dLYG3tVhWIQ3KpxLY6YR4IPEvebQzAYcevsZNLp4kf0at6hnK2yCPqaccamHE7hA+VIYVsxNqfR7/XCDZGnIOsJz++91Mok6LpPOB5KmAKJ9cBBHV6g8nqrcusBUNoEnYhvYIuJkbeQVHuK0+Z8Q8W0zhMZfcBn/mXUcVDQCsacnCbTbb84dqKJh4izGrHgvuOI8E+SvLbFPYSrlL705o1b/cZ6D3681VI9m+/9T7PNxY0Kg7pDwGSyrZD9JOlFM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350f5bbc-c545-4b6b-1137-08d61459df30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:54.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Gautam <vivek.gautam@codeaurora.org>

[ Upstream commit d1e20222d5372e951bbb2fd3f6489ec4a6ea9b11 ]

Currently we check if the number of context banks is not equal to
num_context_interrupts. However, there are booloaders such as, one
on sdm845 that reserves few context banks and thus kernel views
less than the total available context banks.
So, although the hardware definition in device tree would mention
the correct number of context interrupts, this number can be
greater than the number of context banks visible to smmu in kernel.
We should therefore error out only when the number of context banks
is greater than the available number of context interrupts.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[will: drop useless printk]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..5349e22b5c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2103,12 +2103,16 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
 	if (err)
 		return err;
=20
-	if (smmu->version =3D=3D ARM_SMMU_V2 &&
-	    smmu->num_context_banks !=3D smmu->num_context_irqs) {
-		dev_err(dev,
-			"found only %d context interrupt(s) but %d required\n",
-			smmu->num_context_irqs, smmu->num_context_banks);
-		return -ENODEV;
+	if (smmu->version =3D=3D ARM_SMMU_V2) {
+		if (smmu->num_context_banks > smmu->num_context_irqs) {
+			dev_err(dev,
+			      "found only %d context irq(s) but %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			return -ENODEV;
+		}
+
+		/* Ignore superfluous interrupts */
+		smmu->num_context_irqs =3D smmu->num_context_banks;
 	}
=20
 	for (i =3D 0; i < smmu->num_global_irqs; ++i) {
--=20
2.17.1
