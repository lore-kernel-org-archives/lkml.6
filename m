Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA881C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3572083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KqU9AHNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3572083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeIGFUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:14 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:49024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731117AbeIGFUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxW6TXgIBI57HIUxzNDkaCGAzYdnEpUpUCSFXxNh0/Q=;
 b=KqU9AHNFN8mnmVEEBuEnYNn7Dzs5gXJ/8fgTol7vHAM1vHrqphrxm/Ar+rau/6PGG8tbEX1xDsopyN+iouGKdB3jWDm0+NI06Lt2k2IZHgGuaMDUsxTtclyIhF2qWDbsfP7ZpE4zDkNmTp5sroKedx9lI6X8AQ3bcVp3rERnyEU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:42:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 16/30] video: goldfishfb: fix memory leak on
 driver remove
Thread-Topic: [PATCH AUTOSEL 4.4 16/30] video: goldfishfb: fix memory leak on
 driver remove
Thread-Index: AQHURkMv41EzNUDKHUmm2gW/uhVCow==
Date:   Fri, 7 Sep 2018 00:39:08 +0000
Message-ID: <20180907003853.57942-16-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:2BDp1Z9cy4aA/I7FmqkBbVEmbr3zjxWl9YTRAR5zbjE/MWO2I9eRXQKJjVv1ILESxoXoK35HItQy92ipNIyHPK4sRQ++hYdOA3/lWK53CvEHVTmufEW6VnhmIWUIQ0Ew5KbrrPIp8kZcOM6R3iIHyvH5NgAmZMRpctDFh1Qh4hLjw3UA9j7pHO8IbvoHezK5LNeld9RkpA/nqDZZxDN5/srA3rwfRAlkvzczaJWEINPlAETGPBB/uQJ/vt/8kQ2KLtID0mopu79iCk4NGUFqK9JzNMcfj3jw0yDWkeN1zRikcxAW+SeeMjv2Q8Y1NSGwH+qFrdhYNwRWdsF5ODBIQNvl3bFEpn3ZU4+QdOPvMSaaqGS2159qjMBxROqNgNBGZ7yIi5ArE7X9ss2JWD3GgBgayR7qY6KM6Kkcf9h/4K/zD++Ydh9SMoSIAzN4Cr5qZdvDyPggWUWLemlLsAWYIw==;5:F3yOHeLWuwjzGt9sj9JAiL2JC5d3pGMbgDmWhbeoO4vPZFX1KMj7od71KWJOtDMVnjJM7ULdnkT8GTPGsaNvaWDSogfa5A/2cojQRgZqA6P73pGwCr8vskydgIW5MF4mjd6N+4NWsE+rAAATBpo6ZbPhaaRGJGxxTz2iw456bds=;7:R8R8EJle6GjM9SVTXwYJU+XH5MtOaHhQqXuvrX2Roxl96p98Vw2w18ypWk/zFKGXlcYwM3aw3BcobZ3p09/3aCzwTQtCbyMcy1zMhzZjEnzmz0me134DX13fRsBDTqIeLMvvTCEe5V6ucBsU6TojNm4zAVV7MqiBOZVl7lKSEE0PIpdnn11/VRbFA6hr8NP/HtwpmGo1aBeYhTLaszxh2sQJzstZ/MMoscwBTTgfYaVXTya687VrcGv5kyxfhU1g
x-ms-office365-filtering-correlation-id: 7d828079-d3f9-463b-d2b8-08d6145ab9e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776F6CA6DA8B8B718001F70FB000@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6436002)(99286004)(2900100001)(76176011)(6486002)(105586002)(54906003)(110136005)(316002)(106356001)(4477795004)(81156014)(81166006)(8676002)(217873002)(256004)(14444005)(305945005)(7736002)(66066001)(2906002)(6506007)(3846002)(107886003)(14454004)(10090500001)(5250100002)(2501003)(6346003)(6116002)(102836004)(1076002)(186003)(26005)(478600001)(72206003)(4326008)(25786009)(10290500003)(36756003)(5660300001)(6512007)(22452003)(53936002)(97736004)(476003)(446003)(486006)(8936002)(86362001)(68736007)(2616005)(11346002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: j77weWTLNQqR6JlW0/0gMB39uYn6BVWzcIogW8NCt9YqBigDKl7fMb26Cx7kmTTeXIPasMxTDz+Fqe+nWECzNWd25sq45/01KlYr+yamkXrudwaFZrlPePKcpnsPSJTX06V2QaqfajqvE3uTRltxY6wA6ocPNgQgZWMNZW7qRIGFIkeelxegzUH3VMDZCwdIxhnaqD8RHAqeOBpOJZvy6BKZscVobUMUSzfPQow7f7M+Dvof+BI0ijx8P5Ch9yd4HoeDH3h1ZHM+M8tDc1cXUz+97aWpFmwoi9JIdfCtauRs4o12TScUITF1aF+94r2JDbEGXNX328nGo4cedmhdnT7V2NH6d2cwVsCAlUlGO9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d828079-d3f9-463b-d2b8-08d6145ab9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:08.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
