Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8612083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oMcCPRSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8612083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeIGFWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:22:19 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:56221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbeIGFU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxW6TXgIBI57HIUxzNDkaCGAzYdnEpUpUCSFXxNh0/Q=;
 b=oMcCPRSL8n/OPmxRkw03Heo9XBY+J19IC/DGVE9j3pE3hPP1e605S0TaZy9wEIgVRajlk0qUiafJCli8AUimx33Ef7ATs9SHl2Q1+JccVPzI5QZrGOnod7gJOg/s3pwbMvOy1nKjcLqLK6VVjai+2Ywhst+Mj/5uvU0gIyvHgrM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 10/19] video: goldfishfb: fix memory leak on
 driver remove
Thread-Topic: [PATCH AUTOSEL 3.18 10/19] video: goldfishfb: fix memory leak on
 driver remove
Thread-Index: AQHURkM++npjniqS90e7o4qIF2w/8Q==
Date:   Fri, 7 Sep 2018 00:39:33 +0000
Message-ID: <20180907003923.58019-10-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:ZfBtE1qROWu4L0jPJcYV+qUQBM8XFg4UevMPb4eRbZLOsEv1TuCxHYuccjB2/qbv/LDA6z8HTIdeMMV+BfpGvkwh+J2smS0Wa0Bqu8HUyjqZAAonw3znBMO56Zi8ZbHLa7axBMSkU1420VPUh/UJdGzmOsICrzB/X7XHk0IWWj95uZXGnzT4XG9QYqYrFt7UNJFt6QJHPlF9ok9bFxNawGg8kXj+poZpU6oSeXisxt93MaM0B364XxFZM10BE/j7MiE4MVV/KSjNT85kXyOAGESP0YzVYzDcGQLg0L4A1zv3YTDT50iAz/754jTGXiN7+D1yAvxXmcT8JHfXG8E3qgkWTwyByw77VujuxdbUxMROpOG+D7qY4gvinJzK7nCogDVV9LZCgxUyaqK8c+nnaJK2EYxRMuSnNFqTnuxkiXRXMOHtKIanqsqtsdiBDPszU2FUW2YQI8pLsuG+l7kR5Q==;5:N3rXFmTWAN2Y6dNKRuexqvuqz5Mor9yinRbNXlaG2oucalMG59NfrpUn73IvO1MyceYNFuhe/SHxlaGHe4MO7oUkz+sJHHphlalGcLTCYuuOK4H2xd2MTc01QpOrKsYquPPrqTqDLK6U6qOq60UFp90+D5bAXJBr8kUtgn6Opcg=;7:xvxWIFjr5O+tLxJeBuIxxz0fcRdbCrIR+B5IZCdaV+8gfDFDIarYmv0knC5vt2BztaWYdd71OUOV5OrRcFiAu9svv+g2zjLkIPOfn/yQLKZC7hgju/EcXeOB4NZpa5uip2zzjI+a+jWhLJ8rzLAlcs9b2SO8NvFCjMIf2MvghxFTPoRpO5de0ylU7nwdiTP9kBBgcdNHoINCgtCcsL+XXIxJYPlJFxCYH5oc1zm/POM+EOv4mGkUXIHhrQa65OTe
x-ms-office365-filtering-correlation-id: 9c6251cb-081d-4673-43d1-08d6145ac0b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469D8A3E514C80A86C2AF1BFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(4477795004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KPllBl+x3y1nOqIn8HzXmQFkKK/edCMaxXePbAzFPxJE0QLmVyV6FM3qvELIx0yeCriPbeIMwcMuQeRHFSUcI9dRzKws+FitlOdsUlRetGj8Y+BZKhMrQ/7Mzv99N76DjEZnOPo7qG1EyI2QgHzzwvVpm+12coL0YsmgMIYi8fn1hSSh4oUiMZikbTearzItzpe2B0zq32bezDXmSFuGgaamD5b6aX2+LtSFItBMnVj0vj9q+xEUVhkdDodLCW5XSs/B6CN9sbhQWuJYvtrmX86Y0kTAiKDFyIh6nDNc94lT7RaFemvVsbSNpOFy7JCci/PqnVC24nGZ6oxruayAxb3KDylM3cNIHscOW1ytIn4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6251cb-081d-4673-43d1-08d6145ac0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:33.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 7f6c9e6cfc6c..14a93cb21310 100644
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
