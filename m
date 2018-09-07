Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E5EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D4C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AOt57WO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeIGFQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:24 -0400
Received: from mail-eopbgr690133.outbound.protection.outlook.com ([40.107.69.133]:54795
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeIGFQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGJEJ6jvE6UONsLUFLmDC5hMaPzLs1ZjmemFdoP/1/M=;
 b=AOt57WO8VXB6q1VHXPASaL9IFAfZT44xCEhe4F4iNGUrW+da8d93l4TAhjvBTOoIv7LNdLGgIoBzN4Q/g3vRLVRyLqSx6fwWsWTY5HXCuXp9m4eTigqAHywQXtAC9kIrkvgzfGqBzTLWDK/t2GZ4s2FGn62xYXaSRGRx4H9MTJw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:38:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/67] iommu/arm-smmu: Error out only if not
 enough context interrupts
Thread-Topic: [PATCH AUTOSEL 4.14 04/67] iommu/arm-smmu: Error out only if not
 enough context interrupts
Thread-Index: AQHURkLxk9/c3AITIkG+svKJ0/FAZg==
Date:   Fri, 7 Sep 2018 00:37:23 +0000
Message-ID: <20180907003716.57737-4-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:FrFFTawyBa1Fe7wM0q7pUbYnA61ciC9PViDcbbjkTuX9laCZDLlhGcPg9kZyBenEYWPrXJwIlZrktA8oZam8pKmY9Ul+gZs+TiV8/dRK9XfH7JOKTFdR4orSWgR0AvHh9UI0+5cjh4GL+rq9mfv/4dF6DbM47Md1i1DQshgqNUD7ISgLLO2+zfExGup7WPgADjvZEevAg3dzSeU8qdM9/93y/6D8T+GJ00Y2hmkObmmU/ZzD1iIqoLn+aWJ8xU1KqkSsGLbn9It/SJMK0Uaq4dnaLziTNXoQUznpoPs9yVEq8Au/gkgSYPR0hyaNnWk9NbNaXwIX5udMV338CM/gfMMqXODyL+ko7+qWh34pKhgfGcrbqUtDsLgz7bmZif5PXeBt61wp2cvjb3IbZsDd6ozIipD2jCMEGfNhLx7cU4ntJSf918C2FqHo2Gk3CQIZRNQtLybx0+r5/GHAvGBPkQ==;5:HKTAGd+NAflw5HzJQvDs/sDTrXCTecBIAW5nQthLn2NEMBeGnBWEE9jOtsVC/eDC5RqyV1T8qUHJNBAWRo3su5S8O3sW6TS1DX6ixPghnYZqLPDY9o8GlD/tkazG2iKSbPWgfyAdycnxpEBQKqE7NKvYjlaILpMupqsUr7b94/k=;7:eSmIuigJW2gMm1EQwjO/l6Nkzo70sZKtnC+wLHJ//cBtpcKNAG0Ot64rXnejajFwvf6AH2Sda9KUQc8cMwbxtWsERAydt6hn3sQzSR8bQxwHr61lB1OMjHOUceAbDfjdGM8NY/vGoa3xhFrvZliJ5WoJvY/Ok7G+qQgdx/fhkIZGrZOB3QBDkBBpV1whlfamxJ1dYcFCf0oQyzpXgs1DsujT3RS0aXEcfjeBGdN+MkMR/0JY27Qs3JxNg5BAffp0
x-ms-office365-filtering-correlation-id: 764c73e6-60f6-48e7-6b6f-08d6145a320c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503664454DF64F13EE78C81FB000@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(8121501046)(5005006)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76176011)(2906002)(217873002)(107886003)(256004)(5250100002)(6512007)(22452003)(14454004)(86612001)(316002)(6436002)(486006)(110136005)(2501003)(6486002)(54906003)(81156014)(81166006)(8676002)(86362001)(10290500003)(2616005)(25786009)(476003)(8936002)(97736004)(5660300001)(102836004)(106356001)(11346002)(68736007)(6666003)(4326008)(6116002)(3846002)(446003)(305945005)(7736002)(66066001)(1076002)(6506007)(478600001)(53936002)(2900100001)(99286004)(10090500001)(105586002)(186003)(72206003)(36756003)(6346003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZD2xpIuNxEJr9ibhkEgRcmJ+xc/vLhGzEdZST7zoAc0ybsZDFzJuTnXiWo1aRBc5vAGHFPyMAm5nBTQ2AwWov0HS6/5wcWoHroASLrCnQqUP4Kcw4CFwffPx75YxgZ204r7hCOm5Hgd2X6HaP/VlqEH9s+JbzP36Ej1IIQd6gRHyLk54fjn3hW+5PBacmZa93Y2frT3A6UIgZ6RnaE/v2vz50orrY8LpkXfnXwI8R33r8wvab4dIHA5NJZX8KsUFAT58MpdOezoWSOX2rNMf2qJkoxephHHaTZpPT1krdr8RlSKPgWdQ5wPtfIlfNIPNz6dyq+fRCo7XQN1dCG1PCdNrVXfIrsdn5znS+9nU3h8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764c73e6-60f6-48e7-6b6f-08d6145a320c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:23.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index 3bdb799d3b4b..2c436376f13e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2100,12 +2100,16 @@ static int arm_smmu_device_probe(struct platform_de=
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
