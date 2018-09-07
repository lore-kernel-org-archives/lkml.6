Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB445C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OTAfLjft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA3A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeIGFTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:00 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730728AbeIGFS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxW6TXgIBI57HIUxzNDkaCGAzYdnEpUpUCSFXxNh0/Q=;
 b=OTAfLjftvLiVlD2QzBxZ5rsDrg8tI9UwevpBrw06jRTkcWKCRNnLq5q2jw4TXgJljY6blkp9jKGLYim/9pJS+lENhM17pQWPFUKdv/KCY4I7FjyUgWuWxp4RnG5nASp6a94ZdqvyX2B+nGZkOgpbrnKasUE2/nZBGXG7flBZfDc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/43] video: goldfishfb: fix memory leak on
 driver remove
Thread-Topic: [PATCH AUTOSEL 4.9 20/43] video: goldfishfb: fix memory leak on
 driver remove
Thread-Index: AQHURkMbo0eSrw8thU2IWUoC6XW3lg==
Date:   Fri, 7 Sep 2018 00:38:33 +0000
Message-ID: <20180907003816.57852-20-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:TUkewzS9B3CwCJWTVJ1JGIuO4LY8r/ZhUZuoBTMaoX7/+D+dCH3Si20AJMwRYEsNT06n6IEVOyo9+KD09tdAsM32EOZUYdYsQH8SzsvmOumPe0QZOOGZoCfzoXeQZVSQ9J8gCxPP5MKUfzMF5OWVSebUKC+eMxFkhjPsQ3wksVJqi1F+oRfJd3ADInTZ4rz+TeudPiTkrFu8k/AtJDNQbRLz0HLZrRo8gRK8lGGPLhRfFr2hjsvvkaWbK5iflERm2VjQI3BzCLAG7KeFHySBQNISsUKrTQ/pHc4Tx0t1VFps1l2GRnZ90zNi3Vx3Az+FjB8pg3L14YTMzKMl4j79ZaM9fT4zrXtMV62abg6z1xN/eKbe8+MOKpPjSOVjSEjMPyrdFVAEgXkQWcbKPvKbGI8lK7NtiypLR23hMrjoKtWZ6GmDDK8u6pKehJKgwZMuntke5+1e1MFhYuNkfQbvaA==;5:18xo7vCUyuifEfVudQDLz4HXnpwialGu6iPsWB3Y4frASWEZzJuI1/+9ARKWLS6eedPFGH9wFyJFujw1EW/KFfz+SWa7fU1ssd82dosVAKpsUBGgyGCigpa7v7O/+siiNj81XckWHu5+I8gzXWKRv9WdrhhWvm4kZlbOjA2zXSE=;7:7LCTAXO6v81tN9tB0uAD0yESNfAsxJsVfcIBYcoiNjTbz+ux3H7uFdf6ATtnMMjFVG+KFHTIaowEZNxtHuJd2pXcvhTLUVudRd+mnBN9KuOFaOEZxtyFTzR3QOmi0VfmAeTBpe7OQCIffkcdLcv64OlUViXGkN8tEJpt3sMFt6fgW3ZV6Qf7zs2BAM3RLfKeQFOkHL8+jILmrgMNF2WFQY5h31AV60tJiled9VGEFpaWoePuGYP4he+SKkRLcPJM
x-ms-office365-filtering-correlation-id: 5421e4bd-6204-404f-c648-08d6145a8c0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08555B01451856081F75E2A4FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(4477795004)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +8LsUZZmj/Tom7wBZcXw14So2Q7GP8hDBrYoCroEcpP7wfTguR3OfAnibUd5hkqyOOzRPqTKn2L0/a60O3fM/XqmDl0fzpSX9EgfFRkWRvjTGR1iMpq2Ea7yZPH7xEKsgUncgExhNSzsCVmAXgbvLypkq/5i9DW33zf7y1vFG1TwGBGc8yxPMFO80R3pBS7//jF92U3ikqPhs1QoxTiS8gZAWP4b8IAFOn6uzM5wkYo6vAmcbNT0DFCegcwBgHSsB+0HfpbTGH9eSBysxMlg4C+3/MD1xAeQfi4LEiL6I73qVA/k/GI1+eKC1R5pXqb06GIWBHl4/4vl/LYkxuqNQPUd3YPDurKRgY3T14eNN4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5421e4bd-6204-404f-c648-08d6145a8c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:33.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
