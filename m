Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27052098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AAQ5uCWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27052098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeIQUh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59201 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbeIQUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180917151012euoutp02dd8820f51d37f0514ba0dface302f8ef~VOInxVWj71481614816euoutp02K
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180917151012euoutp02dd8820f51d37f0514ba0dface302f8ef~VOInxVWj71481614816euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537197012;
        bh=lsWZ0ancngmtxX1n3Fse+Ouak7Qymqi/CgLF9OkT1/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAQ5uCWk00cG85kVqA0GLLQFJ6+lEBV6fR2p1Sk0emekRc2nXmNE9wrn9CdbWkxaq
         JDcW/VFbjYKTAvlJsXhGI6Sa45DazC8x/eK89TteWKn0yrks1zXgA7AW0o06fbMEg6
         xJYiPgAuRegnHLPxsXUbXR4QgG6+3f6aA6cw3ne4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180917151012eucas1p115f7426d579c26f975eec3268d531fdd~VOInKw63A2050920509eucas1p1v;
        Mon, 17 Sep 2018 15:10:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.7C.04441.3D3CF9B5; Mon, 17
        Sep 2018 16:10:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c~VOImIjh2C1107511075eucas1p2w;
        Mon, 17 Sep 2018 15:10:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917151010eusmtrp1a5559102b1fa7f04b069f28e58da658f~VOIl2FFqs3069130691eusmtrp1u;
        Mon, 17 Sep 2018 15:10:10 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-13-5b9fc3d339aa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.48.04284.2D3CF9B5; Mon, 17
        Sep 2018 16:10:10 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151010eusmtip221a9e59f473c61164032fe2517f11788~VOIlbOU-F2369023690eusmtip2l;
        Mon, 17 Sep 2018 15:10:10 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 4/4] crypto: s5p-sss: Add aes-ctr support
Date:   Mon, 17 Sep 2018 17:09:30 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7qXD8+PNrjeaG2xccZ6Vovju5cy
        Wsw538Ji0f1KxqJv339Gi/PnN7Bb3L/3k8ni8q45bBYzzu9jsvj/q5nZgctjy8qbTB7bDqh6
        bFrVyebxb+EUFo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGxbmzWArWqFQ0Ny1g
        amC8INvFyMkhIWAi8erXY/YuRi4OIYEVjBKLpi5hA0kICXxhlJjVyAKR+MwocWnrbWaYjntL
        PjBDJJYzSkw93MUO1/FrqiWIzSZgKnH77iegSRwcIgIKEvO+6oCEmQVamCV+reYEsYUFbCRu
        tr9kBLFZBFQlPp95zA4xX07i5rlOsF2cAh4S7//Mgop3s0v8fykOYvMKlEl8bWmCirtIPHp9
        nQXCFpZ4dXwLVFxG4vTkHrAHJASaGSVufbnGCuFMYJQ4uLoLqsNaYtONV0wghzILaEqs36UP
        EXaUWNXUwQoSlhDgk7jxVhDifj6JSdumM0OEeSU62oQgqtUkXm/Zwgaz9sXnr4wQtofElSNH
        oUE1m1Fi7Y5NjBMY5WchLFvAyLiKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMJ2c/nf8
        0w7Gr5eSDjEKcDAq8fAuWDA/Wog1say4MvcQowQHs5IILzMfUIg3JbGyKrUoP76oNCe1+BCj
        NAeLkjgvn1ZatJBAemJJanZqakFqEUyWiYNTqoHRWW1+t5DB/NnqFifXfHBatmrribkxobfL
        lq0NOCqlOi3vlHV+ufHEDwafa50en9dL3j8/JS/79xyNjy7/N64yKlyXt3Ci5WvRSIsHT1mP
        7v830WCCqLJQ6C6FWqaGjEux5/xYFmepn/gVd/1OW/hmN6N78y5+udWdv4OLw231qYWhNw5X
        LHgnq8RSnJFoqMVcVJwIAK9eeGojAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7qXDs+PNpj13Mhi44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2Mi3NnsRSsUaloblrA1MB4QbaLkZNDQsBE4t6SD8wg
        tpDAUkaJlZ28EHEZiXln+9ggbGGJP9e6gGwuoJpPjBLzl/0Ha2ATMJW4ffcTUIKDQ0RAQWLe
        Vx2QGmaBLmaJGU86wJqFBWwkbra/ZASxWQRUJT6fecwOYvMKuEtc+nKECWKBnMTNc51gMzkF
        PCTe/5nFDnGQu8SWqTMYJzDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREY4NuO/dy8
        g/HSxuBDjAIcjEo8vAsWzI8WYk0sK67MPcQowcGsJMLLzAcU4k1JrKxKLcqPLyrNSS0+xGgK
        dNREZinR5Hxg9OWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDU
        01SQW3w1k3tvf8XRqM+3Dm+ou3mHyzHXL7hR1NBVOFTJs/nQ4lrLQJNn5oHKDrqBF43T7uep
        hX8sVNp1hKuUPYNx/zfl/fzM1s2ienrLWSW4L3ku19ipnnG3gGd/wDOfKrayWwLyjz5p8v1f
        rDrNTubdugk6f9dzcusvUTs83crhzUT3rUosxRmJhlrMRcWJANSOd1eGAgAA
Message-Id: <20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c~VOImIjh2C1107511075eucas1p2w@eucas1p2.samsung.com>
X-CMS-MailID: 20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for aes counter(ctr) block cipher mode of operation for
Exynos Hardware. In contrast to ecb and cbc modes, aes-ctr allows
encyption/decryption for request sizes not being a multiple of 16(bytes).

Hardware requires block sizes being a multiple of 16(bytes). In order to
achieve this, copy request source and destination memory, and align it's size
to 16. That way hardware processes additional bytes, that are omitted
when copying the result back to its original destination.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel 4.19-rc2 with crypto
run-time self test testmgr.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/s5p-sss.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index ba8f2e2ea88f..0064be0e3941 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1813,7 +1813,7 @@ static struct ahash_alg algs_sha1_md5_sha256[] = {
 };
 
 static void s5p_set_aes(struct s5p_aes_dev *dev,
-			const u8 *key, const u8 *iv,
+			const u8 *key, const u8 *iv, const u8 *ctr,
 			unsigned int keylen)
 {
 	void __iomem *keystart;
@@ -1821,6 +1821,9 @@ static void s5p_set_aes(struct s5p_aes_dev *dev,
 	if (iv)
 		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_IV_DATA(0), iv, 0x10);
 
+	if (ctr)
+		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_CNT_DATA(0), ctr, 0x10);
+
 	if (keylen == AES_KEYSIZE_256)
 		keystart = dev->aes_ioaddr + SSS_REG_AES_KEY_DATA(0);
 	else if (keylen == AES_KEYSIZE_192)
@@ -1902,8 +1905,9 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	u32 aes_control;
 	unsigned long flags;
 	int err;
-	u8 *iv;
+	u8 *iv, *ctr;
 
+	/* This sets bit [13:12] to 00, which selects 128-bit counter */
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
@@ -1911,11 +1915,14 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
 		iv = req->info;
+		ctr = NULL;
 	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
-		iv = req->info;
+		iv = NULL;
+		ctr = req->info;
 	} else {
 		iv = NULL; /* AES_ECB */
+		ctr = NULL;
 	}
 
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
@@ -1947,7 +1954,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, ctr, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
@@ -2025,7 +2032,8 @@ static int s5p_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 	struct s5p_aes_ctx *ctx = crypto_ablkcipher_ctx(tfm);
 	struct s5p_aes_dev *dev = ctx->dev;
 
-	if (!IS_ALIGNED(req->nbytes, AES_BLOCK_SIZE)) {
+	if (!IS_ALIGNED(req->nbytes, AES_BLOCK_SIZE) &&
+			((mode & FLAGS_AES_MODE_MASK) != FLAGS_AES_CTR)) {
 		dev_err(dev->dev, "request size is not exact amount of AES blocks\n");
 		return -EINVAL;
 	}
@@ -2072,6 +2080,11 @@ static int s5p_aes_cbc_decrypt(struct ablkcipher_request *req)
 	return s5p_aes_crypt(req, FLAGS_AES_DECRYPT | FLAGS_AES_CBC);
 }
 
+static int s5p_aes_ctr_crypt(struct ablkcipher_request *req)
+{
+	return s5p_aes_crypt(req, FLAGS_AES_CTR);
+}
+
 static int s5p_aes_cra_init(struct crypto_tfm *tfm)
 {
 	struct s5p_aes_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -2126,6 +2139,28 @@ static struct crypto_alg algs[] = {
 			.decrypt	= s5p_aes_cbc_decrypt,
 		}
 	},
+	{
+		.cra_name		= "ctr(aes)",
+		.cra_driver_name	= "ctr-aes-s5p",
+		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.cra_blocksize		= AES_BLOCK_SIZE,
+		.cra_ctxsize		= sizeof(struct s5p_aes_ctx),
+		.cra_alignmask		= 0x0f,
+		.cra_type		= &crypto_ablkcipher_type,
+		.cra_module		= THIS_MODULE,
+		.cra_init		= s5p_aes_cra_init,
+		.cra_u.ablkcipher = {
+			.min_keysize	= AES_MIN_KEY_SIZE,
+			.max_keysize	= AES_MAX_KEY_SIZE,
+			.ivsize		= AES_BLOCK_SIZE,
+			.setkey		= s5p_aes_setkey,
+			.encrypt	= s5p_aes_ctr_crypt,
+			.decrypt	= s5p_aes_ctr_crypt,
+		}
+	},
 };
 
 static int s5p_aes_probe(struct platform_device *pdev)
-- 
2.7.4

