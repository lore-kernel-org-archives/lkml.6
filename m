Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A765C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1A120834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GWN6NWEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1A120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeLCLcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:54 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:52592
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeLCLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4Jb6/3pclBkaONeuzUpg5zxke3xBBEMWCbOt5nB/t0=;
 b=GWN6NWEmvOvHfQOwO3DW4C1abLbQIzijl4VM7qXsu2P+/WPowQHUGHeXLeuQdS1di15OrSVbVCzOrf48vjdrqQrtS2dPSi/IwdDS/ugnq9KklJFBUgvKURJsH3ZK5bCzgKNunIr5C1yfoxQBBUspeR//hRBZ0tt5G8COSEiA76o=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:03 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:03 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 09/12] drm/arm/malidp:- Writeback framebuffer does not
 support any modifiers
Thread-Topic: [RFC AFBC 09/12] drm/arm/malidp:- Writeback framebuffer does not
 support any modifiers
Thread-Index: AQHUivvQsG7PhuBjqU+2JuBpx+kdvA==
Date:   Mon, 3 Dec 2018 11:32:03 +0000
Message-ID: <1543836703-8491-10-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:USzG07r2FiR0juS+X6QgC1/obTXhe1Z0AAwMEI9NEs2/yszoa3Zg0MfuguNUqopoyzk+QWHl763rQ2T+AHdHWoM6ARDXii6989VU+qaEva+j7xx+HA74q6h1V4U2+8WqqsuomZuDl8+HcUwzXKDB0NBChySdjm9F3Gt2KI4aWglO7faIyJTHLqDm1fop67uBRI0Ep1jkObfBQFq2rIwIcQxvxfoMu2rGzC4asPoUcqUuEnvPGVR9JZuxsb8olMfNWOTKSG8dW/nfJ8fguxelklw3rLXVtp8mr/JpX77F0H0PPrbShu1G9IPxjuF97lmQ1EwpH2Ga8A1uyQYZwvWyfYmDKuUSoLK3W5QE+SKAQ1V7CBdxPVA37kkGN5mR8JK0fVJYt3+Oc7driUKymefmEPJpVAba5tkO01iSPhj8Z4Hy/D/usMhxd6EqMoq7idmKFkyUU0ZFdlRu3JLrHJYPaw==;5:JyIp9AFEMDpO8O9Y4oAKqE2mVtf4vLMBo/0lP6hRzX7cePCLoraVfnwllcuU334JNCjFnbJw3OqcHvm8Kz11x5zxKJYQnu+NlOJpnHfkYXQ+YuL8GLCuEdOK0CQkzRnX4ZWQnnflRIKDQmuaNyTpGL0T0QTvI+/QvBtfCBqLwTI=;7:i6e0TZ2FXWCDHaqfvz1RS07Z5KQ7GDRcNPqJTr4MYKIc5+RIKARlqtxfBXBSKGX6bNmI3KJaDhT/i0KrB81+Gp25cN1JUU7zuxa4+Ob72/m7kc3M4Hsbl0/jCMbNn+Hz4XTH/vHvW6p3apwb3gu0Sg==
x-ms-office365-filtering-correlation-id: 73a6468d-fdbf-4eaf-ca58-08d65912f28d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB349185A36B1197ED2C9F231FE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GvvJjoPF/aeURfyDK52H8ps9A/fwfoV81oybDrnIROkOodN41xjeVNOt2u6FOKwMUMt7jPVXW3HG//cpGtyYTzNCkoJyb22Zst7W9Zw/BpZgdA3rZ0UYvLiTB6AZCPNJjbR+mrkDL0m52z0Hjit0bbPn/cPayBu1HWwZjsjxiZ0VBR46wXCvuhievW04J+UZ5jiC2esjj8JylZtPrYz396MAARe8xmf5kKM2HAwZ2c56blgWSIIXi6g0NjvKpzrSGH1+pJrDojXF6yy5NI/9hAjtAL36198oKerY7/OBv3q00Q+XLqjc9UD6PO1M2OXvRthcut4PBd3Gl6Ps6apJVyeXnqxL3PN6zMYwYsWpiqA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a6468d-fdbf-4eaf-ca58-08d65912f28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:03.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In malidp, the writeback pipeline does not support writing crtc output
to a framebuffer with modifiers ie the memory writeback content is
devoid of any compression or tiling, etc.
So we have added a commit check in memory writeback encoder helper function
to validate if the framebuffer has any modifier and if so, return EINVAL.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_m=
w.c
index 0484744..90c964a 100644
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

