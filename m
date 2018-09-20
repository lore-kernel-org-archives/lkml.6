Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A780ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF66621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eru5iwIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF66621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbeITI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:47 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388144AbeITI3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXXWaIzTj/XGkHxWalrodOkeHgK/pZ6dQ6YMSFeKsC0=;
 b=eru5iwIsAD3c9vxiBQS34bmQXquR4kbfycDBFjlleY0yWPY3OCht4Qf1cKEsyEWZ7m8T8+pxRmZikvgFZLJUpP5rHYYNI5dCZ3CUlZF6D9xh+w5jHty5k/eKpgVe0RV+jF6E72Q7EglYaelvBIGVLDO/UDWsQjRmlByXuO40SDM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>, Hang Zhou <hang.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/56] drm/amdgpu: Enable/disable gfx PG feature
 in rlc safe mode
Thread-Topic: [PATCH AUTOSEL 4.18 46/56] drm/amdgpu: Enable/disable gfx PG
 feature in rlc safe mode
Thread-Index: AQHUUIxX9lI2LQZZI0WwA6aYYiMGkw==
Date:   Thu, 20 Sep 2018 02:48:00 +0000
Message-ID: <20180920024716.58490-46-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:Cf4NLEQ2C6RWMF9ldmL9n3iKprKXYaECJvkW73xz8wxnLyPhpsfzkQAP/IqfXj8Q7tbDop8SFWnZt3dz/T6AenysEzK5CnqnbieMa/zy369e0OglcfV2aA/MTJPSWOIXuA+4uKkUD3VsZ48taW/hYSOBzkTnhRG++ELpWUaltYae4kGuBLjGBFPkarVMOhHUp4F3WfXgXntR9A5nFpb6OYo5jqkKZeaCouKV8Lip5FYrxnwzs/JQ4tVoL+9BmQlUv/DYAiiwxLvvF7yYoAxZ+ZMJImSu0y6saVQw5/boygB8XDHx2WsrUfoRGDR92P8giup92EemNzDWjoGlG8/RqQIpk/BBreDsoO9oIDuZoz7yQQLmrTjZea4GFDP0l4wTT7oPIqOi56yEVi3ZRWTch/OE1ORy6whuy4KSkPtntmi0qSdgEI4AvKBBgPneX13YarnLQDvCpbSNU30cpM2M8g==;5:QqoAvQiA6s7hQed3d/LBMYRTksGwP3bBqzMvjvr0oPSg6OQPfD7MISM25Yet2UAwDVar1rBItfbC6g3qcbj5Qphz0xpyUZnuuFu6YgnRQjH0cUwHnm/C2UEO/2q9QkYO3laNEbCut+6t860fL3x4gZJBMZ7llslffptbIZvyfEY=;7:bZNEhTvY/6qmzONq8iuryMNGxjUFuyTVCIJp3+FUIjjesCRbuRVj6Cl/vgKXM3v1QrqI2ONPSV/gwCPKEwGZ+O6WkRv7nwWuvKrV7sN/9cQTkZCTYjxr/Vwt+hf140/yhwcTTgDvL2WvUANQmZzSkf+22kcDNTmeJK5SvuaDYdThsD9f3YH1QFMGZ9al3qurpaqbZ7Wc2Cl+XOkasn2kajN9Kynzmf0pcJIZOXFVod86fdY8zX1tjJSEVSeIT5Or
x-ms-office365-filtering-correlation-id: 35ee9053-b8a4-44a6-069f-08d61ea38acc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165F85E57E3778DEEF73431FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZI8l7y6xj+EiiKmYfSO17PAVAX24BA7uy14jI2XDNYum0PdL/wvdVWgPQu5RQMnkVt5eVXV7jTWILFE3NwO5wtD55DaJkdcT691ZZ9J/iH1B4kOVmSomtocdeY4AK6V7OpFkG/MsnSbU/HAW7UfapGW1Lp8dUBFl4v9Aa/5HuMrqXDObVKnFE1Q0A/Qzr29RVsD5pXeTdFh4DJ7NAWvsX2fhj1BC5wW94gWnMnrK61Gv0Dls6ZEz1Mam3tJRXzevQeCLL8n9S/ch3sk/gmASijpr9xwfrPdFzWkA8GHYI+4yvRvd2WdCUC3Nl6F9sRvWPjccXnJhUIxYhyY5mquqihoOfgaHyyumMZr1ekS+Qyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ee9053-b8a4-44a6-069f-08d61ea38acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:00.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rex Zhu <Rex.Zhu@amd.com>

[ Upstream commit 8ef23364b654d44244400d79988e677e504b21ba ]

This is required by gfx hw and can fix the rlc hang when
do s3 stree test on Cz/St.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hang Zhou <hang.zhou@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 818874b13c99..9057a5adb31b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5614,6 +5614,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
le,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
=20
+	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_SMG |
+				AMD_PG_SUPPORT_RLC_SMU_HS |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_GFX_DMG))
+		adev->gfx.rlc.funcs->enter_safe_mode(adev);
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
@@ -5663,7 +5668,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
le,
 	default:
 		break;
 	}
-
+	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_SMG |
+				AMD_PG_SUPPORT_RLC_SMU_HS |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_GFX_DMG))
+		adev->gfx.rlc.funcs->exit_safe_mode(adev);
 	return 0;
 }
=20
--=20
2.17.1
