Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D674C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3A82083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nQ74di5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3A82083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeJAHTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:19:34 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729155AbeJAHQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=nQ74di5vLYWLKvS6zu0qecJJFJ3T4r5n/OrCW0BsQVa6zqph/+J+dZgVBKDLFP/a7Whtim76a+X9MC0E4cPL9+gj+4J5lf+Z/hftVysWk87IiYtgsy94AjNLEGR92nE/emvydlm3h5iqsSAI6dpG3JGPnw39msbxJ7JJZKmp8Bo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/17] hexagon: modify ffs() and fls() to return
 int
Thread-Topic: [PATCH AUTOSEL 4.4 10/17] hexagon: modify ffs() and fls() to
 return int
Thread-Index: AQHUWR9+PYBw0TdHn06BrE7QktIaJQ==
Date:   Mon, 1 Oct 2018 00:41:30 +0000
Message-ID: <20181001004122.147276-10-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:Ono8fuEyP4pgfZfEItLiALQGbGiKu9PHNdHZFVdLxfSoLMB6uICtQl8sRBWZH3CgtNnrtN9gKi6tdDXY0nC/VBrYb0i+XlMtgMtA0SA/inpT0b5NgV6ZWM4gi7N66hRhK7680OasJLNFIS5yHGTQbFfCy8FlJK0gwqMYM4IwhWbNJsdSykgMYMNHbdofq5ET1bnp5SO3M43DZ1Qv6z1ta6V3uCNLqR/nWTpe4d9+TgtkOImufXLsE2l3VDIekUq4VvwEZdUuypsKclLc/cH59/sfzjNzPtbic4wleZmir+6wXnLvhwOGzXFGpZA8dhF1fJLRLnM6pYNaie0BC6Sk2+uJfoZnrtrv4g2HfIgwPHIq9fBc3XVaxzvhc/TC816OYveypkOZgfs12sn1vvYjJ8zl+dpjvC1PNRoVHzGBmGL/jzLxRUc/4P+UfCb00TZC2ljFgKHN4Zt5DXnBXKigjQ==;5:EW1PT7yxXXODaB0sFClt3XhGaeSoQy+98Vxak3rH5xHAZXuOuZAHTr3bl9NfUuHC42q4cKO+9WJNrimKYwZgnnrnSnjKOLAAFH48QYgLgjNTYUBJqRN4vEQfvrx9pnRH5dwdRlXvHQyoxWwTP6aMuzlcyCw5aTmd9JeIyw+BFG0=;7:fbZIErlao3s6alVq1bg5JltL7SnQGv4oRvCUl2tF8Qzvekw27TpP8mT+0Iu13SL1f22tVEO8oEuT9LGLWF9PH3WACKRoH3xSLEl/ChEQUGJBZBmd634UI8t3STEshiijQKoMTwVb8HX52OmZzIhA60ROsK5CDm6Z9kDPJ0zXKUlVZXeQyRkqUrX+eaemzb5fq7reRPYmBTXzvDHtJ7O9uc5BPgxmnv0PnYPxbm0qTqEB+m2A7lq7TCcCggzXWOBJ
x-ms-office365-filtering-correlation-id: d300b39f-cc26-49e8-3dd9-08d62736a179
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791199282A368F930EF1B65FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cq4cdgoNymoWnGtFuyUj7IslbPZnv7Wh1tM0fQ2b94Y1brKvQrvmIsMd39zAjv2BPUkc3m6Pi/CcbbACveLyxMOCbogWtz8sY15+zg+IZPyIWX2w5bRWTBx8l82WpxjvSzx2bhNL8MCO2zMigrePIJHzvAo3cT7CW6twuXRrU7dL9OxmqVI0l5y1rdqaXYUh9sxyTPPQsqFVCAR2dtDLVNYmRrExHIO/EiH+7qcMvte9BXEdMbORxFLKjoof1H7Isp4n/aPVsyvLxeD/cupbPakE8goNOmLbF0t7QXsvB8+n876+hfhfZqIztUKYgcZFkMV3TSLngZjyYJOQptn8FZj/LJDS8L3f3TTPFtz+LmQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d300b39f-cc26-49e8-3dd9-08d62736a179
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:30.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5c41aaad409c097cf1ef74f2c649fed994744ef5 ]

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffs() and
fls() functions to return int instead of long.  The variables that
they return are already int instead of long.  This return type
matches the return type in <asm-generic/bitops/>.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]

There are no ffs() or fls() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Patch-mainline: linux-kernel @ 07/22/2018, 16:03
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/b=
itops.h
index 5e4a59b3ec1b..2691a1857d20 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) =3D 0, fls(1) =3D 1, fls(0x80000000) =3D 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
=20
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
=20
--=20
2.17.1
