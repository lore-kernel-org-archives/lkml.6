Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F532ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105652147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RuZA6O4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105652147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbeIQIc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:29 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeIQIc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib8YpwwQPYEw4TUWI5wK44NTyDIcADLf/CL/v/1TP4g=;
 b=RuZA6O4lDSpLc05lIlm802S3PNFepmM/d3QIEIjUuEN2DNHftsDMAxQVF2Gr1oNtIzjEWMp0+mZHfEC1licdzjd3pqCo35Z03638pc3nFbZ8FsEPB4inb+RKdzbUDigZY29b5cSlT7QYZSSTgl0T2lzzRMmYHRt5+U/aR4q60SE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 21/43] powerpc/powernv/ioda2: Reduce upper limit
 for DMA window size
Thread-Topic: [PATCH AUTOSEL 4.4 21/43] powerpc/powernv/ioda2: Reduce upper
 limit for DMA window size
Thread-Index: AQHUTjM5GLaaEU9/QUi6sBZ4o8C42A==
Date:   Mon, 17 Sep 2018 03:05:02 +0000
Message-ID: <20180917030445.484-21-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:Ha1bcP3GA0b64c2REaUQhV63njzPdDMEtyKI2quINRtiZzgHLwHIVw0fCf8v0hoZU7FuRFauVpxTx6YR51DmAiyQR7koCxCHPk3LTHhY32KMKms/r8PorRzf8VZESLoMyrR6+61HaYqHl9kIBoWXGrm6IHoBAZoGS856NwnSnsb4CrI729BKTV8wwA8kj/UnrsAB9e9J2gmrKkPnJdpt6X8o4JSN+nRckCCZfH7sbJUqzEl3thVEfikG6UlQ3YfbRJ3V7394tR3zkQIZh+jluz4EmVsoUhOgd5UpyYYQ9SsiCFkwj6mb8yr8/RY58Y9EYLR7haT0upSl7gteE06IHfC0gaWQz867p2HOQWtFfulkpt7752zL7FoPq7MaEnvLRLteAMm2T6QwvmD9GJX1QL41iRvMnDpV4/smG5jSEXF3IzlpVoBzwu9rN+ZE+YwLhn1A7/Ri+NXy0lw2h58LTg==;5:lcpcoBG5o3xnBlVox/PQrgDNbXKmX1ilm3E6xAi23Y4FOhGXW0vecrXgodAIdEHpNEgioq6tUHxIOQ1FXTKiEvooJWZt+44XMWMExbR0+KNFLOmrAj8BXj51TSEvr+0BUdUrhy9gEQuHNs8fTsnenJ3Ml/Z0ivoosX1aUQq3NEA=;7:DVTZxKHU3IiPXg+AcPubJqfs9iALHPcHdN+Z3o26bFr8EkKg8CWBnHmXrskBjlKHK2WGWWNOlhxZ6UVNafUXxKEFMJ0ejReDVD8eHl0Pxoib3e2drE+fybQiPCRDdcRF4LhZT2qQSWeX8GKfkY+akTS76dUn3yzY/9Fd5Pup+rOZ0kpfLSaz27OkK/yXDUxnmRjRS5rbfZWT6HODJAFW4KaHR4DGPm/r8L3u8dgXCqYX9N5XHoc+hCQzQNzfy/mW
x-ms-office365-filtering-correlation-id: 60a4821e-ccb8-4f52-538f-08d61c4aa834
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB075999D6ECA2E2635D412C7CFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(4477795004)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SMznJEcLVbyuHuZEkoqWEh/4weTRjNQ/yRFo1FnXPtIUPnrEt8k2iFUw4SOzPYppkzEUamu177w9E88LNFtKG+jEPLdOg9hm8uokWGIYulMFt20m9jth98LS3rnw6Xrdbe4f5RzknTRmZpYKol8TQLFOk8Y+5tdduvvR3ZihpOggV1Zp7N0QI62+Qm8y3TUisH3rgejkxzYdm4P2PimdsPee9FmYN8mLNCJjhVkAMEx13Ium4mfqMvu8T2Z7e46mLLHcJ/ojT7YB5u1gQMqHeWt6PUQz6fdabssf+n95nPYFelGv5uU4FMeE0sd0n1LQAYA5Ib973nuh2lNXQ8iB/y22KuwJ14BqTerhzUk2JTY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a4821e-ccb8-4f52-538f-08d61c4aa834
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:02.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit d3d4ffaae439981e1e441ebb125aa3588627c5d8 ]

We use PHB in mode1 which uses bit 59 to select a correct DMA window.
However there is mode2 which uses bits 59:55 and allows up to 32 DMA
windows per a PE.

Even though documentation does not clearly specify that, it seems that
the actual hardware does not support bits 59:55 even in mode1, in other
words we can create a window as big as 1<<58 but DMA simply won't work.

This reduces the upper limit from 59 to 55 bits to let the userspace know
about the hardware limits.

Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE l=
evels requested"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index eac3b7cc78c6..ab7b2594e0f6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2270,7 +2270,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, =
__u64 bus_offset,
 	level_shift =3D entries_shift + 3;
 	level_shift =3D max_t(unsigned, level_shift, PAGE_SHIFT);
=20
-	if ((level_shift - 3) * levels + page_shift >=3D 60)
+	if ((level_shift - 3) * levels + page_shift >=3D 55)
 		return -EINVAL;
=20
 	/* Allocate TCE table */
--=20
2.17.1
