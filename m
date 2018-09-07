Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABCD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ojoe31Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABCD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeIGFRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:49 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:27712
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeIGFRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KycvKawS+4BsNw60FGHwm8IbAtJ54OBn1PvcdoABKSQ=;
 b=ojoe31CpcsnhYdTV7pYq5/YKFUoWuEuWeOgH/R2JvwELuA6busNgBHz+mcSaLDiK7MNpAuZwEUes2lgsU3du9QrGBOsCNC/j/Guwh0dfdFyFKwm6rQIkX4lxa4SIbzbFPlPrY1DIVb4Ovwu9fusEKxUMffLGLVYtQywJoXxigV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hanna Hawa <hannah@marvell.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 63/67] dmaengine: mv_xor_v2: kill the tasklets
 upon exit
Thread-Topic: [PATCH AUTOSEL 4.14 63/67] dmaengine: mv_xor_v2: kill the
 tasklets upon exit
Thread-Index: AQHURkML/flaYbtWaEaqcJoDhiBuMQ==
Date:   Fri, 7 Sep 2018 00:38:06 +0000
Message-ID: <20180907003716.57737-63-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:ZqJlhkSzhmSQXQaFf+ZoFxOyt/WzjU6h/G61qik2DmIPBo1uAVeZa6PZqbByW0A9N8nnZ5pSmUyf3jNcSvr/pOy2Ew9I5cg4lQ+I0gtzGRuh7SS+3dBQNkV+Tyos31ywlT1VAq2sgOlyEBaAOAc/biu2bSaX9gOtHmW2pTOUWcGRO9TiHO6X+FJNgNW20itZT9qYsbvyJrBRgfX1SpvgUzQ99v7RdcDCHortuy1obpQwBCQUncHg7pqMtI2lBj/wczbXyXhr50aDZeaxGfwzUCuiS/1bUEheJIdeQoxJMZepnzGodyTggfJM+gGrJ3H+uOvbDLP1RvyV9dskmIirlJxM7YJwTPJqqv/5cNi2mSHh/ezHmxL5E3KUfQNozU4roT3xtJuj2EFoZYF73TA6+T2+SD1Y48UL9itiqS/AAtPcRrIYPPzeXgM5Ro77MMOanH9nzBEQasRSxR6hi/WtIQ==;5:zccs4V3qxeaiOXaGHaHwI8PIUAk7qmd73xSk1tn/7dYh0cH3purxmmXr7bWa/QqOiHk3asNYMCAsyxVJNQkQbnXdMkrup0v27+cO3wVxxUQvmdIS4TYm5lqP15JAuI1FqVRl7EJZxWI6nKkTl0kVLH0S1PdFFltB4k8kYt3F73I=;7:uyI/yzU51a3jkLHjTstmPU9PSy9g5z7Zi2eNM6e2zv5tsLFHaEBli+AtoTBsaBNEARD7bo62/D4MoQop8f1lii0HrkKAFOp6snfmJEadRWYT6VggMr04444eBrf72mDKEj5zx2+lwCQjUPUihRByo9lWZTkMNdwfEZFcLWgHjOM8wpXc6C56kG1Ejr/WO1jSg0NHAyqap//Jk01LodhUVKZixsZeyxZOob6m+NheX6JVx6WbQNYe6oFFf28Qg4Tf
x-ms-office365-filtering-correlation-id: ef264aa5-fb4d-4c31-c2df-08d6145a6625
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08551E782B721DFE3FCEE593FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fQeB8fI1BqVYKKs0ivlvJp2SorPYZh0XrX8iu08bhlHWh8wMWJ8lQXsplCam22pHWMs09CJRzy+k2vPRc1GisVARXR3qouN+GNsmEo72IkazE0n3xWyhRcAeRf79cVHtk04N3Ydl8R0b8ArB+d638q1s7l69v1l/E51gp2gDnhlVXoK501O81TktLmH9olNSagvID3x3mm7xb7Ku/nf/LR/XH9DRH6WqzVqJAhHwpyHBB67QWssiJc+HyyNLQIw/EilRn5E2e10a23iLmd7S/DfSCUEZZV28OBbKCV3D8FjBDovPci+xiNCVBaLUliBK7We4svLE370sFm8tlrDC8obxod4n+3dPN0vCJn70xDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef264aa5-fb4d-4c31-c2df-08d6145a6625
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:06.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 3548caa9e933..75eef589d0ec 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -898,6 +898,8 @@ static int mv_xor_v2_remove(struct platform_device *pde=
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
