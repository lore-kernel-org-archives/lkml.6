Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD191C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E2120666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iNrAmy+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E2120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeJAHOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:22 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbeJAHOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvITsx1Va7IGlEkkTpNP/yacvTJstAKis3tkcVhk2FI=;
 b=iNrAmy+lsUEgkFJ8IBvCZ5WpP2bIlmtX8vTB/AJj6wvjwGI81jUuAZ8Bq5sUfs5jnldS9SPuYO4e9rHEoyMBvg9Utup762AUZ2P9MVP2f1VazLJAw9fhg3lsHq6J4OWfgxvUMvumHWg/8hkKAgN7RTod4tRPDhl/Rpi7VUyoHZ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 55/65] arm64: jump_label.h: use asm_volatile_goto
 macro instead of "asm goto"
Thread-Topic: [PATCH AUTOSEL 4.18 55/65] arm64: jump_label.h: use
 asm_volatile_goto macro instead of "asm goto"
Thread-Index: AQHUWR8WnMiuuBUUw0i5cR9gK58agA==
Date:   Mon, 1 Oct 2018 00:38:36 +0000
Message-ID: <20181001003754.146961-55-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:bZIQNnVndrd9qsp+3wQaCQkexSYc3NeVmuedGQBaI9X4mBrsXfMNdEFLRy+qK4lfJxq3UzJB02MZRw8QQbQVO2boqcwORnXg1bW4CcdY4acGZrURilccIjxomXYlewXgZU6HcUkmE1hBwklC/0h6wzzQQqFZMHmEGH0mr4HavtX4CR1lMqj02IVSuMxW0ymcA2euPL36mtbwWSxl6FRgMThjK+EfwJgnEBCpOSSLQs/egLPwhtU/BWGgnkg31YF3DJ/wSA1uJPU5v4PGrjEJx60FrgGUnL9vagt/Zq60PYW/asCOMtAC8HX5a9fG5WBqNKgmqfeoArR3huWWEmErU8Agi0CXFVzxxyR8CU870/CYdC0mLxSbdfa5FIWw95h6OBDtzteo3YcvL4yYpbC4zN37hAdZ6FUW2vO3bCf2NZeA1i69exEVXstpdMwdnJWNS92+U/Dx8NMjtcd/MKkO+A==;5:NOBt1qOPEjMPkynIoMB41sxaJE5CcP5n9k3TQ1k8iADm6cHGH6wdogq6yLEWH17Zg5CVzVptE9aMvJ2O1kAcBBZAqnt07/EBh8xVY+8DfCOr4wTE776QEJxp1Ifh1qFxdwFlqZA55+mg9MEloH2AhHi+qS/Eu9WpekCVapECj2Y=;7:iQ5FlX39vuBq2h07wxvUU/UlDZAa8qSRLI5rs0KkIAeuVO2gCPC5Sjp/10ibQG0o11klwo6u+yonk1+fX9Ojue6cFaw0nvpZmyZRp6cpnx/u77Lv0PmEV1IKCI4d8RdUG3e+TQVmDJh3GJuissO7HlhgSOZ2bHPduVT5YXYXt6UHrlWLZHNaZve3T5UmkBFMhxf3MPuhKxLP0NmQDQfGsFsdz4D09ksQO3VPRSahNS/AoKa5a9VPetPpN6zS6xvp
x-ms-office365-filtering-correlation-id: d8ec3f0d-91bb-416e-46f1-08d6273649f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824D86B11C57DADA9B82E40FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(85827821059158)(180628864354917)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(26005)(71200400001)(71190400001)(186003)(39060400002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JXu0sdndqlK4e5u2km/GY6I48knOYQPE7n04/lb42BS2CO4snctXMyYMhtPzyAa9figQUba47BoaR7PiTihUJPVpA8wpRbQ97Mwu9txhWOuUNoYjJ3SAPmO2BOAnq/g173V7N2sjRf0nW4+tA1j7Y23Or5agzxdpAcISHlx1UPmY0RlWgKGCSJwNG8TWH63+odl+ybtGHIeJeAz+OaVVExLCbfackn/Ihflimg0/UasG1aU+x9EtdUbIBdoHpfToQS00zColr2ifZrIUMmNuBCwCz8PpZbdvMqcm/InG3d51UPhQvmeP3rxKx9B+Qr46FWFz36YHK/P+/AaVAYk6cuC6egsEmFbitZk0R1oCKTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec3f0d-91bb-416e-46f1-08d6273649f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:36.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

[ Upstream commit 13aceef06adfaf93d52e01e28a8bc8a0ad471d83 ]

All other uses of "asm goto" go through asm_volatile_goto, which avoids
a miscompile when using GCC < 4.8.2. Replace our open-coded "asm goto"
statements with the asm_volatile_goto macro to avoid issues with older
toolchains.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/j=
ump_label.h
index 1b5e0e843c3a..7e2b3e360086 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
=20
 static __always_inline bool arch_static_branch(struct static_key *key, boo=
l branch)
 {
-	asm goto("1: nop\n\t"
+	asm_volatile_goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
@@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct sta=
tic_key *key, bool bran
=20
 static __always_inline bool arch_static_branch_jump(struct static_key *key=
, bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
+	asm_volatile_goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
--=20
2.17.1
