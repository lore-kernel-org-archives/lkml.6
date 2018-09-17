Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86FAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6B208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XEVUpcs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD6B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbeIQIuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:50:05 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729074AbeIQI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtoZscTk/5xZ9aRe+YJopT7N5WROlVeD8XgEPzMk06k=;
 b=XEVUpcs7o0TTzGiXMGXgU6203ttqOy8wSat19LFOmTpOea87H4Xx+NjaFgGvUGvo5wHu3V7tT2htDNVczM0HVwW+au9+FmPp0LhImRCQxF0O++RchzinqmmLsy0eRIy9C4TWZQk/A8nP41TBXKEqAF85OOVfz4Fr7B826j1/Z8k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 133/136] drm/vc4: plane: Expand the lower bits by
 repeating the higher bits
Thread-Topic: [PATCH AUTOSEL 4.18 133/136] drm/vc4: plane: Expand the lower
 bits by repeating the higher bits
Thread-Index: AQHUTjK+J+DSbq9VckS3wQokB+Tkjg==
Date:   Mon, 17 Sep 2018 03:01:35 +0000
Message-ID: <20180917030006.245495-133-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:T2dvKXkem/t/O+Ekp5pOMT/AghbS441fiaqIMPrSiK3z10G4O9tkaZgeczFAdcpVh+kiEtBxFw52AWd/j7WIB4jYjIILNQt/MQDLwCLs8xFYePBgFrjIYhwvgMywqUrPbQU/lWYMG19o3vOU/K29Iob02SYOlgIYJSD52Zjxka2fQ6UiYMGJx+DAAEOFl3WiodA5fAAqt+EiTfSBkE2Ay9nTkQPOD19ODtk3MGrtSfZvFaOAN5qtFj0egrYnts5YcVeNfvpyK+k62hePOI6PMaiTtQhi+gk628LrBiK5H/gplbaS3zRXjoG0uDpmkR+JJD4K3FNy6hrbufZ/UWQfft78LeZyGF8QQN3neRORH2dFkxJkMK+J0k3ND7/C9mArwOf0Gs+Qi/w1EJ1905Yz8E8QUFbCkwBotuJsbSx88S30AzLd3D7ZuFgXu6hRNXOmnbGpywWONWrjo0kBPIsEGA==;5:p+0gqITFrtMcjYITU+FmeAIpSyCzcRSUzmsDa4D2hSHSf5EVtwmzprBurDMG9/ScXsNMni9iLMcKyjVbJr6P8jqqMTxtRZW2BlwmeDzemUHceMpRQIRMk0SnVbE90A2SFgmyrxghhEHJ0bc5EJNspRSswBQ2WPnbxx0Ndh1fTI0=;7:QftKkr0emLU2Z4goGdd/R/gYmDSWQqY8ijpIWf0fYrH7iAv1wTdMnUzRYLoHEkP4y/e/iEWDIESJwAksw1rEyhCS5sxrAos3mrj4+W7nsZMLNB70Po9bK5K+5xwy0cuLnS0sM2TrYL+rgbM46p2v+AEBrMsITQEhAS3Vc1QfEsEQVcpxJojVBqSBd+PP3rTaVC1UYUc88ZnSbHtLxcAb+UHoNOIXAjBWyFe6AZXHj+DKMo3/AM5pNS71mO+QF7Fn
x-ms-office365-filtering-correlation-id: 13985146-9cff-4bdf-d231-08d61c4a22e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB01189FCAA21D4CF92A1EE7CEFB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(966005)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(6306002)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qJTrvCK8Yn7hSWpTwRnD3dpkYrmqCXXmnWHYTk0yIBnae+Ocjp5CJRelRmN+CvhIb7G5vL3C7j9Wse+FTbvz6akFOP4mO8snUiZ8Ch4x4W7Irfcq7BDyWvkHHvpHNteFChqmtZFGYIFEr8BrhnDkikEy7BwpzO5vS+GHQmlDUN4oZ1Ff9sNr2YCaOW3CJH9ysKxgqOe/TrXguWN0Jm8VxeX7OgxWCRHQsE+bimoVfx17vzrvMAhI9iDzpo2dnmkWDUEXaKuX0VnTxMnrONG9HWHiaIHLSvwjhp0Cx4KRjSFxGKQhOBxFCJUN2LAFwxJzrUTC0LeFq6KWyxTtV3ndBy27vLsdlLXVwG7en3c9Y20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13985146-9cff-4bdf-d231-08d61c4a22e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:35.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit 3257ec797d3a8c5232389eb1952d4451e80f3931 ]

The vc4 HVS uses an internal RGB888 representation of the frames, and will
by default expand formats using a lower depth using zeros.

This causes an issue when we try to use other compositing software such as
pixman that fill the missing bits by repeating the higher significant bits.
As such, we can't check the display output in a reliable way by doing a
software composition and an hardware one and compare both.

To prevent this, force the same behaviour so that we can do such things.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180517133759.25626-1-=
maxime.ripard@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plan=
e.c
index e3817d7079a7..9df6f35f23be 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -547,6 +547,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	/* Control word */
 	vc4_dlist_write(vc4_state,
 			SCALER_CTL0_VALID |
+			VC4_SET_FIELD(SCALER_CTL0_RGBA_EXPAND_ROUND, SCALER_CTL0_RGBA_EXPAND) |
 			(format->pixel_order << SCALER_CTL0_ORDER_SHIFT) |
 			(format->hvs << SCALER_CTL0_PIXEL_FORMAT_SHIFT) |
 			VC4_SET_FIELD(tiling, SCALER_CTL0_TILING) |
--=20
2.17.1
