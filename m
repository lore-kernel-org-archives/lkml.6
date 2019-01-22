Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E25DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0249C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jKkqOeHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfAVLLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:48 -0500
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:41571
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbfAVLLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKC+jfmViIgRrAWjx5Sh8JJDiFnry80xEeHCDVJzMXk=;
 b=jKkqOeHpuQzn9dEulddoRhm4oJ38dwynlOYNGtpzXaR7DnQlWbhDvDR3LVLLQBtYLoOQFdeOepfsfgZQPAi2bBOqsoZTib6Zn/vA8P6M82rN4jWuNbazIkHDe9ZLcCO9/LJ5LskqIgbzOJIH/XAjAv2S4FiAZ3Lg1dMw5gjrICk=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1286.eurprd08.prod.outlook.com (10.168.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:11:44 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:44 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 09/11] drm/komeda: Add komeda_kms_check
Thread-Topic: [PATCH v2 09/11] drm/komeda: Add komeda_kms_check
Thread-Index: AQHUskNCu8FeIJKzIEuJggezM8JI7g==
Date:   Tue, 22 Jan 2019 11:11:44 +0000
Message-ID: <20190122110932.5138-10-james.qian.wang@arm.com>
References: <20190122110932.5138-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1286;6:qriucuHmFFLBjlPbX4sTxjyMp+wjN6NPXXyhe5Ugwl9zDh1Gh/MV2V3pTpTR+utmEWLAbkDwAAhkY3qrDChT7Pa329I1z1bvg/V8bgkEN9ZgjJm1MqrmEtJxD6BNt/faLo+w1f9UjSnpRd0AbqCB8El6C6KL1wMK53SxWHM+DInbpnJ7t0+VuQt2ANKvwBpx68+AnsSGzpTlb0OJA5lROoq+R+tqlfkE+VxbJxsHnTkCp811G64JDcALNedClqS0lJRUl8n3N1qFZXO/e7Y3CoGMuiMjzEl86Cl1H9FJdAcdZEpFj1x+YHhgCRxe5EfIuMBxqArkQg//A6TuEQBe6PY+nZO+AgjUhcGWv9+Jx/kCE71G/ET6jm4kHYy4BFbdYjVmRezprEqEfMqmipr2Q512hiojARhEXFn/dXMVaZMVvnUDbpG9GyRV9qTnEjBV5YerHmXWS6WaU3SQSgsd2g==;5:CAe710MQRQo0uo1/VkyI11e6N0L7hzbpNvbzXYMfAZJ3M7NPAiUZvd4MAgBC+SQO3JVRRtyI3QbwAHAEEFUi2KJIKH34xLEVIGm91KaS7igBqfGvg/L+Da7WwGFyGPIPCmXyrui2PKgZgPF7DKT4hPWWoYHwzOrTu7JcXpu6oMkMSkAQy1VI3b2aBkXC1Ci8L2IxQyRr8S+S8vFj/RDO2A==;7:JXHElrvdqB2voOc0h5QrFofcp9dIRkSnvXgI4FgEkWHShyx+h983CT60RTNFisgLU0X0OBiThxp0+Iahti2UGfgM1wzdN+8qXRZhVF3P0//cKxH7KtcW8GBto7oGraB05UwkLERN43wGWSzwRTgJtA==
x-ms-office365-filtering-correlation-id: 4df326bb-4176-47e7-bb02-08d6805a646a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1286;
x-ms-traffictypediagnostic: DB6PR0801MB1286:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1286FBCD59F06C241113D37FB3980@DB6PR0801MB1286.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(6636002)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1286;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: goUE2/FR2OPzqzI7C/9alId14UPKNF2AQD1YDLJBGO89l7PmNl7P+cJL5Xl3ethTiZ6SXDnmK5MxK794MNO78sM70doxCVjHXkeS87XqSAdp7LM05+IaW1FzEsrmSwbM5lJ0STjOGSPUr81jcpkeJk/uknzE5M+eOUrTBD0s1QrvKUyiEfzBHXeqWv+W6PPcftwx3nGRCPa4pmICwIAOndA7Ox7ZFCxf2niRE8fqNCRQ+pPGGHikkrj4Aa7Pg29dhb2tzJosvQVJkHZJ/8IItS6sF8PiQjOyJiRwDycTejqrSiJe+R20L/y/FQiPJ2J6hD5NBHi50Pzjoo89p0AVonRtBLLIog2bmPsK6lRXYoZCxkgJkSZTYzwznL46rn0Ew8b4wohCqz3+0NZQolMDp1F9su9UrQWzNiLoRvckMV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df326bb-4176-47e7-bb02-08d6805a646a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:35.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Implement komeda_kms_check to add all affected_planes (even unchanged) to
drm_atomic_state. since komeda need to re-calculate the resources
assumption in every commit.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 7d7fb5013464..337e6fddead0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -95,9 +95,37 @@ static const struct drm_mode_config_helper_funcs komeda_=
mode_config_helpers =3D {
 	.atomic_commit_tail =3D komeda_kms_commit_tail,
 };
=20
+static int komeda_kms_check(struct drm_device *dev,
+			    struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_st, *new_crtc_st;
+	int i, err;
+
+	err =3D drm_atomic_helper_check_modeset(dev, state);
+	if (err)
+		return err;
+
+	/* komeda need to re-calculate resource assumption in every commit
+	 * so need to add all affected_planes (even unchanged) to
+	 * drm_atomic_state.
+	 */
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_st, new_crtc_st, i) {
+		err =3D drm_atomic_add_affected_planes(state, crtc);
+		if (err)
+			return err;
+	}
+
+	err =3D drm_atomic_helper_check_planes(dev, state);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static const struct drm_mode_config_funcs komeda_mode_config_funcs =3D {
 	.fb_create		=3D komeda_fb_create,
-	.atomic_check		=3D drm_atomic_helper_check,
+	.atomic_check		=3D komeda_kms_check,
 	.atomic_commit		=3D drm_atomic_helper_commit,
 };
=20
--=20
2.17.1

