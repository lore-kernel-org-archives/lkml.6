Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED7C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596332083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SmKPfg0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596332083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeJAHRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:23 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com ([104.47.37.102]:43666
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728986AbeJAHRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=SmKPfg0zdkNLY0UvwMipeId/qjLwhj3GHRvDbNq/dgf0TlH8LU+AZAKDmwCip30Zs6E10UBohwrZ4d6uAzCbAqz7oUktnLWIsOZAy3VL158fc5J2hPV0CMB3xKoYBUiPk80xrVCmERvZ/NdEV8ypVmj6Wt23iBeIgOngASaV6tM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/13] hexagon: modify ffs() and fls() to return
 int
Thread-Topic: [PATCH AUTOSEL 3.18 08/13] hexagon: modify ffs() and fls() to
 return int
Thread-Index: AQHUWR+JoM93Eyvhy064iuLrr85C2Q==
Date:   Mon, 1 Oct 2018 00:41:48 +0000
Message-ID: <20181001004139.147341-8-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:3vDMfMDS+x5kUy1ADTcUJ9Xr1mcFemVZT7fslR3HJfovKKp5Epw6zFDvEkQWzvGzYWknb5QkxmS0urgyMbMbmRhnU2wcfv6G+gx+jOMt6OLOQNWQ8yx5QyuL+WjOht7Hyxs6XUYCRCCHJhuoJgmifUx02LRwIXzI4cHx+CR6rKmGHbWC01qVzjHCvky/q5DW3PlWIoWSSmSH7FEW27GCJlk/6tRMPbQTig3sp496OFaj05xkb3pGjg3+XMIkOc9deKQEREphnAGrtdHJ80NFc4yp3d6WV2F2EKuoOJkC82SSJvfN7S2iFcmzxbv7LGllTVuD54jr/sBvPyUro1DL/CGskwPuENaNmzRXBT9VPJxFNJHFQLlM+T+ZJCroSF2akdazGDVhsGtYkB+LNmjhX3S2L44rbb2ZpA7Dpgfcr/7nVGFlqQpomRqA7lueFZYyP5qOAklgocK9MZhVahV89A==;5:Es05l4y8BZdk5YD2cu38h70S02YJQCPGC93DpnDVUq+GsCwKam5RkVqpbwpIXMbOmT0RN5da8Uc8EbMw1/RsjU5Pt5loj2PYzKKWVxoLYRL5QFo/DlW5PMh+VTsgqo7/qCYTsqSwAzLobqF0R1jBbJrqonpUIyHvTeI5jeCkjbs=;7:I6EkE9YydOjv+CXM7U7Zqcby3anJ6kl+KoIVHopeiqJcotgsGhqUha53B1DdyV3eMqox4bH6r4PZQpKWCC/X8iRiKa+/PJpaphlbCmkpLHYypgCWT6ezAIcY+yqvV8OCPJ4G+i8GgAWr8VVRTwyI8i+KaXWfSr0eCZvn/OGgrDblhft2WgGbxIkK9JEoaSRBXwk6zwzaZ6jRdVKDSBko1RDcjQpstOvZVycatM2bS+8o/ep3IX0fGOI2uXhnuame
x-ms-office365-filtering-correlation-id: 108892e5-09a8-4185-128b-08d62736ac0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07916B81516BA9EB8B285060FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +iHJffRWxgJ8ZHm076oHe4z9tXu3+BwPD0ehsz3ipIsNLI2Xd705Pg5Dua4PqLVO1tHbTuWduoabdCEEOzA1mOW5G+OQqsw/MYIexmJa/F2YrjVRByB4yVhO1keE5nMkpEV9Dygx9VtxjQBQ5ratXiSNu78seY0CQ2F0mQz5h40XnVix1KWV9BQR6Ddb9MwmswAzuaGYBL7fN0VTwrj/GnZBV4Gh/FzsAUzLfxe8fxJSw1q2Z6mzf4l5pR4ps2FxMEIYMB96yJploHo1H638WprEPx1i5CE6nh0qdQAMODmhqwZaio4mL0W2WQtiRPYTmOFMyMmee9g0xNK8wXQ/D0vRVk3cfDci+pmWI5oxzwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108892e5-09a8-4185-128b-08d62736ac0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:48.6316
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
