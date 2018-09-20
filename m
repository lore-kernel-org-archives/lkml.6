Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEBECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A6821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S89d7SvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A6821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbeITIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:35:26 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITIaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLxkxRnqbPudyXUNpyYIROsInONb/+F0sUPpGWAm6ls=;
 b=S89d7SvOwnYIDIg5dgQoTZSBbROv+9bo7eLIj7jc4xLkY/Q4Ut9YEKVrjUNo6OAa7IquZbL2FqOwZ0it5PeDM2tR9JAz/it33hWwKR5uH+5cDi6qNfHztPcdbmUN655x9cZIwtppCLxXqEdc3p2DS59D0j0zT0p93q5jp6QK4l0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>, Hang Zhou <hang.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/25] drm/amdgpu: Enable/disable gfx PG feature
 in rlc safe mode
Thread-Topic: [PATCH AUTOSEL 4.14 17/25] drm/amdgpu: Enable/disable gfx PG
 feature in rlc safe mode
Thread-Index: AQHUUIxoHXdKEehrg0uupfdbaymUow==
Date:   Thu, 20 Sep 2018 02:48:27 +0000
Message-ID: <20180920024810.58594-17-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:zPVyNEypTHYGeuc0FCuGhEDqHA1GOZfz1oWkAMNn/TyrbIMEG0Bav0jVhSoeueu8wxYQBvsIJwvhz0/52OFGcoDic1kUeZZcmgIQ1BELGE79yoIXGEbwV/50cQPObVGfZGDF+6YqbbML7ZgilDDQEPhLY1mJV1Be7GXu7n/KvRYIXUXa/6YQO2ZfCDzsrQ3eLjhCxeutC0fhlOrayqjtvbgXWYcvi28z5G5J6vsiX1vUdGKsgzbKP6BVJC7yiu0FMG7DqnK/dc/a9gowjjXpRRGfkJpDHb4tCCLa4O+aL5D4kbJnWz7828kOI+mt6ESfXHaQWAByZY5iINkQuADYBV8bWrAPRY0eP2WS4je3FfOhli75zMogMn2qAG0MnIDom8w2xeOruv2UHqOjcz8SrvA1+gFrTCn4THT23JXssKpbC9z55L/7u0cBSe0nzmevSI4AwZkJgJIHFYUf14BQjw==;5:flKDZapCvuaeZvF1vup8rlOD2HI5HjKCXWab6rCv6KbVvvn3emawQgrykjtdzxCUSMlqZwiCkd1IuLSY/PunFGO6FP0TCcnIfLDqxP66TxF5qDaDZ906JddouSOZlSfRGFr/Yx0HlvFyeTNMrmn3jyv1t4+RifDBxUFK7cxEYWI=;7:uyOUiit/oYhwGQsxaj38RcJL7ZVBRytVM8yM+W13IpiNqrslNhy6LN4QkzVYvkiAk7VMSoyEBBvI8fT0vnOQKrcjTF46xiLbJcszWd+A+9T9U76s9q+DDMSvHLfWopL5bKco6utnGCB4qpbUxVIuHbTUGpeOn/SgIyWkIEwm+g7WCFiniMhKvqSU92W0H954My1P34bwQKnAzQTm91vPOV4wBx9hUfnzgu7ZkRm7tb1ce0C5eNhe65ttZb6us+l8
x-ms-office365-filtering-correlation-id: 51c493a2-e08e-40d5-0f54-08d61ea3a7d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07440B12F049C8CA9F6A830BFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H8mmgYFPfimBRd/flmWuvI0MC9EqvOD8nlUQ1kPgPzB4sItYV9+q02aaK45wO3GbRff5k6G8LB+hRuLxX8Q6ygpALyGhU4JCj6shZIZ0g6j2P21PeQjah9zSyUfLT3ad052dhA3ryBNH+5WhhV5KCvR9CHf26twtcc2CYj2BpQQGpF0IJLeVV+FUJXTlMnDqnytushJG0N6AfKvn0yQgwvjajcgU/DF2WTJwk/vF6TQXSCapQLGdIz1nyS7GzWo+vhrFsuAVzP8pYtqYQnxGUXjGolFm1zwPjsRCwl/yGBcWyTgx9J1cq0Dbk2OOXPPO4twexhrxWbBJeiEgBuWQQOKxcN8yoYo9OZV53G8QqE4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c493a2-e08e-40d5-0f54-08d61ea3a7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:27.4758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index a7e54820a330..85bcd236890e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5479,6 +5479,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
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
@@ -5527,7 +5532,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
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
