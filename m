Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D294EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80895205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FHFvdnRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80895205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeIBR1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:27:35 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:8192
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729415AbeIBRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4YrKXTfXlRAzWX1/mQDiv/DwBwpHOYIqGxKvGWcfHQ=;
 b=FHFvdnRvrqjfXYuwE9gayy5sjsqkwMyZ9NumG/+BJT1Y3N7lVuZlsOLeZ/zEFVxPPHmixxjrPqhyHwFAP8zCHnVlQAz3o9CHN5U7d5AZ76yyXcB/xeUn85qMKx9Hux78/wjRuhhxQnv00DD9nUPIAXoEkvKfwzCdXqGhxXgyHuk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 66/89] iommu/dma: Respect bus DMA limit for IOVAs
Thread-Topic: [PATCH AUTOSEL 4.14 66/89] iommu/dma: Respect bus DMA limit for
 IOVAs
Thread-Index: AQHUQr3n32Q39PCTs0OTPhSjMe1nVA==
Date:   Sun, 2 Sep 2018 13:07:30 +0000
Message-ID: <20180902064918.183387-66-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:+g4CCMR5fxbiOslcCSG44xPewrPB3OHal0iJ+PhvE3CnQWp1O3N9W6jUkWm5RZcEoS9aPz9/zuOH345mJRDM499BDbKQUMmAdYGFCFD7L4ndEuQmmnF/G+koL8D40DCgm5wL0JGvvIRrB9nCB/YUg2L10QbfoHUl6Cxu6ZUcNmlHJcVZ9s6Su2JwCYFkE4Krsxdp7oaFzfvyZifEnu1Go3AyFQpySaR5laeda2qwJxZnio7o1k7h4JAG5rgPQwg2Nl65slTC36JjI3A01mhqhzGgwSSTpyCtbBL9QXvYl9LBB/TwVWg5BKQrHsDfgggxO+KWYRTS0FuBk/Uiljl/sQmvOrH8f6nog697IA1xkL2tN3fyCICDeTd7VAgkT4Ud1SrBDrM8KcoylFaCnNdBFdc801x5vJRe9wSr7MfMDSmsykJkarJtTW9Tkmcrnok26yPyKHAg6Z7aZ+IYR+xkcw==;5:I/MFZvxPJ5CDgNX80Y/+lP2IaY1HzzDpryKsmhzOsCGMTomyg3tAsJ5R4VTA6qZh0sZj7p+oQGQV7hgkg/nIgqso77q0F4SHJjpHAH0EU1m6Y1Ep/hkS24unUEH0zSgvyFTvR/kwrhPHqcg4GwY0qQNDk/jgcr0e4imZ+ZA99Ko=;7:Wec8116fOGD3JpTZNE7skRa8AXxsvwe4MGHw00Sdks80t2lqwlnWfA1Ou2+liuMJcIc4Oj8awKFd91em9AV8W0lIvi0vYPLqOWNysDtP2wNb7Ov7zR5oakVQtOmGZVDqS7PFdnobF/I04VvMRV61D9llxOKV9Qy6r3+AF+yL6datQhBFNeigSxwYTE/yq3UzlKu1gCIOYFDEc7sRzq8mOODVm34NekXPx2/dEBRG7Hw8NA+B2Xwh1qfIOXn4AQi8
x-ms-office365-filtering-correlation-id: b21a4ae7-844e-4161-a0ed-08d610d51657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01491211FA3CF2487647F089FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3igazPn8SHkkbtf62oawaUXeKy9qmFLELjmijUkaL3L3fViEVFMC4NhLLyjbOeiRHy3eISkAdCTq+bZeFmTDkK8d632nAD8XsSo/R1ps/ClBO5IzMlwIfISAXt6iNMWEAVd4gO0WvSyTT0hAt6rm732GLHngPV5ANr0KK1eW4yf/n14JrEpZTdbeecvWj88TRdd/4zRCy7VB1Vha8UEWK6DJOjC4GaPBUaPsvXXCm17QklGgo+je1RpF7/qYAbJ9ITERBEcGtsj62iBqKWOu7+6uZvueuhxG53G9alEOyDmBi/TG9XT/LULaCETbZ67WAAwXI8ULkqb/sijJ3SqHLdcQt9EJw4It5U49unk8Gv0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21a4ae7-844e-4161-a0ed-08d610d51657
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:30.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index 9d1cebe7f6cb..de8743a7fb78 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -381,6 +381,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_dom=
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
