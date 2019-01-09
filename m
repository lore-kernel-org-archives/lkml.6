Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13136C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7372075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="njQFF2C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfAIXQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:16:30 -0500
Received: from mail-eopbgr820107.outbound.protection.outlook.com ([40.107.82.107]:9868
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfAIXQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qbIIJ68jy5gGd+kk1vX4fPP+K1ZGej+U34dLL52pUQ=;
 b=njQFF2C7MLgfJg6xisNeC8J23RIDbPfaBLTas45xVYk/pfgS15xku77iz70mo3TNEwfwhC8izLx9P7F0Lg39qfXokUTVG0QQQZ41UUEq4qvctG+P2Q6kB4F98+pMzqCn4AgNHK5J08ofyg1c0ME6SqhSEYocoPP7/Iubyz7pVH0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1758.namprd22.prod.outlook.com (10.164.203.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 23:16:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 23:16:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace &
 GCC <= 4.7
Thread-Topic: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with
 ftrace & GCC <= 4.7
Thread-Index: AQHUqHFXHrragMJ1IkS80PCtgAJbBg==
Date:   Wed, 9 Jan 2019 23:16:25 +0000
Message-ID: <20190109231539.24613-1-paul.burton@mips.com>
References: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1758;6:kBkfhsEdXhTs4mG3SdpOyuMzR4b/ZcPUSIEnaPQcKEWx7j4k0zlz1iisyR7xtNx/zxhYZZlMqx3hgeFBdpPt8V3BbUHRIsVHh8cVHnoEhadVzkLT7dI+9P35yVeW6OGkzAhhINKTmwVUBkYMMagGAgrlnAV3t4aO5Gm/WdgdVK6HUi2zVAlb2FSSNzVPNr2WMZISLXJ+z/ivABJBuVKY3QQIY5xMVAGyupCbjBayjTvrHRgsdYXuWiLRla17Lb1TYICI1PbT1KutuFlUDQ0fwmlGCpUB6bqbF12oAz1LLcDFGI0uSer894ZXN3TJtmSc9FLK2rpfe1coL1sq/H52fJXNcAuQfXNddoQjxxwuPKX/xCnx4pDVibmppPz1iJv+0ACcT/pV/3eGN79LflLDJQY7kvbYNo1wGmbFjxi18VpV8vNpiIYYrWS/tO3BBjEDab6btUy4kHqwbsXUC6ouJg==;5:zJ1pdLpQDHdxPnB1qwzIsl9aQScU6kQ8DikM+0F0yxJHW2B97PZTu1cwz7DX5XrbrvJIrpCVQbpIDBM4Dv3lCyr6okcjMc61XvN/2B6ASit4u5475TxmhU/oO+2EF3t1HPfNFvL41HS3YuHn81o9xnYHGh6T4NEM3m149WIMZAnymRiEUA+p2b2+mfPSXllk5i5Fj5e8G8ZbByGnPiCJ+g==;7:4F29qu7KkBmq+9pOAbSu4L1+TbDJpKU5k0fm6REZn1lS6OKml3tvP7lu6RXdQRCGZx/zkb70iAdKVQfJLyswwUHsffFGBp0WyqCZNg9K1XvBTGN5vUEqq1JDtb/1PDbBHqjI1wWHY9MhDEBFzU2Wnw==
x-ms-office365-filtering-correlation-id: 31be6e73-cd8a-42b4-4352-08d6768879df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1758;
x-ms-traffictypediagnostic: MWHPR2201MB1758:
x-microsoft-antispam-prvs: <MWHPR2201MB1758DC8DCAAE5DF26461BBE4C18B0@MWHPR2201MB1758.namprd22.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(346002)(376002)(136003)(199004)(189003)(25786009)(66066001)(68736007)(76176011)(39060400002)(2501003)(5660300001)(4326008)(6916009)(316002)(54906003)(305945005)(7736002)(81156014)(8676002)(8936002)(14444005)(81166006)(256004)(6512007)(186003)(53936002)(102836004)(99286004)(486006)(2351001)(105586002)(386003)(44832011)(6506007)(106356001)(42882007)(478600001)(2616005)(476003)(446003)(6116002)(3846002)(1076003)(6436002)(52116002)(6486002)(36756003)(2906002)(26005)(11346002)(97736004)(5640700003)(71200400001)(71190400001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1758;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vZOi7+sTCnnrY8qGR+/xkHbWcNVp/kynNhgxPYwXOb3XeH/Nr8E/nTTkn8HbFdSbu89qoiCbM7L4oJSUdh0a0tHaqoAQY6cbkIBBgaYXqN+7j3+A+kwUL54LN4NV+uwqZw4p+i/A8Fdd+zqy/aeDV7/LOJmEMnn2n4tMvdxJoZEkZmj7b279NCGh64WfUpbl+OqifsZWoP3C3Xv8cI45T7s0OPyACYlYwgj0luVSVGrupzQ5RVisHK1/p5w+2tjA9xXqkIW9ZCgFpjGgmED/POZrgnTLo0L/5vy4MNQh2I95rlmYJ/Ki9rMNTuOPMSXq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be6e73-cd8a-42b4-4352-08d6768879df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 23:16:25.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building using GCC 4.7 or older, -ffunction-sections & the -pg flag
used by ftrace are incompatible. This causes warnings or build failures
(where -Werror applies) such as the following:

  arch/mips/generic/init.c:
    error: -ffunction-sections disabled; it makes profiling impossible

This used to be taken into account by the ordering of calls to cc-option
from within the top-level Makefile, which was introduced by commit
90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
-pg on gcc-4.7"). Unfortunately this was broken when the
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data elimination
support in Kconfig"), because the flags used by this check no longer
include -pg.

Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
using GCC 4.7 or older.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support in Kc=
onfig")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: stable@vger.kernel.org # v4.19+
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index d47cb77a220e..c787f782148d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1124,6 +1124,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
+	depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >=3D 40800
 	depends on $(cc-option,-ffunction-sections -fdata-sections)
 	depends on $(ld-option,--gc-sections)
 	help
--=20
2.20.1

