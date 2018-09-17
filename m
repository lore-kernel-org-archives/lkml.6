Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B193ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9EF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ke3HtjKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9EF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeIQI0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:07 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:33973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728678AbeIQI0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loZquG6u7rCZGPeHtd0bEdVQdMr3Xz6pcIOy/Y/DM18=;
 b=Ke3HtjKHGQidSSfG7trA+HKhhLX7LWc3fdRgaz/eK1ijIn0nv2T/jo37J1AhDaMdaaNVTrhZhkJ7JlGlpea/p79EwEOLzYuzGAsC62xz6ivFuaJ4wrruPMHCyMi0KKtnUrcjD9NGxEdEOLhzn4K8dCwmLPinzvI3AqtW3b8TS0M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 025/136] drm/amd/display/dc/dce: Fix multiple
 potential integer overflows
Thread-Topic: [PATCH AUTOSEL 4.18 025/136] drm/amd/display/dc/dce: Fix
 multiple potential integer overflows
Thread-Index: AQHUTjKVBDd+hT/xjU6TX5XeF2YetA==
Date:   Mon, 17 Sep 2018 03:00:26 +0000
Message-ID: <20180917030006.245495-25-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:b9vcNj6k3JG8ElDFplseT34QOI5EqdbzgtF2q5eYd0QPaDrTZPzq3U676IiIaratauctCyhmYaZ7Ncew7dxold0lQFjzGQ5GTnhXzjLperb6w/Hp7ptIKSp2TqIVyJXneOgqsbjqvJb1a5qjUAyRgtu+N5lb8xSVZOts3KzoPIYwd+yBhb2bWWuFvgfU4z4gb19OOeoJ00wC1r08dDVGpN1u94dEiqQcYU6RRq0y6X3Cf6H/AxFK/HZ5B7zsb90ShSSAPxH2z1Vpm93FonH0itR5nhadA1K0iMdJ7q6qSUrWLQIwTeI5RVPoYVc6MkHpN2z9yBicPKg4LbMzltUFkpHpbQeo7/xURQCpb/MslPM1eGy9IRHTmAnUdPlimxYEcpI5RUNoFKje2SzmQqrFDogTndmXAY5RYKxkXNLh5Lg0YneLwsXFHZXlMRfsJs/fkJtxXcZnIatbO6dV67GsTA==;5:ypzehto64c0cqnCFxRGIhq7dVPenlztd1lk3saNs/g7PzR9R55xODNwy2EK6aJs62o0Sbd47U4X2uMCHj/qbF9hHkOLzl26pIdJ0YgvE05u9ueUZ6P3vmGq5NqkHqrDwHH68JrTm5J0pFYMvYVDomSSLUGGg4+Rv2U1R+yxf7d0=;7:qQx/zS8Tr2T6czR372gtPkBjCon3SJ0KfaQtTesfxn+1OIeCa+m2+zdIJAzeIbxdcOnjd7SMClLYDxuQt6As9DDWDLrN98bcoHKPCH7GTbyoDVoTvdtYRaaR8H1TEhD9p6hVvp1O7GoK1bZnOQGlF8t91LmlN2KN9nrJqpfoyc+Y1wy65UUfEnKxX7ICj1fO4Gr520L9yzRy8AGyhdZ/4HcFpTQ05d2xbGMDJCKDuGUA7Ofia7RnnEN0ZasPqrV5
x-ms-office365-filtering-correlation-id: 82aa3a53-c442-4448-3249-08d61c49b8c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277D086E87D3E6EADA5CA75FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ymTcqXPNR+uZEvTeCkulKsvD5lL+ba12DtFlUYVmnIumyQkTzynFBwjtegITyCgjb0Gr7mXKUsQRklvx1hmG1aymGHCsrNym3fAfgY8vljmRryIAKEHiX2aLPZTFG7xcWSyIStXSN6lDFahmYrhou76/rs0VBnwWJ6OmlFDi7slDpwE5Arrrb2tTcXn12tDl14wgy3cFgxmZjEw7khNANuNiUVdfmtz0V0A82KnnyETWWcyOX0+QesFocD+T01gYqbdUmSIUhdr82pbOfeBhui03KF8QQYWS++mRqIHmF91lFXKG4UWgj6u3GOI0UmEhnGCBy/TrEi+bqM/w/NWTz5IZClx05NHd7UGKddeIPag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aa3a53-c442-4448-3249-08d61c49b8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:26.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 6f3472a993e7cb63cde5d818dcabc8e42fc03744 ]

Add suffix ULL to constant 5 and cast variables target_pix_clk_khz and
feedback_divider to uint64_t in order to avoid multiple potential integer
overflows and give the compiler complete information about the proper
arithmetic to use.

Notice that such constant and variables are used in contexts that
expect expressions of type uint64_t (64 bits, unsigned). The current
casts to uint64_t effectively apply to each expression as a whole,
but they do not prevent them from being evaluated using 32-bit
arithmetic instead of 64-bit arithmetic.

Also, once the expressions are properly evaluated using 64-bit
arithmentic, there is no need for the parentheses that enclose
them.

Addresses-Coverity-ID: 1460245 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460286 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460401 ("Unintentional integer overflow")
Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 88b09dd758ba..ca137757a69e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -133,7 +133,7 @@ static bool calculate_fb_and_fractional_fb_divider(
 	uint64_t feedback_divider;
=20
 	feedback_divider =3D
-		(uint64_t)(target_pix_clk_khz * ref_divider * post_divider);
+		(uint64_t)target_pix_clk_khz * ref_divider * post_divider;
 	feedback_divider *=3D 10;
 	/* additional factor, since we divide by 10 afterwards */
 	feedback_divider *=3D (uint64_t)(calc_pll_cs->fract_fb_divider_factor);
@@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
  * of fractional feedback decimal point and the fractional FB Divider prec=
ision
  * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))=
*/
=20
-	feedback_divider +=3D (uint64_t)
-			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
+	feedback_divider +=3D 5ULL *
+			    calc_pll_cs->fract_fb_divider_precision_factor;
 	feedback_divider =3D
 		div_u64(feedback_divider,
 			calc_pll_cs->fract_fb_divider_precision_factor * 10);
@@ -203,8 +203,8 @@ static bool calc_fb_divider_checking_tolerance(
 			&fract_feedback_divider);
=20
 	/*Actual calculated value*/
-	actual_calc_clk_khz =3D (uint64_t)(feedback_divider *
-					calc_pll_cs->fract_fb_divider_factor) +
+	actual_calc_clk_khz =3D (uint64_t)feedback_divider *
+					calc_pll_cs->fract_fb_divider_factor +
 							fract_feedback_divider;
 	actual_calc_clk_khz *=3D calc_pll_cs->ref_freq_khz;
 	actual_calc_clk_khz =3D
--=20
2.17.1
