Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ACDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="euIX1/bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBB82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeIGFUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:54 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:41191
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730477AbeIGFUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHYk5R/QWV3k8hTw+RQpqou3W0StCbbiVV3dn23GYMg=;
 b=euIX1/bkXe++tKpRulQ92Jos29rU1q+XjlVJwRgwbZ/6ltmoPvOGDEO4biWyoEabeSLmKH2io1KTjLxKEXQmdHAbLpUZW+vmssFL1e1/IgebX/f8m/BDruSVAU43eOs53uQM3vSA7cm8wXJcrV3T2JvzOXkJqftPIWcaW5iOXh0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fredrik Noring <noring@nocrew.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 13/19] fbdev: Distinguish between interlaced and
 progressive modes
Thread-Topic: [PATCH AUTOSEL 3.18 13/19] fbdev: Distinguish between interlaced
 and progressive modes
Thread-Index: AQHURkM/4VD+NJazREm6jOTM9pZ+cw==
Date:   Fri, 7 Sep 2018 00:39:35 +0000
Message-ID: <20180907003923.58019-13-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:PE40aQgi8GKWa1mykC86AdhTVs8BMFCc9WvO+FzlMbGgnNHkC+qhHQSZK5VboR42s1N6Mff5/cnpfaV1/SwGV+F3LjoUjKksPIZ+lh93MQLiYgWYw85gpYmYeJOYMFFaX6AOB2fJgBboUG+phJua1jXqU6H/6TulkwrBgrImnWhmKl9Hdgc7MmZ+qZfZYLvXDFk5Xd14L5/xj2UiAFn3pyLOeJydGgxVvcHg8x/PW+wmN9guD0h15gXhDV7dXlw/dswN/kKF3KkSKuAIHOwBbb+dCS4uuFdp7Hav5WDqfg7u8eRoGpbRZLNYFBBnyAqscg1wpYRuznctLafGR1iOSJ/QO7NFGGSaJ0uBZJDUzYAqe8f6mo9iW9OE+kVIrAX0QNUEsnqkVGACfc9wgsEVwadObh2Kvd3ddfMpiVVXolZzJRr6k05293rD7R+9mzQN1UhOIqCLDEoeWC25MA6euw==;5:ZNb4hshUa2Xmof4y1NzHgU3ku70qtP0jADfXj8OgIp/ONAFx22qDTV4/Ga5FGBga5adZC+/Q5mWX+rsObGyDx7/lVIAcLCiToIVFBGlQUzxDQNSw8M9biauqScmRPOMFlnZKUk32nehoc5uAf+NkD9L1d8Dt4MNzqA+WTGdLAwc=;7:Oq4JOBX93p58fXYtRKcQCMfyuamzTCtAQyMGivyLPP+lrEXMfgRD6anov9Rnh4msVma1vSdRm3gZdlozlMY3C5N/GEZflczkwIA45RV/S+WKMwoiOJg1c1rMi54mIVL0uFbRkEbH/rttjFht98m1oQwhXRq/Vh12kdfs2ucN3P7DM8hgmV+XAJqFEzy8Ir5Nbcj9tda8lG+05Q889ZJDiiCGNzunfcbLLPoFHNHlDKs5clHiLey07oRDwvFxikwy
x-ms-office365-filtering-correlation-id: 26e64450-2016-4f63-67d3-08d6145ad36d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824BB78F7F2ED4C7DD6D7FAFB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(6436002)(99286004)(36756003)(6512007)(53936002)(68736007)(66066001)(10090500001)(305945005)(2616005)(476003)(7736002)(6666003)(11346002)(97736004)(446003)(8676002)(6486002)(25786009)(2906002)(478600001)(486006)(6346003)(81166006)(81156014)(4326008)(72206003)(316002)(110136005)(54906003)(6506007)(102836004)(22452003)(14444005)(256004)(186003)(26005)(5660300001)(10290500003)(217873002)(5250100002)(2501003)(86362001)(76176011)(14454004)(3846002)(107886003)(8936002)(6116002)(575784001)(1076002)(2900100001)(106356001)(105586002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: j14TBVmdty4PabOKs5wEvIHXg3g6wsQB8P9ruHLXXDlVVfaR2NJ1h+ot3UgJhfy5oVUPO7noARCG96Q4aNkPRRrd2WaUYtFoOstmcVBmIqq7rFLAJwhHVh3+5+6XeEMbu+NCY4qF8hE0p3ZiLd+ARUGUzK7iWp5wsQ/fXe3m68ZUVMHDwxP0GdzuD4DFOaTBV0Lf3+iUckSpnscoe3YG1dNaawNsiL1Us4HTqMyIOmaBIXAYMsfpq1uOnjowzPuhL4l1thl71OwcMU3UKpaDDvdXjtmpTnXz085AAxL7yoH56wjigNvbatvAYL4FtjpfgKQ+T5sCZ4h/pvsfwiVWEKIgosjeiT6Z8RI/MhBZ4RE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e64450-2016-4f63-67d3-08d6145ad36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:35.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 388f7971494b..620d9ec664e1 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -533,7 +533,7 @@ static int fb_try_mode(struct fb_var_screeninfo *var, s=
truct fb_info *info,
  *
  *     Valid mode specifiers for @mode_option:
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
+ *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][p][m] or
  *     <name>[-<bpp>][@<refresh>]
  *
  *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
@@ -542,10 +542,10 @@ static int fb_try_mode(struct fb_var_screeninfo *var,=
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
@@ -586,7 +586,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		unsigned int namelen =3D strlen(name);
 		int res_specified =3D 0, bpp_specified =3D 0, refresh_specified =3D 0;
 		unsigned int xres =3D 0, yres =3D 0, bpp =3D default_bpp, refresh =3D 0;
-		int yres_specified =3D 0, cvt =3D 0, rb =3D 0, interlace =3D 0;
+		int yres_specified =3D 0, cvt =3D 0, rb =3D 0;
+		int interlace_specified =3D 0, interlace =3D 0;
 		int margins =3D 0;
 		u32 best, diff, tdiff;
=20
@@ -637,9 +638,17 @@ int fb_find_mode(struct fb_var_screeninfo *var,
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
@@ -708,11 +717,21 @@ int fb_find_mode(struct fb_var_screeninfo *var,
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
