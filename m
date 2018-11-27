Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC33C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D5020660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="anPxWSWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D5020660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeK1DSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:18:06 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:11920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730663AbeK1DSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGOgnBCcY7jK+SaXpO2anx5mk4daJCtE3/69hI/kWFA=;
 b=anPxWSWC+hHRYRCt91cxFHQD47SKKaxwEgVp4c/R4y21Bh9EWfwV3WOY4kRioi6aclU/7Xj6PLKSyt4r45NjuH7JY0izX+9jGN2fzeu3sDhjDT7vw5r1cbHma/A1biSkIaol5uuTfPvMk/7cjA5kTvRKfpztX2PHsLBjgPyFA2g=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2256.eurprd08.prod.outlook.com (10.172.13.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:19:31 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:31 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH 2/7] lib/lzo: clean-up by introducing COPY16
Thread-Topic: [PATCH 2/7] lib/lzo: clean-up by introducing COPY16
Thread-Index: AQHUhmz6W3fRLI+fRU+YNV7qtQW0fg==
Date:   Tue, 27 Nov 2018 16:19:31 +0000
Message-ID: <20181127161913.23863-3-dave.rodgman@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
In-Reply-To: <20181127161913.23863-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2256;6:w5LBKKUGfWuCM/fR6MF3KnPFUrbQi7iS9T6JL82U6xa5mNQb9cQhUnxd9n5SKNisNN88WqegpWyRkUOKTaMXjeImQDfEIxIU3LsYoXUTm76azsDwYp6DyYBzh55oh2Obe/taVmWs62Y/w7bHwFny/vR2sA73cj3WsoiuNYhRHLCIaTBzKnXDsOP1eQrHOyK7ToxHS5t7T23DuoZw/72YXtXovREeRbLuJUPGTWO42OHhclzdrKwPiCrnQI8+HkEE8dOUwBhKiD+B2ll3RgFro8dUrWmynd79fBSIN/d5f8sgWBTMcEy0m95XQIgE6raNZ1mBeddRJiAUHAlLV3Wa3Nb/T1twv62KC9gLVu2UqJoWtyr+Ti42GejdN4ZrwB4etw+EFQo/wImdWLv5yRm6Xzkiip2B00v9A/fs3rEPglZ8i7rDBsACTmjvhNumH6wQfMCHt40AWJpCLnrG3z9krA==;5:mR96JCcE3payDkV/F/fFWSreAmgv/6N24hFQKNceP3dshIkpsC2Z31Iv2sPi0Yc6rSWlCXTDo1fkVKl+n5MAj+s95OXUozrIs4LmE4YpHLukhPMe8YT+0tWtHQuvzu31z5XlrHO+1SYqtxVkvhfgyPFs72UMo/Sp37+4A1LU42A=;7:S8ytADgYbu5o+lWP6V0uyBOhWCOhMYOPuVLHHuCPVon4bj31Jb17H+u0VBeroq4MIRWCxkOA8OPH3sflJ5uIIeOrVkApjsDYZLjxHWXoRxQ9iuamCXBO5d0I/+xLyn9ihSuvE50+/nLXtHW0c0wf7Q==
x-ms-office365-filtering-correlation-id: 4473446e-62f1-4ad5-b085-08d654841c99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2256;
x-ms-traffictypediagnostic: VI1PR0802MB2256:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB22561FDFB2BEDB9E4B9C10808FD00@VI1PR0802MB2256.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2256;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2256;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(2906002)(106356001)(105586002)(2351001)(256004)(6486002)(52116002)(53936002)(99286004)(6512007)(5660300001)(54906003)(7416002)(7736002)(6116002)(305945005)(1076002)(5640700003)(6916009)(446003)(486006)(3846002)(39060400002)(11346002)(76176011)(6436002)(316002)(476003)(2616005)(44832011)(68736007)(4326008)(102836004)(386003)(66066001)(71200400001)(36756003)(478600001)(25786009)(50226002)(26005)(6506007)(186003)(8936002)(8676002)(81156014)(81166006)(2501003)(97736004)(86362001)(71190400001)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2256;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xwGsAlx2sLD7yeMTXM4OvyWaKWyxwAPaKFF7NkedRpYJ7X5J6C9Biy9u9Ka1XzUo0ApBAGQ16BOISQ46iNUXzsP7xMHNHcmHLiRIQ0gAIKO3J+sV7MWRiQArc0WYb86TY5Z4iAMBL1P7MsDG9wn0j+d0fkinlPY7xS5qixC2xj8Zr/KFGcc2fjn0feWVmJjrPTYdxNuuFtAgZfkALhk3+8xykkkA0L0b/8MORNpgueYTuad6swhMcEYVND+bKxMAZrYFDyg+RO3D2fhikGXo2NKRpJluNVOzSm9K3/hiO1Ad2GJ+cuin4MLdTjGxvgx8kfRGLVxgDEQVookAw1F9tgAjXPxnrr5h/lU4VbdjKck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473446e-62f1-4ad5-b085-08d654841c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:31.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

Most compilers should be able to merge adjacent loads/stores of sizes
which are less than but effect a multiple of a machine word size (in
effect a memcpy() of a constant amount). However the semantics of the
macro are that it just does the copy, the pointer increment is in the
code, hence we see

    *a =3D *b
    a +=3D 8
    b +=3D 8
    *a =3D *b
    a +=3D 8
    b +=3D 8

This introduces a dependency between the two groups of statements which
seems to defeat said compiler optimizers and generate some very strange
sequences of addition and subtraction of address offsets (i.e. it is
overcomplicated).

Since COPY8 is only ever used to copy amounts of 16 bytes (in pairs),
just define COPY16 as COPY8,COPY8. We leave the definition to preserve
the need to do unaligned accesses to machine-sized words per the
original code intent, we just don't use it in the code proper.

COPY16 then gives us code like:

    *a =3D *b
    *(a+8) =3D *(b+8)
    a +=3D 16
    b +=3D 16

This seems to allow compilers to generate much better code by using
base register writeback or simply positively incrementing offsets which
seems to positively affect performance. It is, at least, fewer
instructions to do the same job.

Signed-off-by: Matt Sealey <matt.sealey@arm.com>
---
 lib/lzo/lzo1x_compress.c        |  9 +++------
 lib/lzo/lzo1x_decompress_safe.c | 18 ++++++------------
 lib/lzo/lzodefs.h               |  3 +++
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 236eb21167b5..82fb5571ce5e 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -60,8 +60,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 				op +=3D t;
 			} else if (t <=3D 16) {
 				*op++ =3D (t - 3);
-				COPY8(op, ii);
-				COPY8(op + 8, ii + 8);
+				COPY16(op, ii);
 				op +=3D t;
 			} else {
 				if (t <=3D 18) {
@@ -76,8 +75,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 					*op++ =3D tt;
 				}
 				do {
-					COPY8(op, ii);
-					COPY8(op + 8, ii + 8);
+					COPY16(op, ii);
 					op +=3D 16;
 					ii +=3D 16;
 					t -=3D 16;
@@ -255,8 +253,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
_len,
 			*op++ =3D tt;
 		}
 		if (t >=3D 16) do {
-			COPY8(op, ii);
-			COPY8(op + 8, ii + 8);
+			COPY16(op, ii);
 			op +=3D 16;
 			ii +=3D 16;
 			t -=3D 16;
diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_saf=
e.c
index a1c387f6afba..aa95d3066b7d 100644
--- a/lib/lzo/lzo1x_decompress_safe.c
+++ b/lib/lzo/lzo1x_decompress_safe.c
@@ -86,12 +86,9 @@ int lzo1x_decompress_safe(const unsigned char *in, size_=
t in_len,
 					const unsigned char *ie =3D ip + t;
 					unsigned char *oe =3D op + t;
 					do {
-						COPY8(op, ip);
-						op +=3D 8;
-						ip +=3D 8;
-						COPY8(op, ip);
-						op +=3D 8;
-						ip +=3D 8;
+						COPY16(op, ip);
+						op +=3D 16;
+						ip +=3D 16;
 					} while (ip < ie);
 					ip =3D ie;
 					op =3D oe;
@@ -187,12 +184,9 @@ int lzo1x_decompress_safe(const unsigned char *in, siz=
e_t in_len,
 			unsigned char *oe =3D op + t;
 			if (likely(HAVE_OP(t + 15))) {
 				do {
-					COPY8(op, m_pos);
-					op +=3D 8;
-					m_pos +=3D 8;
-					COPY8(op, m_pos);
-					op +=3D 8;
-					m_pos +=3D 8;
+					COPY16(op, m_pos);
+					op +=3D 16;
+					m_pos +=3D 16;
 				} while (op < oe);
 				op =3D oe;
 				if (HAVE_IP(6)) {
diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 497f9c9f03a8..e1b3cf6459a9 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -23,6 +23,9 @@
 		COPY4(dst, src); COPY4((dst) + 4, (src) + 4)
 #endif
=20
+#define COPY16(dst, src) \
+	do { COPY8(dst, src); COPY8((dst) + 8, (src) + 8); } while (0)
+
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
 #elif defined(CONFIG_X86_64)
--=20
2.16.4

