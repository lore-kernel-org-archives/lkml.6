Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0940C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF4208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="Xe2o+RGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBF4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbeKOCHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:07:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33123 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbeKOCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:07:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so4930777pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKT2FISMHyv8N3RNIMgKnskSouz7U+T77FZX5SCipNI=;
        b=Xe2o+RGU3sDy1iJDIH1MyLPEML1Ft1xD37Su332rVOhPMdqBWW8aRD9WQlVMm68B5s
         pQJ+/0xnT9A2nOGo6svH84cz4jmoj6qEFsxMoarWHUz5TzvXSMsESdHv5odwr0vvrk3G
         bbhT6gzTxC0WXW0TSPWbKtRhQQeynOymODbtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKT2FISMHyv8N3RNIMgKnskSouz7U+T77FZX5SCipNI=;
        b=IkR4FmzukTUqw6JKAOfMNrVafnjKk97TDsz3H8ZkaZmoO8jzm8//9Wuiqp93BQd5CZ
         N1ApIdIJgfPSM4qCJy3bZkOzLruQKazruzXCNLrdh6IQkFW0oTTqWryhxILamEWQO2zc
         KYsZtPA2C9vc6yTYnzCviJJfvnh61n1U4v/695aOZTLOotX0emTqhaEUvmAA4Ok02AzJ
         Ir2HJYM+ftYQTcUNrLqkCVarCfT3QAiAxgHkt+QrsNa3rSTeuizot1R76RXy1TdF9a6B
         3516JSjVD6bSawHxqvaD4oAohcjTy0wyvmU/N50zZN91p1pkLWupVbcVgbhh2RDnGZik
         lCXA==
X-Gm-Message-State: AGRZ1gK5EXUyf/uNRtclJnDH1yk72PIg+J4V8CsB2M7vGVczGQCCsh37
        d8dzWTdAEJZK6HDR9LM4yRamsw==
X-Google-Smtp-Source: AJdET5cRBkyXFJvUKq3VCfQxAZsyxYt/N0oZLeiEwqFa9U4pj3eupedXYixZEDOCSc9ct0Q5uqt3kg==
X-Received: by 2002:a62:6fc7:: with SMTP id k190-v6mr2547163pfc.97.1542211413417;
        Wed, 14 Nov 2018 08:03:33 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53449854pfk.133.2018.11.14.08.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:03:32 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V3 5/7] net: maclorawan: Implement the crypto of maclorawan module
Date:   Thu, 15 Nov 2018 00:01:26 +0800
Message-Id: <20181114160126.4445-6-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the crypto for encryption/decryption and message
integrity code (MIC) according to LoRaWAN(TM) Specification Ver. 1.0.2.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Rename the lrwsec files to crypto files
- Modify for Big/Little-Endian
- Use SPDX license identifiers

V3:
- Order local variables from longest to shortest line in the functions

 net/maclorawan/crypto.c | 209 ++++++++++++++++++++++++++++++++++++++++
 net/maclorawan/crypto.h |  27 ++++++
 2 files changed, 236 insertions(+)
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h

diff --git a/net/maclorawan/crypto.c b/net/maclorawan/crypto.c
new file mode 100644
index 000000000000..5337a661c9d0
--- /dev/null
+++ b/net/maclorawan/crypto.c
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include "crypto.h"
+
+struct crypto_shash *
+lrw_mic_key_setup(u8 *k, size_t k_len)
+{
+	struct crypto_shash *tfm;
+	char *algo = "cmac(aes)";
+	int err;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!IS_ERR(tfm)) {
+		err = crypto_shash_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_shash(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+int
+lrw_aes_cmac(struct crypto_shash *tfm, u8 *bz, u8 *data, size_t len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_init(desc);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, bz, 16);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, data, len);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_final(desc, out);
+
+lrw_aes_cmac_end:
+	return err;
+}
+
+int
+lrw_set_bzero(u8 dir, u32 devaddr, u32 fcnt, u8 len, u8 *bz)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 le_fcnt = cpu_to_le32(fcnt);
+
+	bz[0] = 0x49;
+	memset(bz + 1, 0x00, 4);
+	bz[5] = dir;
+	memcpy(bz + 6, &le_devaddr, 4);
+	memcpy(bz + 10, &le_fcnt, 4);
+	bz[14] = 0x00;
+	bz[15] = len;
+
+	return 0;
+}
+
+int
+lrw_calc_mic(struct crypto_shash *tfm,
+	     u8 dir, u32 devaddr, u32 fcnt, u8* buf, size_t len, u8 *mic4)
+{
+	u8 mic[16];
+	u8 bz[16];
+	int err;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.4 Massege Integrity Code (MIC) */
+	lrw_set_bzero(dir, devaddr, fcnt, len, bz);
+	err = lrw_aes_cmac(tfm, bz, buf, len, mic);
+	if (!err)
+		memcpy(mic4, mic, 4);
+
+	return err;
+}
+
+void
+lrw_mic_key_free(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+struct crypto_skcipher *
+lrw_aes_enc_key_setup(char *algo, u8 *k, size_t k_len)
+{
+	struct crypto_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_skcipher(algo, 0, CRYPTO_ALG_ASYNC);
+	if (!IS_ERR(tfm)) {
+		err = crypto_skcipher_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_skcipher(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+struct crypto_skcipher *
+lrw_encrypt_key_setup(u8 *k, size_t k_len)
+{
+	return lrw_aes_enc_key_setup("cbc(aes)", k, k_len);
+}
+
+int
+lrw_aes_enc(struct crypto_skcipher *tfm, u8 *in, size_t len, u8 *out)
+{
+	SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist src, dst;
+	u8 iv[16];
+	int err;
+
+	memset(iv, 0, 16);
+	/* The buffer for sg_init_one cannot be a global or const local
+	 * (will confuse the scatterlist) */
+	sg_init_one(&src, in, len);
+	sg_init_one(&dst, out, len);
+
+	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &src, &dst, len, iv);
+	err = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+#define	LRW_SEQUENCE_OF_BLOCK_LEN	16
+
+int
+lrw_set_sob(u8 dir, u32 devaddr, u32 fcnt, u8 index, u8 *sob)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	sob[0] = 0x01;
+	memset(sob + 1, 0x00, 4);
+	sob[5] = dir;
+	memcpy(sob + 6, &le_devaddr, 4);
+	memcpy(sob + 10, &_fcnt, 4);
+	sob[14] = 0x00;
+	sob[15] = index;
+
+	return 0;
+}
+
+int
+lrw_encrypt_sob(struct crypto_skcipher *tfm, u8 *sob)
+{
+	return lrw_aes_enc(tfm, sob, LRW_SEQUENCE_OF_BLOCK_LEN, sob);
+}
+
+int
+lrw_encrypt_buf(struct crypto_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	u8 sob[LRW_SEQUENCE_OF_BLOCK_LEN];
+	u8 i, j;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.3.3 MAC Frame Payload Encryption (FRMPayload) */
+	for (i = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN) < len; i++) {
+		lrw_set_sob(dir, devaddr, fcnt, i, sob);
+		lrw_encrypt_sob(tfm, sob);
+		for (j = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN + j) < len; j++)
+			buf[i * LRW_SEQUENCE_OF_BLOCK_LEN + j] ^= sob[j];
+	}
+
+	return 0;
+}
+
+int
+lrw_decrypt_buf(struct crypto_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	/* Accoding to XOR swap algorithm */
+	return lrw_encrypt_buf(tfm, dir, devaddr, fcnt, buf, len);
+}
+
+void
+lrw_aes_enc_key_free(struct crypto_skcipher *tfm)
+{
+	crypto_free_skcipher(tfm);
+}
+
+void
+lrw_encrypt_key_free(struct crypto_skcipher *tfm)
+{
+	lrw_aes_enc_key_free(tfm);
+}
diff --git a/net/maclorawan/crypto.h b/net/maclorawan/crypto.h
new file mode 100644
index 000000000000..2ede02efb8c6
--- /dev/null
+++ b/net/maclorawan/crypto.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_CRYPTO_H__
+#define __LORAWAN_CRYPTO_H__
+
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+
+struct crypto_shash *lrw_mic_key_setup(u8 *k, size_t k_len);
+int lrw_calc_mic(struct crypto_shash *tfm,
+		 u8 dir, u32 devaddr, u32 fcnt, u8* buf, size_t len, u8 *mic4);
+void lrw_mic_key_free(struct crypto_shash *tfm);
+
+struct crypto_skcipher *lrw_encrypt_key_setup(u8 *k, size_t k_len);
+int lrw_encrypt_buf(struct crypto_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+int lrw_decrypt_buf(struct crypto_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+void lrw_encrypt_key_free(struct crypto_skcipher *tfm);
+
+#endif
-- 
2.19.1

