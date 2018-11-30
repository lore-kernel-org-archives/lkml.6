Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8976E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EIYiFw8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8976E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeLABgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:36:06 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbeLABgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5Ms4kD92hu+3rJNjxeuHttjhbI+SQvaDNfhlMnm1WU=;
 b=EIYiFw8Bxx46vmPlyrRbW2f0TwqQ9oB0kMrqh1Ius/fod75PTAK3AK7VUCWN6cdSzd/PmYpduAg5J1KdB0rL75m1zqombsPjWbppu8qfd5SH4JbKyD7A6WspxVVCEDDSmrTRtrE9bRdYIMiXa3Mcyj/BxVbKdEhu9GEYZ/R4ZU8=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:29 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:29 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: [PATCH 6/8] lib/lzo: implement run-length encoding
Thread-Topic: [PATCH 6/8] lib/lzo: implement run-length encoding
Thread-Index: AQHUiLivBfwIBj8HI0am5CIsX1zArw==
Date:   Fri, 30 Nov 2018 14:26:29 +0000
Message-ID: <20181130142600.13782-7-dave.rodgman@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWLP265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::36) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:SL5258A3M9qoOLf53bWXbcMckcDCBDUNptMxTIx7YBt2div0+pi6svH3dmqgapuu0BGNnTT1B4ICl3n24t1BzmSSSW1xB7GAAUTQHtxe3FdjLE9qX3BdmSDDDBlntOt6CL4B/f+MIp5BRK8rIDH5Kwnx7B4BJR1KDDHkpivCX9jLI1lFfnukgC2I2xL3etQJ7t9gUwPyAL/HJAh487KVFKjuMwQ7QiSc9R24KJxNKuFRDKZzHjftsTAWLEh9jJcfyItOQDPVF5u5vV/hXa8iFh3RjumTX893l5FISPmhiB5eD2fPV8VN1OOihkkB6Fh7zGms1ikRDFH2Gw4PqLWe6PJKcYvgKnJiVFnMpsKiKtwVcwyasM7lU4bSYkq3ygdsuMgk34kRKjA5rJ6e+oYbbOeEvC0EAhUu5YQqH1ROEnIOkYao1vF1YsTUbz/VxhNWsR8hLCwYGz8V0wqMxGQsSQ==;5:juEk9E4R8jnYFu8/hXK4mVdjHNF/zfb5XASLlYTqyrZ26hUOaFXCXdEGC1CRhucIkzIVcocOWCbSJd9YwO7zgadUnNCq1cds/3ozPKiqNcWRspFph3NuUh5ek5wwOLnN+kABJ/3jrEHwIm6yba2KE59NVqSxlf3E33WikRDC/Tg=;7:SkcOBkxzCB4Gs4kj2tFI3+0uubR0lmLc4NnglcRbPRMJs+Cajt6GM3GnGgAUK/HCQVop50fZRjUFzTDk2zPfi+ChD+W8h3BI63p3MeDIxt8fYQ4xAKdF5YJ0aT2IimIt37YxVxirWxwI+kvHUV5VwQ==
x-ms-office365-filtering-correlation-id: 0d9a4d2d-6a4f-4dcc-6112-08d656cfd181
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB24152846B85BA5CF077F1D788FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(6306002)(5660300001)(476003)(50226002)(11346002)(486006)(14444005)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(4744004)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(575784001)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(966005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pCKH9L3pPZEwJKgJuqyPdje5JTeY15tKWLKV9rZNArp2NiMoJwfaAJdV3bgFPp+axZFIpi6T8Gt2l54qGYIti1DdW1vCwkIri5SJj6hae9/Sv2Ua6NV6LvticatxzY0UMqht8VBovs6dUasoABSWXCtplmDW/RQ1KFLrPZC/mE38Lz6g0x50YyhI8pcqX0+be6YuPfcuseUSZbKOt8hbj1ZTkiANnIzJnR5xscOv+zE+aJSN6zNExbDM399i0pZj5EX8N5/uTBhlm4NzpJLvEXzttgkAi0VCBNA7UM+k9S+OjlZ30x6iixe2JobGGmgQM4URJ7DfaQj4/KCE+RZNRthzicqwUJuepuRLLMjalBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a4d2d-6a4f-4dcc-6112-08d656cfd181
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:29.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using zram, we frequently encounter long runs of zero bytes.
This adds a special case which identifies runs of zeros and encodes
them using run-length encoding.

This is faster for both compression and decompresion. For
high-entropy data which doesn't hit this case, impact is minimal.

Compression ratio is within a few percent in all cases.

This modifies the bitstream in a way which is backwards compatible
(i.e., we can decompress old bitstreams, but old versions of lzo
cannot decompress new bitstreams).

Link: http://lkml.kernel.org/r/20181127161913.23863-7-dave.rodgman@arm.com
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
Cc: Matt Sealey <matt.sealey@arm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <nitingupta910@gmail.com>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sonny Rao <sonnyrao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/lzo.txt           |  35 ++++++++---
 include/linux/lzo.h             |   2 +-
 lib/lzo/lzo1x_compress.c        | 100 ++++++++++++++++++++++++++++----
 lib/lzo/lzo1x_decompress_safe.c |  75 ++++++++++++++++--------
 lib/lzo/lzodefs.h               |  12 +++-
 5 files changed, 181 insertions(+), 43 deletions(-)

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index 6fa6a93d0949..306c60344ca7 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -78,16 +78,30 @@ Description
      is an implementation design choice independent on the algorithm or
      encoding.
=20
+Versions
+
+0: Original version
+1: LZO-RLE
+
+Version 1 of LZO implements an extension to encode runs of zeros using run
+length encoding. This improves speed for data with many zeros, which is a
+common case for zram. This modifies the bitstream in a backwards compatibl=
e way
+(v1 can correctly decompress v0 compressed data, but v0 cannot read v1 dat=
a).
+
 Byte sequences
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
   First byte encoding::
=20
-      0..17   : follow regular instruction encoding, see below. It is wort=
h
-                noting that codes 16 and 17 will represent a block copy fr=
om
-                the dictionary which is empty, and that they will always b=
e
+      0..16   : follow regular instruction encoding, see below. It is wort=
h
+                noting that code 16 will represent a block copy from the
+                dictionary which is empty, and that it will always be
                 invalid at this place.
=20
+      17      : bitstream version. If the first byte is 17, the next byte
+                gives the bitstream version. If the first byte is not 17,
+                the bitstream version is 0.
+
       18..21  : copy 0..3 literals
                 state =3D (byte - 17) =3D 0..3  [ copy <state> literals ]
                 skip byte
@@ -140,6 +154,11 @@ Byte sequences
            state =3D S (copy S literals after this block)
            End of stream is reached if distance =3D=3D 16384
=20
+        In version 1, this instruction is also used to encode a run of zer=
os if
+        distance =3D 0xbfff, i.e. H =3D 1 and the D bits are all 1.
+           In this case, it is followed by a fourth byte, X.
+           run length =3D ((X << 3) | (0 0 0 0 0 L L L)) + 4.
+
       0 0 1 L L L L L  (32..63)
            Copy of small block within 16kB distance (preferably less than =
34B)
            length =3D 2 + (L ?: 31 + (zero_bytes * 255) + non_zero_byte)
@@ -165,7 +184,9 @@ Authors
 =3D=3D=3D=3D=3D=3D=3D
=20
   This document was written by Willy Tarreau <w@1wt.eu> on 2014/07/19 duri=
ng an
-  analysis of the decompression code available in Linux 3.16-rc5. The code=
 is
-  tricky, it is possible that this document contains mistakes or that a fe=
w
-  corner cases were overlooked. In any case, please report any doubt, fix,=
 or
-  proposed updates to the author(s) so that the document can be updated.
+  analysis of the decompression code available in Linux 3.16-rc5, and upda=
ted
+  by Dave Rodgman <dave.rodgman@arm.com> on 2018/10/30 to introduce run-le=
ngth
+  encoding. The code is tricky, it is possible that this document contains
+  mistakes or that a few corner cases were overlooked. In any case, please
+  report any doubt, fix, or proposed updates to the author(s) so that the
+  document can be updated.
diff --git a/include/linux/lzo.h b/include/linux/lzo.h
index 2ae27cb89927..547a86c71e1b 100644
--- a/include/linux/lzo.h
+++ b/include/linux/lzo.h
@@ -18,7 +18,7 @@
 #define LZO1X_1_MEM_COMPRESS	(8192 * sizeof(unsigned short))
 #define LZO1X_MEM_COMPRESS	LZO1X_1_MEM_COMPRESS
=20
-#define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3)
+#define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
=20
 /* This requires 'wrkmem' of size LZO1X_1_MEM_COMPRESS */
 int lzo1x_1_compress(const unsigned char *src, size_t src_len,
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 82fb5571ce5e..03834b99a5a1 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -20,7 +20,7 @@
 static noinline size_t
 lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		    unsigned char *out, size_t *out_len,
-		    size_t ti, void *wrkmem)
+		    size_t ti, void *wrkmem, signed char *state_offset)
 {
 	const unsigned char *ip;
 	unsigned char *op;
@@ -35,27 +35,85 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 	ip +=3D ti < 4 ? 4 - ti : 0;
=20
 	for (;;) {
-		const unsigned char *m_pos;
+		const unsigned char *m_pos =3D NULL;
 		size_t t, m_len, m_off;
 		u32 dv;
+		u32 run_length =3D 0;
 literal:
 		ip +=3D 1 + ((ip - ii) >> 5);
 next:
 		if (unlikely(ip >=3D ip_end))
 			break;
 		dv =3D get_unaligned_le32(ip);
-		t =3D ((dv * 0x1824429d) >> (32 - D_BITS)) & D_MASK;
-		m_pos =3D in + dict[t];
-		dict[t] =3D (lzo_dict_t) (ip - in);
-		if (unlikely(dv !=3D get_unaligned_le32(m_pos)))
-			goto literal;
+
+		if (dv =3D=3D 0) {
+			const unsigned char *ir =3D ip + 4;
+			const unsigned char *limit =3D ip_end
+				< (ip + MAX_ZERO_RUN_LENGTH + 1)
+				? ip_end : ip + MAX_ZERO_RUN_LENGTH + 1;
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
+	defined(LZO_FAST_64BIT_MEMORY_ACCESS)
+			u64 dv64;
+
+			for (; (ir + 32) <=3D limit; ir +=3D 32) {
+				dv64 =3D get_unaligned((u64 *)ir);
+				dv64 |=3D get_unaligned((u64 *)ir + 1);
+				dv64 |=3D get_unaligned((u64 *)ir + 2);
+				dv64 |=3D get_unaligned((u64 *)ir + 3);
+				if (dv64)
+					break;
+			}
+			for (; (ir + 8) <=3D limit; ir +=3D 8) {
+				dv64 =3D get_unaligned((u64 *)ir);
+				if (dv64) {
+#  if defined(__LITTLE_ENDIAN)
+					ir +=3D __builtin_ctzll(dv64) >> 3;
+#  elif defined(__BIG_ENDIAN)
+					ir +=3D __builtin_clzll(dv64) >> 3;
+#  else
+#    error "missing endian definition"
+#  endif
+					break;
+				}
+			}
+#else
+			while ((ir < (const unsigned char *)
+					ALIGN((uintptr_t)ir, 4)) &&
+					(ir < limit) && (*ir =3D=3D 0))
+				ir++;
+			for (; (ir + 4) <=3D limit; ir +=3D 4) {
+				dv =3D *((u32 *)ir);
+				if (dv) {
+#  if defined(__LITTLE_ENDIAN)
+					ir +=3D __builtin_ctz(dv) >> 3;
+#  elif defined(__BIG_ENDIAN)
+					ir +=3D __builtin_clz(dv) >> 3;
+#  else
+#    error "missing endian definition"
+#  endif
+					break;
+				}
+			}
+#endif
+			while (likely(ir < limit) && unlikely(*ir =3D=3D 0))
+				ir++;
+			run_length =3D ir - ip;
+			if (run_length > MAX_ZERO_RUN_LENGTH)
+				run_length =3D MAX_ZERO_RUN_LENGTH;
+		} else {
+			t =3D ((dv * 0x1824429d) >> (32 - D_BITS)) & D_MASK;
+			m_pos =3D in + dict[t];
+			dict[t] =3D (lzo_dict_t) (ip - in);
+			if (unlikely(dv !=3D get_unaligned_le32(m_pos)))
+				goto literal;
+		}
=20
 		ii -=3D ti;
 		ti =3D 0;
 		t =3D ip - ii;
 		if (t !=3D 0) {
 			if (t <=3D 3) {
-				op[-2] |=3D t;
+				op[*state_offset] |=3D t;
 				COPY4(op, ii);
 				op +=3D t;
 			} else if (t <=3D 16) {
@@ -86,6 +144,17 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 			}
 		}
=20
+		if (unlikely(run_length)) {
+			ip +=3D run_length;
+			run_length -=3D MIN_ZERO_RUN_LENGTH;
+			put_unaligned_le32((run_length << 21) | 0xfffc18
+					   | (run_length & 0x7), op);
+			op +=3D 4;
+			run_length =3D 0;
+			*state_offset =3D -3;
+			goto finished_writing_instruction;
+		}
+
 		m_len =3D 4;
 		{
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ=
64)
@@ -168,7 +237,6 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
=20
 		m_off =3D ip - m_pos;
 		ip +=3D m_len;
-		ii =3D ip;
 		if (m_len <=3D M2_MAX_LEN && m_off <=3D M2_MAX_OFFSET) {
 			m_off -=3D 1;
 			*op++ =3D (((m_len - 1) << 5) | ((m_off & 7) << 2));
@@ -205,6 +273,9 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 			*op++ =3D (m_off << 2);
 			*op++ =3D (m_off >> 6);
 		}
+		*state_offset =3D -2;
+finished_writing_instruction:
+		ii =3D ip;
 		goto next;
 	}
 	*out_len =3D op - out;
@@ -219,6 +290,12 @@ int lzo1x_1_compress(const unsigned char *in, size_t i=
n_len,
 	unsigned char *op =3D out;
 	size_t l =3D in_len;
 	size_t t =3D 0;
+	signed char state_offset =3D -2;
+
+	// LZO v0 will never write 17 as first byte,
+	// so this is used to version the bitstream
+	*op++ =3D 17;
+	*op++ =3D LZO_VERSION;
=20
 	while (l > 20) {
 		size_t ll =3D l <=3D (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
@@ -227,7 +304,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
_len,
 			break;
 		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
 		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
-		t =3D lzo1x_1_do_compress(ip, ll, op, out_len, t, wrkmem);
+		t =3D lzo1x_1_do_compress(ip, ll, op, out_len,
+					t, wrkmem, &state_offset);
 		ip +=3D ll;
 		op +=3D *out_len;
 		l  -=3D ll;
@@ -240,7 +318,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
_len,
 		if (op =3D=3D out && t <=3D 238) {
 			*op++ =3D (17 + t);
 		} else if (t <=3D 3) {
-			op[-2] |=3D t;
+			op[state_offset] |=3D t;
 		} else if (t <=3D 18) {
 			*op++ =3D (t - 3);
 		} else {
diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_saf=
e.c
index aa95d3066b7d..b8f88d5ea3ff 100644
--- a/lib/lzo/lzo1x_decompress_safe.c
+++ b/lib/lzo/lzo1x_decompress_safe.c
@@ -46,11 +46,23 @@ int lzo1x_decompress_safe(const unsigned char *in, size=
_t in_len,
 	const unsigned char * const ip_end =3D in + in_len;
 	unsigned char * const op_end =3D out + *out_len;
=20
+	unsigned char bitstream_version;
+
 	op =3D out;
 	ip =3D in;
=20
 	if (unlikely(in_len < 3))
 		goto input_overrun;
+
+	if (likely(*ip =3D=3D 17)) {
+		bitstream_version =3D ip[1];
+		ip +=3D 2;
+		if (unlikely(in_len < 5))
+			goto input_overrun;
+	} else {
+		bitstream_version =3D 0;
+	}
+
 	if (*ip > 17) {
 		t =3D *ip++ - 17;
 		if (t < 4) {
@@ -151,32 +163,49 @@ int lzo1x_decompress_safe(const unsigned char *in, si=
ze_t in_len,
 			m_pos -=3D next >> 2;
 			next &=3D 3;
 		} else {
-			m_pos =3D op;
-			m_pos -=3D (t & 8) << 11;
-			t =3D (t & 7) + (3 - 1);
-			if (unlikely(t =3D=3D 2)) {
-				size_t offset;
-				const unsigned char *ip_last =3D ip;
+			NEED_IP(2);
+			next =3D get_unaligned_le16(ip);
+			if (((next & 0xfffc) =3D=3D 0xfffc) &&
+			    ((t & 0xf8) =3D=3D 0x18) &&
+			    likely(bitstream_version)) {
+				NEED_IP(3);
+				t &=3D 7;
+				t |=3D ip[2] << 3;
+				t +=3D MIN_ZERO_RUN_LENGTH;
+				NEED_OP(t);
+				memset(op, 0, t);
+				op +=3D t;
+				next &=3D 3;
+				ip +=3D 3;
+				goto match_next;
+			} else {
+				m_pos =3D op;
+				m_pos -=3D (t & 8) << 11;
+				t =3D (t & 7) + (3 - 1);
+				if (unlikely(t =3D=3D 2)) {
+					size_t offset;
+					const unsigned char *ip_last =3D ip;
=20
-				while (unlikely(*ip =3D=3D 0)) {
-					ip++;
-					NEED_IP(1);
-				}
-				offset =3D ip - ip_last;
-				if (unlikely(offset > MAX_255_COUNT))
-					return LZO_E_ERROR;
+					while (unlikely(*ip =3D=3D 0)) {
+						ip++;
+						NEED_IP(1);
+					}
+					offset =3D ip - ip_last;
+					if (unlikely(offset > MAX_255_COUNT))
+						return LZO_E_ERROR;
=20
-				offset =3D (offset << 8) - offset;
-				t +=3D offset + 7 + *ip++;
-				NEED_IP(2);
+					offset =3D (offset << 8) - offset;
+					t +=3D offset + 7 + *ip++;
+					NEED_IP(2);
+					next =3D get_unaligned_le16(ip);
+				}
+				ip +=3D 2;
+				m_pos -=3D next >> 2;
+				next &=3D 3;
+				if (m_pos =3D=3D op)
+					goto eof_found;
+				m_pos -=3D 0x4000;
 			}
-			next =3D get_unaligned_le16(ip);
-			ip +=3D 2;
-			m_pos -=3D next >> 2;
-			next &=3D 3;
-			if (m_pos =3D=3D op)
-				goto eof_found;
-			m_pos -=3D 0x4000;
 		}
 		TEST_LB(m_pos);
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 06fa83a38e0a..682359058b3c 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -13,6 +13,12 @@
  */
=20
=20
+/* Version
+ * 0: original lzo version
+ * 1: lzo with support for RLE
+ */
+#define LZO_VERSION 1
+
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
 #if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
@@ -31,6 +37,7 @@
 #elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
+#define LZO_FAST_64BIT_MEMORY_ACCESS
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_ARM)
@@ -45,7 +52,7 @@
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
 #define M3_MAX_OFFSET	0x4000
-#define M4_MAX_OFFSET	0xbfff
+#define M4_MAX_OFFSET	0xbffe
=20
 #define M1_MIN_LEN	2
 #define M1_MAX_LEN	2
@@ -61,6 +68,9 @@
 #define M3_MARKER	32
 #define M4_MARKER	16
=20
+#define MIN_ZERO_RUN_LENGTH	4
+#define MAX_ZERO_RUN_LENGTH	(2047 + MIN_ZERO_RUN_LENGTH)
+
 #define lzo_dict_t      unsigned short
 #define D_BITS		13
 #define D_SIZE		(1u << D_BITS)
--=20
2.17.1

