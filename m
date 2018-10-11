Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A892F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A892F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJKSev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:34:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:34:51 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHGTI-1fxLOP1Pqy-00DGMP; Thu, 11 Oct 2018 13:07:17 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHGTI-1fxLOP1Pqy-00DGMP; Thu, 11 Oct 2018 13:07:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ivan Djelic <ivan.djelic@parrot.com>
Subject: [PATCH 2/2] [v2] lib/bch: fix possible stack overrun
Date:   Thu, 11 Oct 2018 13:06:17 +0200
Message-Id: <20181011110639.2649053-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181011110639.2649053-1-arnd@arndb.de>
References: <20181011110639.2649053-1-arnd@arndb.de>
X-Provags-ID: V03:K1:kRfMw9+KH0exXxdrQTRRgqf4YBLnY35RZa99T21k5OJgRvpEiAx
 uGJssXABaKecJWHMO+D1N2V8v85pEFOngBkgtI/By2jeoA1x4ELo0eeqhfLiFgqsjVPKPvm
 uixPKrH7J1UH1A/SOl5h0ORkWxo/iXBYp34xlADPykGRBLf+s9+IvGPpHn7n+w8pjIcc5oy
 vj/yB0jNGWYSbrkJ/Hugw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4E1Qqhf+w2E=:LQjzbtYEaENIL7HdEozUGk
 aiCdLKfF4yZ5o7c9dLQ8QiKWEf35ihk+fgaM0rrFgUCnnJkL63z1C2uL5cecX+R8fDn4y5b8A
 oRTE7EX0Fhwqjr0J/3c5y6u4MJUAu5lhIDqbDL8BlXqRMEKj1WF35yHAtI6ci8LQofqvGdDY4
 SfMNCeE/0EVg1SqMHi0TUwWSe1s9T0AYZssA8CoQmKo0N3Kn0u1dttEIi6JZxkGHuoNWSbNYd
 nV0ZDEdo/2350bESHtcH/tZeBhA0QYbuDnhksoua6RAd1nAJtBXAIaWwXXTPW5mQMofDQJvRH
 lLyhrXDMpCmenY9tNXj2+1grbPOUxwABdQq35Wex1kS658GKhRakO9/Iu7oix30Hs64N+kJtb
 iRDgfClxfq+xjoaJIT6Cjv1tjKbyLgVw+t0NB3lgkuGfZtOrWwK8jQQnaPYnYZD0TG91FonQD
 wA4crqfWPaPQl3fycOg05dWFA+h0dMi9f4IkpILyCAJnRWT8xeinzYQ3fgDX3/BBUtHQU0TdW
 Lp+gXRVHnbtPYxQB8hiyFokIpGQSPFiK6+rrLolQioT8KNHGvN1kTDCtjpANIlIeMu+ESp2M5
 dM9m0IZVgKKttrKWKteWuSMUZlprO8SS+YC8qJHHoPEGVbM70eBKhR52HmEDUYxTNA14F/fX0
 ZTYm6BlHzKwCFqyrLb9H4EZ4lxg+lmKnUauePr/xNTJDXAxygHJXdUXxzz3kg7vmQuQ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch introduced very large kernel stack usage and a Makefile
change to hide the warning about it.

From what I can tell, a number of things went wrong here:

- The BCH_MAX_T constant was set to the maximum value for 'n',
  not the maximum for 't', which is much smaller.

- The stack usage is actually larger than the entire kernel stack
  on some architectures that can use 4KB stacks (m68k, sh, c6x), which
  leads to an immediate overrun.

- The justification in the patch description claimed that nothing
  changed, however that is not the case even without the two points above:
  the configuration is machine specific, and most boards  never use the
  maximum BCH_ECC_WORDS() length but instead have something much smaller.
  That maximum would only apply to machines that use both the maximum
  block size and the maximum ECC strength.

The largest value for 't' that I could find is '32', which in turn leads
to a 60 byte array instead of 2048 bytes. Making it '64' for future
extension seems also worthwhile, with 120 bytes for the array. Anything
larger won't fit into the OOB area on NAND flash.

With that changed, the warning can be enabled again.

Only linux-4.19+ contains the breakage, so this is only needed
as a stable backport if it does not make it into the release.

Fixes: 02361bc77888 ("lib/bch: Remove VLA usage")
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use larget MAX_T, and add a check to init_bch, as suggested
by Boris
---
 lib/Makefile |  1 -
 lib/bch.c    | 17 +++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 37fbf6f23148..a74986ff2f73 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -122,7 +122,6 @@ obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 obj-$(CONFIG_BCH) += bch.o
-CFLAGS_bch.o := $(call cc-option,-Wframe-larger-than=4500)
 obj-$(CONFIG_LZO_COMPRESS) += lzo/
 obj-$(CONFIG_LZO_DECOMPRESS) += lzo/
 obj-$(CONFIG_LZ4_COMPRESS) += lz4/
diff --git a/lib/bch.c b/lib/bch.c
index 7b0f2006698b..5db6d3a4c8a6 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -79,20 +79,19 @@
 #define GF_T(_p)               (CONFIG_BCH_CONST_T)
 #define GF_N(_p)               ((1 << (CONFIG_BCH_CONST_M))-1)
 #define BCH_MAX_M              (CONFIG_BCH_CONST_M)
+#define BCH_MAX_T	       (CONFIG_BCH_CONST_T)
 #else
 #define GF_M(_p)               ((_p)->m)
 #define GF_T(_p)               ((_p)->t)
 #define GF_N(_p)               ((_p)->n)
-#define BCH_MAX_M              15
+#define BCH_MAX_M              15 /* 2KB */
+#define BCH_MAX_T              64 /* 64 bit correction */
 #endif
 
-#define BCH_MAX_T              (((1 << BCH_MAX_M) - 1) / BCH_MAX_M)
-
 #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
 #define BCH_ECC_BYTES(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 8)
 
 #define BCH_ECC_MAX_WORDS      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 32)
-#define BCH_ECC_MAX_BYTES      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 8)
 
 #ifndef dbg
 #define dbg(_fmt, args...)     do {} while (0)
@@ -202,6 +201,9 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	const uint32_t * const tab3 = tab2 + 256*(l+1);
 	const uint32_t *pdata, *p0, *p1, *p2, *p3;
 
+	if (WARN_ON(r_bytes > sizeof(r)))
+		return;
+
 	if (ecc) {
 		/* load ecc parity bytes into internal 32-bit buffer */
 		load_ecc8(bch, bch->ecc_buf, ecc);
@@ -1285,6 +1287,13 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
 		 */
 		goto fail;
 
+	if (t > BCH_MAX_T)
+		/*
+		 * we can support larger than 64 bits if necessary, at the
+		 * cost of higher stack usage.
+		 */
+		goto fail;
+
 	/* sanity checks */
 	if ((t < 1) || (m*t >= ((1 << m)-1)))
 		/* invalid t value */
-- 
2.18.0

