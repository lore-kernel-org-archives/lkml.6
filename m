Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8187C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930362064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CkrX/gqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930362064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeJAHPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:32 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbeJAHPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvITsx1Va7IGlEkkTpNP/yacvTJstAKis3tkcVhk2FI=;
 b=CkrX/gqEInFw41DriaLYjxl32s5oaacKTqSI8FL9e79hYDlk843YHmF2A1P93HvWKU00NeOlA+l+/nxRr3bhKdrrOS7XUADLygGIuwXAQNCqETvTcg8ZZkuXp7cOskU6d9hxAZ5DrUfdI2RQ9See30IWfS1SYNvygDTjonYIOUg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/37] arm64: jump_label.h: use asm_volatile_goto
 macro instead of "asm goto"
Thread-Topic: [PATCH AUTOSEL 4.14 29/37] arm64: jump_label.h: use
 asm_volatile_goto macro instead of "asm goto"
Thread-Index: AQHUWR8rRyWj7rASE0SwjynRXvNcGA==
Date:   Mon, 1 Oct 2018 00:39:11 +0000
Message-ID: <20181001003850.147107-29-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:ZYEsic+nIm0sC3V5+Hf8q6wBJTeJW30CimDXLUsOTQzJ2ZlaITW1ehVJVSz586ka68sXWxYRRfn4b9KSUB/gCPxUl8AFwtXD4ojIP1qyOE7R2im2LAT6s1rCaDe35v05RrIQPGdyfNAIreQjaxzrggcEMp4NdVncB578es/bTpXp2/pH972p2NvkhDbnTro6pyAD0bkKrRuYVdLXrdZeVHgb4oRwlZSgoyWv7DdVFpxRgBlrVg1Y0yAjHa1Y1vYYE/BL/enrAUeGj04TV4s58yCZSXIIUlK1WvnY1wVwtePsqBaXqpNkMACZovp0oeJv7CLaUPMrV9oZeiB8txSQKcb6HFtW7FgXQ+IuXJB7snv5K0pl8951mGC90HWYPBlF6IqXrg07q+0r7Za6odX3aVnX0kSYV2JJGpdugbLT4pSC+nu/cxE4LD/e570FC2wC5ZILOYwGzqU1a+mySwJiOw==;5:cU5Gu7QWNC4Gyj5GkmhXHcpZUZVV4tEGGcsY6QPL75aWw2xo31GKy+/UNjxpcNHs/4dsY7pIZimOzzYw3r2xY4zAxY3uoJUghkXfVJBmRoPc8kSU7jaE+TTHGepIyzo+CQ5G4V0KaeShG47mJwnzSmcX//xDaa11uV+dlCLbFzY=;7:+GgCoHAi+saXkbJwg9kOOF5ktf6xR/dt5ySAqFDK8KrsDqNceEUKda9yBKx4MPpybx+HpR9TEosk3SqryipkK18uf02zqOjWc0JjD0mj5xXT6wIpVJMud34YwUg+SeKW37OvJSQ2BMGj6TSUiD2ROeyTfEEUe96DxneiHenHmOtUSGvetbdKudkD4ODHP7GvNPiiZPwXawdyberGpoEmhC1N5/pi0e7ypWelAd+ENPO+sapfv/O3/XAQCzetPYxr
x-ms-office365-filtering-correlation-id: f5637050-7022-428a-2a7a-08d627367602
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08545E28EDD2C844EBC44221FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(85827821059158)(180628864354917)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(39060400002)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: J7WWU31AfQjRCZ0zQJxagKVAs4yPl98TQuDYEH2hbgs5LNGGGq/DO+3fOGaCQCJX1YFZ0za5G2FXMOfbKL9wyRalCJOowVqqP9AYnzXdw4A7x8ZpyRTB8PGjzj/s3ECdGnbNUxJzHYylZqdz1nL+AZrLDMomW40JxGK6hL2ixihKeYKTvXoABGAhJUY9TLt6myDTw4BSNC/sDgeQdAjLEUU8q+SiJpSqvBeFKt49ajZ8mmYjQQFQVn/PtN5NThL4/KJj1bq1SXRLlFjyQg/xHSIB9gByxWSSW0oRfKc3diaviYCyFhhwuhWaRpPDWTVFYLWZdAyaUxqTCAHOeGUMHYIdnMHIN6cEiAi+5cWD+Qk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5637050-7022-428a-2a7a-08d627367602
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:11.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
