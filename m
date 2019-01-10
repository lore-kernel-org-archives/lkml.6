Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D901C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9B21783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="MgqBMrFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfAJPKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:10:53 -0500
Received: from mail-eopbgr70132.outbound.protection.outlook.com ([40.107.7.132]:54144
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbfAJPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfejE45XFsxyeIfyxe8zRHW01ZzjfRWcAHquFt+YA9c=;
 b=MgqBMrFR4naTxUAztDmCmDdzKMWtGJnD+MudZlHOAZkc+Zytc15CF8uv8qA89FUPKZQgXry//AHF+tB5jARZu9H8o/+LXK1ocgNmJV9OEMVkBKccksR2tUPNoPy+AdGJgAAAnYxqIjuOmyd7ohQzMepQQ3266TCXymP2TmdzYAc=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:49 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:49 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes, wait
 for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vA==
Date:   Thu, 10 Jan 2019 15:10:48 +0000
Message-ID: <20190110151020.30468-5-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4037;6:l5rhVY1b7Vw+8qRryBKOAWCM+qSOqEKtoIViAXkUnIHinZT0ZFWR6q3OcI+/+RRdoPBJpakmte+wm3juySvuuuFb5k0xp4DMC7lOwcH56NoSQGdAJL9gK16QpGoJ6L36+YtquhRFltf9iCTH74RNLdnxALH9YwNb6kzLIBBtvie1i8pzHju3y1Erkufq3l+d1hoFtf7Nh7uOrRnkJ2RUE1wQFZVYlSdWpW0l5fFdmkT1YT7oocc4Iu5gn3hTt9mW4M12BrGiEXDwVCh9ZRwU9ss5bA5BOTjQB/ac3rFfWrQynVc0dIO9eX9fReSq2UcRf1vI1VWcWsOa0Atu5E//wGP2paKB11JvMfSwd0CTAJpEcKV/f0gGjqv+5QaKg5ga1Rt20Iuuj5w0x2Fh6LyBgoacBceWqLbzyDjOFtpsphJAL5OAuB3iuc5buaE9MHqylEQ5aR6J8xg8Z4yFOyWrZw==;5:SzL99niKpz8qePpr8b2aFnzNFY7nkbG+X7BOgZ2JkG+oZW+zuZLFA9yOFtIuaOfiGLMXcnHeQUYKOLlybd42GQYIu7WuVS25WuPvthtxRxhRY+sx4j/3B+2I+0DkQIq9XM63PWQ0nJaHQdoIOln2Bo0KZxz1o0TqN8Bl+ym3fVAgktck0PI6Sy9fEJHvoVAQrD+CY5l+OGHJ1C1udDfhqw==;7:F1y0og5CbUNdVrxCikeqjbuEU/+yytYXU/z/LdeBew+TKUbSZV89YaiGa+oN4CKVU4fDh6V3aOFywJ5cG8FQz6V5mpBwsst+9TCe7a1Wzj9ualQpyux/hqhdXao6cawYcgzZJxtcmosG/fz0ogRmTQ==
x-ms-office365-filtering-correlation-id: 529e6263-5f82-4f7b-2903-08d6770dcd8e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4037;
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403701D52805462BB9362B09BC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4037;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4037;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(14444005)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002)(14773001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4037;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2u7gdM1Ky+CIK2saE/pt0xt2IA/NLsZKeqmXJBtdIeIwRV+FoFw0H3enSJrl8cVyyqZ1AtsZ34j08PjfWdQB24V5A97kzUmO3KeAG1M1QemRrqgcQ4n532q2D3JTKFtJfwRKxMIkn78u5QMnxPqld/EgFmFdl94xRakkmcxlvE7F5qsBfHIcn9q6Xii7nVlmwBMkhK/88zSlTrbmr34vYqo32KsoE4NILVlQFqMoCI7p/b7VIYN5j9+31uyBfRZHwI1btJ44D2TycheXa0Y27w2m/jcOnvP73UkgdDQV65YCciZxvR1NNRE3blcMk8Yh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e6263-5f82-4f7b-2903-08d6770dcd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:48.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A2Q and UPDATE bits have no effect in the channel disable registers.
However, since they are present, assume that the intention is to disable
planes, not immediately as indicated by the RST bit, but on the next
frame shift since that is what A2Q and UPDATE means in the channel enable
registers.

Disabling the plane on the next frame shift is done with the EN bit,
so use that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 05519e8c6586..f2f570642f84 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -728,9 +728,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm=
_plane *p,
=20
 	/* Disable the layer */
 	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
-				    ATMEL_HLCDC_LAYER_RST |
-				    ATMEL_HLCDC_LAYER_A2Q |
-				    ATMEL_HLCDC_LAYER_UPDATE);
+				    ATMEL_HLCDC_LAYER_EN);
=20
 	/* Clear all pending interrupts */
 	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
--=20
2.11.0

