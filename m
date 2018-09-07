Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15925C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ITXBkAIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4F52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeIGFUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:16 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731117AbeIGFUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXT3XZV6AUnsB18enhcviLDF/LwY6/A2H4hMZPHyoPM=;
 b=ITXBkAIBqiUeCHmFQOGwdPgJ0d06tqFg/Q4pfp58QNML+3jqczGP0x387X1OcA4nFD1zbqmVtq0dXDRRNADKFEwi2Rh/NK4z66XzRDWcO2/01yfPElJvFUXDXA5e8+69zlDY4P4UPU3aTSBca5U/48RqnRwCVFEc57yuiNUliAE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fredrik Noring <noring@nocrew.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 19/30] fbdev: Distinguish between interlaced and
 progressive modes
Thread-Topic: [PATCH AUTOSEL 4.4 19/30] fbdev: Distinguish between interlaced
 and progressive modes
Thread-Index: AQHURkMxiHbiO/xs0UCppIaP5ISEFQ==
Date:   Fri, 7 Sep 2018 00:39:11 +0000
Message-ID: <20180907003853.57942-19-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:Xpp7kxbYLH+fYtEN20HOnQkmP8rsL4erydzOOJxWNhqG9iijKskWV7r4hCDdBbQA+6WXOvbLSMXvKbST5fhp1eSi1g1QB4rf3xcq/A3Uj19E1yiiSGZjkX5WHMA0IxOT0hPMasSGh0Q2sknnFPGrIY5dCrFblvCmhPL9htzoXEfoe3Qc6ZjUqQHM2Lw+gijPmsciGtd9yc9e5vnxDq1dRzUPoojXDtVXUCLbiDMNCKV2NCGIclLXlhvNRswvd3EaiFVvZRtVJrv5fR2bPaNsASrOtTi9UNXFQtQL1DzP9MsYecYzOh/a/qzXA1ASakIxJ+uTu4apQmqyhDYAx6QYh0go3cZ8kBGYstYqDhoB9hVqaoABSq0wmMEcbJ1O4tdQDsH2ptSYdDxlZ9SAr9xdoAYUC+Yxai4gvClesL5r3S/UDuI2EIPYVJCbeVjOgXPhH0yT/LeknsMh+uOD7TWhxw==;5:OFroBUUwLDVwHcrvi028qPW7IWwasDhf5LKqNWxA+mdzcXpYVoPxDcwT/X38onA1YrMHG33z5yqUdVnTDlaN1M641uPQiOwkefM4OTMNxbNdmH2tnou/iWaiiHfCW2i/X177DR9R+bfqAVCTaVPTBB7siCLKUhV60jEVXipMMjI=;7:Pi6qQGf839czTrkOXOvWqkS1Ioc0JTfREuQhN209Eaz7pFGJzoVBaKK0Bb5uAPRiWgOqunLbbIqv3pqh5x2hcfM6LpC87z5AvxYgOx/gUKLI1pv+5jDBF4f56+tyNfRk2cyAxP/oUvOJVR8g60kSf6hWclG64POtkG6nCEuDojoSm8IB+bS1A/BOpcHGPqgILI33LClA58VijpajfK/eu1XGKEJAS4Vdd+qfK4+3IN9Q1s4Xp2oDg4nuJYpac/2q
x-ms-office365-filtering-correlation-id: ed8aff41-adf6-43a2-90ec-08d6145aba96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822B321584B8552BA60DACBFB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K8lyL7a7aAYlA2qexxcJmlImVFfgks3eA0wiXcSHV3MDwBItEUJ3eTt7ap08SI+3CtGOF5pXinHCf+cWhju5fOjKIjHkwup6JEder7De6e37w+M5eI+3bAjWE5xVtNIyLS+Ss0FWX8gP3Q3/cAVXBCDg+A0aX1ViSE+q2ZTlCXqPFI5F5gb8hJOXjr2y8B4b4hJPYanZccHTl0cmZ20T4bHzXSvi++YceQQ4GcC/wN71LS0scKg43IOyZbjVc1wlfjHOWFyfa8HjBDDXEK/hjf6Sq0AMmVWhO/q5rPF6I7x/1d1axN8uLWTbjYQqDFdpCZclf4U/EZFe07ZhnOWxGYivJ4CW38Pz21SFChw7/FQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8aff41-adf6-43a2-90ec-08d6145aba96
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:11.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fredrik Noring <noring@nocrew.org>

[ Upstream commit 1ba0a59cea41ea05fda92daaf2a2958a2246b9cf ]

I discovered the problem when developing a frame buffer driver for the
PlayStation 2 (not yet merged), using the following video modes for the
PlayStation 3 in drivers/video/fbdev/ps3fb.c:

    }, {
        /* 1080if */
        "1080if", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
        FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
    }, {
        /* 1080pf */
        "1080pf", 50, 1920, 1080, 6734, 148, 484, 36, 4, 88, 5,
        FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
    },

In ps3fb_probe, the mode_option module parameter is used with fb_find_mode
but it can only select the interlaced variant of 1920x1080 since the loop
matching the modes does not take the difference between interlaced and
progressive modes into account.

In short, without the patch, progressive 1920x1080 cannot be chosen as a
mode_option parameter since fb_find_mode (falsely) thinks interlace is a
perfect match.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
[b.zolnierkie: updated patch description]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/core/modedb.c | 41 ++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/m=
odedb.c
index 2510fa728d77..de119f11b78f 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -644,7 +644,7 @@ static int fb_try_mode(struct fb_var_screeninfo *var, s=
truct fb_info *info,
  *
  *     Valid mode specifiers for @mode_option:
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
+ *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][p][m] or
  *     <name>[-<bpp>][@<refresh>]
  *
  *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
@@ -653,10 +653,10 @@ static int fb_try_mode(struct fb_var_screeninfo *var,=
 struct fb_info *info,
  *      If 'M' is present after yres (and before refresh/bpp if present),
  *      the function will compute the timings using VESA(tm) Coordinated
  *      Video Timings (CVT).  If 'R' is present after 'M', will compute wi=
th
- *      reduced blanking (for flatpanels).  If 'i' is present, compute
- *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
- *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
- *      'i' and 'm' must be after 'M' and 'R'. Example:
+ *      reduced blanking (for flatpanels).  If 'i' or 'p' are present, com=
pute
+ *      interlaced or progressive mode.  If 'm' is present, add margins eq=
ual
+ *      to 1.8% of xres rounded down to 8 pixels, and 1.8% of yres. The ch=
ars
+ *      'i', 'p' and 'm' must be after 'M' and 'R'. Example:
  *
  *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
  *
@@ -697,7 +697,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		unsigned int namelen =3D strlen(name);
 		int res_specified =3D 0, bpp_specified =3D 0, refresh_specified =3D 0;
 		unsigned int xres =3D 0, yres =3D 0, bpp =3D default_bpp, refresh =3D 0;
-		int yres_specified =3D 0, cvt =3D 0, rb =3D 0, interlace =3D 0;
+		int yres_specified =3D 0, cvt =3D 0, rb =3D 0;
+		int interlace_specified =3D 0, interlace =3D 0;
 		int margins =3D 0;
 		u32 best, diff, tdiff;
=20
@@ -748,9 +749,17 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!cvt)
 					margins =3D 1;
 				break;
+			case 'p':
+				if (!cvt) {
+					interlace =3D 0;
+					interlace_specified =3D 1;
+				}
+				break;
 			case 'i':
-				if (!cvt)
+				if (!cvt) {
 					interlace =3D 1;
+					interlace_specified =3D 1;
+				}
 				break;
 			default:
 				goto done;
@@ -819,11 +828,21 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			if ((name_matches(db[i], name, namelen) ||
 			     (res_specified && res_matches(db[i], xres, yres))) &&
 			    !fb_try_mode(var, info, &db[i], bpp)) {
-				if (refresh_specified && db[i].refresh =3D=3D refresh)
-					return 1;
+				const int db_interlace =3D (db[i].vmode &
+					FB_VMODE_INTERLACED ? 1 : 0);
+				int score =3D abs(db[i].refresh - refresh);
+
+				if (interlace_specified)
+					score +=3D abs(db_interlace - interlace);
+
+				if (!interlace_specified ||
+				    db_interlace =3D=3D interlace)
+					if (refresh_specified &&
+					    db[i].refresh =3D=3D refresh)
+						return 1;
=20
-				if (abs(db[i].refresh - refresh) < diff) {
-					diff =3D abs(db[i].refresh - refresh);
+				if (score < diff) {
+					diff =3D score;
 					best =3D i;
 				}
 			}
--=20
2.17.1
