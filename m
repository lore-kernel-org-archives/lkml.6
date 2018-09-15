Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D50ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0D8208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dLkF0TvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0D8208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeIOGtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:09 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbeIOGsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aD9wPOaLUzcRwDfoxvRVPBNADEPCJTUlq/s4QWhW3k=;
 b=dLkF0TvQJRp0RMWcEvf8qirFvRNjrSs/TzmZ9e6cHcT91xKER9ZJ8772t0in8VpI2VOGZXCETt+2zR8BdDglxVVDx21G8heuwU64bB/AbmHHQ4Byexbt+6A1riHoG6hzKmh0psJRGq8X2DSWqILpKQsQAcQbvlN4ykYGJbHaos8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 83/92] staging: fsl-dpaa2/eth: Fix DMA mapping
 direction
Thread-Topic: [PATCH AUTOSEL 4.18 83/92] staging: fsl-dpaa2/eth: Fix DMA
 mapping direction
Thread-Index: AQHUTJO7lLIFFpEZxUuUcDAdpD+ATA==
Date:   Sat, 15 Sep 2018 01:30:48 +0000
Message-ID: <20180915012944.179481-82-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:SHIco6KolqxYx/lBOV7J37Tj2h7dQ6N7Zwrrg5mKRT8sWzmgDD+efYKMpTSTC0ssmZo3E5DzGUA3/gLlwrGcJvDjnTstBs00lbIteiPte0V8VK4bycdaGIuqCF70sxb3Mcw1/bPvbqegJw/p62/9qW8KdC6w6USMAWRK0+XJKZFyAWRDBk/WKaJp5jmaq3hJ7dT7pjDLL9foy1hGaRbZJYE1jPIFIoQEpZNlhPrYE1z5LVo+lPDaAvjKdYxkoKWJ2HOWaW0qEdnDa1owwgQ84Ka74LjYJRbr+DDdUa7ALQylT6m91RhUlVb4/y935ZSXcZJXGsPtKmonoqGAR7mxiyG6+8o3sVp9PfwAMYknq9IHAAAsX4PwTNF1CP6ifbhLScKbBLLKvP+x1MVcNUPVQ4PESyEpjR9vm81R/3i+7Ylowe9FFjzVnKzz0pwzoMok5W4PAENA0gxWEAh5Yy+6Ow==;5:2Vivwy4gEyfwlyGJnJVkwnGKZxYOWnMoyVggfjqo9Z4OQtcFpNQOVw8gGeFcIflN6Yb5sEBkS0iyPsxotJ6mEiAcM7EQ5+i4KZY6yLu2Obta5wzWvjC+g5fHWq82quOsXTNlDQjuGJ0Y5ibeX8CyRK0gA/FB2LvV8BVlQ7lsUcg=;7:HuHOsf0gsQw2bHkeE4hXCn06fVrYWb8Nv6ofCsmHWJePlMTOleQe1rQoetiSz0K6Jec0EWPoLT304MtDdS0FOVu/tirVtf+VyqX5NDPlNoG1JwUDUXCO/DnbrvEiKJST7Vlk07YwMCDdVaBK1jwZqfygIeec4Z60bofr/eIQXQhJynPaP5xh6cSB3TPgTtdi+0ZoRc02LvKMvWLYVoJChSex8J4I1GjpC79Sd3pi3pehf0d1ArHyX6kEo7Ta224Q
x-ms-office365-filtering-correlation-id: 9df83c2f-ca68-47c1-88bc-08d61aaafc62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470E01E2D4C440B995511EEFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Qegx/rLzuljfJF3pyvm8MGZykeV1l3JpyyZcjNOG3CK2273/ywtlbOhAI0J0FqhRq27t5ryNo+eHPeDxq2jxGG0/kvl7FWmkgXO8aqgWiuZoNgvYwp0ml2yJA3vIAKRBavhENRpmlmvjwQ1VvRcKCK3f/k7rwIM2n1MkaGGW8KFjH6wMGBJFVSG34UTY4RIB+ofZcyINDQpXArt+GW0X6end/j40bt4qt7hiJQjpZfKT3t4pvzGLBKcJ5J2WTVpVpPBJwVTASrnRHGr0AdAmai3uWcbsqVRb+H0QA/6dBXG0nAHEFm1WunX6PfMzynzXb+LpKmGdlzT+y/9X10NycTK0lbVit3hHGOV3O0tX/TM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df83c2f-ca68-47c1-88bc-08d61aaafc62
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:48.9948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 466bcdc1fa303be175c45d054bb00effc575033a ]

We are using DMA_FROM_DEVICE when mapping RX frame buffers,
but DMA_BIDIRECTIONAL for unmap. Fix the direction for DMA
unmapping operation.

Fixes: 87eb55e418b7 ("staging: fsl-dpaa2/eth: Fix potential endless loop")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/stagi=
ng/fsl-dpaa2/ethernet/dpaa2-eth.c
index 396371728aa1..537d5bb5e294 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -767,7 +767,7 @@ static void free_bufs(struct dpaa2_eth_priv *priv, u64 =
*buf_array, int count)
 	for (i =3D 0; i < count; i++) {
 		vaddr =3D dpaa2_iova_to_virt(priv->iommu_domain, buf_array[i]);
 		dma_unmap_single(dev, buf_array[i], DPAA2_ETH_RX_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
+				 DMA_FROM_DEVICE);
 		skb_free_frag(vaddr);
 	}
 }
--=20
2.17.1
