Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B9CECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8361B214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i3BbQB2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8361B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeIQIZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:56 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728680AbeIQIZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+0ZvIuba6PzIJuCQ/TSZPhm5tBwW5NZk+j1u3hLZVE=;
 b=i3BbQB2b1gHHtL/WnTS2Y1kCsWw2cXxpul/KI+p0iCHAGHFcq/frgtNvI366y6/XCrihgeMRIAyWyJ32R2cUe5uaRcl1QZXupAxjI33APdceU8X1UP4d8TeQn2AaC6XorPOCX+E/3xpIIvev5is1JycmtqOD/Mk6y2k70EigYWE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 026/136] drm/amd/display: fix use of
 uninitialized memory
Thread-Topic: [PATCH AUTOSEL 4.18 026/136] drm/amd/display: fix use of
 uninitialized memory
Thread-Index: AQHUTjKWGPnMlE1UPUiX+vf2By8yDw==
Date:   Mon, 17 Sep 2018 03:00:27 +0000
Message-ID: <20180917030006.245495-26-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:PCIScea0fFPgM/GS2pv0dh6WWYGga6+2DpvP+29khm1PJU7PjumvBn8vZFIgpOAMsCxFihyi0fKKDjA+traSNR8mQnQxFbS0ORtVHC/V/yBPVWZ58RSy6zjHW01dzg2LyIzxlUX8wQhQ3fGQGNTxyp0WzcwQ4Q4vpbi+NlQYvIYo3MG1HANbeeTVSnG8T1LEHf23hbA15NAVAAkQYOVfl+FrPw/l+wJ5u7mLg6I2LzHNLBIaX5dSowCzwJ/5PA8NUG64vVWLxlAx5i/u1t3SxlTwyVH/clMjiQLrbduvoHfCnDwOCBCqSl+bgoBRWGwXqBrptZNTWSe305jRRZHfM2ULdjTxMqv1WD/3Msg2b0GC/JlVKEpkN1zmolUXTqnJlVORVqJNRpW+B5Pjb1nU7CdnSfcRBo1SdA8PRd5BuDWYEOeNoKHueF7u1WZ2SKaIL5/xAa0VZZBP5F4Tb7qE7A==;5:fidQLZ7tFvjF7CzlHYSbtz9DSb+siiBjMmMVhGwVFRPXjKVxEYzYEuAVF4wWzjjrGh01FnZLPcH7d2xdd52erj5gU5yuZ9byNXbglbN8aS/MzaW1II1pRi+9Vk9K1KS9HXI4a80A89IDwbJMqpmww5dwJ5esZMyUWe6fVAdRB7o=;7:Oald7rypl5E9q28/nnizWF5vocv8njbtJsicDxc3wlIErDROsPjzT88xsbXibxGl5SmHIz/JGFoffw4ofsEjBOf/sxEjxt6WVHh6OfUvcFF36Xv00eKDT680m+WpAIU10vFiXjdCK6Vcfym/iSyrRf3VUobZIuQGOqP2Vh6tyez8375K5UVKZlVsiAkV3lT6Qnf65mB9FlU9Vo+HtpsZ3S/AQjkcxHOEF32SOyqPVJX1FbJLx2m2usxYEbFRZBOG
x-ms-office365-filtering-correlation-id: 6e7d5c5f-807f-4886-a5d8-08d61c49b8f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277C267E84D93EDA38765DCFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lMxYKMFQHQzSqMZT8BXTlfX3+nyEzXHXEj2GECrcV8XS1O3AloXXWn7IisNgDa6JHkVDktKmJruJc8Y/wBrUzHLp2P4VzVqBUOMTGRb4ahObcoPyT4EGXhxOCGsz62GHThgtqA4cSWHtCa9KeR3IgZRT8Y+4jZgevSBQQFqd5uiveHX20fDHxNQZ+gpaSqpi9ZZEju8b2/uE2bBFWDMkx84ZnFgYZ4+aiRswNR6VTBmV4hbfrKmKnYcTUFX0v/m3dcmiRAA20NfJQpO5nm0TfMmDB6QKBQi+QaVM6jv9AqtWCt4mE7M+vZEI2lu2IwEHPGcsTkL121V2/Wvd6V+/IhSpm1CnDlE2aOdzRb5c93w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7d5c5f-807f-4886-a5d8-08d61c49b8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:27.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[ Upstream commit f3e077d95ca0a016fdf3d6b1e97a9910dfdaff17 ]

DML does not calculate chroma values for RQ when surface is not YUV, but DC
will unconditionally use the uninitialized values for HW programming.
This does not cause visual corruption since HW will ignore garbage chroma
values when surface is not YUV, but causes presubmission tests to fail
golden value comparison.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c =
b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index c2037daa8e66..0efbf411667a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -239,6 +239,8 @@ void dml1_extract_rq_regs(
 	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.r=
q_l);
 	if (rq_param.yuv420)
 		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.=
rq_c);
+	else
+		memset(&(rq_regs->rq_regs_c), 0, sizeof(rq_regs->rq_regs_c));
=20
 	rq_regs->rq_regs_l.swath_height =3D dml_log2(rq_param.dlg.rq_l.swath_heig=
ht);
 	rq_regs->rq_regs_c.swath_height =3D dml_log2(rq_param.dlg.rq_c.swath_heig=
ht);
--=20
2.17.1
