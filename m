Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D06C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB372082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b+tv/TpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB372082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeLABgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:36:09 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeLABgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk++C5NZk0LsAH59L/70qEW+pcyBwW0Y2ar9ubJ1d1E=;
 b=b+tv/TpEP/5Dv+iKf8KaGMf/EwiuXOwkDJaBIWJMgfp0tQPfTHO4sHGPWcLjOEAmJ/q3NG9CNzbtmXggHYexntOOkIq7Fyz9JgTasVDFp9m6IltYPENbYSx5lmmYdZZN3RYu2skKqhrpLWpANA+tNmNckWAlkRoGw+hb3R8a4N0=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:30 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:30 +0000
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
Subject: [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
Thread-Topic: [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
Thread-Index: AQHUiLiv6s5Abfp4Ek2DoxSsO/+Ulw==
Date:   Fri, 30 Nov 2018 14:26:30 +0000
Message-ID: <20181130142600.13782-8-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:jnrMlcCHcGeSIW7BdRiyuCrM5Bpp1SbhVRLGimryf+N8IaCBhsLRqUTz5DcI6JogRxT0ts3Tmc5gRjE/aL9WDu/98dG+iDKJrJVAeRay2ItNNcPsln9jVnJWDJMPbapnqxImeO3K9GvefDVHfWk9LCVNxX5zcanyc9dhdmx6Nrq0R3PVvvCWBzqA9rjF1Ja/9t5pY6KIjzAVl/56JwvgttenodLJNdUHhWmITAlXaZYJE/lNxvOviwtlUkTVcGgTqQmsSrxcAbzfdm+BeheQXWdrux2NDIOQTHQbOKpru1MhRQ64wCCyQVW1V1wyg73umfbMhw3fwqUuJ9L/3z1QYu9ySFfqGUeO+kazxaWuFrDtfTlvOBDLnFQZQiLvdBpbscfS1FyZ17bLksWof6L/i5p+JP4FuiW41crw/iqeogAq5TIMk7y1VVs2mpsoUC15Z8y23IBmZgTLnANsK12qhA==;5:UNmdZG6pNpPAJ6RgER62Qjh7fVY28d+W2EWmKRrnzWIM49/9UXFJozvqsefBCif4uRn2c0FUzrDkMsDvZWN3FfvRPvudIhIG8ClSwJnM57zbKS/f1o1ajpbMZMVuW5hS4qgfdQBLPAR22DqGs/9/hquUc+JhH20gaUKFJzGuJe4=;7:z9QBoW8S0sUascwJ9OHTft/+a8HJdxvNX2EwQdJVUuCVEYvtRLmxaJQlvXU3DytyfEhhejqCmwTxjOXjOtp0oG+N40QPEkk53E/oYPDd2SO4bub1YqJ+rp0fSt5SOjLKcKwHsmoO0t9Wr3lXny0Cnw==
x-ms-office365-filtering-correlation-id: d722df57-cff6-4c59-2a06-08d656cfd23a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2415C7D7A5A5FA650EF89C558FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(6306002)(5660300001)(476003)(50226002)(11346002)(486006)(14444005)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(4744004)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(575784001)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(966005)(3846002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vOk1UDo44ggmP2bXpqL+B2xpImmdsG3upDC2zOt9bPLQ/U5OYvVd0T6Wh+D6uK7RzLEuZwejesjWcZIqvcB9/yHxiw62NoHnJeQMccaMu4+ABxYTdG+M/WiN03ZOthgEn+4VlVSux1juXfKDTvjI2VK59UOGO3V3jl/cRFLamMZm+U6QTCiD8DWs0cmIsOxr874HLDrsBSNGmI3QGbQVIKrRCQfOeMdGcj5R7YJCQ3nc+u4T+Oc5VUEgiFaXH6baNMJzbJ4oadqxQPCMljHtVX97LDL+73HtfHsudtI4a4WzHemqxdnsdddoHx9bPka6AoPVuHdRhECpkjLHZj6AnIsQQc+XMZ5/U+06Rurzz9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d722df57-cff6-4c59-2a06-08d656cfd23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:30.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent any issues with persistent data, separate lzo-rle
from lzo so that it is treated as a separate algorithm, and
lzo is still available.

Link: http://lkml.kernel.org/r/20181127161913.23863-8-dave.rodgman@arm.com
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
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 Documentation/lzo.txt      |  12 ++-
 crypto/Makefile            |   2 +-
 crypto/lzo-rle.c           | 175 +++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c            |   4 +-
 drivers/block/zram/zcomp.c |   1 +
 include/linux/lzo.h        |   4 +
 lib/lzo/lzo1x_compress.c   |  42 +++++++--
 lib/lzo/lzodefs.h          |   3 +-
 8 files changed, 226 insertions(+), 17 deletions(-)
 create mode 100644 crypto/lzo-rle.c

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index 306c60344ca7..f79934225d8d 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -88,6 +88,10 @@ length encoding. This improves speed for data with many =
zeros, which is a
 common case for zram. This modifies the bitstream in a backwards compatibl=
e way
 (v1 can correctly decompress v0 compressed data, but v0 cannot read v1 dat=
a).
=20
+For maximum compatibility, both versions are available under different nam=
es
+(lzo and lzo-rle). Differences in the encoding are noted in this document =
with
+e.g.: version 1 only.
+
 Byte sequences
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -99,8 +103,8 @@ Byte sequences
                 invalid at this place.
=20
       17      : bitstream version. If the first byte is 17, the next byte
-                gives the bitstream version. If the first byte is not 17,
-                the bitstream version is 0.
+                gives the bitstream version (version 1 only). If the first=
 byte
+                is not 17, the bitstream version is 0.
=20
       18..21  : copy 0..3 literals
                 state =3D (byte - 17) =3D 0..3  [ copy <state> literals ]
@@ -154,8 +158,8 @@ Byte sequences
            state =3D S (copy S literals after this block)
            End of stream is reached if distance =3D=3D 16384
=20
-        In version 1, this instruction is also used to encode a run of zer=
os if
-        distance =3D 0xbfff, i.e. H =3D 1 and the D bits are all 1.
+        In version 1 only, this instruction is also used to encode a run o=
f
+        zeros if distance =3D 0xbfff, i.e. H =3D 1 and the D bits are all =
1.
            In this case, it is followed by a fourth byte, X.
            run length =3D ((X << 3) | (0 0 0 0 0 L L L)) + 4.
=20
diff --git a/crypto/Makefile b/crypto/Makefile
index 5e789dc2d4fd..23491b70e601 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -127,7 +127,7 @@ obj-$(CONFIG_CRYPTO_CRC32C) +=3D crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) +=3D crc32_generic.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF) +=3D crct10dif_common.o crct10dif_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) +=3D authenc.o authencesn.o
-obj-$(CONFIG_CRYPTO_LZO) +=3D lzo.o
+obj-$(CONFIG_CRYPTO_LZO) +=3D lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) +=3D lz4.o
 obj-$(CONFIG_CRYPTO_LZ4HC) +=3D lz4hc.o
 obj-$(CONFIG_CRYPTO_842) +=3D 842.o
diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
new file mode 100644
index 000000000000..ea9c75b1db49
--- /dev/null
+++ b/crypto/lzo-rle.c
@@ -0,0 +1,175 @@
+/*
+ * Cryptographic API.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/lzo.h>
+#include <crypto/internal/scompress.h>
+
+struct lzorle_ctx {
+	void *lzorle_comp_mem;
+};
+
+static void *lzorle_alloc_ctx(struct crypto_scomp *tfm)
+{
+	void *ctx;
+
+	ctx =3D kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	return ctx;
+}
+
+static int lzorle_init(struct crypto_tfm *tfm)
+{
+	struct lzorle_ctx *ctx =3D crypto_tfm_ctx(tfm);
+
+	ctx->lzorle_comp_mem =3D lzorle_alloc_ctx(NULL);
+	if (IS_ERR(ctx->lzorle_comp_mem))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void lzorle_free_ctx(struct crypto_scomp *tfm, void *ctx)
+{
+	kvfree(ctx);
+}
+
+static void lzorle_exit(struct crypto_tfm *tfm)
+{
+	struct lzorle_ctx *ctx =3D crypto_tfm_ctx(tfm);
+
+	lzorle_free_ctx(NULL, ctx->lzorle_comp_mem);
+}
+
+static int __lzorle_compress(const u8 *src, unsigned int slen,
+			  u8 *dst, unsigned int *dlen, void *ctx)
+{
+	size_t tmp_len =3D *dlen; /* size_t(ulong) <-> uint on 64 bit */
+	int err;
+
+	err =3D lzorle1x_1_compress(src, slen, dst, &tmp_len, ctx);
+
+	if (err !=3D LZO_E_OK)
+		return -EINVAL;
+
+	*dlen =3D tmp_len;
+	return 0;
+}
+
+static int lzorle_compress(struct crypto_tfm *tfm, const u8 *src,
+			unsigned int slen, u8 *dst, unsigned int *dlen)
+{
+	struct lzorle_ctx *ctx =3D crypto_tfm_ctx(tfm);
+
+	return __lzorle_compress(src, slen, dst, dlen, ctx->lzorle_comp_mem);
+}
+
+static int lzorle_scompress(struct crypto_scomp *tfm, const u8 *src,
+			 unsigned int slen, u8 *dst, unsigned int *dlen,
+			 void *ctx)
+{
+	return __lzorle_compress(src, slen, dst, dlen, ctx);
+}
+
+static int __lzorle_decompress(const u8 *src, unsigned int slen,
+			    u8 *dst, unsigned int *dlen)
+{
+	int err;
+	size_t tmp_len =3D *dlen; /* size_t(ulong) <-> uint on 64 bit */
+
+	err =3D lzo1x_decompress_safe(src, slen, dst, &tmp_len);
+
+	if (err !=3D LZO_E_OK)
+		return -EINVAL;
+
+	*dlen =3D tmp_len;
+	return 0;
+}
+
+static int lzorle_decompress(struct crypto_tfm *tfm, const u8 *src,
+			  unsigned int slen, u8 *dst, unsigned int *dlen)
+{
+	return __lzorle_decompress(src, slen, dst, dlen);
+}
+
+static int lzorle_sdecompress(struct crypto_scomp *tfm, const u8 *src,
+			   unsigned int slen, u8 *dst, unsigned int *dlen,
+			   void *ctx)
+{
+	return __lzorle_decompress(src, slen, dst, dlen);
+}
+
+static struct crypto_alg alg =3D {
+	.cra_name		=3D "lzo-rle",
+	.cra_flags		=3D CRYPTO_ALG_TYPE_COMPRESS,
+	.cra_ctxsize		=3D sizeof(struct lzorle_ctx),
+	.cra_module		=3D THIS_MODULE,
+	.cra_init		=3D lzorle_init,
+	.cra_exit		=3D lzorle_exit,
+	.cra_u			=3D { .compress =3D {
+	.coa_compress		=3D lzorle_compress,
+	.coa_decompress		=3D lzorle_decompress } }
+};
+
+static struct scomp_alg scomp =3D {
+	.alloc_ctx		=3D lzorle_alloc_ctx,
+	.free_ctx		=3D lzorle_free_ctx,
+	.compress		=3D lzorle_scompress,
+	.decompress		=3D lzorle_sdecompress,
+	.base			=3D {
+		.cra_name	=3D "lzo-rle",
+		.cra_driver_name =3D "lzo-rle-scomp",
+		.cra_module	 =3D THIS_MODULE,
+	}
+};
+
+static int __init lzorle_mod_init(void)
+{
+	int ret;
+
+	ret =3D crypto_register_alg(&alg);
+	if (ret)
+		return ret;
+
+	ret =3D crypto_register_scomp(&scomp);
+	if (ret) {
+		crypto_unregister_alg(&alg);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void __exit lzorle_mod_fini(void)
+{
+	crypto_unregister_alg(&alg);
+	crypto_unregister_scomp(&scomp);
+}
+
+module_init(lzorle_mod_init);
+module_exit(lzorle_mod_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LZO-RLE Compression Algorithm");
+MODULE_ALIAS_CRYPTO("lzo-rle");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 0590a9204562..c1c56c9771cf 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -76,8 +76,8 @@ static char *check[] =3D {
 	"cast6", "arc4", "michael_mic", "deflate", "crc32c", "tea", "xtea",
 	"khazad", "wp512", "wp384", "wp256", "tnepres", "xeta",  "fcrypt",
 	"camellia", "seed", "salsa20", "rmd128", "rmd160", "rmd256", "rmd320",
-	"lzo", "cts", "sha3-224", "sha3-256", "sha3-384", "sha3-512",
-	"streebog256", "streebog512",
+	"lzo", "lzo-rle", "cts", "sha3-224", "sha3-256", "sha3-384",
+	"sha3-512", "streebog256", "streebog512",
 	NULL
 };
=20
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 4ed0a78fdc09..4d9a38890965 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -20,6 +20,7 @@
=20
 static const char * const backends[] =3D {
 	"lzo",
+	"lzo-rle",
 #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
 	"lz4",
 #endif
diff --git a/include/linux/lzo.h b/include/linux/lzo.h
index 547a86c71e1b..e95c7d1092b2 100644
--- a/include/linux/lzo.h
+++ b/include/linux/lzo.h
@@ -24,6 +24,10 @@
 int lzo1x_1_compress(const unsigned char *src, size_t src_len,
 		     unsigned char *dst, size_t *dst_len, void *wrkmem);
=20
+/* This requires 'wrkmem' of size LZO1X_1_MEM_COMPRESS */
+int lzorle1x_1_compress(const unsigned char *src, size_t src_len,
+		     unsigned char *dst, size_t *dst_len, void *wrkmem);
+
 /* safe decompression with overrun testing */
 int lzo1x_decompress_safe(const unsigned char *src, size_t src_len,
 			  unsigned char *dst, size_t *dst_len);
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 03834b99a5a1..c4384ea14a50 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -20,7 +20,8 @@
 static noinline size_t
 lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		    unsigned char *out, size_t *out_len,
-		    size_t ti, void *wrkmem, signed char *state_offset)
+		    size_t ti, void *wrkmem, signed char *state_offset,
+		    const unsigned char bitstream_version)
 {
 	const unsigned char *ip;
 	unsigned char *op;
@@ -46,7 +47,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 			break;
 		dv =3D get_unaligned_le32(ip);
=20
-		if (dv =3D=3D 0) {
+		if (dv =3D=3D 0 && bitstream_version) {
 			const unsigned char *ir =3D ip + 4;
 			const unsigned char *limit =3D ip_end
 				< (ip + MAX_ZERO_RUN_LENGTH + 1)
@@ -282,30 +283,36 @@ lzo1x_1_do_compress(const unsigned char *in, size_t i=
n_len,
 	return in_end - (ii - ti);
 }
=20
-int lzo1x_1_compress(const unsigned char *in, size_t in_len,
+int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		     unsigned char *out, size_t *out_len,
-		     void *wrkmem)
+		     void *wrkmem, const unsigned char bitstream_version)
 {
 	const unsigned char *ip =3D in;
 	unsigned char *op =3D out;
 	size_t l =3D in_len;
 	size_t t =3D 0;
 	signed char state_offset =3D -2;
+	unsigned int m4_max_offset;
=20
 	// LZO v0 will never write 17 as first byte,
 	// so this is used to version the bitstream
-	*op++ =3D 17;
-	*op++ =3D LZO_VERSION;
+	if (bitstream_version > 0) {
+		*op++ =3D 17;
+		*op++ =3D bitstream_version;
+		m4_max_offset =3D M4_MAX_OFFSET_V1;
+	} else {
+		m4_max_offset =3D M4_MAX_OFFSET_V0;
+	}
=20
 	while (l > 20) {
-		size_t ll =3D l <=3D (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
+		size_t ll =3D l <=3D (m4_max_offset + 1) ? l : (m4_max_offset + 1);
 		uintptr_t ll_end =3D (uintptr_t) ip + ll;
 		if ((ll_end + ((t + ll) >> 5)) <=3D ll_end)
 			break;
 		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
 		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
-		t =3D lzo1x_1_do_compress(ip, ll, op, out_len,
-					t, wrkmem, &state_offset);
+		t =3D lzo1x_1_do_compress(ip, ll, op, out_len, t, wrkmem,
+					&state_offset, bitstream_version);
 		ip +=3D ll;
 		op +=3D *out_len;
 		l  -=3D ll;
@@ -348,7 +355,24 @@ int lzo1x_1_compress(const unsigned char *in, size_t i=
n_len,
 	*out_len =3D op - out;
 	return LZO_E_OK;
 }
+
+int lzo1x_1_compress(const unsigned char *in, size_t in_len,
+		     unsigned char *out, size_t *out_len,
+		     void *wrkmem)
+{
+	return lzogeneric1x_1_compress(in, in_len, out, out_len, wrkmem, 0);
+}
+
+int lzorle1x_1_compress(const unsigned char *in, size_t in_len,
+		     unsigned char *out, size_t *out_len,
+		     void *wrkmem)
+{
+	return lzogeneric1x_1_compress(in, in_len, out, out_len,
+				       wrkmem, LZO_VERSION);
+}
+
 EXPORT_SYMBOL_GPL(lzo1x_1_compress);
+EXPORT_SYMBOL_GPL(lzorle1x_1_compress);
=20
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LZO1X-1 Compressor");
diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 682359058b3c..c0657441a35d 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -52,7 +52,8 @@
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
 #define M3_MAX_OFFSET	0x4000
-#define M4_MAX_OFFSET	0xbffe
+#define M4_MAX_OFFSET_V0	0xbfff
+#define M4_MAX_OFFSET_V1	0xbffe
=20
 #define M1_MIN_LEN	2
 #define M1_MAX_LEN	2
--=20
2.17.1

