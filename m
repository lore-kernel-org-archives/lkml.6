Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26354C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACA420652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PV0UgpVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACA420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeIBRbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:14 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeIBRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb3N/VwPPgvJjJ52Et7SAo1SB2Fk2JCzg8bVbTq+7M8=;
 b=PV0UgpVZniuWwGaRmzcOWfqdgK/NUz/tILGhrtpxCQ3U5J5H3bMPzYdzYP4X6tMtqgRT3S3EXvMf1FBbw8+Eis+d73qzu49mhGO0ddvuqMHDHrbr2KPnHpwRYpR/T7zm29EN3Qmj93QHcoSd74/TApA8ksyTVEB/TWSKb3ZLYsc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 41/62] iommu/dma: Respect bus DMA limit for IOVAs
Thread-Topic: [PATCH AUTOSEL 4.9 41/62] iommu/dma: Respect bus DMA limit for
 IOVAs
Thread-Index: AQHUQr7wIVIeNSrPjkOXkW0klaenCQ==
Date:   Sun, 2 Sep 2018 13:14:55 +0000
Message-ID: <20180902131411.183978-31-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:jmUPTPm1PsSV65Zt8SttvEKU0GtYOgug1rwIVyFKvfiMnEDYqYA7ZmnJZBI3OYwFgCORfH/WG1/ieb64QeKkSdAmDuNbOj/lsfywcpXKZLcZE6vCO8EVVNSOHG7Fjl/TLGtRrKK4sewSQanyE7iGD7UkQ8MYvSUcT5B0xK+yFWOOTpKqWBTUcR26w7l3meYrRWq7QF36mQwdCLRRRlkNAvxyqRrauQCF//vf9GePt5r7fE1DKMMaSs/O6yUzVag+v+S9+qpcWP6LGpdpJlnAQIKEVAgK15grBcUaX7nM42wTV97yduBKiYioVK/qKOmiVn8y09H708MQhqCoMvyjFRBEi1AEnlrfC71RHo7hW3OggOpaSBSnaK9ZgOFK5NFSfAe7tczaJ5UFTCkeYC6/dyVyMKdT/qgKD+AbrpnTem4wp4PK1QA/luLgTTLY/AFwfFfM7tmbdzv2yzGRy/sDxw==;5:7aAkrV6T8lAxVQ3VZqjmLQECMugyl2KuHQvMT7xaqCPw1GDU9sohi7+vhU7PQhJwfOrzMmEuGxoDawY/7x2338xawjBH/wHM9g+G88Zuvc62Vanf/7hiF7a1qmsff21w5CfaVLZoTwOT6fYQ1U5FOoMm95TIvIrH8wNTU1/QrgQ=;7:GC97Xrp+8ZpVGnW3mMHCGGqn6fPL77E/DQziLxv7amuJDQ3nhXWcKVXfPhcFD5c/R+tEX+Sp8hQdYYJyxIwcjZpLDuFQE3TY85+bL7EkxELOrwoZlVd2FJ1jKbHLOEkagrYtEqDAL1etaeUwkTDX7Z0C8bp65jnT/ZBl3xF3AtJsqcf0EhIC0hcSoWgDxdAm0X7q6eENInEhlPkDiAJO0ct1EGjVNRNZYdFftCNqbi1JJYVEKE/gNvE1M+zk4MV6
x-ms-office365-filtering-correlation-id: 3bda95a8-5464-4d57-0df1-08d610d61355
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074177C8D3BBD6249F147C2BFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R8FA8bWPmN+RSsWdAgddqQKgj74XdIpI6zE9u9ACcAani+tslBGW47xx+k/4tiMxwdIdWKtBZJdlVPOeS9tiNDEmc8uGp9JER0JXXLXbwIwVoViMN/3bQA+o/1Eax5eIINCluKm2rUCJkc0smXN1/FzZOLC3aVXxT0TxSyN0rohPQUPGQWGJHT23K8mw9kNjL0Y2RU3m6OqZk/s0y/FfeiegDv3PWPJZjeMSlCt9XiKShscGoc/kRkDQUzcwkznU0Rd8jUMLoJO4ZlnqPWAY+/OyLOFkOrf8/u6IhGshnBXoOgDKa5auZGrn7zGSIZoySLBZz5OEQTavIHDX36J5ivwK5ySPcxJ0a8tJG/V0bhA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda95a8-5464-4d57-0df1-08d610d61355
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:55.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 03bfdc31176cbe21e456f889ccbbf67568831149 ]

Take the new bus limit into account (when present) for IOVA allocations,
to accommodate those SoCs which integrate off-the-shelf IP blocks with
narrower interconnects such that the link between a device output and an
IOMMU input can truncate DMA addresses to even fewer bits than the
native size of either block's interface would imply.

Eventually it might make sense for the DMA core to apply this constraint
up-front in dma_set_mask() and friends, but for now this seems like the
least risky approach.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1520e7f02c2f..efee734f072e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -209,6 +209,9 @@ static struct iova *__alloc_iova(struct iommu_domain *d=
omain, size_t size,
 	unsigned long shift =3D iova_shift(iovad);
 	unsigned long length =3D iova_align(iovad, size) >> shift;
=20
+	if (dev->bus_dma_mask)
+		dma_limit &=3D dev->bus_dma_mask;
+
 	if (domain->geometry.force_aperture)
 		dma_limit =3D min(dma_limit, domain->geometry.aperture_end);
 	/*
--=20
2.17.1
