Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1459C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DjDcR/Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B7D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIGFYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:24:50 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730880AbeIGFTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xyc50Tf1GZoEpTBIguys+25ai5bR0zqWCbdPOnOEb8=;
 b=DjDcR/Qq1IREUe+p4cBTdSSjRxBYBUo7R4L3ExvOUo1ISqFW8K+EDLbynywu9V/1bFa9+YYCxT4RslYWMqoVaOXFa9SxB9WNqUt5NyfngF8er7cqwsD52OXaz3FMWunaCxf4jXuTAlrMheELpyHqi9vk133fdeXgmPp7EYnQHsQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hanna Hawa <hannah@marvell.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 42/43] dmaengine: mv_xor_v2: kill the tasklets
 upon exit
Thread-Topic: [PATCH AUTOSEL 4.9 42/43] dmaengine: mv_xor_v2: kill the
 tasklets upon exit
Thread-Index: AQHURkMj+DBW6VEvDkaGwpvNwVrk2w==
Date:   Fri, 7 Sep 2018 00:38:47 +0000
Message-ID: <20180907003816.57852-42-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:/yFXAqyRwsBVuADCIxuFv/bxNI55pAbkttD7ab3PCP/l85lQ2n92/Ivhn28jGEoYQCvjS2DmlAin6b0KMK+D7UBy5bh9uIN21PoNGbUVHsozORYPbjiNd7hJruI0uhAMPvlxJ9ILgSwA9eLhztRVWzKU3ENdwewh27Mj3RPenlug11z+VwVpvWNXwpQLXaw2jEv4Iwmr9d8wWRyCGo1IC0OSqE3r8eTUmbdfp+033ph091EaFeH9xNDhKuLXPe1YGkoiqTUuW1ao66D7hzVdJb8kthnXp+bL2qhzPK2O2K+LwjccV1o0Dfab9kYZBGOwWVETKRtb7ZW5mb+oOHYMU4YmA4RFzOwiRwW3Rzoh/I8echVXhLXvrorFfMIul1PcxC8Yahrkfix3Su32ItkkblsK7YPK7E/S4NCARnrrYr9J1tIw0Lhc3/7XAXedm85CiR7rBr6FvVOrVVIBNu5bUg==;5:9lfsPwCx/+0XL1Wmb7M/SINfBB/ucvmuPIGT5+h2WLJzImW+wOQb7s3txSgh2suaA0eQA6f3ro8WuAkv8PUhKZ84/Er2ziyNLMugECE+/hoTKQB2aTDp+R+seQRw+dEQw8BSBwpGEQtJY6pA1RNA65POPx4gtGdDcbSx+TNPBxU=;7:DcIwuun/B2qsD4JAfs/c1zKUxxdG6q+UZoztuZPGV9Pb9nevJRIhAm5+VM6uLCwkEI3el950NC7ncMLglm4tkxzXz32C8KxU0k0zxwE7Uq6hlyL467CGUD5BTvZGPdkf34XNEp2xLVOKKF/4VdDwFnrwC+2IXx4JNwG6qHxPzxgC7wqaLgamikhPhu7P7qjRSuAQgYUg6iem+E1XXRoN2x6GNChnK12oMiyWynhI+EeXoZKTtKetRF9Mj1TzZMor
x-ms-office365-filtering-correlation-id: 81568668-940e-45ba-2155-08d6145aa356
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694A5E4F9159228C69920B8FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5kAokRP8BZMknh9Jku9xHHwnIBooB0yIFQ8tu468JONX2M17VYplsnrTYzU6e2PbbDHPmrLtbaFAJzaeIaHLK/pHro5Xba2lKSc5FGcQVBSNsX9dgiIpvRuQQFRvsoKKann+P/JZwJMVamaWbUQC9yEoaK9zNPumqPUOF8EzMQPm7vkqDDD7h8PFPEujdFEZMNsK9oaejdjE9lUXLo163cz/ruexI7M77ZPDr4xTQ6CgcaIZtbdm5PExkXqkhYT7rEu+5bvaeP3EQlCWzwvlb07QNeu5ybRGftuwq8lv+3ReTGpnBa71n6PIVYMDkpLCaoECVrihWuB4paW3IP7USlpZKoEFGaTxkCmqdUIDgoo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81568668-940e-45ba-2155-08d6145aa356
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:47.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

[ Upstream commit 8bbafed8dd5cfa81071b50ead5cb60367fdef3a9 ]

The mv_xor_v2 driver uses a tasklet, initialized during the probe()
routine. However, it forgets to cleanup the tasklet using
tasklet_kill() function during the remove() routine, which this patch
fixes. This prevents the tasklet from potentially running after the
module has been removed.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/mv_xor_v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 71866646ffef..be1f5c26fae8 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -844,6 +844,8 @@ static int mv_xor_v2_remove(struct platform_device *pde=
v)
=20
 	platform_msi_domain_free_irqs(&pdev->dev);
=20
+	tasklet_kill(&xor_dev->irq_tasklet);
+
 	clk_disable_unprepare(xor_dev->clk);
=20
 	return 0;
--=20
2.17.1
