Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C8A20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EaoxFWbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C8A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbeIGFRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730187AbeIGFRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXT3XZV6AUnsB18enhcviLDF/LwY6/A2H4hMZPHyoPM=;
 b=EaoxFWbxy9Vec9nibO5+78/9Dbho3/3Z0FCdaUQ5Ea7YC8TwKcsLH5MaoK5NG1BhpytlQ3XtZGPA0SxOyq+Za0xZwKS0hL1nGtYTXp3Wu4oY+pI+X/gGEOFlPbfd7AkR1scAo99Uc0R/ADBQDGtkkTQ1Ol6JLYz344AcHi6WlZg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fredrik Noring <noring@nocrew.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 37/67] fbdev: Distinguish between interlaced and
 progressive modes
Thread-Topic: [PATCH AUTOSEL 4.14 37/67] fbdev: Distinguish between interlaced
 and progressive modes
Thread-Index: AQHURkMAMEoB8Duo6U6czy108haSgw==
Date:   Fri, 7 Sep 2018 00:37:49 +0000
Message-ID: <20180907003716.57737-37-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:/LdKXEQdp9xCXj7vt5Lh1O02D9MxDyThFDKpbbOtpUrDVPvva7yF4LeXe/WVM206XS+AS9J1/c+9jqMEoOkH3xaZsFJXWjfk9U4PfqjlmO83gEv71Go+lzQhtztCfz/8aiRGf5iDvGxV73I4se/TlTOEU0EnL8AGO/JktwEQGO8vD44l2IfUbfiTFbkBOMEpZ/xsd/TpHb4/EBV7k4dLLrqrWG9p4nUFkUmBMjiWNlLCOEBDB/jw/lUl24w3Rx762J3bBVMbIRi8qkB1tIiY6zUcS9oOGfS0IWxeg4r2KXevnPsFM7aP9gZpRuNS9f+Uibvu+w8WaPNhJCwEIcHf1TVh0qABfXkdciddjSO50tjLM4epmLfK4HiNzctBU3qDKrjpcYZXFhPJeqQ3aO8gedu1sQ6hmVoqpJVOuJRLz3RyXD4dxeDwc37EEn5Yr5ZdZx4AGsivZ+OgpFO3E87pQg==;5:5UlDpAD5Rh3o8bREjINPX2kRp8TGi2ymYySq9HF6/9ZOPmTNas/4JfuzxBrPN7/tZXlPBFlNb/TXQL08WLfcH6cC41LODrJsq8u0jCDj/PeC2tS+Xn9PEy4yseZvkG8KbbrDENqSRIRBTji4wqJpBJm+hr0cqYvgeNN6wIpyYH8=;7:jpddvPexTxRnEMA9MTwi/af1wwN75HJ0SKW/L7k8mpzVBGp53DL9Fi8QioHGYI3uydvzDp37ZZKUpXUHRhMUyYB0lQziHhpNy9xCQwly/px4x7hFeQXhMtcSABxQ6E89Q4YIDK4CsUn8q6s4olDx+F452IIG/eXPrHAgOpo4xrE0dZEQXwKwiIT8dkSA8yp1zW4FxPSD49xWfc3tngDjk1YJXdsXPSzaRbiU2cct4r8ACDa3Y9KAIfshX74kIOly
x-ms-office365-filtering-correlation-id: ddb1023a-e2cd-499f-4da2-08d6145a4c29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB06964F8573DD4BDB2EAD1F77FB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(14444005)(106356001)(10090500001)(2900100001)(575784001)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zo4Jzs/A4Hn9hdqeioyY7kedsQrlbhfbFK2YnRlG6UqqUqaAhOV6KmAfTpnFTAUhTfC4bBtjIpKs2CN5EnH6g+il1TIuSJG+2hzteOEU3gnSlpvqEwJJGo7BW5mBdk8zXZr91GHdwiTD9RQhUddeBXsem5lQFjolaz0EkEimky7JzjTU5g+Q+C2IHCmMpwz1i4/wBk7Yv4pngsvvi/NEwRdUKWZW1oCEBSU5EnKcvJEuBtk7+dHhcDIo7tV6RwtyQBEdQB8UC5akkir54jf3OQn40FQWU0n9sA1476roLgJGY2jOpyTPfcr/2Fo3lJCHSWozZ690so5S93igHI2OrvfVbBZsdHMed7TD3HrhFPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb1023a-e2cd-499f-4da2-08d6145a4c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:49.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
