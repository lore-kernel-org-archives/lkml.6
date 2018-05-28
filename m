Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165480AbeE1NjN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:39:13 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50960 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162988AbeE1NjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:39:09 -0400
To: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>
Subject: [PATCH 1/5] scsi: ufs: Add crypto source file for UFS HC driver
CC: <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org;Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <2dbe91ed-e3ed-e5bb-7f38-c5cf571494d5@synopsys.com>
Date: Mon, 28 May 2018 14:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.144.133.104]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch facilitates XTS algorithm based Inline Encryption
to the UFS Host Controller driver. It uses Linux Kernel
Cryptography Framework(LKCF). This patch provides functions
for resource allocation, inline encryption engine initialization,
preparing the local reference block for crypto operation,
management of key slots, hardware key programming, querying the
hardware capability, registration of algorithm etc.

Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
---
 drivers/scsi/ufs/ufshcd-crypto.c | 520 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 520 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c

diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 0000000..297f7fa
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Universal Flash Storage Host controller driver crypto
+ *
+ * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors:
+ *      Manjunath M Bettegowda <manjumb@synopsys.com>,
+ *      Ladvine D Almeida <ladvine@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "ufshcd.h"
+#include "unipro.h"
+
+#include "ufshcd-dwc.h"
+#include "ufshcd-crypto.h"
+
+static struct ufs_hba *g_ufs_hba;
+static DEFINE_SPINLOCK(hw_lock);
+
+static void ufshcd_query_xts_ccaps(struct ufshcd_xts_ctx *ctx);
+static void ufshcd_calculate_keyhash(const u8 *key,
+		unsigned int keylen, u8 *keyhash);
+static bool ufshcd_find_keycfgidx(struct ufshcd_xts_ctx *ctx,
+		const u8 *key, int cap_idx);
+static int ufshcd_find_keycapidx(struct ufshcd_xts_ctx *ctx,
+		unsigned int keylen);
+static void ufshcd_program_xtskey(struct ufshcd_xts_ctx *ctx,
+		const u8 *key, int cap_idx);
+
+/**
+ * ufshcd_crypto_memory_alloc - allocate memory required for
+ * crypto configuration.
+ * @hba: per-adapter interface
+ * Returns 0 on success, non-zero value on failure
+ */
+int ufshcd_crypto_memory_alloc(struct ufs_hba *hba)
+{
+	hba->cc.ccfg = kcalloc(hba->cc.ccfg_count,
+			sizeof(struct ufshcd_x_cryptocfg), GFP_KERNEL);
+	if (!hba->cc.ccfg)
+		goto err_ccfgxp_alloc;
+	hba->ccxp = kcalloc(hba->cc.ccap_count,
+			sizeof(struct ufshcd_x_crypto_cap), GFP_KERNEL);
+	if (!hba->ccxp)
+		goto err_ccapxp_alloc;
+	return 0;
+
+err_ccapxp_alloc:
+	kfree(hba->cc.ccfg);
+err_ccfgxp_alloc:
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(ufshcd_crypto_memory_alloc);
+
+/**
+ * ufshcd_remove_crypto_memory - free allocated
+ * crypto memory
+ * @hba: per-adapter interface
+ */
+void ufshcd_remove_crypto_memory(struct ufs_hba *hba)
+{
+	kfree(hba->ccxp);
+	kfree(hba->cc.ccfg);
+}
+EXPORT_SYMBOL(ufshcd_remove_crypto_memory);
+
+/**
+ * ufshcd_read_crypto_capabilities - check for the crypto
+ * capabilities in hardware
+ * @hba: per-adapter interface
+ */
+void ufshcd_read_crypto_capabilities(struct ufs_hba *hba)
+{
+	u32 reg_data = 0;
+
+	if (ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES) &
+			MASK_CRYPTO_SUPPORT) {
+		hba->caps |= UFSHCD_CAP_INLINE_ENCRYPTION;
+		reg_data = ufshcd_readl(hba, REG_UFS_CCAP);
+		hba->cc.ccfg_count = (reg_data & UFSHCD_CFGC_MASK) >>
+			UFSHCD_CFGC_SHIFT;
+		hba->cc.ccap_count = reg_data & UFSHCD_CC_MASK;
+	}
+	if (unlikely(!hba->cc.ccfg_count) ||
+			unlikely(!hba->cc.ccap_count))
+		hba->caps &= ~UFSHCD_CAP_INLINE_ENCRYPTION;
+	pr_debug("%s: Max Caps Supported : %03d, Max Configs Supported : %03d\n",
+			__func__, hba->cc.ccap_count, (hba->cc.ccfg_count + 1));
+}
+EXPORT_SYMBOL(ufshcd_read_crypto_capabilities);
+
+/**
+ * ufshcd_query_xts_ccaps - query for xts crypto capabilities
+ * in hardware.
+ * @ctx: ufshcd xts algorithm context
+ */
+static void ufshcd_query_xts_ccaps(struct ufshcd_xts_ctx *ctx)
+{
+	u32 caps = 0, key_size_idx = 0;
+	int cap_idx = 0;
+	struct ufs_hba *hba = g_ufs_hba;
+
+	ctx->key_cap_idx = kmalloc_array(UFSHCD_KS_MAX,
+			sizeof(*ctx->key_cap_idx), GFP_KERNEL);
+	if (!ctx->key_cap_idx)
+		return;
+	memset(ctx->key_cap_idx, -EINVAL,
+			UFSHCD_KS_MAX*sizeof(*ctx->key_cap_idx));
+
+	for (cap_idx = 0; cap_idx < hba->cc.ccap_count;
+			cap_idx++) {
+		caps = ufshcd_readl(hba,
+				REG_UFS_CRYPTOCAP + (cap_idx * 4));
+		if ((caps & UFSHCD_ALGID_MASK) != UFSHCD_AES_XTS)
+			continue;
+		key_size_idx = (caps & UFSHCD_KS_MASK) >>
+			UFSHCD_KS_SHIFT;
+		ctx->key_cap_idx[key_size_idx] = cap_idx;
+	}
+}
+
+/**
+ * ufshcd_prepare_for_crypto - prepare block buffer for
+ * crypto operation
+ * @hba: per-adapter interface
+ * @lrbp: pointer to local reference block
+ */
+void ufshcd_prepare_for_crypto(struct ufs_hba *hba,
+		struct ufshcd_lrb *lrbp)
+{
+	struct crypto_skcipher *skcipher_tfm;
+	struct crypto_blkcipher **blkcipher_ctx;
+	struct ufshcd_x_cryptocfg *p_crypt_cfg =
+		hba->cc.ccfg;
+	struct ufshcd_xts_ctx *ctx;
+	struct bio *bio = lrbp->cmd->request->bio;
+	int active_cfg_idx = -1, cap_idx;
+
+	if (unlikely(!bio))
+		return;
+
+	spin_lock(&hw_lock);
+	if ((bio->bi_opf & REQ_INLINE_ENCRYPTION)
+			&& hba->cc.ccap_en) {
+		switch (lrbp->cmd->cmnd[0]) {
+		case READ_6:
+		case READ_10:
+		case READ_16:
+		case WRITE_6:
+		case WRITE_10:
+		case WRITE_16:
+			lrbp->lba = scsi_get_lba(lrbp->cmd);
+			if (bio->bi_ie_private != NULL) {
+				skcipher_tfm =
+					bio->bi_ie_private;
+				blkcipher_ctx =
+					crypto_tfm_ctx(&skcipher_tfm->base);
+				ctx = crypto_blkcipher_ctx(*blkcipher_ctx);
+				active_cfg_idx =  ctx->active_ccfg_idx;
+				if (memcmp((p_crypt_cfg+active_cfg_idx)
+					->ckey_hash, ctx->cipher_keyhash,
+						SHA1_LENGTH)) {
+					cap_idx = ufshcd_find_keycapidx(ctx,
+						ctx->keylen);
+					ufshcd_program_xtskey(ctx,
+						ctx->cipher_key, cap_idx);
+				}
+				lrbp->ccfg_idx = active_cfg_idx;
+			}
+			break;
+		default:
+			break;
+		};
+	}
+	spin_unlock(&hw_lock);
+	mb(); /* make sure key programming is completed here */
+}
+EXPORT_SYMBOL(ufshcd_prepare_for_crypto);
+
+/**
+ * ufshcd_calculate_keyhash - compute hash value of key
+ * @key: key value
+ * @keylen: key length
+ * @keyhash: key hash value
+ */
+static void ufshcd_calculate_keyhash(const u8 *key, unsigned int keylen,
+		u8 *keyhash)
+{
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct crypto_wait wait;
+	struct crypto_ahash *tfm;
+	int ret = 0;
+
+	tfm  = crypto_alloc_ahash("sha1", 0, 0);
+	if (IS_ERR(tfm))
+		return;
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto err_req_alloc;
+
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+			crypto_req_done, &wait);
+	sg_init_one(&sg, key, keylen);
+	ahash_request_set_crypt(req, &sg, keyhash, keylen);
+	ret = crypto_ahash_digest(req);
+	if (ret)
+		goto err_hash_op;
+	ret = crypto_wait_req(ret, &wait);
+	if (ret)
+		goto err_hash_op;
+
+	/* free transformation once the operation is
+	 * completed.
+	 */
+err_hash_op:
+	ahash_request_free(req);
+err_req_alloc:
+	crypto_free_ahash(tfm);
+}
+
+/**
+ * ufshcd_find_keycfgidx - find key configuration index
+ * to be used
+ * @ctx: crypto transformation context
+ * @key: key value
+ * @cap_idx: capability index
+ * Return true if match found, else false.
+ */
+static bool ufshcd_find_keycfgidx(struct ufshcd_xts_ctx *ctx,
+		const u8 *key, int cap_idx)
+{
+	struct ufs_hba *hba = g_ufs_hba;
+	struct ufshcd_x_cryptocfg *p_crypt_cfg =
+		hba->cc.ccfg;
+	bool found_match = false;
+	int cfg_idx = 0;
+
+	for (cfg_idx = 0; cfg_idx < hba->cc.activecfg_count; cfg_idx++) {
+		if (cap_idx == (p_crypt_cfg+cfg_idx)->ccap_idx &&
+				!memcmp((p_crypt_cfg+cfg_idx)->ckey_hash,
+					ctx->cipher_keyhash, SHA1_LENGTH)) {
+			found_match = true;
+			break;
+		}
+	}
+	if (found_match == false) {
+		ctx->active_ccfg_idx =
+			hba->cc.activecfg_count % hba->cc.ccfg_count;
+		hba->cc.activecfg_count++;
+	} else
+		ctx->active_ccfg_idx = cfg_idx;
+
+	return found_match;
+}
+
+/**
+ * ufshcd_find_keycapidx - find capability index for the key used.
+ * @ctx: crypto transformation context
+ * @keylen: key length value
+ * Returns capability index value.
+ */
+static int ufshcd_find_keycapidx(struct ufshcd_xts_ctx *ctx,
+		unsigned int keylen)
+{
+	int cap_idx = -EINVAL;
+
+	if (unlikely(!ctx->key_cap_idx))
+		return PTR_ERR(ctx->key_cap_idx);
+
+	switch (keylen) {
+	case AES_KEYSIZE_128 * 2:
+		cap_idx = ctx->key_cap_idx[UFSHCD_KS_128];
+		break;
+	case AES_KEYSIZE_192 * 2:
+		cap_idx = ctx->key_cap_idx[UFSHCD_KS_192];
+		break;
+	case AES_KEYSIZE_256 * 2:
+		cap_idx = ctx->key_cap_idx[UFSHCD_KS_256];
+		break;
+	};
+	return cap_idx;
+}
+
+/**
+ * ufshcd_program_xtskey - program the encryption key in
+ * hardware
+ * @ctx: crypto transformation context
+ * @key: key value
+ * @cap_idx: capability index
+ */
+static void ufshcd_program_xtskey(struct ufshcd_xts_ctx *ctx,
+		const u8 *key, int cap_idx)
+{
+	struct ufs_hba *hba = g_ufs_hba;
+	struct ufshcd_x_cryptocfg *p_crypt_cfg =
+		hba->cc.ccfg;
+	u32 reg_val = 0, ccfgp_base = 0;
+	u32 dword_0_15 = 0, dword_16 = 0;
+	int index;
+	int i = 0;
+	u8 ckey[64] = {};
+
+	index = ctx->active_ccfg_idx;
+	memcpy(ckey, key, ctx->keylen/2);
+	memcpy(ckey+32, key+ctx->keylen/2, ctx->keylen/2);
+	memcpy((p_crypt_cfg+index)->ckey_hash,
+			ctx->cipher_keyhash, SHA1_LENGTH);
+	(p_crypt_cfg+index)->ccap_idx = cap_idx;
+	/* Data Unit size is Sector size of 512 bytes */
+	(p_crypt_cfg+index)->dus_mask = UFSHCD_DUSIZE_512;
+	(p_crypt_cfg+index)->ccfg_en  = true;
+
+	reg_val = ufshcd_readl(hba, REG_UFS_CCAP);
+	ccfgp_base = ((((reg_val & UFSHCD_CFGPTR_MASK) >> UFSHCD_CFGPTR_SHIFT)*
+				XCRYPTOCFG_PTR_OFFSET) +
+			(index * XCRYPTOCFG_SIZE));
+	/* disable configuration before programming key */
+	ufshcd_writel(hba, 0U, (ccfgp_base + XCRYPTOCFG_DW16_OFFSET));
+
+	/* Program the key */
+	for (i = 0; i < 64; i += 4) {
+		dword_0_15 = ((ckey[i+3] << 24) | (ckey[i+2] << 16) |
+				(ckey[i+1] << 8) | (ckey[i+0]));
+		ufshcd_writel(hba, dword_0_15,
+				(ccfgp_base + i + XCRYPTOCFG_KEYS_OFFSET));
+	}
+	/* Program DWORD16 */
+	dword_16 = (((p_crypt_cfg+index)->ccap_idx << 8) |
+			((p_crypt_cfg+index)->dus_mask));
+	if ((p_crypt_cfg+index)->ccfg_en) {
+		hba->cc.ccap_en = true;
+		dword_16 |= XCRYPTOCFG_ENABLE;
+	}
+	ufshcd_writel(hba, dword_16, (ccfgp_base + XCRYPTOCFG_DW16_OFFSET));
+}
+
+/* ********************** ALG API ************************************ */
+
+static int ufshcd_xts_setkey(struct crypto_tfm *tfm, const u8 *key,
+		unsigned int keylen)
+{
+	struct ufshcd_xts_ctx *ctx = crypto_tfm_ctx(tfm);
+	int err = 0, cap_idx = -EINVAL;
+
+	ctx->active_ccfg_idx = -1;
+	err = xts_check_key(tfm, key, keylen);
+	if (err)
+		return err;
+
+	cap_idx = ufshcd_find_keycapidx(ctx, keylen);
+	if (unlikely(cap_idx == -EINVAL))
+		goto fallback;
+
+	ctx->keylen = keylen;
+	memcpy(ctx->cipher_key, key, keylen);
+	ufshcd_calculate_keyhash(key, keylen, ctx->cipher_keyhash);
+	spin_lock(&hw_lock);
+	if (ufshcd_find_keycfgidx(ctx, key, cap_idx) == false)
+		ufshcd_program_xtskey(ctx, key, cap_idx);
+	spin_unlock(&hw_lock);
+fallback:
+	crypto_skcipher_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(ctx->fallback, tfm->crt_flags &
+			CRYPTO_TFM_REQ_MASK);
+	err = crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	if (!err && !keylen)
+		ctx->keylen = keylen;
+
+	return (ctx->active_ccfg_idx+1);
+}
+
+/* common function for encrypt/decrpyt */
+static int ufshcd_xts_crypt(struct blkcipher_desc *desc,
+		struct scatterlist *dst, struct scatterlist *src,
+		unsigned int nbytes, int enc)
+{
+	struct ufshcd_xts_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
+	int err = 0, active_cfg_idx;
+	SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+
+	active_cfg_idx = ctx->active_ccfg_idx;
+	if (!nbytes)
+		return -EINVAL;
+
+	/* Transform functions are not required for the inline encryption.
+	 * However, they are called whenever there is any need for the
+	 * fallback.
+	 */
+	skcipher_request_set_tfm(req, ctx->fallback);
+	skcipher_request_set_callback(req, desc->flags, NULL, NULL);
+	skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
+	err = enc ? crypto_skcipher_encrypt(req) : crypto_skcipher_decrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+static int ufshcd_xts_encrypt(struct blkcipher_desc *desc,
+		struct scatterlist *dst, struct scatterlist *src,
+		unsigned int nbytes)
+{
+	return ufshcd_xts_crypt(desc, dst, src, nbytes, 1);
+}
+
+static int ufshcd_xts_decrypt(struct blkcipher_desc *desc,
+		struct scatterlist *dst, struct scatterlist *src,
+		unsigned int nbytes)
+{
+	return ufshcd_xts_crypt(desc, dst, src, nbytes, 0);
+}
+
+static int ufshcd_xts_init(struct crypto_tfm *tfm)
+{
+	const u32 flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK;
+	struct ufshcd_xts_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret = 0;
+
+	ctx->fallback = crypto_alloc_skcipher("xts(aes)", 0, flags);
+	if (IS_ERR(ctx->fallback)) {
+		pr_err("%s: Failed to allocate fallback", __func__);
+		ret = PTR_ERR(ctx->fallback);
+		goto err_alloc_fallback;
+	}
+	crypto_skcipher_set_flags(ctx->fallback,
+			crypto_skcipher_get_flags((
+					struct crypto_skcipher *)tfm));
+
+	if (!g_ufs_hba) {
+		pr_err("%s: host not allocated", __func__);
+		ret = -EINVAL;
+		goto err_alloc_host;
+	}
+
+	ufshcd_query_xts_ccaps(ctx);
+	return ret;
+
+err_alloc_host:
+	crypto_free_skcipher(ctx->fallback);
+err_alloc_fallback:
+	return ret;
+}
+
+static void ufshcd_xts_exit(struct crypto_tfm *tfm)
+{
+	struct ufshcd_xts_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	kfree(ctx->key_cap_idx);
+	if (!PTR_ERR(ctx->fallback))
+		crypto_free_skcipher(ctx->fallback);
+	ctx->fallback = NULL;
+}
+
+static struct crypto_alg ufshcd_xts_alg = {
+
+	.cra_name		= "xts(aes)",
+	.cra_driver_name	= "xts-aes-ufshcd",
+	.cra_priority		= 400,
+	.cra_flags		= CRYPTO_ALG_TYPE_BLKCIPHER |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY |
+				  CRYPTO_ALG_NEED_FALLBACK,
+	.cra_blocksize		= AES_BLOCK_SIZE,
+	.cra_ctxsize		= sizeof(struct ufshcd_xts_ctx),
+	.cra_alignmask		= 0,
+	.cra_type		= &crypto_blkcipher_type,
+	.cra_module		= THIS_MODULE,
+	.cra_init		= ufshcd_xts_init,
+	.cra_exit		= ufshcd_xts_exit,
+	.cra_u.blkcipher = {
+		.min_keysize	= 2*AES_MIN_KEY_SIZE,
+		.max_keysize	= 2*AES_MAX_KEY_SIZE,
+		.setkey		= ufshcd_xts_setkey,
+		.encrypt	= ufshcd_xts_encrypt,
+		.decrypt	= ufshcd_xts_decrypt,
+		.ivsize		= AES_BLOCK_SIZE,
+	}
+};
+
+/**
+ * ufshcd_enable_crypt_alg - enable crypto algorithm in UFSHCD
+ * @hba: per-adapter interface
+ * Returns 0 on success, non-zero value on failure
+ */
+int ufshcd_enable_crypt_alg(struct ufs_hba *hba)
+{
+	int err = 0;
+	u32 reg_data = 0;
+
+	reg_data = ufshcd_readl(hba, REG_CONTROLLER_ENABLE);
+	reg_data |= CRYPTO_GENERAL_ENABLE;
+	ufshcd_writel(hba, reg_data, REG_CONTROLLER_ENABLE);
+	g_ufs_hba = hba;
+
+	err = crypto_register_alg(&ufshcd_xts_alg);
+	return err;
+}
+EXPORT_SYMBOL(ufshcd_enable_crypt_alg);
+
+/**
+ * ufshcd_disable_crypt_alg - disable crypt algorithm in UFSHCD
+ * @hba: private structure pointer
+ */
+void ufshcd_disable_crypt_alg(struct ufs_hba *hba)
+{
+	u32 reg_data = 0;
+
+	hba->cc.ccap_en = false;
+	crypto_unregister_alg(&ufshcd_xts_alg);
+	reg_data = ufshcd_readl(hba, REG_CONTROLLER_ENABLE);
+	reg_data &= ~CRYPTO_GENERAL_ENABLE;
+	ufshcd_writel(hba, reg_data, REG_CONTROLLER_ENABLE);
+}
+EXPORT_SYMBOL(ufshcd_disable_crypt_alg);
-- 
2.7.4
