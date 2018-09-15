Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E16ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82E4208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FWposEZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82E4208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeIOGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:08 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728953AbeIOGsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM+o92v5c6yPWwrfPsQQyj2Er36bN50C3Sse6mkN2Ng=;
 b=FWposEZuSLB6P9Bjolo2dkT2VG6mbxQni9gAlxAPjZjWFYVSv1BYsDbYj+n+5FksDhQ/Z1jitnWX23KitFRY+EQ1//I/yqdVxZhpaxQdO8P0Mb9sfN3jkEmeSyWwDAFXyqA38VZgT0/qfSe9zztfPcVwIAO2ghXNRY9gapfXoYk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 82/92] dmaengine: sh: rcar-dmac: avoid to write
 CHCR.TE to 1 if TCR is set to 0
Thread-Topic: [PATCH AUTOSEL 4.18 82/92] dmaengine: sh: rcar-dmac: avoid to
 write CHCR.TE to 1 if TCR is set to 0
Thread-Index: AQHUTJO74AoaH9MFXkG2d3pvbvdCnA==
Date:   Sat, 15 Sep 2018 01:30:48 +0000
Message-ID: <20180915012944.179481-81-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:1gQX96Dyr1BWyN7oNENfrlWW/2uf5cwTgNeVBxPrBeQDpDQ0zZ4Cxxdy38sp3dPmHdC9D/V5axAWeGx1fgOyY4b9F+6YncTeOBidHuSdB/c20TVvlHyxnfjaJ2UuRFsep/JIRppGTmo3zeP28zS+hqgh4eIEyD+9ApgqPfPKjlCujHHYVN229nIjjR3Zg+iv1CLxIwQeP6rTSLgm3KV47nEmFRTW796/NnBdLHfm9yuqI63MulI00Lg9ASxEDF5hxnkFOdkPixZFA0AZtCfxf9wxd4BHPrALq498K9/gRCH1nbs3X8hMT5s/yN8M5oNLfKFEGPjfhM0qrc3LNpEzS3Yb16R9B7ZSVoXgHPtlzbmcLSnZEhqUI60YmTZPa3L5SuzD4tFiivWhSv16qngtob5XZw2/BvJA9dWVdRYMv7w5g5mqPgeNYwKQjl8flwa8UVCOSvPKObI/zWPfJHz2HQ==;5:aO7CMNtV60C7eZ810VtJ5beOeTzxqKt/3Es4GgtkA5l6KhRKL0vV7c8mhKr2yxiQqHYQY2XGXQrHeUwCUmh7muMyAJsHArxVwIHHkEhCLCsfUJ4u0UxWHdD6J9NAHXsjdc/BD9IjR2XCgEuUB6keUp5iHjD2NGsAvhs7UbCUQF4=;7:FuqF+84EKXrc93Sp3oamDzOrWucKQhQSF+fOUAkhbLRABDwu9rKlA4diFMkGY7DFxGZzBPfkRx8DDSwlvJHvfFT6XciJmXj7GA96XzSuBsHtJV4lNifgf7ktxItEpoB9rfrpxpMXNG/84U32049cWuFEsHmnqnzSz5y7ZsQFEmQc2QBePKlIDs1Pf4iI26si2blm0dKAfWZYtwMCkMxh38ZHate2Uiwzn++pEHM/QqNbWfU3dJ6C5Xc1mw8bvaBQ
x-ms-office365-filtering-correlation-id: 68ac4b9e-0f94-4204-64a9-08d61aaafc1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047022E1D33414DFB4352CA9FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: y49Z2bUwJBvFrnouogeEycqSRpVNsZaG20WKeNOSa3ZKZtT8ByiIFqgNaT1SullLXD98ivggw0pm5ki3Kyouq+y9lX2eOWGnFlA1BjGR0YqRbZM/bZzZDDMazjZOJ8bYsQfUouZMHxnFcUtm795sLvLIN+zROo+H4Etpyee7ruFWwe/1FRWcmZl8MIXwE8m9IwbbHbGOfAiy5wKMTgMpM68opE7VYLXE9SQK2W43WI6lZ9MmUmOAPczx/vD17k6FO8DTHFeI22JEN2QKO3goAwxcytVK3Bu6ENw7xJe/7t1rnHWEuhEePhrHYB0pm3OA4/kjZiLkYPIJsnnEhaXjZlf4po6+mHTZePFzCu0GmlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ac4b9e-0f94-4204-64a9-08d61aaafc1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:48.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 538603c6026ce769eec633bb79349f5f287519c7 ]

This patch fixes an issue that unexpected retransfering happens
if TCR is set to 0 before rcar_dmac_sync_tcr() writes DE bit to
the CHCR register. For example, sh-sci driver can reproduce this
issue like below:

 In rx_timer_fn():		/* CHCR DE bit may be set to 1 */
  dmaengine_tx_status()
   rcar_dmac_tx_status()
    rcar_dmac_chan_get_residue()
     rcar_dmac_sync_tcr()	/* TCR is possible to be set to 0 */

According to the description of commit 73a47bd0da66 ("dmaengine:
rcar-dmac: use TCRB instead of TCR for residue"), "this buffered data
will be transferred if CHCR::DE bit was cleared". So, this patch
doesn't need to check TCRB register.

Fixes: 73a47bd0da66 ("dmaengine: rcar-dmac: use TCRB instead of TCR for res=
idue")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/sh/rcar-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 2a2ccd9c78e4..8305a1ce8a9b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -774,8 +774,9 @@ static void rcar_dmac_sync_tcr(struct rcar_dmac_chan *c=
han)
 	/* make sure all remaining data was flushed */
 	rcar_dmac_chcr_de_barrier(chan);
=20
-	/* back DE */
-	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
+	/* back DE if remain data exists */
+	if (rcar_dmac_chan_read(chan, RCAR_DMATCR))
+		rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
 }
=20
 static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
--=20
2.17.1
