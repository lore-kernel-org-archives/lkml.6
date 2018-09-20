Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB86821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cn7zJcZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB86821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeITIbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:00 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387736AbeITIa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67uS9o7G90Xj6Lko/cKTTJbp5GcVATLDU1JOkVM6kBg=;
 b=cn7zJcZ9hh43doxzV+epykyzJYqmqDG5HlalSNhRbxBHU7CPe17nxxQfIycrrAbujlMQdXZ3792Li+ftIA8c5QKeyjflkA7yoz7sKPnUV2XiJt4TFVqUr/yBOaCwFJEZKLWH0IXTMrEo6ep3qZw1Ko55331PgS4TixyIW6LCHBU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>, Hang Zhou <hang.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/14] drm/amdgpu: Enable/disable gfx PG feature
 in rlc safe mode
Thread-Topic: [PATCH AUTOSEL 4.9 10/14] drm/amdgpu: Enable/disable gfx PG
 feature in rlc safe mode
Thread-Index: AQHUUIx0T8aXHHFsLUiJrltv+dsaYA==
Date:   Thu, 20 Sep 2018 02:48:48 +0000
Message-ID: <20180920024838.58666-10-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:sO4heqk2+6aGDsd7eHqIGMrUu77vifEi01q25azzaJ5JQdAt21hKzSM5S+hcoss3bLiLnff6RRqQhQMM9R3veLJux0lxtKha6cYrgWtuGE3Sif+575eVkmewwnHibGjs2xkQjL+EoAvAneMRtYwyO3EqkNcxps82kZhHkQbNA3cT9VTP6cdLNBmvMmLb3bpv2XvpUoqz3HwwODSWI1MIL5JVmfBVErPmxZ6fhLST6bQzKjDKj/5Dps9tMV0OsdpdSqGV53DTNkAd9JGAPoKnIrIzR6V2nZtsNudqNJCsqGPXRDx4d/ThkjS4fHGphB+ojwBYz3AUg0CdflZmeXhLBR8uaOizzB2qlx+HY7wx2sJFJ1gGwqhDfg1Tj/Yb00KLBtTnYzF/8+3RoqbPUg3JEN6LwJbTUcYGibXVL0ABxYa30tyruR9iOPgCkN46vNYgIk0uVIGaux05/T7QA7TTzA==;5:sj2DRkEwWcNGpYqxKszHLRhM5yTuOrC1YYjEoPOP2eXZf/nMI1u04gi9DJ9uVbvBtXJZitJNfW73aWvjQZOnycP7jqUhlLF1F4OG8kONUNhjUoKkW9fi9sVsnlReNjNslmMnDO8j3HDJ+sXWSg1Nw8P++REmNwJRfeBcFnyRyO4=;7:G8vicsm1xOoR6xwXmk46fFBattvC+F7n2VemA/wnWbLPadFyBYZaP6G3b5xFGNVePt5RnA+x+zVUY/JwP6ZEmAoh+aViVwgvcAfYqLlKeMWPMRKKC9AtuxzZ29k9aroHVLZ41dD0BLmgOIkBWYGyUhq8sQKAH8YeXsLHpGwjj0txjifRjc3Ue46MNXnp3+Sv8SkOWGJkdM+Qb/VxKzfs9Fd6j61dmKZIpu5WTrH1tvmAImqKO+woR23CMjV3AolT
x-ms-office365-filtering-correlation-id: 2b3c3716-a92a-453d-3bb4-08d61ea3bee0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB046972F232A1D63302C96FA5FB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JgO+dZ+TozJbhH6JA8ON67np09p/6+LnHnjBr9VtvBurx+L5y0kDZmVJEKUJb9R8MoATcuMFLeDNHF62NTIB/8xbnGCa3sJfeuXDgwxS4IcyQdHLETI6UrGbXV+/4yOED1a666DFzwqfd69ckPFAMSlkv292l9SyTqQyYfSwnzX8G8jAt0G0bF6UR82SrwoNbRYwY0b9XRHv1Qt3hc7nrWReF7KceiKCtFQoK8znlepZiUVLiA4q4zizMTDlLZxs3QdxsgFvGxC0KcsBQqMbHiSz5iDdMHHwzTPEmiWrROiIsg7Hn6CpMeizjcVFYTDpV5como+wPVdjjnBbpQ9+BfWzXDk2Dh47x+MtVJV+Ez4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c3716-a92a-453d-3bb4-08d61ea3bee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:48.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 564362e8b486..c8a5cf5365a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5551,6 +5551,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
le,
 	if (!(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
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
@@ -5586,7 +5591,11 @@ static int gfx_v8_0_set_powergating_state(void *hand=
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
