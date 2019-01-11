Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2142183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Kk0Yzjn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390284AbfAKTGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:06:48 -0500
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:49344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732319AbfAKTGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+JaG20mMq1brCJQXEUyirq2TkMVa8cZZ3YdXVC76sI=;
 b=Kk0Yzjn5FAEpqtZbgMYG3OArz8xFDiNWnEhexZqOG1xdV+19a2jsmkhbpkTsTIwGupXfhaxicghDy0piPLlRHCZp8SKNgxA5xWwBF+ZQo1savAmc4YikLUDzBqF0wKFH7wIOEuAfd5NwNK01bdvfISchPD5yhSdqrCSrpGxP8U8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1279.namprd22.prod.outlook.com (10.174.162.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 19:06:44 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 19:06:44 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace
 & GCC <= 4.7
Thread-Topic: [PATCH v2] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with
 ftrace & GCC <= 4.7
Thread-Index: AQHUqeDKUuLp4q2hMEe3blE3yqqboA==
Date:   Fri, 11 Jan 2019 19:06:44 +0000
Message-ID: <20190111190538.6744-1-paul.burton@mips.com>
References: <CAK7LNAS-r4gZOxdJCNaQwHtOYbxHbdupu57qncWkE+bhGfb_7g@mail.gmail.com>
In-Reply-To: <CAK7LNAS-r4gZOxdJCNaQwHtOYbxHbdupu57qncWkE+bhGfb_7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1279;6:MDTJ8t8TwPALLDXzpsCHvFm9waD7+pSL/QQe7PG6nkyxnrfa5qrbrm5lewj8dCPBMKTeysk8RRsLNYu/9VyYylX/e9QSeCPovDqKBmSvDZBV2IwfoEocvKBjWmnlaxoxAzBvJ0I9altZUSIebaUGtMt64BCW68/eRIwMvE0+cL4plrfdU9GlicYV04vHKtjOrKfCZMz4nOsUewsQ/cWFhv0/TGYVoQ1N91CH+gl0XXKutgaTif7rW9hPvFx5mvGi15mjb/jZdgi/YsKEhSZbEnd4MHzt7h0fiSS5e7q065wgxTB1dg3MUT+YaBVzrg1oZLbv2WfwXIc483tH2OD5TaNkgyEYPie2mw1WxXMoYwphcCreBC+CG1pUuNI9UhanjGakCorQTLQX64mJ6NarErc2dooaTgVFPM96jTuIYWDQCjiGUxZoa3dlFox8ooll8r1GwB14wg1i5g68DgjLdw==;5:OXdZizbtNhJyyq4U1dIIN/JXPmFDr0YpN3PwARarPePgYKWo6bzqqB1uN0Tsockh2xXgckxKcULvRKGhkYQ+I360IaLiMBsFEJurIhC202TLLX05DSyRlxiaUBxJwIMxEWF6aSYadswd2Jrg8xLj7D0FBhlnYi+wAtK/waBX4AYn3bsS7ddtYP1yIoq7tFaUtyGM+g5ctRD5Hj+r8beACg==;7:O8aHH12oXZ+IGnTkk6YbEOQqV4myCjkS1Rf+grl8n71YDS6X2qPiuizwgtBTTOQMbc84GziAKRYP7Azkb/rpxGZPCvznDlhv6pnXlivTngDEvWB1vYGJS+660bWzLn4fQrvtGkhcT4Z2jQwnXGeLtw==
x-ms-office365-filtering-correlation-id: d3b1094a-8eb8-47ef-51ad-08d677f7ed2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1279;
x-ms-traffictypediagnostic: MWHPR2201MB1279:
x-microsoft-antispam-prvs: <MWHPR2201MB12793275C970A2FE77837714C1850@MWHPR2201MB1279.namprd22.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(54906003)(2501003)(186003)(39060400002)(6116002)(3846002)(52116002)(478600001)(99286004)(4326008)(2906002)(76176011)(6916009)(105586002)(2351001)(97736004)(5660300001)(106356001)(25786009)(6512007)(53936002)(6506007)(8676002)(8936002)(81156014)(81166006)(2616005)(305945005)(7736002)(68736007)(26005)(316002)(36756003)(14454004)(102836004)(42882007)(66066001)(386003)(11346002)(1076003)(476003)(446003)(486006)(6436002)(44832011)(71200400001)(71190400001)(256004)(5640700003)(14444005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1279;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MdZEpRiPFCmAL+PEpH+W2Wu6kWir9BaneeU5ByiDHJ7mhDkXO+sRaoDxmOEHAHK98gH/+ioJ8MOMSGrNX4u/09sMiKfYuASk9I4/Dw5GhGfJcs1ZnQU40+uPOXhO4nk21M2Fr0gicavgIWkCpG8xzWXaqvYEfPjNCSr5M51W71LPRpfIukC2SMzYwJmfiGrQ2BAumBwKqDfiDJ4FRGMSMqzD+d003YqGoy4sb9+l2OzBeqD/1D9C6n+x59e7gx2iDK+0OdtxIV3XeG2RuyXcKovjAOOC3xdfe0ECyaGG/NBnGwBRRQO5OMHFJZPxAMtq/1+Akkov4299UkJxqAcD48yUO8KBf2+cnnHZCP9IsXcfy5QjtqfoYm2ExzfIjc1g7g3LSnHtW/G3oaLzBmFqjshmAif3OMk2NTKtktmz31Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b1094a-8eb8-47ef-51ad-08d677f7ed2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:06:44.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1279
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
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Invert the dependency as Masahiro suggested.
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index d47cb77a220e..513fa544a134 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1124,6 +1124,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
+	depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)
 	depends on $(cc-option,-ffunction-sections -fdata-sections)
 	depends on $(ld-option,--gc-sections)
 	help
--=20
2.20.1

