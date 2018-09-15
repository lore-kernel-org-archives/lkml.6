Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F0BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BAE20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S62ZdZr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BAE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeIOHC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:02:58 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728347AbeIOGsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmkxO7SrMtzykzK+lGAH6syixSClMhDIZM7ElpmZfO4=;
 b=S62ZdZr3t48KWVTH+I8WIYu3yj+NRTbkQW4qrwQwIr3iHkGDDJHDhQVmveaazErBmay7i+rg33ExD5lw+LiFJHYzTKu6fz74rFuvvRDUL+fKsg2/zRG4x49ZhJm5pI6yr3DRiRTclu8Vm11nFrYW8wk37KJ7L+y0gHprfDNlHKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 79/92] drm/amd/pp: Send khz clock values to DC
 for smu7/8
Thread-Topic: [PATCH AUTOSEL 4.18 79/92] drm/amd/pp: Send khz clock values to
 DC for smu7/8
Thread-Index: AQHUTJO5mx5HuZJru0SNhOZvzO7iuA==
Date:   Sat, 15 Sep 2018 01:30:46 +0000
Message-ID: <20180915012944.179481-78-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:jFgl3JIMKAqlNYVe5XDSg0XUpkRoY0e8M0ugWpm7spuUg1uSgRvxo3Ac/LHn9LP8OKvaSOWPxILhabFqLObUaLDU2CYHrW4jfrXEfs/7qGbmzDvXx1xvUyNv3HPXNzLzMK75FNFI1URxVSM5eoyDO7ZJdvAbOF13SL68flz1gKL86MF+F2mksUEw4rvQjVO2rb4GfPJQb6VMW7PkX0lc5pwlFkFU/nQ3gq3tAqfgOL//rhx6Agdx5/5aLZVvDtzakOr3sM3gbVcnqreIgsBslpjwrVGy507vKH2PpU2dknfo5OI5cSZzsaDUvRNuc8P2rIgrut/EofIGLGDKJgO158iSqIR2qSrrlfssyqCVUupzWDM4d4oUft1zw3KBsiK1FrYUH6eG8gkkVgKhuYxq1ThOfkV4WuTqnmBA/fpDL1H+tEqzzP7Nz78TOJyEIccKqQgUgrA2bR9Cr4n12ku9ag==;5:ssffKFiwvf8u/TavqRu/NqFJHSl0+uDxKt8Y0OOVrwhIEtNWA4d2l0NQ3TVlcv5PKBPR1zMNXdICRV3Y/9Rn71xPJVKx82Z5EYXkzzo+SrkpHxAgDr1EcVTzC7RH9L0t9y+v4OIclSoXzHjfXmwUjEvvxvOX29bqPCLe7+oXP8k=;7:gedesfZ5Iwj+f//piHHaS0KhxgO+0Z0uakwok2NpiHK40H28WER4FbDQoBjeM9gj6fN3LFqDIkYyZ0Wswjbt2/Tn8ioXorUzoKnLPZnGB3Z75A2uejkFKIVnvy3o6gOL2ZB3RQo4b8+PbAoqQV+Aw6DhXQ/hrwtq0EGZPjkIO/c5dg7JFhBiwhLVAYFrrK3O342dmckR7JDMujHPqvfdRXW5ysHIbm4v7zvSCWmJpgFiopzW/2T9dQGJyH9pgSro
x-ms-office365-filtering-correlation-id: 279aa470-364f-428d-6f08-08d61aaafb44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047081CF02B68A61E008EE5BFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Hg4grVl/D5rENajkGYtaitPI3Tt+pAIJb+lKvzvuwaD2RvehVOUqbuGrwGfG1tN0SMOt5APOKRl7u4F3KJcgK3RXGv++j+9gu1ABzFDfZ/Tz3R2Zz39QDjeqWWFe+xpu7qABtKfkYUTKEPM1gFGQZEf5LFrXlTiCQFkAzEfGY9JTaHfHwp4HNGEC+f0rJ2ayWEl3owIsszQRmnFK/mBrERMxQPiGFgLWM/gMdAWut8o5L84a8kKD+yGbZyqcv2C3QlMM8/y0j7N2t3oqScUwUDWh/iSddqm4wRb5ppPKqjZoZ5vtHvAP3QinjFdNq04zJ8AvaMEYoWH5vbKK1JHvPX7RyVfu+kbXkGeD3Kl/J3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279aa470-364f-428d-6f08-08d61aaafb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:46.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit c3cb424a086921f6bb0449b10d998352a756d6d5 ]

The previous change wasn't covering smu 7 and 8 and therefore DC was
seeing wrong clock values.

This fixes an issue where the pipes seem to hang with a 4k DP and 1080p
HDMI display.

Fixes: c3df50abc84b ("drm/amd/pp: Convert clock unit to KHz as defined")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc:rex.zhu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 8 ++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index f8e866ceda02..77779adeef28 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4555,12 +4555,12 @@ static int smu7_get_sclks(struct pp_hwmgr *hwmgr, s=
truct amd_pp_clocks *clocks)
 			return -EINVAL;
 		dep_sclk_table =3D table_info->vdd_dep_on_sclk;
 		for (i =3D 0; i < dep_sclk_table->count; i++)
-			clocks->clock[i] =3D dep_sclk_table->entries[i].clk;
+			clocks->clock[i] =3D dep_sclk_table->entries[i].clk * 10;
 		clocks->count =3D dep_sclk_table->count;
 	} else if (hwmgr->pp_table_version =3D=3D PP_TABLE_V0) {
 		sclk_table =3D hwmgr->dyn_state.vddc_dependency_on_sclk;
 		for (i =3D 0; i < sclk_table->count; i++)
-			clocks->clock[i] =3D sclk_table->entries[i].clk;
+			clocks->clock[i] =3D sclk_table->entries[i].clk * 10;
 		clocks->count =3D sclk_table->count;
 	}
=20
@@ -4592,7 +4592,7 @@ static int smu7_get_mclks(struct pp_hwmgr *hwmgr, str=
uct amd_pp_clocks *clocks)
 			return -EINVAL;
 		dep_mclk_table =3D table_info->vdd_dep_on_mclk;
 		for (i =3D 0; i < dep_mclk_table->count; i++) {
-			clocks->clock[i] =3D dep_mclk_table->entries[i].clk;
+			clocks->clock[i] =3D dep_mclk_table->entries[i].clk * 10;
 			clocks->latency[i] =3D smu7_get_mem_latency(hwmgr,
 						dep_mclk_table->entries[i].clk);
 		}
@@ -4600,7 +4600,7 @@ static int smu7_get_mclks(struct pp_hwmgr *hwmgr, str=
uct amd_pp_clocks *clocks)
 	} else if (hwmgr->pp_table_version =3D=3D PP_TABLE_V0) {
 		mclk_table =3D hwmgr->dyn_state.vddc_dependency_on_mclk;
 		for (i =3D 0; i < mclk_table->count; i++)
-			clocks->clock[i] =3D mclk_table->entries[i].clk;
+			clocks->clock[i] =3D mclk_table->entries[i].clk * 10;
 		clocks->count =3D mclk_table->count;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
index 50690c72b2ea..288802f209dd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1604,17 +1604,17 @@ static int smu8_get_clock_by_type(struct pp_hwmgr *=
hwmgr, enum amd_pp_clock_type
 	switch (type) {
 	case amd_pp_disp_clock:
 		for (i =3D 0; i < clocks->count; i++)
-			clocks->clock[i] =3D data->sys_info.display_clock[i];
+			clocks->clock[i] =3D data->sys_info.display_clock[i] * 10;
 		break;
 	case amd_pp_sys_clock:
 		table =3D hwmgr->dyn_state.vddc_dependency_on_sclk;
 		for (i =3D 0; i < clocks->count; i++)
-			clocks->clock[i] =3D table->entries[i].clk;
+			clocks->clock[i] =3D table->entries[i].clk * 10;
 		break;
 	case amd_pp_mem_clock:
 		clocks->count =3D SMU8_NUM_NBPMEMORYCLOCK;
 		for (i =3D 0; i < clocks->count; i++)
-			clocks->clock[i] =3D data->sys_info.nbp_memory_clock[clocks->count - 1 =
- i];
+			clocks->clock[i] =3D data->sys_info.nbp_memory_clock[clocks->count - 1 =
- i] * 10;
 		break;
 	default:
 		return -1;
--=20
2.17.1
