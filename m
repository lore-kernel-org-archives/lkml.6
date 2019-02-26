Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F97C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DCB2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CGA5dnDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfBZQVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:09 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:63296
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728668AbfBZQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCvjvxRYhuY0SvB1vNzKgYMGI898imZNUT9UDgs1vHI=;
 b=CGA5dnDWpWKKQvjqjlHq0NPhjDn/VIPspIX3dtCKYPmkqTV3yK4xylpszhKUE3YrL5Bwm+Db1zM5uO/2PP/vyV3axzO4Bg0QBwhHma2x+T8QSVTqBdqt7eShZOkUELEsL7jdcd6pRAWnqi7jKXuLC9gpuQjncc+j31ZzMUuWFQg=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:58 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:58 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH 07/10] drm/arm/malidp:- Writeback framebuffer does not support
 any modifiers
Thread-Topic: [PATCH 07/10] drm/arm/malidp:- Writeback framebuffer does not
 support any modifiers
Thread-Index: AQHUze9B968JoGHcgkazxxZzNLshmg==
Date:   Tue, 26 Feb 2019 16:20:58 +0000
Message-ID: <1551198042-4314-8-git-send-email-ayan.halder@arm.com>
References: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19a7491c-8aba-4a9c-529b-08d69c0663f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:tQfb0VCRg1XN0fdaOprGACQiTeoNSNHAWdLPHGydenoiyqjUf8M/9TBgRBp8r6Ev2ItMcihePkH+CGIA1aEcsWBW9gGdn/QWZtIt7GzbQ7dM94tM/hJfo9e7OPofDqF8IIBME5zoNrceRXdqxV3RwFcEcH8Q5qGDITUaIsQTF7I=
x-microsoft-antispam-prvs: <AM0PR08MB36829C18D83BF8012650D9FDE47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zwDHDanXBdU8zSD4I3GeUoQHzhzsaSbWwjXg+KYKK5vH1xB4WSwwdwh9w6k5gexgtvjV+XadQes7ImLIocJUlWs2bl3Ln5Mh9O03pc2B1PC2G/nKk5uBM78hdaLag23kWzThCXxRNkIpa80tQyS0pXZKt98lbLznLQfUXqMDQO7nvgjUX/hxC0qIpvJsIUGLDizsrFd/A3Qke0rJ5BdHWtibjw+ftLpItQ2NnPoL1zBT8AIboSTOOwluoYEu2DA3JJdronq30YRKp227onuOUXKpll/1BrXeLLUNwZGopZD7rRpkE/Uk+AEojSZhKORdnXr/7wSwSbfCmpFWf31Lxyw0zmurXg4JpARSBONWkYf2dXtPAHHLjr201i+azJ8IJvwdygMivmA+z8M+u4BQtFV3x1B45ShJDl4leKjYDsw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a7491c-8aba-4a9c-529b-08d69c0663f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:57.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Kumar Halder <ayan.halder@arm.com>

In malidp, the writeback pipeline does not support writing crtc output
to a framebuffer with modifiers ie the memory writeback content is
devoid of any compression or tiling, etc.
So we have added a commit check in memory writeback encoder helper function
to validate if the framebuffer has any modifier and if so, return EINVAL.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_m=
w.c
index 28cd351..2865f7a 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -141,6 +141,11 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *enc=
oder,
 		return -EINVAL;
 	}
=20
+	if (fb->modifier) {
+		DRM_DEBUG_KMS("Writeback framebuffer does not support modifiers\n");
+		return -EINVAL;
+	}
+
 	mw_state->format =3D
 		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
 					fb->format->format, !!fb->modifier);
--=20
2.7.4

