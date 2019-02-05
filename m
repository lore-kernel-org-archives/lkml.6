Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE4C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B168217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NbLPQ0Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfBEQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:00:09 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:64858
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729547AbfBEQAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r7rH7FC4ZstT3XJUMVJ3xmdnvAfe5zqWU1gFYLnku8=;
 b=NbLPQ0ApqYHbVq9jqPtFkJdemKRxen7SIbUJwcVN7DxA7KgyUwI3KmD7+pNvHdS6e6OeykZzEGoZ3qiuJ7DVakdGifCDr1iue0VXtIMI5yasIJXnBPWGTeOBYfGTvE4JWYC3iW4JBu4ytRGpFPQGWDWK07rkDljb+EAUNwikXTA=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2191.eurprd08.prod.outlook.com (10.172.12.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 16:00:01 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 16:00:01 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Sealey <Matt.Sealey@arm.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     nd <nd@arm.com>
Subject: [PATCH v5 1/3] lib/lzo: implement run-length encoding
Thread-Topic: [PATCH v5 1/3] lib/lzo: implement run-length encoding
Thread-Index: AQHUvWvZUcf6vOBHxUC4DNnaJrCX5A==
Date:   Tue, 5 Feb 2019 16:00:01 +0000
Message-ID: <20190205155944.16007-2-dave.rodgman@arm.com>
References: <20190205155944.16007-1-dave.rodgman@arm.com>
In-Reply-To: <20190205155944.16007-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2191;6:7M9dSbG1ucc6pD769g7UsETrmTilahSMvMu7z4pyL6BfY0u1H22QUB47IyLZrQvN+xISJfOBZ2NgOasi5Ktc+heFdwXmv7U7wWFIs3e3ik2C0pfxu+D79qXrQHUW1+/812C2+kb3tQXs2pWgv84ZiFU6Yn6ECnEGyCPejlLVU8s0GhHC3h75wF08kAs9wPES5AgpFWxllZf0nBjLAgRs0dGgpor8VGdbeHnkKfCCSd5Xnp17X/RLlVCrFF8hKnVnJ5pAV8ioyHFqYF2WIOSa/5yAv28GVpn/3rs+XoF/ZFSzQvXXsqfKAYQOJILb1eyf256OradAs2Tj12jeL6ETSSWGdh4BK3aPAz8nwfo8izGYYCcqfe9Ng6wOahH0BmbxxldwaPvHvdiRjQPWA0/0M5ufuwYn2+ljEgpYiDueQGKpCCY9H9ZJUnI/B4NRCgTFpU6cAomj4n6gql0oylWUuw==;5:CYw4HM5kr9CnxmgVXepgATYZPqPfZnMT47w8P3cV54wElGgB8g0p+WK7rihg8xasAl86yI2Aa6VWyeimeGo1b8TS/XHN0hHw0HzWehjdBQoM8Ww3kRcADaxQuWh0dV50aJhzc3cY4sk9JQyfeswwlXbWq2ptKN2EEFwd270QMCnzVAQwXbJBSwtVikmoRmvBso4u3V3SjBh+oP1/vjwAQg==;7:m3AWS2rU+XbNsi8EYIl1lAJua+c73oEm2GCrxrYTIQ/0JQYJ9T2wRh5WvsjccBoZCpiiG/+KAsu7qJTC4zaJ/y4YT7BgCbzOmzxLU+dt289i2NBMqig+jit9MSYAtI3aqAZ8RHINenHMyMCo088WNw==
x-ms-office365-filtering-correlation-id: b0b37972-2b35-4c28-e9d2-08d68b82fc05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2191;
x-ms-traffictypediagnostic: VI1PR0802MB2191:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB21915C535A620D71F09CF5DB8F6E0@VI1PR0802MB2191.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(99286004)(110136005)(2501003)(305945005)(11346002)(446003)(4326008)(26005)(186003)(6486002)(6506007)(106356001)(36756003)(386003)(68736007)(2906002)(8676002)(52116002)(105586002)(8936002)(76176011)(81166006)(81156014)(50226002)(486006)(66066001)(53936002)(3846002)(6116002)(1076003)(7416002)(25786009)(30864003)(256004)(97736004)(102836004)(14444005)(478600001)(44832011)(2616005)(316002)(476003)(71190400001)(71200400001)(6436002)(2201001)(14454004)(86362001)(6512007)(7736002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2191;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5BsVEbJbB6pbqehMNEunsU8R4ESrR17x8/sEADWxeHnt5YfBkL531Zc5FKRLyry5w7v/utcq3UdVksiekIgwHlDLsQIBzh27swmm4Zj4B43r8pzwDo4qwRVyCbxarZFsmn9nd6FeOyIlwwZFABI7Y1P68OIHFZAti6dp9AXbSUP8+1/tcyNhFzaRtSdfoJgscyciU8f5iRsxnyXjKT5tB86lsgOTBLsTH/M938k0ZrEIzuzDPZY2jwiLHyTXvjITgf8uvjjJ0SGPoKVG/ER9npTfQG1e79hHAaBzmUbSq6CkU2oAAQhlOZfpjkNq+n0ix5/ABPLjWgemzAsM1ykbhI+vDBQSjFLdf6rFd8xTAS1MPvHvBYRr2dX5dtyY6MN83q8A15pIwYx+DmAdrksIOVQuCaXgWipfkEDUeSIP+QQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b37972-2b35-4c28-e9d2-08d68b82fc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:00:00.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2191
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
index 236eb21167b5..89cd561201ff 100644
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
@@ -88,6 +146,17 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
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
@@ -170,7 +239,6 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
=20
 		m_off =3D ip - m_pos;
 		ip +=3D m_len;
-		ii =3D ip;
 		if (m_len <=3D M2_MAX_LEN && m_off <=3D M2_MAX_OFFSET) {
 			m_off -=3D 1;
 			*op++ =3D (((m_len - 1) << 5) | ((m_off & 7) << 2));
@@ -207,6 +275,9 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
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
@@ -221,6 +292,12 @@ int lzo1x_1_compress(const unsigned char *in, size_t i=
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
@@ -229,7 +306,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
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
@@ -242,7 +320,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
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
index a1c387f6afba..6d2600ea3b55 100644
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
@@ -154,32 +166,49 @@ int lzo1x_decompress_safe(const unsigned char *in, si=
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
index fa0a45fed8c4..ac64159ee344 100644
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
@@ -28,6 +34,7 @@
 #elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
+#define LZO_FAST_64BIT_MEMORY_ACCESS
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >=3D 5)
@@ -37,7 +44,7 @@
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
 #define M3_MAX_OFFSET	0x4000
-#define M4_MAX_OFFSET	0xbfff
+#define M4_MAX_OFFSET	0xbffe
=20
 #define M1_MIN_LEN	2
 #define M1_MAX_LEN	2
@@ -53,6 +60,9 @@
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

