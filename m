Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA3822419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ISJLlqFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA3822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeKLWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:19:36 -0500
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:3150
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbeKLWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=665VAxaGwNjEYt1ewPjqJ+2qcjeKbwLoYKc8JkoAQzk=;
 b=ISJLlqFHCpzNMeGjsXARkJzuECYbywNHp3CuTqr8EW2Z6Z9LK9t6R9DxiJPWnbS6Uuo0nOqzgWINwP7IW2KQ4Wo8x52NmRXIc/gEDs1PwIIuiF2P7sBAYFqM5X3ItYp70XR9751IFWf09xibeqLFIVhP9KfvNYWhJ4X8sMGbDho=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2715.namprd12.prod.outlook.com (20.176.116.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 12:26:30 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9da0:57ec:ca4:8b1]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9da0:57ec:ca4:8b1%3]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 12:26:30 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        Filippo Sironi <sironi@amazon.de>, Wei Wang <wawei@amazon.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] amd/iommu: Fix Guest Virtual APIC Log Tail Address Register
Thread-Topic: [PATCH] amd/iommu: Fix Guest Virtual APIC Log Tail Address
 Register
Thread-Index: AQHUeoLwGAsFBj8NSEiOjh7412jylA==
Date:   Mon, 12 Nov 2018 12:26:30 +0000
Message-ID: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.109.129.36]
x-clientproxiedby: SG2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:3:2::13) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2715;20:aG4zjUnFvF6IBodVvkAjoycSO41qzzfuZo+jUyp2P8T+dsPZkUlDL2KiiUEvrSAZXGuQkVkxjFTAAE3SZa9B2RxS5z5n/w1hIjMaBDClb622bOYqbDgSqeO7mM/lZaqL7gQH2VLDdjilh+mi5EuWCvnLpigX2RuLi2rD+NUa2deZxp7QQhbPxLFAmO7mDzMLRhdW1TonoG4Ysm8j3V1DIiqMVuaehmpQxLrwjMX8Qt6S/m5X6upq8ra1opNOatX8
x-ms-office365-filtering-correlation-id: 8d01ee15-a3c6-49a1-88a2-08d6489a12d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2715;
x-ms-traffictypediagnostic: DM6PR12MB2715:
x-microsoft-antispam-prvs: <DM6PR12MB2715FEA3924AA23241899AA7F3C10@DM6PR12MB2715.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR12MB2715;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2715;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(71200400001)(71190400001)(97736004)(25786009)(8676002)(81156014)(81166006)(8936002)(2616005)(106356001)(105586002)(110136005)(476003)(486006)(54906003)(316002)(72206003)(26005)(575784001)(2906002)(1857600001)(478600001)(186003)(36756003)(86362001)(1076002)(6486002)(3846002)(305945005)(6116002)(6436002)(7736002)(6506007)(14444005)(386003)(256004)(68736007)(14454004)(52116002)(6512007)(66066001)(53936002)(2501003)(4326008)(5660300001)(2900100001)(99286004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2715;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eIde8/cACK6+qD64VIcaQYEuNgpepV7T5G79azf+IuXXhHl/nTyuMyMiXhD7aWGDW9k1X1COuqVe6TTy4PesJU24rdL5iYww09WTZPIWzfoUhAbFHUfKMVPodSw5B/6bpdpcHum86rvveb7ESSDFCIkbAWijoVtNO7FwIhNWLbcQAR81jvqlffL5gkHs/xYbbbEMh3KHRoDStSiapi4mcLAA2ed1lZf6urRGE7E9i4p8vhzmN3ON5/+91Fe8FPXtuMzkePv78p0Mz8XDXQDLkiI9yjfTP05WkpNPQ/TP4TKLNla8qnSt6U7DQ9QGtVkY0/5GE89zahIk0yqKtcH4P79fHi9ykUszKFu00Ge132Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d01ee15-a3c6-49a1-88a2-08d6489a12d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 12:26:30.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

This register should have been programmed with the physical address
of the memory location containing the shadow tail pointer for
the guest virtual APIC log instead of the base address.

Fixes: 8bda0cfbdc1a  ('iommu/amd: Detect and initialize guest vAPIC log')
Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.=
c
index 9c3d610e1e19..e777fa90b2c2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -797,7 +797,8 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	entry =3D iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
 		    &entry, sizeof(entry));
-	entry =3D (iommu_virt_to_phys(iommu->ga_log) & 0xFFFFFFFFFFFFFULL) & ~7UL=
L;
+	entry =3D (iommu_virt_to_phys(iommu->ga_log_tail) &
+		 (BIT_ULL(52)-1)) & ~7ULL;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
 		    &entry, sizeof(entry));
 	writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
--=20
2.17.1

