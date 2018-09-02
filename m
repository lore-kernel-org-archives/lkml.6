Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F5C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68714204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nqlGIw3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68714204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeIBRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:20 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeIBRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5ModYp9aLiKo6OKJYNRdNjRuUfVoyjkR747uS91wPc=;
 b=nqlGIw3oiQ1ctlD5K4SaqOIfpPr7fvikZatKTRhSMVpyKD5bzU6aYpH7zg2B8uripZtp5J9uYyehKVveZDrIFBUQDEiX2dYdKK7Rqw60c3D0yOP6/4M5PPXhJKfnigXCqKCzqAVlIFOHRaV6am0vBBNRVshGotOsvorf8ptGySA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 095/131] iommu/dma: Respect bus DMA limit for
 IOVAs
Thread-Topic: [PATCH AUTOSEL 4.18 095/131] iommu/dma: Respect bus DMA limit
 for IOVAs
Thread-Index: AQHUQr2Q2sq/lASlYUOYO9c1mVIkSg==
Date:   Sun, 2 Sep 2018 13:05:03 +0000
Message-ID: <20180902064601.183036-95-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:cX8Nrl9lA8C2kQj67jE0551NYBm+phxrp9PZY1nc1z928IACU0o6i5wUO8ps5a8iSzHU6WI1Z8djSIo0eWhKpNBaCxXLC7mbw8+kHLSWuSSYke+VrzM4voBJLI2esbLeJaeYNqiOb2giXFp9Eq8Au4S8el50dESgIWmFv6FVryA+zxDudgggS6l8Aaww1g8p90MYneOgK29vayv00KmaoDuqhum8p8rhgpyxxZlhbfW45l9M7rHdk6Wwqy/hFw6q+hvlJcfBbABRKvztaCxDiQSm67BJKjgjzd3uUd2MgVMu3HL0u70hBggAe7OJ6M/rd8pRYB4/qnkT7G/K6cauTt/OqfrfF6Mg3wW07oPNpmcBen4E6bUUZ5ACbbISN9SF8+UDRNyyWLVTFoN/im61vmEuOs50wVWDn6dplkynOYYhh93iXfyZ5up+MWU0xs42OD0T5TgSdz+ynyoY6YfjYg==;5:N/jye0+iP0f0telQwUn1bD5/AgcARYc47MdrljHlYgNGNLPBbSeeBXCOfLBQCSMq+KWgRE9+mC6vYENoJBQHdHu7ZbS7DUvw5fE5FG4Vo5eHNJCA4T7rbafV/lXeV+3Jh6DeXDVEaTFT/WpbRFe1MsvXwMQje/gAk/5i24dDb78=;7:Gxa6l/vOg/x0TlwbI5NE8iriQIm+kwWARPEiBlVhp0JM8hUpXs/Cc1QTfhhg7EIlFDpZnJQ/ZrsuJGVK8nnF8jwsdvKySN+JlrdUzESL2A3tG3U2HpcFDBpmsvrvQzoUk07g5FEqMs/Oev4+e8C2Put+6me4fAkcvVbvwfar7tO3qMn56hyAk0NuiWUApPLYDE9DRnDq/RKfQKORrNDR4vlF79sV0U5ZaAMsFw0YOlac6mJPkf2DZZ3IYMv1L+vK
x-ms-office365-filtering-correlation-id: b616b683-fff5-425c-9eec-08d610d4c42b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01847D8153E6044F1A16BF98FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uD6skU/VJJKuv0T8EtGj73YDtE08WLlVRokhjSTafzen6+Nwcox2dUxK4dJGn+15ZhVv+mQMvzNnuVVfNmrwBNkgvqjJcpYUmJupLlc1domdayUjCtmWvoDPzps8CVGIK9pjARyIQACJZctFJzwFC80BMbZAo6Fd+aU4nWFQnfxmg2T/VhONXJvTi3kHAlHa7eLNsdmlTojWAW8IMIIdKqRPW6TbSVbFoPA/7rWdK2ayiJbRngjF3K6NYwysO4Ap4wPEvAGC9/REwHLgqQV/XaSW1RJjO764KlD2fYzWuAVJv7cYrVpV8iCikQYP/rFyw64A5S/Ubwmyp0CetjMpleTcvxi8CDFS7WLhW9D2pAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b616b683-fff5-425c-9eec-08d610d4c42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:03.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index ddcbbdb5d658..511ff9a1d6d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -367,6 +367,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_dom=
ain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len =3D roundup_pow_of_two(iova_len);
=20
+	if (dev->bus_dma_mask)
+		dma_limit &=3D dev->bus_dma_mask;
+
 	if (domain->geometry.force_aperture)
 		dma_limit =3D min(dma_limit, domain->geometry.aperture_end);
=20
--=20
2.17.1
