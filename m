Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77446ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014932147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="agSdntIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014932147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeIQJCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:02:22 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728587AbeIQIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciPo0ldZg9nIK/F4gHqvYeVF+u1L47ID0bZ8v8DkrsM=;
 b=agSdntIly9tKMzvWbNljcBvOh7Ij0tyDiN9IgP1qqTrRXMfx+/GEJrr52GYTvSmrhe0xM5qDFQhSUqxMm736+hn1BiwcafxoA6WAiOLpuJxO0ktpXYIbDt4dZkCASb36tJg24bhktzkq5sPPB/JryTaOnGSuVak3rV32bpCOWRc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 018/136] iommu/amd: make sure TLB to be flushed
 before IOVA freed
Thread-Topic: [PATCH AUTOSEL 4.18 018/136] iommu/amd: make sure TLB to be
 flushed before IOVA freed
Thread-Index: AQHUTjKTZYWsALGKCkCcF+pzJEJW+Q==
Date:   Mon, 17 Sep 2018 03:00:22 +0000
Message-ID: <20180917030006.245495-18-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:+78TmlLGqQBpRg3x9WcVTDbRqLjai+OOSf9fZJpsExdBngUjuwiqHCPL7cbClczbIuACGYUsbJ47KN0KBid02W5fqqO/5dEaZDihPP4zcfjGL2sVUh8WLrsTs1KbGA3o3nhC1NuffH2GWVjEZ4eMG72tBHZyip5M2SVzPcitsXPanChVldlhF+ygSVdAo6Nfb3U0hoVu/T7ZBc9O8qH/MDYNKLXGhHnjjxl8+wecCf3rN38f0CG9I8WzFtTfGBKw8vAYZXfGd4N6Op15ZFRDKSdNQ5jhLvyIMs6tShZmrmq4IUHY58fWB4KFnE1KHit3fuf3iahea49P7L89hQX3xgcGL9S4vYQ64YqbzF4xxnCOvoSnbD+Hmn9PDpfTYiMeh7Rb8FcK1SrMrLrqkbr5Tdc6H1TljmkaVX8GLyWBh+1SgRIA5ySNg/JftKciYvcljRj3/jKwODDEZVYfYpDgpw==;5:FMJaamXt9o9XYEOmjuWRRDjpViP+x8vEi4b8woK10bPLqgL4dtPo8q0K1kmfCnJQdUNoS/vAN9U+CcX3eJTQ9+qOA1RVmDnxPjdYOoXuELRWsa9X0VV/BSYsDDnFUMBGUFWayL4FH1SbKUWUG7o17CQQ8LKAAZKdAQcNemd5puQ=;7:tz6eJS0Z2vC7kt0K3AV902N3JxyUIsE2qPSdW6GyrufQN3WSAHOGa/lq+t2LVltfb9Sf5/71K0janUIM0xr3+ZjsxPw0pfYPSnyO/wo7IiSCGh2yOwsERHM31AlqIFgBukbagfS7immGpGlzOBsT5L4A3y5Kud5c/MCcsLbTXgxF/IzbTC6PLGvsR3DW2YVh92gmb6UXrc7OEHwVYiUM3Q5KxVEdNhVIGUUsErrk8H6nI1y9QwhIQmDxNKTHGfFi
x-ms-office365-filtering-correlation-id: 4e5701a2-79eb-469a-7fdc-08d61c49b747
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277EA2A8AEE2DC72B3488AEFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /fyUrKcoD6nejZPWatacP0hvy5vDgMJ2ejeAdt79rjVVUTF7QGCApNkIwHXLlfdjflzjlSj/eYw1krBMpvABeBkIk76jkYjc4DeStSGPBbWvH4oi86LU2ZQ4xVGv9vEQq8k7m7lBwerord+jDnKS/T1Ii/64pdmZTwA81pXjqoQlQHOwWG7CGDFZC9kA/PkgGvdiY96kkYikd1feizWxonJ1dKCwU2Tq1KcRPZf2ZepR4zP9LYwIa26WntNRs77WtM90CVBRk5q0LzfHXph285qCYJPmrFymAftJ1x0nTZCkU5JgOYJZnFU12kZXOJEd9jdYQmNa3m+RnomphohgUxrUkkR2A7pby91b1R1pceE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5701a2-79eb-469a-7fdc-08d61c49b747
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:22.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 3c120143f584360a13614787e23ae2cdcb5e5ccd ]

Although the mapping has already been removed in the page table, it maybe
still exist in TLB. Suppose the freed IOVAs is reused by others before the
flush operation completed, the new user can not correctly access to its
meomory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c50051..d77c97fe4a23 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2405,9 +2405,9 @@ static void __unmap_single(struct dma_ops_domain *dma=
_dom,
 	}
=20
 	if (amd_iommu_unmap_flush) {
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
+		dma_ops_free_iova(dma_dom, dma_addr, pages);
 	} else {
 		pages =3D __roundup_pow_of_two(pages);
 		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
--=20
2.17.1
