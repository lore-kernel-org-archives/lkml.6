Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29460C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82812083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="pA8c9lD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82812083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeJAHQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:00 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729094AbeJAHP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvITsx1Va7IGlEkkTpNP/yacvTJstAKis3tkcVhk2FI=;
 b=pA8c9lD5oXt5GREfgN6GWjPNt80idObC5Huld05ReJg9qB4atr9v2f1LE6l+/sSICz3LxgDrtDVKtBkLGvSN6zs6lUCksbO8Qcb9BieoJdklOoicdGbBP0KaKBKuFgPbUh33SXimacpQz0V46k1SCrlV7v7BfyxJYmIlPx9DvzY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 19/26] arm64: jump_label.h: use asm_volatile_goto
 macro instead of "asm goto"
Thread-Topic: [PATCH AUTOSEL 4.9 19/26] arm64: jump_label.h: use
 asm_volatile_goto macro instead of "asm goto"
Thread-Index: AQHUWR9hEGEba4nGH0e3PjbkcAfT3g==
Date:   Mon, 1 Oct 2018 00:40:40 +0000
Message-ID: <20181001004026.147201-19-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:wrcfsMic0Z8+zKnfsJ7kF9YsppN0ZS7Z/sViXco8k+CLXbjXoBysnJQkA7i1WzdHiYGxoZLGb4d9kngQ/LIVXYeFwPTps4xe/XfANG7VcjPsMhzV6DIB1kbu6BeniS5Xq5ItGycza+5B21Yonv2IrNFkUhw46eX15x1+ScMppLVnsI0VF1B+Icp49OLW/T1vDY1zPzIcqP8gP8LuqDgyTBTINdDS9as5/BhmHErIXiUvoEcs80EWFD4IUjx2S0KbxF7xARnNHkb3Oh/VdLyvGv/3Ttl8FnTIy+hipzHoQIRsea6pgXU06qTGx+/fKChQ58gpvgU5MwZqOIe0s2Z6Ke3JHYD9LzXz3h0/j61J7ZsyLMGftotuBrrpUDK2R74dyUnq7u+zdH0z2scdN5G5Y7BJyI135G40seF7umXi34QUc6AC3cu6dYClwgXAkEn4Zz0mPSbCw9nYlvuNrysBDg==;5:Xb/qh5r8/2J1V84/fXRnmGdd2N7fH/j9URIjI9vTaAP1tefb8u32qMFIkVGFz5vkirdLy/RgjeZq/4sP0yakEWg2t6PZ3tqR2Xe0jH6lv6jzCIWfjHJW1I4tcrlhH7BxM2nVJcxEdJehRldp2okb2HuVWOc5mLFbVjTeLhGZ90g=;7:e12+MJLhJAnuIigALGZRqWT3HNUnjdXpAMxKaQqEgsddVPQKF5RaIBjZu0ElRaH9UhMsltGkCV1gGZ60ILfc93zVlNe9mGmiVPyBnG+/h616q4Fj7VOAdUlM4v2cwg9NvhT6kCtPsyn9i0nevSaNg6um38RM7/XRCJ42IFOJ2lX0lSGvMiHvkPGRUY4p0B2XoD5j+RwOus5aC5TgQ5uDiaVzDyPpWIupvUuH8ydmtnV64ZYAd3PXvjqYZPE55ENR
x-ms-office365-filtering-correlation-id: 77f52437-ebbf-4e76-392b-08d6273683a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01655EB12F1F8866919582B1FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(85827821059158)(180628864354917)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(39060400002)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lsIVTxexa3yZtsab1nDFaoN6f4P3aO/qCGcNjkslP0B0DKLwfTM/ft+WC+K/JWY3YA+ANgTRSV7MQgd5pSHiw8aTuCMvA+5z6SBLSeN/XBvG+1dW9NWp0My3pGpbpjHbhWlWpaPYWFVEPgJaugGjduDjyePYPt3PChgZk+4O2kOucwdbaCiMpyRBYCwnIHOwNvIDcShFJas305Bl8zkoXtoFp9F4xFZSdByySK+P57+Tkpd2+dJ4o3hflfoxE18A72JIvPBcmgeZVkcyenFw6gwqnnVHSc7ww/8zGtwirWq67xPDoY2hZtWFnLEoVF2DZdkdqrWWOKOrt9rthjC3Oz0UahIqPa+5B7/nBItEJX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f52437-ebbf-4e76-392b-08d6273683a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:40.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
