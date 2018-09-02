Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EECCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AC4204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o3qH2TbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AC4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeIBRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:25 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728562AbeIBRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi+aqfssaAXPcRRr3ne9rL7fR5HsovRQaMDGOyw2tmY=;
 b=o3qH2TbK+4b44+9j8EV3Lw5IyP4AqLhW6Qp1Fo8zGTdPgx+unTh5F+WuwlRbWpxdnialh6frTvCcNMZwhyYd8bAZu4j84cQ9RYEn5+0rMlcri3yTlUD18WBKseSo/KE+8UJgiTI88n1D2R7f4S3ndDQSRHHzM18C/DmusNuI8Y8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "anthony.koo@amd.com" <anthony.koo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 101/131] drm/amd/display: Prevent PSR from being
 enabled if initialization fails
Thread-Topic: [PATCH AUTOSEL 4.18 101/131] drm/amd/display: Prevent PSR from
 being enabled if initialization fails
Thread-Index: AQHUQr2UxlrMj1nI4EGaB460FzUvtw==
Date:   Sun, 2 Sep 2018 13:05:10 +0000
Message-ID: <20180902064601.183036-101-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:9mtb1sOt050+z3n7Z+FmPUruhtuCSF40J2oBjQCSTAWzOvhSaqo1oaGz92h/FBKA0g8zWFi/81spf/6geqvsSK7+u6Y9i9m/QTpjvv+1Li8xJG+JRQm196ip3m9P2gkxtdylDPw2KOCE7N+cD/76PjLVQxOK3YLGhEq8H2MpUuls/px2NvWu6yYOhKFgn1ZdfNQ/HTif7GsbPvEdzINYLQjDo8S2CFZKKkOrMS3N+vWVKFafDy284w7N4X+xlFBpBzbINfmireFzMUwBTCPWiFUXCNDjhyW0RoZaEb3A91XMCaKjfzC8fWuGcW3Zp+Z5I0+YDzdDvsiVVureGrJ3w9TPemUfIpvPKyr4Crzh7jUnnfeSKCHtMmor3Yn6f9Gncb2d78fwWOW+GKZw7KGc5Vb3B2ZNOFWorM0JiuyxMAPeHmYAazoQL5l0OLkITW+/gbRdv9vGFNuKANjMW2aEwA==;5:3EfVStbauT7WE1vU+no+Z5taCQxOAyqw44V8nrq1JFVZ9Wt1dBTOPFs6CtVUqcgSpKc2OmEbD+E17RwHZYvNl7sy64R0EHLD9v26P0t4YPSUHkYNso5y6Jh+YV6hb6jWAzEQUuagWyNc5DQtRVfuADmVvjKqb59dtJSp23LY05g=;7:tlx87joPkMZhAXdyTuIpq4gNQvg1a3Jl4dL2+RWPqv9kwCMdNyM4THEJvdOQqGrvVLCm/n2sHQRPFt3J5Oi4Q/uWUhWTKAdOWEVwQz6CGgOA6eK1JYL0Zoif1srEWoTA5w7IqV3ldqgMbm/wu4SB+bI534nHr0h2xTgWdG3dCM3bhiFdCNwnYNUaeJG9EL34s0tNgHEWiywWDEbvvAcadKcvu+a8sEfd2M/jMUdCQMIkTQt4B5W8/PNQ4wFZ9XQG
x-ms-office365-filtering-correlation-id: 462dcc30-9de1-4119-dd51-08d610d4c58a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB01848D8FB37442556880E2C3FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Whe+mmvWFZyQJXPj/tVYrauGrblbhB5TmgwFTHxTgMLiZCRLE2e47H1FqypuctWgcShM1ZgXI45jjFHMyX+ID9MySkG5+MvW7sxC48Aai6aDweQHHrjoNU+Y4HI7ZGjKa1nyfiBO2UgZS90rAeBPRlSVy8cASWuXC+9wN71n4Br2R5ym+hqO11SWWg87cKXmyLlVasi7hDFPYAoZvZqkbxz0zV/IHMp0NVUItt90FFARyVL+uatrN15UJ7VuFrf/E/2DnBfjFyQhomVU07yTt7ijAp9YegjB/4xu6GzNmI044TI8xe2dqQQ1eRZUemVhGIQgpqHB0jv/5PIzugqqXQAdVA3qqPg09k8cAedUQ6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462dcc30-9de1-4119-dd51-08d610d4c58a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:10.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit 9907704174e0ad4ed02766fac4049971e583323d ]

[Why]
PSR_SET command is sent to the microcontroller in order to initialize
parameters needed for PSR feature, such as telling the microcontroller
which pipe is driving the PSR supported panel. When this command is
skipped or fails, the microcontroller may program the wrong thing if
driver tries to enable PSR.

[How]
If PSR_SET fails, do not set psr_enable flag to indicate the feature is
not yet initialized.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 38 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  2 +-
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/dr=
m/amd/display/dc/dce/dce_dmcu.c
index a576b8bbb3cd..dea40b322191 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -150,7 +150,7 @@ static void dce_dmcu_set_psr_enable(struct dmcu *dmcu, =
bool enable, bool wait)
 	}
 }
=20
-static void dce_dmcu_setup_psr(struct dmcu *dmcu,
+static bool dce_dmcu_setup_psr(struct dmcu *dmcu,
 		struct dc_link *link,
 		struct psr_context *psr_context)
 {
@@ -261,6 +261,8 @@ static void dce_dmcu_setup_psr(struct dmcu *dmcu,
=20
 	/* notifyDMCUMsg */
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
+
+	return true;
 }
=20
 static bool dce_is_dmcu_initialized(struct dmcu *dmcu)
@@ -545,24 +547,25 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dm=
cu, bool enable, bool wait)
 	 *  least a few frames. Should never hit the max retry assert below.
 	 */
 	if (wait =3D=3D true) {
-	for (retryCount =3D 0; retryCount <=3D 1000; retryCount++) {
-		dcn10_get_dmcu_psr_state(dmcu, &psr_state);
-		if (enable) {
-			if (psr_state !=3D 0)
-				break;
-		} else {
-			if (psr_state =3D=3D 0)
-				break;
+		for (retryCount =3D 0; retryCount <=3D 1000; retryCount++) {
+			dcn10_get_dmcu_psr_state(dmcu, &psr_state);
+			if (enable) {
+				if (psr_state !=3D 0)
+					break;
+			} else {
+				if (psr_state =3D=3D 0)
+					break;
+			}
+			udelay(500);
 		}
-		udelay(500);
-	}
=20
-	/* assert if max retry hit */
-	ASSERT(retryCount <=3D 1000);
+		/* assert if max retry hit */
+		if (retryCount >=3D 1000)
+			ASSERT(0);
 	}
 }
=20
-static void dcn10_dmcu_setup_psr(struct dmcu *dmcu,
+static bool dcn10_dmcu_setup_psr(struct dmcu *dmcu,
 		struct dc_link *link,
 		struct psr_context *psr_context)
 {
@@ -577,7 +580,7 @@ static void dcn10_dmcu_setup_psr(struct dmcu *dmcu,
=20
 	/* If microcontroller is not running, do nothing */
 	if (dmcu->dmcu_state !=3D DMCU_RUNNING)
-		return;
+		return false;
=20
 	link->link_enc->funcs->psr_program_dp_dphy_fast_training(link->link_enc,
 			psr_context->psrExitLinkTrainingRequired);
@@ -677,6 +680,11 @@ static void dcn10_dmcu_setup_psr(struct dmcu *dmcu,
=20
 	/* notifyDMCUMsg */
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
+
+	/* waitDMCUReadyForCmd */
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
+
+	return true;
 }
=20
 static void dcn10_psr_wait_loop(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h b/drivers/gpu/drm=
/amd/display/dc/inc/hw/dmcu.h
index de60f940030d..4550747fb61c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -48,7 +48,7 @@ struct dmcu_funcs {
 			const char *src,
 			unsigned int bytes);
 	void (*set_psr_enable)(struct dmcu *dmcu, bool enable, bool wait);
-	void (*setup_psr)(struct dmcu *dmcu,
+	bool (*setup_psr)(struct dmcu *dmcu,
 			struct dc_link *link,
 			struct psr_context *psr_context);
 	void (*get_psr_state)(struct dmcu *dmcu, uint32_t *psr_state);
--=20
2.17.1
