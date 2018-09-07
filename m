Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6248420857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hA24LuZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6248420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeIGFPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:22 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729190AbeIGFPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXT3XZV6AUnsB18enhcviLDF/LwY6/A2H4hMZPHyoPM=;
 b=hA24LuZnpv1rg0onnEPB1fSAlZGckO6vh3UzOTvP3U8dKNeFujcJ56n6pa1CmZR/7sF0uSwmIoAr6KJwq19oWHtsOaqRq/NSGiwdQNW/cphjGhAOVZuQzLZCbAFnt+i9JWkdMWUYT2+yWzi+ppoZZhQu6yVsAsouZCak4w37A8A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fredrik Noring <noring@nocrew.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/88] fbdev: Distinguish between interlaced and
 progressive modes
Thread-Topic: [PATCH AUTOSEL 4.18 48/88] fbdev: Distinguish between interlaced
 and progressive modes
Thread-Index: AQHURkLQc4byHgYxm0y45sUeZ3V2YQ==
Date:   Fri, 7 Sep 2018 00:36:27 +0000
Message-ID: <20180907003547.57567-48-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:Aca+yruX4zZKfXB0OzI4/t2LoJIEUNz7Pdo7ibclilnmu6INLcWouzg0QpgrwjfIo29vjXWz4ngboOpShEqO2inKGIuHrQ+Ya7psxHo+4pl4ssWhwX3LtWDLVQMDdr0wdJADPjoD/AVvwgAp8iZdyvWsxhMJhjnP1U59tv8fuGDvXscVTOmY1i8P5jhS3r9t35O8CBAFDgfm9yYn5a7c5zytKnua9aGO/Qypf+JHgY3fMPuPDRQb0XJBw8ivWdGMpoP4SBHahRZfMqwk1ReOntPDCPUpyplyHFz0JMWBtns7d6gGjbG/R7i/8FCpmijfp3lkctIWQ1N+9A2zDGRNCKsxKPkrdq+FOJDHHhqkxCiGofAjgd8WZLBD4Cv3gw/fjoC0V9cfi99tGisU9A1IxdnZEzKYHl5KBAYChqX7JFyiLh6eRKY6GoTzleIVjElGu8oCPK3qLp5d+TxMaKKVfw==;5:fkdOT2A8S7ThgFdprMSgeNZd4c0eAU5zzSOPflicbfAbiE51wUlWQ+9K3QqRULu2lH7kLDUHD9NJ3QSjCEksfOm9BYsglHgABcqIn8jwnpaPgIm3Tkh07zuP76s2mlmTicqFK+xAlTkQfvO3IYe4AZ85rDZQvm2kxqznCEYYBlE=;7:3f0T6gF0r6FXiQCnm9SkFtbcRk4/dguKV1tUt61ya2JutADKybZOsUw0zVZoUo7L6YyMImXYxQLI8se0ARQgRV13akwSIkao7MTVXyFvKeHXZV9GEwgDRX16P07VOVFrCvImHc1wmOtDhWGez97UoZUgUyh1SmoXVsDhlaFFJ523sZFsV5ArvGO8q5T18PqR1lguFhfp3Jot50ey8uqimnVt8NwO0nTtgEfJKIz76IEWGYP7La2iZZJiCjsnODK5
x-ms-office365-filtering-correlation-id: 097c0f32-8325-49ce-44ce-08d6145a01f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773422571EA191178EC0C8FFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eJLlf9UWpPmK5pzufK+1Qt9x9v3WjdklO2mxa7GJxzWmT5fJgs9rgv35NMa+JeUx8MyDu+wtHXFoBI1AfgGxTzlDVGTddjZyvIDjv+9ZJbpRV2dy9P4slbmvKz2REpo9BvM4Nz/h1dRwkEoeWuns9cZi90nobyYJseXh6zGWoHTyepEAJGWWbTFa8bc3vLb8kfV2g9BY4Jq5b+OqYe+g5rPkQftoF39wuEkTwhVUndWmvY62JXpKprvjCF4thxP5/T0aBn5i72GZ+j9u0VGy7XwHf4ecMqyEcwv0LPrT0banJpqK8BMz0bMsrETwLgI50baPeB2dd/dRVKr+hbpuGarO/iCgGTk8BBTpjwndYXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097c0f32-8325-49ce-44ce-08d6145a01f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:28.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
