Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C2B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zvx1zUcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C2B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeIGFPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:16 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbeIGFPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox9lMZ3R4RNQJTSQHihjQG3f3wVMvtppWZSM2NywWKw=;
 b=Zvx1zUcXVcswMttR5SX9EjrcEaOd33WjAXLSBH6iQN+LEu+QXf7IP38SoguEwDjDnLh9k0c5HNNOtU+a7V9kDPKE9ZLoiUR9AyiJPXGA1IL0gEeUYtJBdr1fH672Q/teHh+nR6pDu5IueEaQr7AIN43YcYBiHLHKsKPbY4VH8rw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 44/88] video: goldfishfb: fix memory leak on
 driver remove
Thread-Topic: [PATCH AUTOSEL 4.18 44/88] video: goldfishfb: fix memory leak on
 driver remove
Thread-Index: AQHURkLOvFxnHulgt0qPtwBn8DAWQQ==
Date:   Fri, 7 Sep 2018 00:36:25 +0000
Message-ID: <20180907003547.57567-44-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:Y/fT4SqKDlUdRQaDju6/zSchmQUBJjybHlm0eUFUDL3fkGsIwjc0mcMpiYnYe9e1W79QKTr4E2vMVAUQmwHDZ0+587+oPky6kKH7PDW12U3Bf3HymUrLwoL+1KQ6fcqukFc729vwdvjE1nPR80K9jFoeXzpEfihzB+45OnibFGCkwbkvptyvM6IW7B1aqYBx9movTpsizvW5kvJzHnzriLT3/fUnqG0hxotofVndidxfVc5hHEkIBLuEEIRWl8n74+KOkYqDQsu0acTP4HVQfWWdRnCBqZ0dTwFtwf53575ElYJ5OC/FUGvqfRPTU8P2b+2kKDm/aAShxMdzMBoGX299rbHq3N/7VAHiXtTZAuFjjFzJmwp6/iO+vim+8A1s7qNvCY66NIosYxjSPcNR8an0BW3+kWOlFKBykD0MiGY1IdW7FmsEynrDuNoUh+Chjf5HC4K4ZiAEBtMa+2yZmw==;5:lgseKR5wEDiuPDeUOyN33TDMWfhz5njhDynarLX4AUAopT5Zd4b3Dkj4Grs0U5NeTV0/YHwuPWIeAw3RjhDiIOpKx4BN5qqZCphVh30UyyHP75Rh/HpmEgtmBuuh/WpivHleRKW7cy/fJC2FAqYYmmODwDRiwkpSTTtNjOrC9oI=;7:7wPwTnEBlC1JlYXI0WobrWPaqsQnZB0R8OGXxkAOqW6iUkF8iazPT8DYxSBc7uToNwPkWZUle+RXSJuVpcvqzjnB900pveXMtMNSk876BgkKFeRKMKi4graOfJWB4x462NnYIgWMZsuJE4QCN2C/5ikfHPE4/paGnZR9/u+tzUPdRZrBsQYLR2uVB1Cyw7bCD3qJLWQ4u8YLk+/rONTdo9EMhZL1mIQ+K7+VAE2BGsybnjZYRR9xGBn3xLuS0mf8
x-ms-office365-filtering-correlation-id: 13dfbe2a-0122-4e4d-1afa-08d6145a00df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773CD42703AF31D705CC4A1FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(4477795004)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AaAzTm0fbLnG46a/zkS3UGlzN65RM3AXlZqB58Ot++pvJ8WpFwYdiSzmR/LgoPhNyGPFHtJFuZmNfkBcNM8Qeb5rlPmvfqRMGU8v9MGPdnFGlTVL4UBdFFv4AitBmm4IQus7Oii44esyT1MAmWuBNE0sUFUP8ez7VFNXuPfQurbyeOffYJyzgTgDt63+5b+A6juTFZ8n2q4qJFb0a6MYG5H0O5lYThXMCAyhEFhAGZBtPJTDASnUNInWc8OXbJB2laN4UPGT86jYo18HEWotgrcfTXto+cZ4PSOEb1+TTxca6TK+6Z0B0Djb1cWS5hS35hHgfHosCVNqXow6xnwztYdbTzkDZVYHE1EAR/ttWio=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dfbe2a-0122-4e4d-1afa-08d6145a00df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:25.3851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 5958fde72d04e7b8c6de3669d1f794a90997e3eb ]

goldfish_fb_probe() allocates memory for fb, but goldfish_fb_remove() does
not have deallocation of fb, which leads to memory leak on probe/remove.

The patch adds deallocation into goldfish_fb_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/goldfishfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfis=
hfb.c
index 3b70044773b6..9fe7edf725c6 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -301,6 +301,7 @@ static int goldfish_fb_remove(struct platform_device *p=
dev)
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
 	iounmap(fb->reg_base);
+	kfree(fb);
 	return 0;
 }
=20
--=20
2.17.1
