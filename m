Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeE1N2y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:28:54 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:50880 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939123AbeE1N0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:26:54 -0400
To: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>
Subject: [PATCH 2/5] scsi: ufs: Add crypto header file for UFS HC driver
CC: <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <24ee982e-1495-31da-a74f-43a23cd54c96@synopsys.com>
Date: Mon, 28 May 2018 14:26:47 +0100
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


This patch adds the required structures, enum definitions,
function prototypes for UFS Host Controller Crypto support.

Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
---
 drivers/scsi/ufs/ufshcd-crypto.h | 156 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 0000000..f5d5148
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#ifndef _UFSHCD_CRYPTO_H
+#define _UFSHCD_CRYPTO_H
+
+#include <linux/crypto.h>
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/hash.h>
+#include <crypto/algapi.h>
+#include <crypto/scatterwalk.h>
+
+#define REQ_INLINE_ENCRYPTION REQ_DRV
+
+/* CCAP Register Masks */
+#define UFSHCD_CFGPTR_MASK     (0xff000000)
+#define UFSHCD_CFGPTR_SHIFT    (24)
+#define UFSHCD_CFGC_MASK       (0x0000ff00)
+#define UFSHCD_CFGC_SHIFT      (8)
+#define UFSHCD_CC_MASK         (0x000000ff)
+
+/* x-CRYPTOCAP Register Masks */
+#define UFSHCD_KS_MASK         (0x00ff0000)
+#define UFSHCD_KS_SHIFT        (16)
+#define UFSHCD_SDUSB_MASK      (0x0000ff00)
+#define UFSHCD_SDUSB_SHIFT     (8)
+#define UFSHCD_ALGID_MASK      (0x000000ff)
+
+#define SHA1_LENGTH            (20)
+
+struct ufshcd_lrb;
+struct ufs_hba;
+
+/* supported crypto algorithms */
+enum ufshcd_crypto_algorithms {
+	UFSHCD_AES_XTS           = 0x00,
+	UFSHCD_BITLOCKER_AES_CBC = 0x01,
+	UFSHCD_AES_ECB           = 0x02,
+	UFSHCD_ESSIV_AES_CBC     = 0x03,
+};
+
+/* supported key sizes */
+enum ufshcd_crypto_key_sizes {
+	UFSHCD_KS_128 = 0x01,
+	UFSHCD_KS_192 = 0x02,
+	UFSHCD_KS_256 = 0x03,
+	UFSHCD_KS_512 = 0x04,
+	UFSHCD_KS_MAX = 0x05,
+};
+
+/* supported data unit sizes */
+enum ufshcd_crypto_data_unit_sizes {
+	UFSHCD_DUSIZE_512 = 0x01,
+	UFSHCD_DUSIZE_1K  = 0x01<<1,
+	UFSHCD_DUSIZE_2K  = 0x01<<2,
+	UFSHCD_DUSIZE_4K  = 0x01<<3,
+	UFSHCD_DUSIZE_8K  = 0x01<<4,
+	UFSHCD_DUSIZE_16K = 0x01<<5,
+	UFSHCD_DUSIZE_32K = 0x01<<6,
+	UFSHCD_DUSIZE_64K = 0x01<<7,
+};
+
+/* crypto configuration register fields */
+enum ufshcd_xcryptocfg_offsets {
+	XCRYPTOCFG_ENABLE      = 0x01<<31,
+	XCRYPTOCFG_SIZE        = 0x80,
+	XCRYPTOCFG_PTR_OFFSET  = 0x100,
+	XCRYPTOCFG_KEYS_OFFSET = 0x00,
+	XCRYPTOCFG_DW16_OFFSET = 0x40,
+	XCRYPTOCFG_DW17_OFFSET = 0x44,
+};
+
+/* ufshcd_x_crypto_cap - Crypto Capability X */
+struct ufshcd_x_crypto_cap {
+	u32 cap_x;            /* KS[23:16] SDUSB[15:08] ALGID[07:00] */
+};
+
+/**
+ * ufshcd_x_cryptocfg -  Crypto Configuration X
+ * @ckey_hash:  511:0   (64 bytes)  CRYPTOKEY
+ * @dus_mask:   519:512 (1 byte)    DUSIZE
+ * @ccap_idx:   527:520 (1 byte)    CAPIDX
+ * @reserved_1: 535:528 (1 byte)    Reserved
+ * @ccfg_en:    543:536 (1 byte)    CFGE
+ * @multi_slot: 551:544 (1 byte)    Reserved for Multi-Host Functions
+ * @reserved_2: 559:558 (1 byte)    Reserved
+ * @vsb:        575:560 (2 bytes)   VSB(Vendor Specific Bits)
+ * @reserved_3: 1023:576 (56 bytes) Reserved
+ */
+struct ufshcd_x_cryptocfg {
+	u8 ckey_hash[64];
+	u8 dus_mask;
+	u8 ccap_idx;
+	u8 reserved_1;
+	u8 ccfg_en;
+	u8 multi_slot;
+	u8 reserved_2;
+	u8 vsb[2];
+	u8 reserved_3[56];
+};
+
+/**
+ * ufshcd_ccap - Crypto Capability structure
+ * @ccap_en: enable capability of hardware
+ * @ccfg:    CFGPTR Configuration array pointer
+ * @ccfg_count: CFGC Configuration count
+ * @ccap_count: CC Number of Crypto capabilities
+ * @activecfg_count:  Total Active configurations
+ */
+struct ufshcd_ccap {
+	u8 ccap_en;
+	struct ufshcd_x_cryptocfg *ccfg;
+	u8 ccfg_count;
+	u8 ccap_count;
+	u8 activecfg_count;
+};
+
+/**
+ * ufshcd_xts_ctx - UFSHCD XTS algorithm context
+ * @fallback: fallback algorithm
+ * @keylen:   key length
+ * @cipher_key: encryption key
+ * @cipher_keyhash: hash value of encryption key
+ * @key_cap_idx: key capability index
+ * @active_ccfg_idx: key configuration index
+ */
+struct ufshcd_xts_ctx {
+	struct crypto_skcipher *fallback;
+	u32  keylen;
+	u8   cipher_key[2*AES_KEYSIZE_256];
+	u8   cipher_keyhash[64];
+	int *key_cap_idx;
+	int  active_ccfg_idx;
+};
+
+int  ufshcd_crypto_memory_alloc(struct ufs_hba *hba);
+void ufshcd_remove_crypto_memory(struct ufs_hba *hba);
+void ufshcd_read_crypto_capabilities(struct ufs_hba *hba);
+void ufshcd_prepare_for_crypto(struct ufs_hba *hba,
+				struct ufshcd_lrb *lrbp);
+int  ufshcd_enable_crypt_alg(struct ufs_hba *hba);
+void ufshcd_disable_crypt_alg(struct ufs_hba *hba);
+
+#endif /* End of Header */
-- 
2.7.4
